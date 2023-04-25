*CPS reg
*Cleaning ASEC data

clear

global buildpter "~\Dropbox\Hours constraints and home prod\build"
*global buildpter "C:\Users\ilariamalisan\Dropbox\Hours constraints and home prod\build" // workstation
*cd "C:\Users\39328\Dropbox\Hours constraints and home prod\build\input\CPS-ATUS"
cd "$buildpter\input\CPS-ATUS"

import delimited cps_asec_76_21.csv // asec pre 75 is non linkable between years but we don't exploit that dimension
compress
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
compress
save cps_asec_76_21.dta, replace

use cps_asec_76_21.dta, clear

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

replace otpay = . if otpay == 99

replace classwkr = . if classwkr == 99


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
count if cpsidp == .
drop if cpsidp == .
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

gen in_lf = 0
replace in_lf = 1 if empstat>=10 & empstat<=22

// Employment - Out of LF as missing
gen employed = 0
replace employed = . if in_lf == 0
replace employed = 1 if empstat == 10 | empstat == 12  // at work or has job but not at work last week
tab employed, m
label var employed "Employed, out of LF as missing"
by cpsidp: gen into_employed = employed==1 & employed[_n-1]==0
label var into_employed "Into employment, out of LF as missing"

// Employment - Out of LF as zero
gen employed_alt = 0
replace employed_alt = 1 if empstat == 10 | empstat == 12  // at work or has job but not at work last week
tab employed_alt, m
label var employed_alt "Employed, out of LF as zero"
by cpsidp: gen into_employed_alt = employed_alt==1 & employed_alt[_n-1]==0
label var into_employed_alt "Into employment, out of LF as zero"

//Spouse LF
gen in_lf_sp = 0
replace in_lf_sp = 1 if empstat_sp>=10 & empstat_sp<=22

// Employment spouse - Out of LF as missing
gen employed_sp = 0
replace employed_sp = . if in_lf_sp == 0
replace employed_sp = 1 if empstat_sp == 10 | empstat_sp == 12  // at work or has job but not at work last week
tab employed_sp, m
label var employed_sp "Employed spouse, missing if out of LF"

// Employment spouse - Out of LF as zero
gen employed_sp_alt = 0
replace employed_sp_alt = 1 if empstat_sp == 10 | empstat_sp == 12  // at work or has job but not at work last week
tab employed_sp_alt, m
label var employed_sp_alt "Employed spouse, zero if out of LF"

//Selfemployed -- will use this as restriction. Same as employed will not drop if = 0 because of merge
gen selfempl = 0
replace selfempl = . if classwkr == . | classwkr == 0
replace selfempl = 1 if classwkr == 10 | classwkr == 13 | classwkr == 14

tab selfempl, m

//Unemployed - Out of LF as missing
gen unemp = 0
replace unemp = . if in_lf == 0
replace unemp = 1 if empstat == 20 | empstat == 21 | empstat == 22 // unemployed: experienced worker or new worker
tab unemp, m
label var unemp "Unemployed, missing if out of LF"
by cpsidp: gen into_unemp = unemp ==1 & unemp[_n-1]==0 if unemp!=.
label var into_unemp "Into unemployment, missing if out of LF"

//Unemployed - Out of LF as zero
gen unemp_alt = 0
replace unemp_alt = 1 if empstat == 20 | empstat == 21 | empstat == 22 // unemployed: experienced worker or new worker
tab unemp_alt, m
label var unemp_alt "Unemployed, zero if out of LF"
by cpsidp: gen into_unemp_alt = unemp_alt ==1 & unemp_alt[_n-1]==0
label var into_unemp_alt "Into unemployment, zero if out of LF"


*Restrictions
drop if age > 67 | age < 22
*keep if employed == 1 // Add this restriction to regressions
drop if statefip > 56 // grouped states, drops part of 1976
drop if year == 1976

