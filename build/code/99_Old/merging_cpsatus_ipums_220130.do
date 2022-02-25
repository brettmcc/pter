*Creating dataset
*2022.01.17

clear

global build "C:\Users\39328\Dropbox\Hours constraints and home prod\build"
cd "$build\input\CPS-ATUS"


*CPS
import delimited cps_00001.csv

label var serial "Unique ID for each household in a given survey month and year (CPS)"
label var hwtfinl "Household-level weight, to be used for household statistics (CPS monthly)"
label var pernum "Person in household (CPS)"
label var wtfinl "Final basic weights"
label var earnwt "Earnings weight"
label var uhrsworkorg "Usual hours worked per week, outgoing rotation groups"
label var otpay "Usually receive overtime, tips, or commissions"

format cpsid cpsidp %14.0f

replace earnweek = . if earnweek >= 9999.99 // Not in universe
replace uhrsworkorg = . if uhrsworkorg == 998 // Don't know
replace uhrsworkorg = . if uhrsworkorg == 999 // NIU
replace otpay = . if otpay == 99 // Blank or niu
replace paidhour = . if paidhour == 0 | paidhour == 6 | paidhour == 7
replace hourwage = . if hourwage >= 999


gen annualwt = earnwt / 12 // NB this is the weight to use for earnings


*Double checking with baseline characteristics
svyset [iweight = wtfinl]
svy: tabulate sex, count
gen female = 0 
replace female = 1 if sex == 2
svy, subpop(female): mean age
svy: tabulate race, count
svy: mean age, over(race)
svy: mean age, over(sex)

sum earnweek [iw=annualwt] if year== 2016
sum hourwage [iw=annualwt] if year== 2015

svyset [iweight = annualwt]
svy: mean earnweek, over(race)
svy: mean uhrsworkorg, over(sex)

tab age sex [iweight = wtfinl]


global variables "year serial month hwtfinl mish asecflag pernum wtfinl earnwt hourwage paidhour earnweek uhrsworkorg otpay annualwt"

foreach i in $variables{
	rename `i' `i'_cps
}

/*
*counting CPS observations
gen count_cps = 0
replace count_cps = 1 if year_cps != . 

by year_cps month_cps, sort: egen tot_cps_monthly = sum(count_cps)
tab tot_cps_monthly
sum tot_cps_monthly // 130k

*count MORG
gen count_morg = 0
replace count_morg = 1 if mish == 4 | mish == 8
bys year_cps month_cps: sum count_morg
tab count_morg if year_cps == 2016 & month_cps == 6 // around 30k

drop count*
*/

save cps_15_17.dta, replace

clear

*******ATUS
import delimited atus_00001.csv

format caseid %14.0f
format wt06 %7.0f

label var hrsatrate "Hours worked at hourly rate"
label var otpay "Weekly overtime earnings"
label var hrsatrate "Hrs per week that the respondent usually works at main job at the rate reported in HOURWAGE"
label var otusual "Usually receives overtime, tips, commissions at main job" // this corresponds to OTPAY in CPS!

replace earnweek = . if earnweek >= 9999.99 // Not in universe
replace paidhour = . if paidhour == 99
replace hourwage = . if hourwage >= 999
replace hrsatrate = . if hrsatrate >= 996
replace otusual = . if otusual == 99
replace otpay = . if otpay >= 99999.98

replace earnweek_cps8 = . if earnweek_cps8 >= 9999.99 // Not in universe
replace otpay_cps8 = . if otpay_cps8 >= 99999.97 // Blank or niu
replace paidhour_cps8 = . if paidhour_cps8 == 99
replace hourwage_cps8 = . if hourwage_cps8 >= 999
replace otusual_cps8 = . if otusual_cps8 >= 98



svyset [pw = bwt]
sum earnweek [iw=bwt] if year== 2016
sum hourwage [iw=bwt] if year== 2015 

svyset [pw = wt06]
sum earnweek [iw=wt06] if year== 2016
sum hourwage [iw=wt06] if year== 2015 

// match between cps and atus

global variables "year month caseid pernum lineno wt06 bwt empstat earnweek paidhour hourwage hrsatrate otusual otpay cpsupdate *_cps8"

foreach i in $variables{
	rename `i' `i'_atus
}

/*
*counting ATUS obs to build weights
gen count = 1

by year_atus month_atus, sort: egen tot_month_atus = sum(count)
tab tot_month_atus
sum tot_month_atus // 900

preserve

collapse (count) count  [pweight = bwt], by (year_atus month_atus)
format count %13.0g
sum count // 11.5 million

rename count count_atus
save atus_count.dta, replace

restore

preserve

collapse (count) count  [pweight = wt06], by (year_atus month_atus)
format count %13.0g
sum count // 6 billions -- this is number of hour - person

restore
*/


