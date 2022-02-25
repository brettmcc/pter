*CPS reg
*Cleaning ASEC data

clear

global build "C:\Users\39328\Dropbox\Hours constraints and home prod\build"
cd "$build\input\CPS-ATUS"

cd "C:\Users\ilariamalisan\Downloads" // workstation

import delimited cps_asec_76_21.csv // asec pre 75 is non linkable between years but we don't exploit that dimension

*Sample
tab year

tab year asecflag, m

drop if month == 3 & asecflag == 2 // dropping March basic while keeping ASEC to avoid double counting

sort cpsid mish
order mish, after(month)

tab month if cpsidp == . 
tab year if cpsidp == . 

tab month if cpsidp == 0

count if cpsidp == .& cpsid == .

*Respondents who are part of the ASEC oversample (as indicated by ASECOVERP) have a CPSIDP value of 0 


**
save cps_asec_76_21.dta, replace

*Sample

order cpsid cpsidp, after(month)

order serial, last

order incwage, after(hhincome)
format cpsid cpsidp cpsidp_sp hrhhid %15.0f
format incwage %8.0f

tab year
tab year if cpsid == 0 // if they also have cpsid == 0 I cannot link them to basic monthly

count if cpsidp == 0 & cpsid == 0 // 1,728,423
tab year if cpsidp == 0 & cpsid == 0
drop if cpsidp == 0 & cpsid == 0

count if cpsidp == . & cpsid == . // 160,799
tab year if cpsidp == . & cpsid == .
drop if cpsidp == . & cpsid == .

count if cpsidp == 0 // 877,142
tab year if cpsidp == 0

drop if cpsidp == 0  // oversampled for ASEC, would be duplicates. 
* Might need to get them back when we add weights

//checking id
sort cpsidp mish
bys cpsidp: gen agechange = age - age[_n-1]
order agechange, after(age)
tab agechange, m // missing are first occurrences of every id
drop if agechange <-2 | agechange>2 & agechange!=. // mistakes in id 795,554


*Variables
label var hhincome "Household income during previous calendar year" // sum inctot for all members
label var uhrsworkt "Hours usually worked per week at all jobs"
label var uhrswork1 "Hours usually worked per week at main job"
label var ahrsworkt "Hours worked last week"

replace hhincome = . if hhincome == 99999999
replace incwage = . if incwage == 99999999
replace incwage_sp = . if incwage_sp == 99999999

replace race = . if race == 999
replace race_sp = . if race_sp == 999

replace marst = . if marst == 9
replace marst_sp = . if marst_sp == 9

replace ind1950 = . if ind1950 == 0
replace empstat = . if empstat == 0
replace empstat_sp = . if empstat_sp == 0

replace hhtenure = . if hhtenure == 0
replace wkstat = . if wkstat == 99
replace wkstat_sp = . if wkstat_sp == 99

replace whyptlwk = .  if whyptlwk < 10
replace whyptlwk_sp = .  if whyptlwk_sp < 10

replace uhrsworkt = . if uhrsworkt >= 997
replace uhrsworkt_sp = . if uhrsworkt_sp >= 997

replace uhrswork1 = . if uhrswork1 >= 997
replace uhrswork1_sp = . if uhrswork1_sp >= 997

replace ahrsworkt = . if ahrsworkt == 999
replace ahrsworkt_sp = . if ahrsworkt_sp == 999

sort cpsidp mish
order cpsidp_sp, after(cpsidp)

gen spouse_info = 1 if cpsidp_sp != . // spouse info flag
// Don't need spouse dummies except pter (done later)

// whyptlwk vs wkstat
*tab wkstat whyptlwk
*tab2xl whyptlwk wkstat using whyptlwk_wkstat, col(1) row(1)

*tipical household: 19760100000200 cpsid
* hhincome, incwage only observed in asec
by cpsidp (mish): gen first = 1 if _n == 1 // first obs flag
order first, after(mish)

egen everasec = max(asecflag) if first != 1, by(cpsid) // equivalent to bys
bys cpsidp: replace everasec = everasec[_n+1] if missing(everasec) & first == 1
tab everasec, m

order everasec, after(asecflag)

replace everasec = 0 if everasec == .

order whyptlwk wkstat, after(incwage)

*Income info
tab year everasec, m
tab year asecflag, m

*keep if everasec == 1 // Don't drop those not in asec, as we will have one specification without income

