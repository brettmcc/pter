*CPS reg
*Cleaning ASEC data

clear

global build "C:\Users\39328\Dropbox\Hours constraints and home prod\build"
cd "$build\input\CPS-ATUS"

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

tab year
tab year if cpsid == 0 // 76-87 if they also have cpsid == 0 I cannot link them to basic monthly

count if cpsidp == 0 & cpsid == 0 // 1,728,423
tab year if cpsidp == 0 & cpsid == 0
drop if cpsidp == 0 & cpsid == 0

count if cpsidp == . & cpsid == . // 160,799
tab year if cpsidp == . & cpsid == .
drop if cpsidp == . & cpsid == .

count if cpsidp == 0 // 876,817
tab year if cpsidp == 0

gen flag_nocpsidp = 1 if cpsidp == 0

drop if cpsidp == 0  // oversampled for ASEC, would be duplicates

//checking id
sort cpsidp mish
sort cpsidp
bys cpsidp: gen agechange = age - age[_n-1]
drop if agechange <-2 | agechange>2 & agechange!=. // mistakes in id 795,554

tab agechange, m // missing are first occurrences of every id
br if agechange == -2


*Variables
label var hhincome "Household income during previous calendar year" // sum inctot for all members

replace hhincome = . if hhincome == 99999999
replace incwage = . if incwage == 999999999
replace race = . if race == 999
replace marst = . if marst == 9
replace ind1950 = . if ind1950 == 0
replace empstat = . if empstat == 0
replace hhtenure = . if hhtenure == 0
replace wkstat = . if wkstat == 99
replace whyptlwk = .  if whyptlwk < 10

// whyptlwk vs wkstat
tab wkstat whyptlwk
tab2xl whyptlwk wkstat using whyptlwk_wkstat, col(1) row(1)

*tipical household: 19760100000200 cpsid
* hhincome, incwage only observed in asec
egen everasec = max(asecflag), by(cpsid) // equivalent to bys

order everasec, after(asecflag)
replace everasec = 0 if everasec == .


order whyptlwk wkstat, after(incwage)

*Income info
tab year everasec, m
tab year asecflag, m

tab year asecflag if flag_nocpsidp == 1, m

*keep if everasec == 1 // Don't drop those not in asec, as we will have one specification without income

*Panel structure
isid cpsidp mish
sort cpsidp mish

duplicates report cpsidp mish
/*
duplicates tag cpsidp mish, gen (dup)
br if dup == 1
drop if flag_nocpsidp == 1
*/

xtset cpsidp mish

// Mish count
bys cpsidp (mish): egen ncount = count(cpsidp)
tab ncount

tsset cpsidp mish

//

*Dummies
gen female = 0
replace female = 1 if sex == 2 & sex != .

gen black = 0
replace black = 1 if race == 200 & race != .

gen married = 0 
replace married = 1 if marst == 1 & marst != . | marst == 2 & marst != .

tab married

//Lifecycle events
* Homeowner status changes
gen howner = 0
replace howner = 1 if hhtenure == 1

bys cpsidp: gen homeown_chg = howner != l.howner if howner != . & l.howner != .

*Marital status changes 
bys cpsidp: gen marst_chg = married != l.married if married != . & l.married != .

*Number of children changes
sort cpsidp mish

by cpsidp (mish): gen first = 1 if _n == 1

bys cpsidp: gen children_chg = . if first == 1

bys cpsidp: replace children_chg = nchild[_n] != nchild[_n-1] if first != 1

bys cpsidp: egen n_child_chg = sum(children_chg)

//Empstat

gen employed = 0
replace employed = 1 if empstat == 10 | empstat == 12  // at work or has job but not at work last week


*Restrictions
drop if age > 67 | age < 22
keep if employed == 1

// Educ

gen less_highschool = 0
replace less_highschool = 1 if educ <= 71

gen highschool = 0
replace highschool = 1 if educ == 72 | educ == 73

gen somecollege = 0
replace somecollege = 1 if educ >=  80 & educ <= 110

gen collegeup = 0
replace collegeup = 1 if educ >= 111

//Industry
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


*PTER: Becoming PTER
gen pter = 0
replace pter = 1 if whyptlwk == 010 | whyptlwk == 060 | whyptlwk == 020

tab pter whyptlwk
order pter, after(everasec)

bys cpsidp: gen into_pter = (l.pter == 0 & pter == 1) // becoming PTER
order into_pter, after(pter_)


* Log Family income = total family income - own earnings

* Assigning income values from asec to non asec months (should be ok since this is yearly)

gen famincome = hhincome - incwage
order famincome, after(pter)

// Log of family income
gen log_faminc = log(famincome)
order log_faminc, after(hhincome2)

foreach j of numlist 1/4{
bys cpsidp: replace log_faminc = log_faminc[_n+`j'] if missing(log_faminc)
bys cpsidp: replace log_faminc = log_faminc[_n-`j'] if missing(log_faminc)
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

//Household income
bys cpsidp: egen flag = sum (asecflag) // flag for twice in asec
order flag, after(asecflag)
tab flag
tab everasec, m

*bys cpsidp year: egen hhincome2 = min(hhincome) // try without this bit
gen hhincome2 = hhincome

foreach j of numlist 1/4{
bys cpsidp: replace hhincome2 = hhincome2[_n+`j'] if missing(hhincome2)
bys cpsidp: replace hhincome2 = hhincome2[_n-`j'] if missing(hhincome2)
}
order hhincome2, after(hhincome)


//Log wage

*bys cpsidp year: egen incwage2 = min(inctot)
gen log_wage = log(incwage)

foreach j of numlist 1/4{

bys cpsidp: replace log_wage = log_wage[_n+`j'] if missing(log_wage)
bys cpsidp: replace log_wage = log_wage[_n-`j'] if missing(log_wage)
}

order log_wage, after(hhincome2)

//FT - PT status changes



// Year-month dummies
tab month
tab month if flag == 2

gen monthly_date = mofd(mdy(month, 1, year))
format monthly_date %tm
order monthly_date, after(mish)



cd "$build\output"

save asec_monthly_76_21.dta, replace
