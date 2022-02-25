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
format cpsid cpsidp hrhhid %15.0f
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

replace hhincome = . if hhincome == 99999999
replace incwage = . if incwage == 99999999
replace race = . if race == 999
replace marst = . if marst == 9
replace ind1950 = . if ind1950 == 0
replace empstat = . if empstat == 0
replace hhtenure = . if hhtenure == 0
replace wkstat = . if wkstat == 99
replace whyptlwk = .  if whyptlwk < 10

sort cpsidp mish

// whyptlwk vs wkstat
tab wkstat whyptlwk
tab2xl whyptlwk wkstat using whyptlwk_wkstat, col(1) row(1)

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

order becom_homeowner, after(howner)// very few ones

*Marital status changes 
/*
bys cpsidp: gen marst_chg = married != married[_n-1] if married != . & married[_n-1] != .
tab marst_chg, m
order marst_chg, after(married)
*/

gen married = 0 
replace married = 1 if marst == 1 & marst != . | marst == 2 & marst != . // no missing marst

gen divorced = 0 // diverced includes separated and widowed (widowed listed together with divorced for early years)
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

//Empstat

gen employed = 0
replace employed = 1 if empstat == 10 | empstat == 12  // at work or has job but not at work last week
tab employed, m


*Restrictions
drop if age > 67 | age < 22
keep if employed == 1

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

*PTER: Becoming PTER
gen pter = 0
replace pter = 1 if whyptlwk == 010 | whyptlwk == 060 | whyptlwk == 020
replace pter = . if whyptlwk ==.  

tab whyptlwk pter, m
order pter, after(everasec)

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