save atus_15_17.dta, replace



**********************************************************************Merging
merge 1:m cpsidp statefip using cps_15_17

/*
    Result                           # of obs.
    -----------------------------------------
    not matched                     4,500,493
        from master                     2,938  (_merge==1) ATUS
        from using                  4,497,555  (_merge==2) CPS

    matched                           158,418  (_merge==3) CPS - ATUS
    -----------------------------------------
*/


tab year_atus if _merge == 1 // their CPS data is in 2014

drop if _merge == 1
drop if _merge == 2 // I wont' be able to compute weekly base pay


svyset [pw = wt06]
sum earnweek_cps [iw=wt06] if year_cps== 2016 & _merge == 3

svyset [pw = earnwt_cps]
sum earnweek_cps [iw=earnwt_cps] if year_cps== 2016 & _merge == 3
sum earnweek_cps8_atus [iw=annualwt_cps] if year_cps== 2016 & _merge == 3


label var otpay_cps8_atus "Weekly overtime earnings in CPS (but reported only in ATUS)"

order year_cps, after(year_atus)
order earnweek_cps earnweek_cps8_atus earnweek_atus, after(year_cps)

gen temp = earnweek_cps8_atus - earnweek_cps
sum temp
order temp, after(earnweek_cps8_atus)

order otpay_cps8_atus otpay_atus, after(earnweek_atus)
order cpsidp month_cps, after(year_cps)
format cpsidp %14.0f
order year_atus month_atus, after(year_cps)

sort cpsidp month_cps

cd "$build\output"
save merged_ipums_cpsatus.dta, replace

*******************************************************************************

*Trying to reconstruct balanced sample
drop if earnweek_cps == . & earnweek_cps8_atus == . & earnweek_atus == . // I need this info

order paidhour_cps paidhour_cps8_atus paidhour_atus, after(otpay_atus)

drop if paidhour_cps== . & paidhour_cps8_atus == . & paidhour_atus == . // 0 nice

order otpay_cps otusual_cps8_atus otusual_atus, after (otpay_atus)

count if otpay_cps == . & otusual_cps8_atus == . & otusual_atus == . // 0 nice

*TRIAL 1) ATUS DATA

*Conservative approach: only use more recent atus data
count if earnweek_atus != . & paidhour_atus != . & otusual_atus != . // 83975
count if earnweek_atus != . & paidhour_atus != . & otusual_atus != . & year_atus == 2016 // 32148
count if earnweek_atus != . & paidhour_atus != . & otusual_atus != . & year_atus == 2016 & month_atus == 12 // 2786
count if earnweek_atus != . & paidhour_atus != . & otusual_atus != . & year_atus == 2016 & month_atus == 4 // 2491


*building weekly base pay = earnweek - otpay
*drop if earnweek_atus == .

* Assumption: if otusual == 1 but otpay == . then otusual was referring to tips or commissions
replace otpay_atus = 0 if otpay_atus == .
gen weekly_base_pay_atus = earnweek_atus - otpay_atus
order weekly_base_pay_atus, after(earnweek_atus)
assert weekly_base_pay_atus <= earnweek_atus

sum weekly_base_pay_atus [iw=annualwt] if year_atus== 2016

* Hourly vs salaried
gen byte hourly_atus = 0
replace hourly_atus = 1 if paidhour_atus == 1

gen byte salaried_atus = 0
replace salaried_atus = 1 if paidhour_atus == 2

tab hourly_atus paidhour_atus
tab salaried_atus paidhour_atus

svyset [iweight = annualwt]
svy, subpop(hourly_atus): mean age
svy, subpop(salaried_atus): mean age
svy, subpop(hourly_atus): mean weekly_base_pay_atus
svy, subpop(salaried_atus): mean weekly_base_pay_atus
svy, subpop(hourly_atus): mean earnweek_atus
svy, subpop(salaried_atus): mean earnweek_atus
*/

*TRIAL 2) CPS DATA
* Use CPS data: very few earnings data are updated
tab cpsupdate_atus, m
label var cpsupdate_atus "Earnings updated in ATUS from CPS"
replace cpsupdate_atus = . if cpsupdate_atus == 99

*Use CPS earning data to go with weights, and cps otpay (which is only reported in atus) -- This will mean using cps timing
count if earnweek_cps8_atus != . & paidhour_cps8_atus != . & otusual_cps8_atus != . // 83127
count if earnweek_cps8_atus != . & paidhour_cps8_atus != . & otusual_cps8_atus != . & year_cps == 2016 // 31230
count if earnweek_cps8_atus != . & paidhour_cps8_atus != . & otusual_cps8_atus != . & year_cps == 2016 & month_cps == 12 // 1808
count if earnweek_cps8_atus != . & paidhour_cps8_atus != . & otusual_cps8_atus != . & year_cps == 2016 & month_cps == 4 // 3009
*CPS SAMPLE IN ATUS IS ROUGHLY THE SAME NUMEROSITY AS ATUS SAMPLE

