*CPS reg
*Cleaning ASEC data

clear

global build "C:\Users\39328\Dropbox\Hours constraints and home prod\build"
cd "$build\input\CPS-ATUS"

import delimited cps_asec_67_21.csv // asec pre 75 is non linkable between years but we don't exploit that dimension

*Sample
tab year
drop if year < 1976 // this is only ASEC, fix the ipums extract

tab month asecflag if month == 3
drop if month == 3 & asecflag == 2 // dropping March basic while keeping ASEC to avoid double counting

sort cpsid mish
order mish, after(month)

tab month if cpsidp == . 
tab month if cpsidp == 0

count if cpsidp == .& cpsid == .

*Respondents who are part of the ASEC oversample (as indicated by ASECOVERP) have a CPSIDP value of 0 


**
save cps_asec_76_21.dta, replace

*Sample
*sort cpsid year month pernum
sort cpsidp mish
order cpsid cpsidp, after(month)

order serial, last

order incwage, after(hhincome)
format cpsid cpsidp hrhhid %14.0f


tab year if cpsid == 0 // 76-87 if they also have cpsid == 0 I cannot link them to basic monthly

count if cpsidp == 0 & cpsid == 0 // 95,079
tab year if cpsidp == 0 & cpsid == 0
drop if cpsidp == 0 & cpsid == 0

count if cpsidp == . & cpsid == . // 160,799
tab year if cpsidp == . & cpsid == .
drop if cpsidp == . & cpsid == .

count if cpsidp == 0 // 876,817
tab year if cpsidp == 0

preserve
drop if cpsidp == 0 

tab year

restore

drop if cpsidp == 0  // oversampled for ASEC, set aside for the time being

sort cpsidp mish

*tipical household: 19760100000200 cpsid
* hhincome, inctot only observed in asec
* households that never appear in asec have no use for the analysis
egen everasec = max(asecflag), by(cpsid) // equivalent to bys

order everasec, after(asecflag)


order whyptlwk, after(incwage)

* I can only work with everasec == 1 because that's where info on income is collected. still I won't be able to compute yearly changes as most individual enter asec only once.
* The only option would be to consider individuals who happen to enter asec twice because of the survey design
tab year everasec, m

keep if everasec == 1 

*Panel structure
xtset cpsidp mish

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
bys cpsidp: gen children_chg = nchild - l.nchild

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

save asec_monthly_76_87.dta, replace


********************************************************************************
********************************************************************************
*Longitudinal asec

* We keep individuals whose mish 1 go from Dec to March (=include March ASEC) so that also mish 5 go from Dec to March (=include March ASEC) --> 1/3 of cps basic monthly sample appears twice in ASEC, for them we can compute change in log earnings 
cd "$build\input\CPS-ATUS"

clear 

import delimited long_asec_78_86.csv  // wide format

*Sample
order cpsid cpsidp, after(month_2)
order serial*, last
format cpsid cpsidp hrhhid %14.0f

sort cpsidp mish_1
order mish*, after(month_2)

count if cpsidp == .& cpsid == .

order inctot*, after(hhincome_2)
drop asecflag* // always = 1

foreach j of numlist 1/2 {
label var hhincome_`j' "Household income during previous calendar year" // sum inctot for all members

replace hhincome_`j' = . if hhincome_`j' == 99999999
replace inctot_`j' = . if inctot_`j' == 999999999
replace race_`j' = . if race_`j' == 999
replace marst_`j' = . if marst_`j' == 9
replace ind1950_`j' = . if ind1950_`j' == 0
replace empstat_`j' = . if empstat_`j' == 0

}

assert sex_1 == sex_2
gen flag = 1 if sex_1 != sex_2

gen flag2 = age_2 - age_1
drop if flag == 1 & flag2 > 2 // mistakes in matching
drop if flag2 > 2
drop if flag2 < 0
tab flag
drop if flag == 1
tab flag2

