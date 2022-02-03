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


global variables "year serial month hwtfinl asecflag pernum wtfinl earnwt hourwage paidhour earnweek uhrsworkorg otpay annualwt"

foreach i in $variables{
	rename `i' `i'_cps
}

save cps_15_17.dta, replace

clear

*ATUS
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
replace paidhour_cps8 = . if paidhour_cps8 == 0 | paidhour_cps8 == 6 | paidhour_cps8 == 7 | paidhour_cps8 == 99
replace hourwage_cps8 = . if hourwage_cps8 >= 999
replace otusual_cps8 = . if otusual_cps8 == 99



svyset [pw = wt06]
sum earnweek [iw=wt06] if year== 2016
sum hourwage [iw=wt06] if year== 2015 // match between cps and atus

global variables "year month caseid pernum lineno wt06 empstat earnweek paidhour hourwage hrsatrate otusual otpay cpsupdate *_cps8"

foreach i in $variables{
	rename `i' `i'_atus
}

save atus_15_17.dta, replace



**********************************************************************Merging
merge 1:m cpsidp using cps_15_17

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



*Trying to reconstruct balanced sample
drop if earnweek_cps == . & earnweek_cps8_atus == . & earnweek_atus == . // I need this info

order paidhour_cps paidhour_cps8_atus paidhour_atus, after(otpay_atus)

drop if paidhour_cps== . & paidhour_cps8_atus == . & paidhour_atus == . // 1,275 -- Woulnd't know how to classify them

order otpay_cps otusual_cps8_atus otusual_atus, after (otpay_atus)

count if otpay_cps == . & otusual_cps8_atus == . & otusual_atus == . // 0 nice

*Conservative approach: only use more recent atus data
count if earnweek_atus != . & paidhour_atus != . & otusual_atus != . // 83975
count if earnweek_atus != . & paidhour_atus != . & otusual_atus != . & year_atus == 2016 // 32148
count if earnweek_atus != . & paidhour_atus != . & otusual_atus != . & year_atus == 2016 & month_atus == 12 // 2785
count if earnweek_atus != . & paidhour_atus != . & otusual_atus != . & year_atus == 2016 & month_atus == 4 // 2491

cd "$build\output"
save merged_ipums_cpsatus.dta, replace




*building weekly base pay = earnweek - otpay
drop if earnweek_atus == .

* Assumption: if otusual == 1 but otpay == . then otusual was referring to tips or commissions
replace otpay_atus = 0 if otpay_atus == .
gen weekly_base_pay = earnweek_atus - otpay_atus
order weekly_base_pay, after(earnweek_atus)
assert weekly_base_pay <= earnweek_atus

sum weekly_base_pay [iw=annualwt] if year_atus== 2016

* Hourly vs salaried
gen byte hourly = 0
replace hourly = 1 if paidhour_atus == 1

gen byte salaried = 0
replace salaried = 1 if paidhour_atus == 2

tab hourly paidhour_atus
tab salaried paidhour_atus

svyset [iweight = annualwt]
svy, subpop(hourly): mean age
svy, subpop(salaried): mean age
svy, subpop(hourly): mean weekly_base_pay
svy, subpop(salaried): mean weekly_base_pay
svy, subpop(hourly): mean earnweek_atus
svy, subpop(salaried): mean earnweek_atus


save merged_ipums_cpsatus.dta, replace