*building weekly base pay = earnweek - otpay
*drop if earnweek_cps8_atus == .

* Assumption: if otusual == 1 but otpay == . then otusual was referring to tips or commissions
replace otpay_cps8_atus = 0 if otpay_cps8_atus == .
gen weekly_base_pay_cps8 = earnweek_cps8_atus - otpay_cps8_atus
order weekly_base_pay_cps8, after(earnweek_cps8_atus)
assert weekly_base_pay_cps8 <= earnweek_cps8_atus

sum weekly_base_pay_cps8 [iw=annualwt_cps] if year_cps== 2016

* Hourly vs salaried
gen byte hourly_cps8 = 0
replace hourly_cps8 = 1 if paidhour_cps8_atus == 1

gen byte salaried_cps8 = 0
replace salaried_cps8 = 1 if paidhour_cps8_atus == 0

tab hourly_cps8 paidhour_cps8_atus
tab salaried_cps8 paidhour_cps8_atus

*States
drop if statefip > 56 // 50 states + DC

*States which did not change minimum wage
gen states_nomwc = 0
replace states_nomwc = 1 if statefip == 01 | statefip == 13 | statefip == 16 | statefip == 18 | statefip == 19 | statefip == 20 | statefip == 21 | statefip == 22 | statefip == 28 | statefip == 33 | statefip == 35 | statefip == 37 | statefip == 38 | statefip == 40 | statefip == 42 | statefip == 45 | statefip == 47 | statefip == 48 | statefip == 49 | statefip == 51 | statefip == 55 | statefip == 56


svyset [iweight = annualwt]
svy, subpop(hourly_cps8): mean age
svy, subpop(salaried_cps8): mean age
svy, subpop(hourly_cps8): mean weekly_base_pay_cps8
svy, subpop(salaried_cps8): mean weekly_base_pay_cps8
svy, subpop(hourly_cps8): mean earnweek_cps8_atus
svy, subpop(salaried_cps8): mean earnweek_cps8_atus

cd "$build\output"
save clean_ipums_cpsatus.dta, replace


********************************************************************************
*Building ATUS + Earner study weights
* Option 1: weight = EARNWT / tot obs in ATUS
* Option 2: weight = EARNWT * BTW
/*
*Option 1 
cd "$build\input\CPS-ATUS"
merge m:1 year_atus month_atus using atus_count, gen(_merge2) // merging total obs in ATUS

/*

    -----------------------------------------
    not matched                        40,473
        from master                    40,471  (_merge2==1)
        from using                          2  (_merge2==2)

    matched                            48,879  (_merge2==3)
    -----------------------------------------
*/

by year_atus month_atus, sort: gen float weight_atus = earnwt_cps * count_atus
format weight_atus %14.0g

sum weight_atus

preserve 

keep if year_atus != .
svyset [iweight = weight_atus]
svy, subpop(hourly_atus): mean weekly_base_pay_atus
svy, subpop(salaried_atus): mean weekly_base_pay_atus
svy, subpop(hourly_atus): mean earnweek_atus
svy, subpop(salaried_atus): mean earnweek_atus

restore
* This creates weights which are too big to be true
/*

    Variable |        Obs        Mean    Std. Dev.       Min        Max
-------------+---------------------------------------------------------
 weight_atus |     48,879    3.93e+10    6.72e+10          0   4.22e+11
*/

drop weight_atus


*Option 2
gen weight_atus = earnwt_cps * bwt_atus // NB bwt_atus only has values for 15 and 16!
format weight_atus %11.0g

tab year_atus if weight_atus !=  0
tab month_atus if weight_atus !=  0 & year_atus != 2017

sum weight_atus if year_atus != 2017 // 44.000.000 still different from us working population but reasonable

svyset [iweight = weight_atus]
svy, subpop(salaried_atus): mean earnweek_atus if year_atus == 2016 & month_atus == 12
svy, subpop(salaried_atus): mean weekly_base_pay_atus if year_atus == 2016 & month_atus == 12
svy, subpop(hourly_atus): mean weekly_base_pay_atus if year_atus == 2016 & month_atus == 12

preserve
keep if year_atus != .
drop if year_atus == 2017
cap drop temp
gen temp = 1

collapse (count) temp  [pweight = weight_atus], by (year_atus month_atus)
format temp %13.0g
sum temp //
tab temp month_atus if year_atus == 2016

restore

sum earnwt_cps
*/