// OTPAY -- will use this as restriction in one specification
replace otpay = 0 if otpay == 1
replace otpay = 1 if otpay == 2


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
tab wkstat unemp, m
tab wkstat unemp_alt, m // wkstat missing if out of LF so we're good

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
//out of LF is missing
gen pter = 0
replace pter = . if in_lf == 0
replace pter = 1 if whyptlwk == 010 | whyptlwk == 060 | whyptlwk == 020
*replace pter = . if whyptlwk ==.  
tab whyptlwk pter, m
order pter, after(everasec)
label var pter "PTER, missing if out of LF"
//out of LF is zero
gen pter_alt = 0
replace pter_alt = 1 if whyptlwk == 010 | whyptlwk == 060 | whyptlwk == 020
*replace pter = . if whyptlwk ==.  
tab whyptlwk pter_alt, m
order pter_alt, after(pter)
tab pter pter_alt
label var pter_alt "PTER, zero if out of LF"

* PTER Spouse
//out of LF is missing
gen pter_sp = 0
replace pter_sp = . if in_lf_sp == 0
replace pter_sp = 1 if whyptlwk_sp == 010 | whyptlwk_sp == 060 | whyptlwk_sp == 020
*replace pter_sp = . if whyptlwk_sp ==.  
tab whyptlwk_sp pter_sp, m
order pter_sp, after(pter)
label var pter_sp "Spouse PTER, missing if spouse out of LF"
//out of LF is zero
gen pter_sp_alt = 0
replace pter_sp_alt = 1 if whyptlwk_sp == 010 | whyptlwk_sp == 060 | whyptlwk_sp == 020
tab whyptlwk_sp pter_sp_alt, m
order pter_sp_alt, after(pter_sp)
label var pter_sp_alt "Spouse PTER, zero if spouse out of LF"

*Becoming PTER
//out of LF is missing
gen into_pter = 0
replace into_pter =. if pter == . | first == 1 | in_lf == 0
bys cpsidp: replace into_pter = 1 if pter[_n-1] == 0 & pter == 1 // becoming PTER
order into_pter, after(pter)
label var into_pter "Becoming PTER, missing if out of LF"
//out of LF is zero
gen into_pter_alt = 0
replace into_pter_alt =. if pter_alt == . | first == 1
bys cpsidp: replace into_pter_alt = 1 if pter_alt[_n-1] == 0 & pter_alt == 1 // becoming PTER
order into_pter_alt, after(into_pter)
label var into_pter_alt "Becoming PTER, zero if out of LF"

tab into_pter, m
tab pter pt, m
tab pter employed, m
tab wkstat if pt == 0 & pter == 1 // Full time schedules ?


* Log Family income = total family income - own earnings from work

* Assigning income values from asec to non asec months (should be ok since this is yearly)

gen famincome = hhincome - incwage
order famincome, after(into_pter)