foreach j of numlist 1/4{
bys cpsidp: replace log_faminc = log_faminc[_n+`j'] if missing(log_faminc)
bys cpsidp: replace log_faminc = log_faminc[_n-`j'] if missing(log_faminc) // check with brett
}

/*
bys cpsidp: gen chglog_faminc = log(famincome)-log(famincome[_n-4]) //NB this holds only for the double march individuals!
label variable chglog_faminc "Chg. ln of family income"
order chglog_faminc, after(famincome) // how should I treat missing because of log 0?

*Assign change in yearly income to other obs in the same year
foreach j of numlist 1/4{
bys cpsidp: replace chglog_faminc = chglog_faminc[_n+`j'] if missing(chglog_faminc)
bys cpsidp: replace chglog_faminc = chglog_faminc[_n-`j'] if missing(chglog_faminc)
}
*/


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
format cpsidp hrhhid_cps8 caseid %15.0f

tab year

sort cpsidp year

save atus_03_20.dta, replace

count if cpsidp == 0 | cpsidp == . //linking key with monthly CPS 

* CPSIDP_SP identifies spouse in CPS

*Variables
label var famincome "Family's total annual income" // same as hhincome in cps, but these are classes of income
label var earnweek "Weekly earnings at ATUS time"
label var spusualhrs " Usual work hours (spouse or partner), ATUS time"
label var act_hhact "Minutes per day spent in household activities"

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

*Dummies
gen female = 0
replace female = 1 if sex == 2 & sex != .

gen black = 0
replace black = 1 if race == 110 & race != . // most conservative, discuss with brett
tab race black, m

// Marital status
gen married = 0 
replace married = 1 if marst == 1 & marst != . | marst == 2 & marst != . // also consider as married if spouse is not present, doublecheck

gen divorced = 0 // diverced includes separated and widowed (widowed listed together with divorced for early years)
replace divorced = 1 if marst == 3 | marst == 4 | marst == 5

gen single = 0
replace single = 1 if marst == 6

order married divorced single, after(marst)
tab married, m
tab divorced, m
tab single, m

// Employment status
gen employed = 0
replace employed = 1 if empstat == 1 | empstat == 2  // at work or has job but not at work last week
tab employed, m

// empstat_sp is always missing

// Spouse's employment status
gen employed_sp = 0
replace employed_sp = 1 if spempstat == 1 | spempstat == 2  // at work or has job but not at work last week
replace employed_sp = . if spempstat == .
tab employed_sp, m

tab age 

*Restrictions
drop if age > 67 | age < 22
keep if employed == 1

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

gen pt = 0
replace pt = . if fullpart ==.
replace pt = 1 if fullpart == 2

gen ft = 0
replace ft = . if fullpart ==.
replace ft = 1 if fullpart == 1

tab pt ft, m

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

tab pter_atus pter_atus_sp, m // only 53 couples would be pter 
/*
           |           pter_atus_sp
 pter_atus |         0          1          . |     Total
-----------+---------------------------------+----------
         0 |       990         43      7,092 |     8,125 
         1 |        31         53      1,254 |     1,338 
         . |     2,935        501    110,920 |   114,356 
-----------+---------------------------------+----------
     Total |     3,956        597    119,266 |   123,819 
*/

// PTER couple

gen pter_atus_couple = 0
replace pter_atus_couple = 1 if pter_atus == 1 & pter_atus_sp == 1 
// no risk of douple counting as only one individual per household enters atus
replace pter_atus_couple = . if pter_atus ==. | pter_atus_sp == .

tab pter_atus_couple, m

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
/*
gen net_famincome = famincome - income - income_sp
order net_famincome income income_sp, after(famincome)
*/

// Spouse hoursworked
tab spusualhrs, m

save atus_clean_03_20, replace

***********************************************
*Merging cps monthly with atus data

clear

import delimited linking_keys_cps_atus.csv // contains SPLOC = partner indicator for cps basic monthly 

order cpsidp cpsid sploc cpsidp_sp pernum_sp, after(month)
format cpsidp cpsid cpsidp_sp hrhhid %15.0f

sort cpsidp mish

drop hwtfinl asecflag hflag asecwth wtfinl asecwt 

save linking_keys_cps_atus, replace

***
merge m:m cpsidp using asec_monthly_76_21
// Need info on incwage and hoping to get wider sample for both spouses pter


/*

    Result                           # of obs.
    -----------------------------------------
    not matched                    36,578,547
        from master                19,960,561  (_merge==1)
        from using                 16,617,986  (_merge==2)

    matched                        17,410,964  (_merge==3)
    -----------------------------------------

*/

keep if year >= 2001 // could be in atus 2003
/*
                 _merge |      Freq.     Percent        Cum.
------------------------+-----------------------------------
        master only (1) | 19,960,561       53.41       53.41
            matched (3) | 17,410,964       46.59      100.00
------------------------+-----------------------------------
                  Total | 37,371,525      100.00
*/


keep if _merge == 3

drop _merge
*Now we have person id + spouse id + cps monthly info on person
global head_info "year month cpsidp sploc mish pernum monthly_date hwtfinl asecflag everasec pter into_pter famincom log_faminc hflag asecwth hhtenure howner  becom_homeowner homeown_chg hhincome incwage log_wage wtfinl asecwt age sex race marst married divorced single s_to_m remain_married m_to_d remain_single nchild children_chg n_child_chg empstat ind ind1950 whyptlwk wkstat pt ft pt_ft ft_pt pt_always ft_always educ female black marst_chg first employed less_highschool highschool somecollege collegeup industry ncount tot_mish count_ft count_pt max_ft max_pt"

foreach i in $head_info {
	rename `i' `i'_head
}

*Merge again to get cps monthly info on spouse 

rename cpsidp_sp cpsidp // spouse's id, so that I can merge her cps monthly info

merge m:m cpsidp using asec_monthly_76_21

keep if year >= 2001 // could be in atus 2003


/*
                 _merge |      Freq.     Percent        Cum.
------------------------+-----------------------------------
        master only (1) |  7,819,437       33.32       33.32
         using only (2) |  5,895,880       25.12       58.44
            matched (3) |  9,751,916       41.56      100.00
------------------------+-----------------------------------
                  Total | 23,467,233      100.00
*/

drop if _merge == 2 // spouse info without head info

global spouse_info "year month cpsidp sploc_sp mish pernum monthly_date hwtfinl asecflag everasec pter into_pter famincome log_faminc hflag asecwth hhtenure howner  becom_homeowner homeown_chg hhincome incwage log_wage wtfinl asecwt age sex race marst married divorced single s_to_m remain_married m_to_d remain_single nchild children_chg n_child_chg empstat ind ind1950 whyptlwk wkstat pt ft pt_ft ft_pt pt_always ft_always educ female black marst_chg first employed less_highschool highschool somecollege collegeup industry ncount tot_mish count_ft count_pt max_ft max_pt"

foreach i in $spouse_info {
	rename `i' `i'_spouse
}

//Obtained head cpsmonthly + spouse cpsmonthly dataset

save head_spouse_cps, replace

// Combining with head's atus info
rename cpsidp_head cpsidp 

merge m:1 cpsidp using atus_clean_03_20, gen(_merge_atus)

/*
    Result                           # of obs.
    -----------------------------------------
    not matched                    16,430,406
        from master                16,427,493  (_merge_atus==1)
        from using                      2,913  (_merge_atus==2)

    matched                           924,125  (_merge_atus==3)
    -----------------------------------------
*/

keep if _merge_atus == 3

tab _merge

tab year



*** Creating variables which were not possible with atus only

// Family income net of both spouses' labor income

* --> household income from cps monthly

count if income != .
count if incwage_head != .

count if income_sp != .
count if incwage_spouse != .

count if hhincome_head != .
count if famincome != .

*Issue: famincome is categorical, but hhincome is missing for lots of individuals. For the time being use categorical famincome + head and spouse wage as controls

// PTER couple

gen pter_cps_couple = 0
replace pter_cps_couple = 1 if pter_head == 1 & pter_spouse == 1 
// double counting?
replace pter_cps_couple = . if pter_head ==. | pter_spouse == .

tab pter_cps_couple, m // more

tab pter_atus_couple, m


***
save cps_atus_merged_headspouse, replace