gen flag3 = 1 if race_1 != race_2
assert race_1 == race_2
drop if flag3 == 1


//Empstat
foreach j of numlist 1/2 {
gen employed_`j' = 0
replace employed_`j' = 1 if empstat_`j' == 10 | empstat_`j' == 12  // at work or has jub but not at work last week
}

*Restrictions
drop if age_1 > 67 | age_1 < 22
keep if employed_1 & employed_2 == 1

isid cpsidp // nice

*Dummies
gen female = 0
replace female = 1 if sex_1 == 2 & sex_1 != .

gen black = 0
replace black = 1 if race_1 == 200 & race_1 != .

foreach j of numlist 1/2 {
gen married_`j' = 0 // build changes in marital status? for the time being dummy based on time 1
replace married_`j' = 1 if marst_`j' == 1 & marst_`j' != . | marst_`j' == 2 & marst_`j' != .
}

tab married_1 married_2

// Educ
foreach j of numlist 1/2 {

gen less_highschool_`j' = 0
replace less_highschool_`j' = 1 if educ_`j' <= 71

gen highschool_`j' = 0
replace highschool_`j' = 1 if educ_`j' == 72 | educ_`j' == 73

gen somecollege_`j' = 0
replace somecollege_`j' = 1 if educ_`j' >=  80 & educ_`j' <= 110

gen collegeup_`j' = 0
replace collegeup_`j' = 1 if educ_`j' >= 111
}

tab collegeup_1 collegeup_2 // what about downwards movements?

//Industry
foreach j of numlist 1/2 {
gen industry_`j' = .
replace industry_`j' = 1 if ind1950_`j' <200
replace industry_`j' = 2 if ind1950_`j' >=200 & ind1950_`j' <300
replace industry_`j' = 3 if ind1950_`j' >=300 & ind1950_`j' <400
replace industry_`j' = 4 if ind1950_`j' >=400 & ind1950_`j' <500
replace industry_`j' = 5 if ind1950_`j' >=500 & ind1950_`j' <600
replace industry_`j' = 6 if ind1950_`j' >=600 & ind1950_`j' <700
replace industry_`j' = 7 if ind1950_`j' >=700 & ind1950_`j' <800
replace industry_`j' = 8 if ind1950_`j' >=800 & ind1950_`j' <900
replace industry_`j' = 9 if ind1950_`j' >=900 & ind1950_`j' <= 936

tab industry_`j', gen(d_industry_`j')
}

*PTER
foreach j of numlist 1/2 {
	gen pter_`j' = 0
	replace pter_`j' = 1 if whyptlwk_`j' == 010 | whyptlwk_`j' == 060 | whyptlwk_`j' == 020
	
}
tab pter_1 whyptlwk_1
tab pter_1 pter_2


* Log change in Family income = total family income - own earnings

order hhincome* inctot*, after(pter_2)
order mish*, after(month_2)
order faminc*, last

foreach j of numlist 1/2 {
	gen famincome_`j' = hhincome_`j' - inctot_`j'
}
order famincome*, after(inctot_2)

gen chglog_faminc = log(famincome_2)-log(famincome_1)
label variable chglog_faminc "Chg. ln of family income"
order chglog_faminc, after(famincome_2) // how should I treat missing because of log 0?


*Log change in wage
* Lifecycle

// Year-month dummies
* month is always == 3 because this is asec!
/*
foreach j of numlist 1/2 {
gen monthly_date_`j' = mofd(mdy(month_`j', 1, year_`j'))
format monthly_date_`j' %tm
}
*/

cd "$build\output"

save wide_asec_78_86.dta, replace

reshape long year_ month_ mish_ hhincome_ inctot_ famincome_ pernum_ age_ sex_ race_ marst_ ind1950_ whyptlwk_ wkstat_ educ_ pter_ married_ less_highschool_ highschool_ somecollege_ collegeup_ industry_, i(cpsidp) j(t)

save long_asec_78_86.dta, replace // long format