foreach j of numlist 1/4{
bys cpsidp: replace famincome = famincome[_n+`j'] if missing(famincome)
bys cpsidp: replace famincome = famincome[_n-`j'] if missing(famincome)
}

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

foreach j of numlist 1/4{
bys cpsidp: replace famincome_married = famincome_married[_n+`j'] if missing(famincome_married)
bys cpsidp: replace famincome_married = famincome_married[_n-`j'] if missing(famincome_married)
}

//Log wage

*bys cpsidp year: egen incwage2 = min(inctot)
count if incwage == 0
gen log_wage = log(incwage+1)
order log_wage, after(incwage)

foreach j of numlist 1/4{
bys cpsidp: replace log_wage = log_wage[_n+`j'] if missing(log_wage)
bys cpsidp: replace log_wage = log_wage[_n-`j'] if missing(log_wage)
}

// Year-month dummies
tab month

gen monthly_date = mofd(mdy(month, 1, year))
format monthly_date %tm
order monthly_date, after(mish)
compress
sort cpsidp mish

cd "$buildpter\input\CPS-ATUS"
save asec_monthly_76_21.dta, replace

***********************************************
***********************************************
*ATUS

cd "$buildpter\input\CPS-ATUS"

clear

import delimited atus_03_20.csv

order cpsidp, after(year)
format cpsidp cpsidp_sp hrhhid_cps8 caseid %15.0f
order cpsidp_sp, after (cpsidp)

tab year

sort cpsidp year

*cd "$buildpter\output"
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
replace otpay = . if otpay >99999
replace clwkr = . if clwkr == 99

order year month cpsidp, first
sort cpsidp month
format cpsidp %15.0f

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

// Employment status - not in LF as missing
gen employed_atus = 0
replace employed_atus = . if empstat == 5
replace employed_atus = 1 if empstat == 1 | empstat == 2  // at work or has job but not at work last week
tab employed_atus, m
label var employed_atus "Employed ATUS, missing if not in LF"

// Employment status - not in LF as zero
gen employed_atus_alt = 0
replace employed_atus_alt = 1 if empstat == 1 | empstat == 2  // at work or has job but not at work last week
tab employed_atus_alt, m
label var employed_atus_alt "Employed ATUS, zero if not in LF"


// empstat_sp is always missing

// Spouse's employment status - missing if not in LF
gen employed_sp_atus = 0
replace employed_sp_atus = . if spempstat > 3
replace employed_sp_atus = 1 if spempstat == 1 | spempstat == 2  // at work or has job but not at work last week
replace employed_sp_atus = . if spempstat == .
tab employed_sp_atus, m

// Spouse's employment status - zero if not in LF
gen employed_sp_atus_alt = 0
replace employed_sp_atus_alt = 1 if spempstat == 1 | spempstat == 2  // at work or has job but not at work last week
replace employed_sp_atus_alt = . if spempstat == .
tab employed_sp_atus_alt, m

tab age 
rename age age_atus

*Restrictions
drop if age_atus > 67 | age_atus < 22
*keep if employed == 1

// Educ
tab educ, m

gen less_highschool_atus = 0
replace less_highschool_atus = 1 if educ <= 17

gen highschool_atus = 0
replace highschool_atus = 1 if educ == 20 | educ == 21

gen somecollege_atus = 0
replace somecollege_atus = 1 if educ >=  30 & educ <= 32

gen collegeup_atus = 0
replace collegeup_atus = 1 if educ >= 40 & educ != .

tab educ collegeup_atus

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

// PTER there are a lot of missing in whyptlwk_cps8
gen pter_atus = 0
replace pter_atus = 1 if whyptlwk_cps8 == 01 | whyptlwk_cps8 == 02
* "could only find part-time" category missing here!
*replace pter_atus = . if whyptlwk_cps8 ==.
tab pter_atus, m

// what should we do? try to merge with full cps monthly hoping there are less missing? call this pter_atus (even though this is from cps8) and check if it gets better after the merge with cps full monthly

// PTER spouse 
tab whyptlwk_cps8_sp, m

gen pter_atus_sp = 0
replace pter_atus_sp = 1 if whyptlwk_cps8_sp == 01 | whyptlwk_cps8_sp == 02
* "could only find part-time" category missing here!
*replace pter_atus_sp = . if whyptlwk_cps8_sp ==.
tab pter_atus_sp, m


/*
// PTER couple

gen pter_atus_couple = 0
replace pter_atus_couple = 1 if pter_atus == 1 & pter_atus_sp == 1 
// no risk of douple counting as only one individual per household enters atus
replace pter_atus_couple = . if pter_atus ==. | pter_atus_sp == .

tab pter_atus_couple, m
*/

// Self employed
gen selfempl_atus = 0
replace selfempl_atus = . if clwkr == .
replace selfempl_atus = 1 if clwkr == 6 | clwkr == 7

tab selfempl_atus, m

//Otpay = those potentially able to work more hours
gen otpay_atus = 0 if otpay == 0
replace otpay_atus= 1 if otpay > 0 & otpay != .

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

// Decile of family income
capture ssc install egenmore

global income "net_famincome net_famincome_married"

foreach i in $income {
egen `i'_decile = xtile(`i'), nq(10)
}

// Spouse hoursworked
tab spusualhrs, m

// Number of adults
gen hh_adults = hh_size - hh_numkids
replace hh_adults = . if hh_size == . | hh_numkids == .

// Rename year, month to prepare for merge
rename year year_atus
rename month month_atus

label var pter_atus "PTER"
label var pter_atus_sp "Spouse PTER"


cd "$buildpter\output"
compress
save atus_clean_03_20, replace
*************************************************
***********************************************
*Merging cps monthly with atus data

clear

cd "$buildpter\input\CPS-ATUS"
use asec_monthly_76_21

// Attach ATUS info to head cpsidp
cd "$buildpter\output"
mmerge cpsidp using atus_clean_03_20, _merge(_merge_atus) type(n:n)

/*

    Result                           # of obs.
    -----------------------------------------
    Result                           # of obs.
    -----------------------------------------
    not matched                    41,252,021
        from master                41,251,271  (_merge_atus==1)
        from using                        750  (_merge_atus==2)

    matched                         1,154,716  (_merge_atus==3)
    -----------------------------------------

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
cd "$buildpter\input\CPS-ATUS"

save cps_atus_merged_76_21, replace

// Attach ATUS info to CPS spouse cpsidp

clear

use atus_clean_03_20
rename cpsidp_sp cpsidp_sporiginal
rename cpsidp cpsidp_sp // to merge into cps spouse cpsidp 
*this helps in case the ATUS survey was completed by the spouse and the spouse does not appear as head but only as spouse in cps 
rename homeworkhrs homeworkhrs_sp
compress
save atus_clean_03_20_temp, replace

clear 

use cps_atus_merged_76_21

merge m:1 cpsidp_sp using atus_clean_03_20_temp, gen(_merge_atus_sp)

/*
    Result                           # of obs.
    -----------------------------------------
    not matched                    41,766,250
        from master                41,701,169  (_merge_atus_sp==1)
        from using                     65,081  (_merge_atus_sp==2)

    matched                           705,568  (_merge_atus_sp==3)
    -----------------------------------------

*/

sort cpsidp mish

order year month mish cpsid cpsidp cpsidp_sp, first
drop if cpsidp == .

save cps_atus_merged_76_21, replace


// Either spouse pter (CPS)
use cps_atus_merged_76_21,clear
gen pter_eitherspouse = 0
*replace pter_eitherspouse = . if pter ==. | pter_sp == .

replace pter_eitherspouse = 1 if pter == 1 & pter_sp == 1 

tab pter_eitherspouse, m // more

// Either spouse pter (atus)
gen pter_eitherspouse_atus = 0
*replace pter_eitherspouse_atus = . if pter_atus ==. | pter_atus_sp == .

replace pter_eitherspouse_atus = 1 if pter_atus == 1 & pter_atus_sp == 1 

tab pter_eitherspouse_atus, m // more

order pter into_pter pter_sp pter_atus pter_atus_sp pter_eitherspouse pter_eitherspouse_atus homeworkhrs homeworkhrs_sp, after(cpsidp_sp) 

drop bls*

// Decile of family income
capture ssc install egenmore

global income "famincome famincome_married"

foreach i in $income {
egen `i'_decile = xtile(`i'), nq(10)
}

sort cpsidp mish

bys cpsidp: gen temp = sum(employed)
gen ever_employed = 0
bys cpsidp: replace ever_employed = 1 if temp > 0 & temp != .
drop temp

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

*create state-level aggregate variablese
bysort monthly_date statefip: egen shr_married = mean(married)
bysort monthly_date statefip: egen sum_employed = total( employed )
gen labor_force = empstat>=10 & empstat<=22
bysort monthly_date statefip: egen sum_lf = total( labor_force  )
gen unemp_rt = 1-sum_employed /sum_lf
gen unemp_rt2 = unemp_rt^2
xtset cpsidp monthly_date
gen into_employed_sp = employed_sp==1 & l1.employed_sp==0
gen into_unemployed_sp = employed_sp==0 & l1.employed_sp==1
gen into_unemployed = employed==0 & l1.employed==1 // <<< Difference with into_unemp created in line 294 using _n-1 operator: if there are missing periods (which we have because of the way the panel works) the lag operator generates a missing value, while _n-1 operator uses the value from, for example, two periods ago
*br year month mish cpsidp employed unemp into_unemp into_unemployed empstat if cpsidp == 19910301021601 | cpsidp == 20181100302202 // for example of the above
egen state_monthyear_code = group(statefip monthly_date)
gen pter_conditional = pter if employed==1
gen pter_conditional_alt = pter_alt if employed_alt==1
bysort statefip monthly_date: egen pter_st = mean(pter_conditional)
bysort statefip monthly_date: egen unemp_st = mean(unemp)
bysort statefip monthly_date: egen pter_st_alt = mean(pter_conditional_alt)
bysort statefip monthly_date: egen unemp_st_alt = mean(unemp_alt)
compress
sort cpsidp mish
compress
save "${buildpter}\output\cps_atus_merged_76_21.dta", replace

*********************** Bartik IV for pter, into_pter, unemp

cd "$buildpter\output"

global var "pter into_pter"
global time "year my"

foreach t in $time {
* PTER

use year monthly_date employed female ind1950 wtfinl married statefip pter_conditional into_pter if married==1 & female==0 & employed==1 & ind1950 != . using  "${buildpter}\output\cps_atus_merged_76_21.dta", clear // employed, married men
rename monthly_date my
//ind1950==347, "Fabricated nonferrous metal products", doesn't appear until 2003. Combine with "Not specified metal industries"
replace ind1950 =348 if ind1950==347
if `t' == year{
	collapse (sum) E_ist = employed (mean) pter_is`t' = pter_conditional into_pter_is`t' = into_pter [aw=wtfinl], by(ind1950 statefip `t')
}
else if `t' == my{
	collapse (sum) E_ist = employed (mean) pter_is`t' = pter_conditional into_pter_is`t' = into_pter year [aw=wtfinl], by(ind1950 statefip `t')
}
bysort ind1950: egen E_i1977tmp = sum(E_ist) if year==1977
by ind1950: egen E_i1977 = min(E_i1977tmp) // employment in industry i in 1977 -- missing values for industry 347
drop E_i1977tmp
bysort ind1950 statefip: gen E_is1977tmp = E_ist if year==1977
bysort ind1950 statefip: egen E_is1977 = min(E_is1977tmp) // employment in industry i and state s in 1977
drop  E_is1977tmp
bys ind1950 `t': egen n_is`t'=count(statefip) // number of states with obs for time-ind pair

foreach v in $var{
bysort ind1950 `t': egen `v'_i`t' = sum(`v'_is`t')
gen `v'_i`t'_leaveout = (`v'_i`t' - `v'_is`t')/ (n_is`t' - 1)
gen `v'_ssc_is`t' = E_is1977/E_i1977 * `v'_i`t'_leaveout //shift-share component
bys ind1950 `t': egen `v'_i`t'_hat = sum(`v'_ssc_is`t')
gen `v'_is`t'_hat_leaveout = `v'_i`t'_hat - `v'_ssc_is`t'
	}
capture rename my monthly_date
compress
save "${buildpter}\temp\temp_pter_`t'.dta",replace

* Unemployment
use year monthly_date employed female ind1950 wtfinl married statefip unemp ever_employed if married==1 & female==0 & ever_employed==1  & ind1950 != . using  "${buildpter}\output\cps_atus_merged_76_21.dta", clear // EVER_employed, married men
//ind1950==347, "Fabricated nonferrous metal products", doesn't appear until 2003. Combine with "Not specified metal industries"
replace ind1950 =348 if ind1950==347

rename monthly_date my 
if `t' == year{
	collapse (sum) E_ist = employed U_ist=unemp (mean) unemp_is`t' = unemp [aw=wtfinl], by(ind1950 statefip `t')
}
else if `t' == my{
		collapse (sum) E_ist = employed U_ist=unemp (mean) unemp_is`t' = unemp year [aw=wtfinl], by(ind1950 statefip `t')
}
fillin ind1950 statefip `t'
bysort ind1950: egen E_i1977tmp = sum(E_ist) if year==1977
by ind1950: egen E_i1977 = min(E_i1977tmp) // employment in industry i in 1977 -- missing values for industry 347
drop E_i1977tmp
bysort ind1950 statefip: gen E_is1977tmp = E_ist if year==1977
bysort ind1950 statefip: egen E_is1977 = min(E_is1977tmp) // employment in industry i and state s in 1977
drop  E_is1977tmp
bysort ind1950 `t': egen unemp_i`t' = sum(unemp_is`t')
bys ind1950 `t': egen n_is`t'=count(statefip) // number of states with obs for time-ind pair
gen unemp_i`t'_leaveout = (unemp_i`t' - unemp_is`t')/ (n_is`t' - 1)
gen unemp_ssc_is`t' = E_is1977/E_i1977 * unemp_i`t'_leaveout //shift-share component
bys ind1950 `t': egen unemp_i`t'_hat = sum(unemp_ssc_is`t')
gen unemp_is`t'_hat_leaveout = unemp_i`t'_hat - unemp_ssc_is`t'
capture rename my monthly_date
compress
save "${buildpter}\temp\temp_unemp_`t'.dta",replace

}
*into unemp
global time "year my"
foreach t in $time {
use year monthly_date employed female ind1950 wtfinl married statefip unemp into_unemp ever_employed if married==1 & female==0 & ever_employed==1  & ind1950 != . using  "${buildpter}\output\cps_atus_merged_76_21.dta", clear // EVER_employed, married men
rename monthly_date my 
//ind1950==347, "Fabricated nonferrous metal products", doesn't appear until 2003. Combine with "Not specified metal industries"
replace ind1950 =348 if ind1950==347
if `t' == year{
	collapse (sum) E_ist = employed (mean) into_unemp_is`t' = into_unemp [aw=wtfinl], by(ind1950 statefip `t')
}
else if `t' == my{
		collapse (sum) E_ist = employed (mean) into_unemp_is`t' = into_unemp year [aw=wtfinl], by(ind1950 statefip `t')
}