*Panel structure
isid cpsidp mish
sort cpsidp mish

xtset cpsidp mish

// Mish count
bys cpsidp (mish): egen ncount = count(cpsidp)
tab ncount

tsset cpsidp mish

//

*Dummies
gen female = 0
replace female = 1 if sex == 2 & sex != .
tab female, m

gen black = 0
replace black = 1 if race == 200 & race != .
tab black, m



//Lifecycle events
* Homeowner status changes
gen howner = 0
replace howner = 1 if hhtenure == 1
replace howner = . if hhtenure == .
tab hhtenure howner, m
order howner, after(hhtenure)

foreach j of numlist 1/4{
bys cpsidp: replace howner = howner[_n+`j'] if missing(howner)
bys cpsidp: replace howner = howner[_n-`j'] if missing(howner)
}
/*
bys cpsidp: gen homeown_chg = howner != howner[_n-1] if howner != . & howner[_n-1] != . // double check
order homeown_chg, after(howner)
replace homeown_chg = 0 if first == 1 & homeown_chg == .
tab homeown_chg, m
*/

// Becoming homeowner
gen becom_homeowner = 0
replace becom_homeowner =. if howner == .
bys cpsidp: replace becom_homeowner = . if first == 1
bys cpsidp: replace becom_homeowner = 1 if (howner[_n-1] == 0 & howner == 1)

order becom_homeowner, after(howner) // very few ones

*Marital status changes 
/*
bys cpsidp: gen marst_chg = married != married[_n-1] if married != . & married[_n-1] != .
tab marst_chg, m
order marst_chg, after(married)
*/

gen married = 0 
replace married = 1 if marst == 1 & marst != . | marst == 2 & marst != . // no missing marst

gen divorced = 0 // divorced includes separated and widowed (widowed listed together with divorced for early years)
replace divorced = 1 if marst == 3 | marst == 4 | marst == 5 | marst == 7

gen single = 0
replace single = 1 if marst == 6

order married divorced single, after(marst)
tab married, m
tab divorced, m
tab single, m

// Got married
gen s_to_m = 0
replace s_to_m =. if marst == .
bys cpsidp: replace s_to_m = . if first == 1
bys cpsidp: replace s_to_m = 1 if (single[_n-1] == 1 & married == 1)

// Remain married
gen remain_married = 0
replace remain_married =. if marst == .
bys cpsidp: replace remain_married = . if first == 1
bys cpsidp: replace remain_married = 1 if (married[_n-1] == 1 & married == 1)

//Divorced / separated
gen m_to_d = 0
replace m_to_d =. if marst == .
bys cpsidp: replace m_to_d = . if first == 1
bys cpsidp: replace m_to_d = 1 if (married[_n-1] == 1 & divorced == 1)

// Remained single (omitted group)
gen remain_single = 0
replace remain_single =. if marst == .
bys cpsidp: replace remain_single = . if first == 1
bys cpsidp: replace remain_single = 1 if (single[_n-1] == 1 & single == 1)

order s_to_m remain_married m_to_d remain_single, after(single)


*Number of children changes
sort cpsidp mish

cap drop first
by cpsidp (mish): gen first = 1 if _n == 1 // first obs flag

bys cpsidp: gen children_chg = . if first == 1

bys cpsidp: replace children_chg = nchild[_n] != nchild[_n-1] if first != 1
order children_chg, after(nchild)

bys cpsidp: egen n_child_chg = sum(children_chg)
order n_child_chg, after(children_chg)
tab n_child_chg, m
br if n_child_chg > 3

*Number of adults
gen nadults = famsize - nchild
order nadults famsize, after(nchild)

drop if nadults < 1 // famsize counts family members living together including oneself, so if nadults if below 1 there are issues with the data

//Empstat
// Self
gen employed = 0
replace employed = 1 if empstat == 10 | empstat == 12  // at work or has job but not at work last week
tab employed, m

//Spouse
gen employed_sp = 0
replace employed_sp = 1 if empstat_sp == 10 | empstat_sp == 12  // at work or has job but not at work last week
tab employed_sp, m


*Restrictions
drop if age > 67 | age < 22
*keep if employed == 1 // Add this restriction to regressions

sort cpsidp mish

// Educ
tab educ, m

gen less_highschool = 0
replace less_highschool = 1 if educ <= 71

gen highschool = 0
replace highschool = 1 if educ == 72 | educ == 73

gen somecollege = 0
replace somecollege = 1 if educ >=  80 & educ <= 110

gen collegeup = 0
replace collegeup = 1 if educ >= 111

tab educ collegeup

//Industry
tab ind1950, m

gen industry = .
replace industry = 1 if ind1950 <200
replace industry = 2 if ind1950 >=200 & ind1950 <300
replace industry = 3 if ind1950 >=300 & ind1950 <400
replace industry = 4 if ind1950 >=400 & ind1950 <500
replace industry = 5 if ind1950 >=500 & ind1950 <600
replace industry = 6 if ind1950 >=600 & ind1950 <700
replace industry = 7 if ind1950 >=700 & ind1950 <800
replace industry = 8 if ind1950 >=800 & ind1950 <900
replace industry = 9 if ind1950 >=900 & ind1950 <= 936

tab industry, m

//FT - PT status changes
gen pt = 0
replace pt = . if wkstat ==.
replace pt = 1 if wkstat == 12 |  wkstat == 20 |  wkstat == 21 |  wkstat == 22 |  wkstat == 40 |  wkstat == 41 //check with brett
tab pt employed

gen ft = 0
replace ft = . if wkstat ==.
replace ft = 1 if wkstat == 10 | wkstat == 11 |  wkstat == 14 | wkstat == 15 //check with brett

tab wkstat pt, m
tab pt ft, m
order pt ft, after(wkstat)

* Status changes
//Pt to ft
gen pt_ft = 0
replace pt_ft =. if pt == . | ft == .
bys cpsidp: replace pt_ft = . if first == 1
bys cpsidp: replace pt_ft = 1 if (pt[_n-1] == 1 & ft == 1) // pt to ft

// Ft to pt
gen ft_pt = 0
replace ft_pt =. if pt == . | ft == .
bys cpsidp: replace ft_pt = . if first == 1
bys cpsidp: replace ft_pt = 1 if (ft[_n-1] == 1 & pt == 1) // ft to pt

order pt_ft ft_pt, after(ft)
tab pt_ft
tab ft_pt

//Always pt
gen pt_always = 0
replace pt_always =. if pt == . | ft == .

gen count_pt = . if first == 1
bys cpsidp: replace count_pt = sum(pt)
bys cpsidp: egen max_pt = max(count_pt)
order count_pt max_pt, after(pt)

cap drop ncount
bys cpsidp (mish): egen ncount = count(cpsidp)
tab ncount, m

bys cpsidp: egen tot_mish = max(ncount) // number of months in sample (could be different from last mish if individual follows non regular interview pattern)

bys cpsidp: replace pt_always = 1 if max_pt == tot_mish

//Always ft
gen ft_always = 0
replace ft_always =. if pt == . | ft == .

gen count_ft = . if first == 1
bys cpsidp: replace count_ft = sum(ft)
bys cpsidp: egen max_ft = max(count_ft)

bys cpsidp: replace ft_always = 1 if max_ft == tot_mish

order pt_always ft_always, after (ft_pt)
tab pt_always
tab ft_always
order count_pt max_pt, last

*PTER
gen pter = 0
replace pter = 1 if whyptlwk == 010 | whyptlwk == 060 | whyptlwk == 020
replace pter = . if whyptlwk ==.  

tab whyptlwk pter, m
order pter, after(everasec)

* PTER Spouse
gen pter_sp = 0
replace pter_sp = 1 if whyptlwk_sp == 010 | whyptlwk_sp == 060 | whyptlwk_sp == 020
replace pter_sp = . if whyptlwk_sp ==.  

tab whyptlwk_sp pter_sp, m
order pter_sp, after(pter)

*Becoming PTER
gen into_pter = 0
replace into_pter =. if pter == . | first == 1
bys cpsidp: replace into_pter = 1 if pter[_n-1] == 0 & pter == 1 // becoming PTER
order into_pter, after(pter)

tab into_pter, m
tab pter pt, m
tab wkstat if pt == 0 & pter == 1 // Full time schedules ?


* Log Family income = total family income - own earnings from work

* Assigning income values from asec to non asec months (should be ok since this is yearly)

gen famincome = hhincome - incwage
order famincome, after(into_pter)

// Log of family income
count if famincome == 0
br if famincome < 0 // negative household income? they end up as missing so ok
gen log_faminc = log(famincome+1)
order log_faminc, after(famincome)

// Famincome spouse
gen famincome_sp = . if cpsidp_sp == .
replace famincome_sp = hhincome - incwage_sp
order famincome_sp, after(log_faminc)

// Famincome_married as Income - both spouse's wages
gen famincome_married = . if cpsidp_sp == .
replace famincome_married = hhincome - incwage - incwage_sp
order famincome_married, after(log_faminc)

//Log wage

*bys cpsidp year: egen incwage2 = min(inctot)
count if incwage == 0
gen log_wage = log(incwage+1)
order log_wage, after(incwage)

// Year-month dummies
tab month

gen monthly_date = mofd(mdy(month, 1, year))
format monthly_date %tm
order monthly_date, after(mish)


cd "$build\output"

save asec_monthly_76_21.dta, replace

***********************************************
***********************************************
*ATUS

cd "$build\input\CPS-ATUS"

cd "C:\Users\ilariamalisan\Downloads" // workstation

clear

import delimited atus_03_20.csv

order cpsidp, after(year)
format cpsidp cpsidp_sp hrhhid_cps8 caseid %15.0f
order cpsidp_sp, after (cpsidp)

tab year

sort cpsidp year

cd "$build\output"
save atus_03_20.dta, replace

count if cpsidp == 0 | cpsidp == . //linking key with monthly CPS 

* CPSIDP_SP identifies spouse in CPS

*Variables
label var famincome "Family's total annual income" // same as hhincome in cps, but these are classes of income
label var earnweek "Weekly earnings at ATUS time"
label var spusualhrs " Usual work hours (spouse or partner), ATUS time"

replace famincome = . if famincome >= 996
replace hh_numkids = . if hh_numkids == 99
replace age = . if age >= 996
replace sex = . if sex == 99
replace race = . if race == 9999
replace marst =. if marst == 99
replace educ = . if educ == 999
replace empstat = . if empstat == 99 //ATUS time
replace spempstat = . if spempstat >= 96 //ATUS time
replace ind2 = . if ind2 == 9999
replace whyptlwk_cps8 = . if whyptlwk_cps8 == 999
replace whyptlwk_cps8_sp = . if whyptlwk_cps8_sp == 999 // CPS time
replace fullpart =. if fullpart == 99 //ATUS time
replace earnweek = . if earnweek >= 99999 // ATUS time
replace earnweek_sp = . if earnweek_sp >= 99999 // ATUS time
replace fullpart_cps8 = . if fullpart_cps8 == 99
replace fullpart_cps8_sp = . if fullpart_cps8_sp== 99

replace earnweek_cps8 = . if earnweek_cps8 >= 99999
replace earnweek_cps8_sp = . if earnweek_cps8_sp>= 99999
replace spousepres = . if spousepres == 99 // ATUS time
replace spempnot = . if spempnot == 99 
replace spusualhrs = . if spusualhrs >= 995 // 995 = hours vary
replace spearnweek = . if spearnweek >= 99999 //last CPS time
replace empstat_sp = . if empstat_sp == 99 // ATUS time
replace fullpart_sp = . if fullpart_sp == 99 // ATUS time

// Home work hours 
egen sum = rowtotal(bls_carehh bls_carenhh bls_carenhh_travel bls_hhact_exter bls_hhact_food bls_hhact_hhmgmt bls_hhact_hwork bls_hhact_inter bls_hhact_lawn bls_hhact_pet bls_hhact_tool bls_hhact_vehic bls_purch_bank bls_purch_cons bls_purch_gov bls_purch_groc bls_purch_health bls_purch_hhserv bls_purch_home bls_purch_prof bls_purch_travel bls_purch_vehic)

gen homeworkhrs = sum /60 // atus items are expressed in minutes

*Dummies
gen female_atus = 0
replace female_atus = 1 if sex == 2 & sex != .

gen black = 0
replace black = 1 if race == 110 & race != . // most conservative, discuss with brett
tab race black, m

// Marital status
gen married_atus = 0 
replace married_atus = 1 if marst == 1 & marst != . | marst == 2 & marst != . // also consider as married if spouse is not present, doublecheck

gen divorced_atus = 0 // diverced includes separated and widowed (widowed listed together with divorced for early years)
replace divorced_atus = 1 if marst == 3 | marst == 4 | marst == 5

gen single_atus = 0
replace single_atus = 1 if marst == 6

order married_atus divorced_atus single_atus, after(marst)
tab married_atus, m
tab divorced_atus, m
tab single_atus, m

// Employment status
gen employed_atus = 0
replace employed_atus = 1 if empstat == 1 | empstat == 2  // at work or has job but not at work last week
tab employed_atus, m

// empstat_sp is always missing

// Spouse's employment status
gen employed_sp_atus = 0
replace employed_sp_atus = 1 if spempstat == 1 | spempstat == 2  // at work or has job but not at work last week
replace employed_sp_atus = . if spempstat == .
tab employed_sp_atus, m

tab age 

*Restrictions
drop if age > 67 | age < 22
*keep if employed == 1

// Educ
tab educ, m

gen less_highschool = 0
replace less_highschool = 1 if educ <= 17

gen highschool = 0
replace highschool = 1 if educ == 20 | educ == 21

gen somecollege = 0
replace somecollege = 1 if educ >=  30 & educ <= 32

gen collegeup = 0
replace collegeup = 1 if educ >= 40 & educ != .

tab educ collegeup

//Industry
tab ind2, m

* ind2 can be collapsed into 21 macro sector by just considering the first 2 digits

gen industry = int(ind2/10)

tab industry ind2, m

//FT - PT 
* info in fullpart, fullpart_cps8, fullpart_sp, fullpart_cps8_sp -- start using ATUS info

gen pt_atus = 0
replace pt_atus = . if fullpart ==.
replace pt_atus = 1 if fullpart == 2

gen ft_atus = 0
replace ft_atus = . if fullpart ==.
replace ft_atus = 1 if fullpart == 1

tab pt_atus ft_atus, m

// fullpart_sp always missing

// PTER -- there are a lot of missing in whyptlwk_cps8
gen pter_atus = 0
replace pter_atus = 1 if whyptlwk_cps8 == 01 | whyptlwk_cps8 == 02
* "could only find part-time" category missing here!
replace pter_atus = . if whyptlwk_cps8 ==.
tab pter_atus, m

// what should we do? try to merge with full cps monthly hoping there are less missing? call this pter_atus (even though this is from cps8) and check if it gets better after the merge with cps full monthly

// PTER spouse 
tab whyptlwk_cps8_sp, m

gen pter_atus_sp = 0
replace pter_atus_sp = 1 if whyptlwk_cps8_sp == 01 | whyptlwk_cps8_sp == 02
* "could only find part-time" category missing here!
replace pter_atus_sp = . if whyptlwk_cps8_sp ==.
tab pter_atus_sp, m


/*
// PTER couple

gen pter_atus_couple = 0
replace pter_atus_couple = 1 if pter_atus == 1 & pter_atus_sp == 1 
// no risk of douple counting as only one individual per household enters atus
replace pter_atus_couple = . if pter_atus ==. | pter_atus_sp == .

tab pter_atus_couple, m
*/

// Income
*generating annual income from work from weekly earnings: earnweek, spearnweek

*earnweek_sp always missing
gen income = earnweek * 52 // rough measure

gen income_sp = spearnweek * 52

tab income, m
tab earnweek, m // what should we do about topcoding?
tab income_sp, m

// Famincome
* famincome is categorical and brought over from cps -- probably best to directly use variable from cps monthly 
*building famincome = midpoint anyways
gen famincome_rec = famincome

replace famincome_rec = 2500 if famincome == 1
replace famincome_rec = 6246.5 if famincome == 2
replace famincome_rec = 8749.5 if famincome == 3
replace famincome_rec = 11249.5 if famincome == 4
replace famincome_rec = 13749.5 if famincome == 5
replace famincome_rec = 17499.5 if famincome == 6
replace famincome_rec = 22499.5 if famincome == 7
replace famincome_rec = 27499.5 if famincome == 8
replace famincome_rec = 32499.5 if famincome == 9
replace famincome_rec = 37499.5 if famincome == 10
replace famincome_rec = 44999.5 if famincome == 11
replace famincome_rec = 54999.5 if famincome == 12
replace famincome_rec = 67499.5 if famincome == 13
replace famincome_rec = 87499.5 if famincome == 14
replace famincome_rec = 124999.5 if famincome == 15
replace famincome_rec = 150000 if famincome == 16

tab famincome_rec, m

// Net famincome for married couples
gen net_famincome_married = famincome_rec - income - income_sp
replace net_famincome_married = . if famincome_rec == . | income == . | income_sp == .
replace net_famincome_married = . if net_famincome_married < 0
order net_famincome_married famincome_rec income income_sp, after(famincome)

// Net famincome for single
gen net_famincome = famincome_rec - income
replace net_famincome = . if famincome_rec == . | income == . 
replace net_famincome = . if net_famincome < 0
order net_famincome, after(famincome)

// Spouse hoursworked
tab spusualhrs, m

// Rename year, month to prepare for merge
rename year year_atus
rename month month_atus

cd "$build\output"

save atus_clean_03_20, replace
*************************************************
***********************************************
*Merging cps monthly with atus data

clear

use asec_monthly_76_21

// Attach ATUS info to head cpsidp
merge m:m cpsidp using atus_clean_03_20, gen(_merge_atus)

/*

    Result                           # of obs.
    -----------------------------------------
    not matched                    42,070,464
        from master                42,069,714  (_merge_atus==1)
        from using                        750  (_merge_atus==2)

    matched                         1,154,716  (_merge_atus==3)
    -----------------------------------------


*/

tab _merge_atus if year >= 2001 // could be in atus 2003

/*
            _merge_atus |      Freq.     Percent        Cum.
------------------------+-----------------------------------
        master only (1) | 18,123,403       94.01       94.01
         using only (2) |        750        0.00       94.01
            matched (3) |  1,154,716        5.99      100.00
------------------------+-----------------------------------
                  Total | 19,278,869      100.00

*/


save cps_atus_merged_76_21, replace

// Attach ATUS info to CPS spouse cpsidp

clear

use atus_clean_03_20
rename cpsidp_sp cpsidp_sporiginal
rename cpsidp cpsidp_sp // to merge into cps spouse cpsidp 
*this helps in case the ATUS survey was completed by the spouse and the spouse does not appear as head but only as spouse in cps 
rename homeworkhrs homeworkhrs_sp

save atus_clean_03_20_temp, replace

clear 

use cps_atus_merged_76_21

merge m:1 cpsidp_sp using atus_clean_03_20_temp, gen(_merge_atus_sp)

/*
    Result                           # of obs.
    -----------------------------------------
    not matched                    42,584,693
        from master                42,519,612  (_merge_atus_sp==1)
        from using                     65,081  (_merge_atus_sp==2)

    matched                           705,568  (_merge_atus_sp==3)
    -----------------------------------------


*/

sort cpsidp mish

order year month mish cpsid cpsidp cpsidp_sp, first
drop if cpsidp == .

save cps_atus_merged_76_21, replace


// Either spouse pter (CPS)

gen pter_eitherspouse = 0
replace pter_eitherspouse = . if pter ==. | pter_sp == .

replace pter_eitherspouse = 1 if pter == 1 & pter_sp == 1 

tab pter_eitherspouse, m // more

// Either spouse pter (atus)
gen pter_eitherspouse_atus = 0
replace pter_eitherspouse_atus = . if pter_atus ==. | pter_atus_sp == .

replace pter_eitherspouse_atus = 1 if pter_atus == 1 & pter_atus_sp == 1 

tab pter_eitherspouse_atus, m // more

order pter into_pter pter_sp pter_atus pter_atus_sp pter_eitherspouse pter_eitherspouse_atus homeworkhrs homeworkhrs_sp, after(cpsidp_sp) 

drop bls*

// Decile of family income
*ssc install egenmore

global income "famincome famincome_married net_famincome net_famincome_married"

foreach i in $income {
egen `i'_decile = xtile(`i'), nq(10)
}

sort cpsidp mish

*Labelling for tables
label var black "Black"
label var female "Female"
label var age "Age"
label var highschool "High school"
label var somecollege "Some college"
label var collegeup "College"
label var becom_homeowner "Became homeowner"
label var s_to_m "Got married"
label var remain_married "Remain married"
label var m_to_d "Divorced or separated"
label var n_child_chg "Number of children changes"
label var children_chg "Change in the number of children"
label var log_faminc "Log of family income"
label var log_wage "Log of wage"
label var ft_pt "FT to PT"
label var pt_ft "PT to FT"
label var pt_always "PT to PT"
label var pt "Part-time"
label var homeworkhrs "Homework hours"
label var homeworkhrs_sp "Homework hours - Spouse"
label var pter "PTER"
label var pter_atus "PTER"
label var pter_sp "Spouse PTER"
label var pter_atus_sp "Spouse PTER"
label var nchild "Number of children"
label var nadults "Number of adults"



save cps_atus_merged_76_21, replace

****************************************************************************************************************************