bysort ind1950: egen E_i1977tmp = sum(E_ist) if year==1977
by ind1950: egen E_i1977 = min(E_i1977tmp) // employment in industry i in 1977 -- missing values for industry 347
drop E_i1977tmp
bysort ind1950 statefip: gen E_is1977tmp = E_ist if year==1977
bysort ind1950 statefip: egen E_is1977 = min(E_is1977tmp) // employment in industry i and state s in 1977
drop  E_is1977tmp
bysort ind1950 `t': egen into_unemp_i`t' = sum(into_unemp_is`t')
bys ind1950 `t': egen n_is`t'=count(statefip) // number of states with obs for time-ind pair
gen into_unemp_i`t'_leaveout = (into_unemp_i`t' - into_unemp_is`t')/ (n_is`t' - 1)
gen into_unemp_ssc_is`t' = E_is1977/E_i1977 * into_unemp_i`t'_leaveout //shift-share component
bys ind1950 `t': egen into_unemp_i`t'_hat = sum(into_unemp_ssc_is`t')
gen into_unemp_is`t'_hat_leaveout = into_unemp_i`t'_hat - into_unemp_ssc_is`t'
capture rename my monthly_date
compress
save "${buildpter}\temp\temp_into_unemp_`t'.dta",replace
}

use "${buildpter}\output\cps_atus_merged_76_21.dta", clear
merge m:1 ind1950 statefip year using "${buildpter}\temp\temp_pter_year.dta"
merge m:1 ind1950 statefip monthly_date using "${buildpter}\temp\temp_pter_my.dta", gen(_merge2)
merge m:1 ind1950 statefip year using "${buildpter}\temp\temp_unemp_year.dta", gen (_merge3)
merge m:1 ind1950 statefip monthly_date using "${buildpter}\temp\temp_unemp_my.dta", gen(_merge4)
merge m:1 ind1950 statefip monthly_date using "${buildpter}\temp\temp_into_unemp_my.dta", gen(_merge5)
merge m:1 ind1950 statefip year using "${buildpter}\temp\temp_into_unemp_year.dta", gen(_merge6)
compress
sort cpsidp mish

save "${buildpter}\output\cps_atus_merged_76_21_leaveout.dta",replace
****************************************************************************************************************************
