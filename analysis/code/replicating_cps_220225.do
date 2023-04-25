* Estimating equation 1 and 2 using CPS

//global pre "C:\Users\Brett\Dropbox\"
global pre "C:\Users\Brett's Workstation\Dropbox\"
global build "$pre\Hours constraints and home prod\build"

global analysis "$pre\Hours constraints and home prod\analysis"

cd "$build\output"

clear all

*EQUATION 1


*Option 1:
*Sample ASEC + basic monthly, only those who appear twice in asec have nonmissing change in earnings
*ASEC + Basic Monthly, Use log earnings as a control --> bigger longitudinal sample
*ssc install reghdfe
*ssc install erepost
*ssc install estout

global demographic "age i.black i.female"
global demographic2 "age i.black"

global educ "i.highschool i.somecollege i.collegeup" //omitted: less than high school
global lifecycle "becom_homeowner s_to_m remain_married m_to_d n_child_chg" // omitted: remained single

global lifecycle2 "becom_homeowner s_to_m remain_married m_to_d children_chg" // omitted: remained single.
*Change in the number of children instead of number of children change

global employment "ft_pt pt_ft pt_always" // omitted: FT always
global employment2 "ft_pt pt_ft pt" // omitted: FT.

global income "log_faminc log_wage"

cd "$analysis\output"

xtset cpsidp mish

// Should I cluster standard errors to the individual / household level in equation 1?

*** 1. ASEC + Basic Monthly, controlling for log income and log wage

reghdfe into_pter $demographic $educ $lifecycle $income i.industry $employment if employed == 1, absorb(monthly_date) vce(robust) nocons

sum into_pter if employed == 1
local mean = r(mean)
estadd scalar mean = `mean'
estadd local pfe "N"
estadd local yfe "Y"
estadd local controls "Y"
estadd local income "Y"
eststo eq11, refresh 

*Male only

reghdfe into_pter $demographic2 $educ $lifecycle $income i.industry $employment if employed == 1 & female == 0, absorb(monthly_date) vce(robust) nocons

sum into_pter if employed == 1 & female == 0
local mean = r(mean)
estadd scalar mean = `mean'
estadd local pfe "N"
estadd local yfe "Y"
estadd local controls "Y"
estadd local income "Y"
eststo eq11m, refresh 


*Female only 

reghdfe into_pter $demographic2 $educ $lifecycle $income i.industry $employment if employed == 1 & female == 1, absorb(monthly_date) vce(robust) nocons

sum into_pter if employed == 1 & female == 1
local mean = r(mean)
estadd scalar mean = `mean'
estadd local pfe "N"
estadd local yfe "Y"
estadd local controls "Y"
estadd local income "Y"
eststo eq11w, refresh 


*** 2. ASEC + Basic Monthly, without controlling for log income and log wage

reghdfe into_pter $demographic $educ $lifecycle i.industry $employment if employed == 1, absorb(monthly_date) vce(robust) nocons

sum into_pter if employed == 1
local mean = r(mean)
estadd scalar mean = `mean'
estadd local pfe "N"
estadd local yfe "Y"
estadd local controls "Y"
estadd local income "N"
eststo eq12, refresh 

*Male only
reghdfe into_pter $demographic2 $educ $lifecycle i.industry $employment if employed == 1 & female == 0, absorb(monthly_date) vce(robust) nocons

sum into_pter if employed == 1 & female == 0
local mean = r(mean)
estadd scalar mean = `mean'
estadd local pfe "N"
estadd local yfe "Y"
estadd local controls "Y"
estadd local income "N"
eststo eq12m, refresh 

*Female only
reghdfe into_pter $demographic2 $educ $lifecycle i.industry $employment if employed == 1 & female == 1, absorb(monthly_date) vce(robust) nocons

sum into_pter if employed == 1 & female == 1
local mean = r(mean)
estadd scalar mean = `mean'
estadd local pfe "N"
estadd local yfe "Y"
estadd local controls "Y"
estadd local income "N"
eststo eq12w, refresh 


*** 3. ASEC + Basic Monthly, without controlling for log income and log wage + individual FE
* Substituting n_child_chg with children_chg and pt_always with pt (otherwise omitted because of collinearity)

reghdfe into_pter $demographic $educ $lifecycle2 i.industry $employment2 if employed == 1, absorb(cpsidp monthly_date) vce(robust) nocons

sum into_pter if employed == 1
local mean = r(mean)
estadd scalar mean = `mean'
estadd local pfe "Y"
estadd local yfe "Y"
estadd local controls "Y"
estadd local income "N"
eststo eq13, refresh 

*Male only
reghdfe into_pter $demographic2 $educ $lifecycle2 i.industry $employment2 if employed == 1 & female == 0, absorb(cpsidp monthly_date) vce(robust) nocons

sum into_pter if employed == 1 & female == 0
local mean = r(mean)
estadd scalar mean = `mean'
estadd local pfe "Y"
estadd local yfe "Y"
estadd local controls "Y"
estadd local income "N"
eststo eq13m, refresh 

*Female only
reghdfe into_pter $demographic2 $educ $lifecycle2 i.industry $employment2 if employed == 1 & female == 1, absorb(cpsidp monthly_date) vce(robust) nocons

sum into_pter if employed == 1 & female == 1
local mean = r(mean)
estadd scalar mean = `mean'
estadd local pfe "Y"
estadd local yfe "Y"
estadd local controls "Y"
estadd local income "N"
eststo eq13w, refresh 


esttab eq11 eq12 eq13 eq11m eq12m eq13m eq11w eq12w eq13w using eq1.tex, replace se r2 label scalars("mean Dep. var. mean" "pfe Person FE" "yfe Year-month FE" "controls Controls" "income Income") nonotes star(* 0.10 ** 0.05 *** 0.01) ///
keep($demographic $demographic2 $educ $lifecycle $lifecycle2 $income $employment $employment2 , relax ) booktabs ///
mgroups("Overall" "Men" "Women",pattern(1 0 0 1 0 0 1 0 0) span prefix(\multicolumn{@span}{c}{) suffix(}) end(\cmidrule(lr){2-4}\cmidrule(lr){5-7}\cmidrule(lr){8-10})) mtitle("\shortstack{Becomin\\PTER}" "\shortstack{Becoming\\PTER}" "\shortstack{Becoming\\PTER}" "\shortstack{Becoming\\PTER}" "\shortstack{Becoming\\PTER}" "\shortstack{Becoming\\PTER}" "\shortstack{Becoming\\PTER}" "\shortstack{Becoming\\PTER}" "\shortstack{Becoming\\PTER}") /// WORK ON THIS
	substitute("\_" "_" "{l}{\footnotesize" "{p{17cm}}{\footnotesize" ) ///
	addnotes("\textit{Notes}: The table presents coefficient estimates from equation \ref{eq:EQUATION 1 CPS} using data from the Current Population Survey. Columns 4 -- 6 subset to male workers, while columns 7 -- 9 subset to female workers. Control variables are age, race, educational attainment, howeowner status, marital status and number of children changes, full-time, part-time changes. Columns 1 -- 3 also control for gender. Columns 1, 4 and 7 control for the logarithm of family income (net of head labor income) and the logarithm of head labor income. Columns 3, 6 and 9 control for changes in number of children instead of number of children changes. Heteroskedasticity-robust standard errors are reported. \sym{*}, \sym{**}, and \sym{***} denote statistical significance at the 10\%, 5\%, and 1\% levels, respectively.") // work on this
	
********************************************************************************
*EQUATION 2

* HOME WORK HOURS - SELF

*CPS dataset
	/*
* CPS variables
* DOES IT MAKE SENSE WITH CPS DATASET?
* LEFT IT ASIDE FOR THE TIME BEING

use cps_atus_merged_76_21, clear

// Single
*With income controls
keep if year > 2001
drop if nadults > 13

reghdfe homeworkhrs pter nchild nadults i.famincome_decile if single == 1 & employed==1, absorb(year) vce(cluster cpsid) nocons 
// without controlling for pt because pter is only defined for those working pt in this regression (not a given since it is defined from whyptlwk)

// cannot add individual fe since income and homeworkhrs is only observed once per individual (and household)

// if individual FE can't be included, should we go back to control for demographics?

sum homeworkhrs if single == 1 & employed==1
local mean = r(mean) 
estadd scalar mean = `mean'
estadd local pfe "N"
estadd local yfe "Y"
estadd local controls "Y"
estadd local income "Y"
eststo eq2s, refresh

*Without income controls
reghdfe homeworkhrs pter nchild nadults if single == 1 & employed==1, absorb(year) vce(cluster cpsid) nocons

// did not add individual fe since homeworkhrs is only observed once per individual 
// id fe would go through nonetheless as homeworkhrs is repeated equal for every observation in cps

sum homeworkhrs if single == 1 & employed==1
local mean = r(mean)
estadd scalar mean = `mean'
estadd local pfe "N"
estadd local yfe "Y"
estadd local controls "Y"
estadd local income "N"
eststo eq2sni, refresh

// Married
* CPS variables
*With income controls

reghdfe homeworkhrs pter nchild nadults i.famincome_married_decile if married == 1 & employed == 1, absorb(year) vce(cluster cpsid) nocons

// pt excluded because of collinearity

sum homeworkhrs if married == 1 & employed == 1
local mean = r(mean)
estadd scalar mean = `mean'
estadd local pfe "N"
estadd local yfe "Y"
estadd local controls "Y"
estadd local income "Y"
eststo eq2m, refresh

*Without income controls
reghdfe homeworkhrs pter nchild nadults if married == 1 & employed == 1, absorb(year) vce(cluster cpsid) nocons

sum homeworkhrs if married == 1 & employed == 1
local mean = r(mean)
estadd scalar mean = `mean'
estadd local pfe "N"
estadd local yfe "Y"
estadd local controls "Y"
estadd local income "N"
eststo eq2mni, refresh

// Married men

*With income controls

reghdfe homeworkhrs pter nchild nadults i.famincome_married_decile pt if married == 1 & employed == 1 & female == 0, absorb(year) vce(cluster cpsid) nocons // pter couple from cps

sum homeworkhrs if married == 1 & employed == 1 & female == 0
local mean = r(mean)
estadd scalar mean = `mean'
estadd local pfe "Y"
estadd local yfe "Y"
estadd local controls "Y"
estadd local income "Y"
eststo eq2mm, refresh

*Without income controls
reghdfe homeworkhrs pter nchild nadults pt if married == 1 & employed == 1 & female == 0, absorb(cpsipd year) vce(cluster cpsid) nocons

sum homeworkhrs if married == 1 & employed == 1 & female == 0
local mean = r(mean)
estadd scalar mean = `mean'
estadd local pfe "Y"
estadd local yfe "Y"
estadd local controls "Y"
estadd local income "N"
eststo eq2mmni, refresh

// Married women

*With income controls

reghdfe homeworkhrs pter nchild nadults i.famincome_married_decile pt if married == 1 & employed == 1 & female == 1, absorb(cpsipd year) vce(cluster cpsid) nocons // pter couple from cps

sum homeworkhrs if married == 1 & employed == 1 & female == 1
local mean = r(mean)
estadd scalar mean = `mean'
estadd local pfe "Y"
estadd local yfe "Y"
estadd local controls "Y"
estadd local income "Y"
eststo eq2mw, refresh

*Without income controls
reghdfe homeworkhrs pter nchild nadults pt if married == 1 & employed == 1 & female == 1, absorb(cpsipd year) vce(cluster cpsid) nocons // pter couple from cps

sum homeworkhrs if married == 1 & employed == 1 & female == 1
local mean = r(mean)
estadd scalar mean = `mean'
estadd local pfe "Y"
estadd local yfe "Y"
estadd local controls "Y"
estadd local income "N"
eststo eq2mwni, refresh

esttab eq2s eq2sni eq2m eq2mni eq2mm eq2mmni eq2mw eq2mwni using eq2_homeworkhours_cps.tex, replace se r2 label scalars("mean Dep. var. mean" "pfe Person FE" "yfe Year FE" "controls Controls" "income Income") nonotes star(* 0.10 ** 0.05 *** 0.01) ///
keep(pter) booktabs ///
mgroups("Single" "Married",pattern(1 0 1 0 0 0 0 0) span prefix(\multicolumn{@span}{c}{) suffix(}) end(\cmidrule(lr){2-3}\cmidrule(lr){4-9})) ///
mgroups("Men" "Women",pattern(0 0 0 0 1 0 1 0) span prefix(\multicolumn{@span}{c}{) suffix(}) end(\cmidrule(lr){6-7}\cmidrule(lr){8-9})) ///
mtitle("\shortstack{Homework\\hours}" "\shortstack{Homework\\hours}" "\shortstack{Homework\\hours}" "\shortstack{Homework\\hours}" "\shortstack{Homework\\hours}" "\shortstack{Homework\\hours}" "\shortstack{Homework\\hours}" "\shortstack{Homework\\hours}") ///
substitute("\_" "_" "{l}{\footnotesize" "{p{17cm}}{\footnotesize" ) ///
addnotes("\textit{Notes}: The table presents coefficient estimates from equation \ref{eq:housework} using data from the American Time Use Survey and the Current Population Survey. Columns 1 and 2 subset to single-headed households, while columns 3--8 subset to married households. Columns 5 and 6 refer to men in married households, while columns 7 and 8 to women in married households. Control variables are the number of children in the household, number of adults, whether the individual works part-time. Odd columns also control for family income (net of own labor income and, if married, of spouse's labour income) decile. Standard errors are clustered at the household level. \sym{*}, \sym{**}, and \sym{***} denote statistical significance at the 10\%, 5\%, and 1\% levels, respectively.")

//I substituted head for individual

// Better own homework hours?
*/

*********************************************************
*ATUS variables
use atus_clean_03_20, clear

// Single

*With income controls

reghdfe homeworkhrs pter_atus hh_numkids hh_adults i.net_famincome_decile pt_atus if single_atus == 1 & employed_atus == 1, absorb(year_atus) vce(robust) nocons

*ATUS DATA = no individual FE, no vce(cluster household) because there is only one observation per household -- add demographic controls?

sum homeworkhrs if single_atus == 1 & employed_atus == 1
local mean = r(mean)
estadd scalar mean = `mean'
estadd local pfe "N"
estadd local yfe "Y"
estadd local controls "Y"
estadd local income "Y"
eststo has, refresh 


*Without income controls
reghdfe homeworkhrs pter_atus hh_numkids hh_adults pt_atus if single_atus == 1 & employed_atus == 1, absorb(year_atus) vce(robust) nocons

sum homeworkhrs if single_atus == 1 & employed_atus == 1
local mean = r(mean)
estadd scalar mean = `mean'
estadd local pfe "N"
estadd local yfe "Y"
estadd local controls "Y"
estadd local income "N"
eststo hasni, refresh 


// Married 

*With income controls

reghdfe homeworkhrs pter_atus hh_numkids hh_adults i.net_famincome_married_decile pt_atus if married_atus == 1 & employed_atus == 1, absorb(year_atus) vce(robust) nocons

sum homeworkhrs if married_atus == 1 & employed_atus == 1
local mean = r(mean)
estadd scalar mean = `mean'
estadd local pfe "N"
estadd local yfe "Y"
estadd local controls "Y"
estadd local income "Y"
eststo ham, refresh 

*Without income controls
reghdfe homeworkhrs pter_atus hh_numkids hh_adults pt_atus if married_atus == 1 & employed_atus == 1, absorb(year_atus) vce(robust) nocons // pter dummy from atus

sum homeworkhrs if married_atus == 1 & employed_atus == 1
local mean = r(mean)
estadd scalar mean = `mean'
estadd local pfe "N"
estadd local yfe "Y"
estadd local controls "Y"
estadd local income "N"
eststo hamni, refresh 

// Married men

*With income controls

reghdfe homeworkhrs pter_atus hh_numkids hh_adults i.net_famincome_married_decile pt_atus if married_atus == 1 & employed_atus == 1 & female_atus == 0, absorb(year_atus) vce(robust) nocons // pter couple from atus

sum homeworkhrs if married_atus == 1 & employed_atus == 1 & female_atus == 0
local mean = r(mean)
estadd scalar mean = `mean'
estadd local pfe "N"
estadd local yfe "Y"
estadd local controls "Y"
estadd local income "Y"
eststo hamm, refresh 

*Without income controls
reghdfe homeworkhrs pter_atus hh_numkids hh_adults pt_atus if married_atus == 1 & employed_atus == 1 & female_atus == 0, absorb(year_atus) vce(robust) nocons

sum homeworkhrs if married_atus == 1 & employed_atus == 1 & female_atus == 0
local mean = r(mean)
estadd scalar mean = `mean'
estadd local pfe "N"
estadd local yfe "Y"
estadd local controls "Y"
estadd local income "N"
eststo hammni, refresh 


// Married women

*With income controls

reghdfe homeworkhrs pter_atus hh_numkids hh_adults i.net_famincome_married_decile pt_atus if married_atus == 1 & employed_atus == 1 & female_atus == 1, absorb(year_atus) vce(robust) nocons

sum homeworkhrs if married_atus == 1 & employed_atus == 1 & female_atus == 1
local mean = r(mean)
estadd scalar mean = `mean'
estadd local pfe "N"
estadd local yfe "Y"
estadd local controls "Y"
estadd local income "Y"
eststo hamw, refresh 

*Without income controls
reghdfe homeworkhrs pter_atus hh_numkids hh_adults pt_atus if married_atus == 1 & employed_atus == 1 & female_atus == 1, absorb(year_atus) vce(robust) nocons

sum homeworkhrs if married_atus == 1 & employed_atus == 1 & female_atus == 1
local mean = r(mean)
estadd scalar mean = `mean'
estadd local pfe "N"
estadd local yfe "Y"
estadd local controls "Y"
estadd local income "Y"
eststo hamwni, refresh 

*mtitles("Men" "Women",pattern(0 0 0 0 1 0 1 0) span prefix(\multicolumn{@span}{c}{) suffix(}) end(\cmidrule(lr){6-7}\cmidrule(lr){8-9})) ///

esttab has hasni ham hamni hamm hammni hamw hamwni using eq2_homeworkhours_atus.tex, replace se r2 label scalars("mean Dep. var. mean" "pfe Person FE" "yfe Year FE" "controls Controls" "income Income") nonotes star(* 0.10 ** 0.05 *** 0.01) ///
keep(pter_atus) booktabs ///
mgroups("Single" "Married",pattern(1 0 1 0 0 0 0 0) span prefix(\multicolumn{@span}{c}{) suffix(}) end(\cmidrule(lr){2-3}\cmidrule(lr){4-9})) ///
mtitle("\shortstack{Homework\\hours}" "\shortstack{Homework\\hours\\}" "\shortstack{Homework\\hours\\}" "\shortstack{Homework\\hours\\}" "\shortstack{Homework\\hours\\Men}" "\shortstack{Homework\\hours\\Men}" "\shortstack{Homework\\hours\\Women}" "\shortstack{Homework\\hours\\Women}") ///
substitute("\_" "_" "{l}{\footnotesize" "{p{17cm}}{\footnotesize" ) ///
addnotes("\textit{Notes}: The table presents coefficient estimates from equation \ref{eq:housework} using data from the American Time Use Survey. Columns 1 and 2 subset to single-headed households, while columns 3--8 subset to married households. Columns 5 and 6 refer to men in married households, while columns 7 and 8 to women in married households. Control variables are the number of children in the household, number of adults, whether the individual works part-time. Odd columns also control for family income (net of own labor income and, if married, of spouse's labour income) decile. Heteroskedasticity-robust standard errors are reported. \sym{*}, \sym{**}, and \sym{***} denote statistical significance at the 10\%, 5\%, and 1\% levels, respectively.")

*********************************************************
* HOME WORK HOURS - SPOUSE

* CPS variables

use cps_atus_merged_76_21, clear

// Married
*With income controls

reghdfe homeworkhrs_sp pter nchild nadults i.famincome_married_decile if married == 1 & employed == 1, absorb(year) vce(cluster cpsid) nocons

// individual fe can't be added beause howework hours and income are observed once per id

// pt always = 1 in e(sample)

sum homeworkhrs_sp if married == 1 & employed == 1
local mean = r(mean)
estadd scalar mean = `mean'
estadd local pfe "N"
estadd local yfe "Y"
estadd local controls "Y"
estadd local income "Y"
eststo hsm, refresh 

*Without income controls
reghdfe homeworkhrs_sp pter nchild nadults if married == 1 & employed == 1, absorb(year) vce(cluster cpsid) nocons

sum homeworkhrs_sp if married == 1 & employed == 1
local mean = r(mean)
estadd scalar mean = `mean'
estadd local pfe "N"
estadd local yfe "Y"
estadd local controls "Y"
estadd local income "N"
eststo hsmni, refresh 

// Married men

*With income controls

reghdfe homeworkhrs_sp pter nchild nadults i.famincome_married_decile if married == 1 & employed == 1 & female == 0, absorb(year) vce(cluster cpsid) nocons

sum homeworkhrs_sp if married == 1 & employed == 1 & female == 0
local mean = r(mean)
estadd scalar mean = `mean'
estadd local pfe "N"
estadd local yfe "Y"
estadd local controls "Y"
estadd local income "Y"
eststo hsmm, refresh 

*Without income controls
reghdfe homeworkhrs_sp pter nchild nadults if married == 1 & employed == 1 & female == 0, absorb(year) vce(cluster cpsid) nocons

sum homeworkhrs_sp if married == 1 & employed == 1 & female == 0
local mean = r(mean)
estadd scalar mean = `mean'
estadd local pfe "N"
estadd local yfe "Y"
estadd local controls "Y"
estadd local income "N"
eststo hsmmni, refresh 

// Married women

*With income controls

reghdfe homeworkhrs_sp pter nchild nadults i.famincome_married_decile if married == 1 & employed == 1 & female == 1, absorb(year) vce(cluster cpsid) nocons

sum homeworkhrs_sp if married == 1 & employed == 1 & female == 1
local mean = r(mean)
estadd scalar mean = `mean'
estadd local pfe "N"
estadd local yfe "Y"
estadd local controls "Y"
estadd local income "Y"
eststo hsmw, refresh 

*Without income controls
reghdfe homeworkhrs_sp pter nchild nadults if married == 1 & employed == 1 & female == 1, absorb(year) vce(cluster cpsid) nocons

sum homeworkhrs_sp if married == 1 & employed == 1 & female == 1
local mean = r(mean)
estadd scalar mean = `mean'
estadd local pfe "N"
estadd local yfe "Y"
estadd local controls "Y"
estadd local income "N"
eststo hsmwni, refresh 


esttab hsm hsmni hsmm hsmmni hsmw hsmwni using eq2_homeworkhours_spouse_cps.tex, replace se r2 label scalars("mean Dep. var. mean" "pfe Person FE" "yfe Year FE" "controls Controls" "income Income") nonotes star(* 0.10 ** 0.05 *** 0.01) ///
keep(pter) booktabs ///
mgroups("Overall" "Men" "Women",pattern(1 0 1 0 1 0) span prefix(\multicolumn{@span}{c}{) suffix(}) end(\cmidrule(lr){2-3}\cmidrule(lr){4-5}\cmidrule(lr){6-7})) ///
mtitle("\shortstack{Spouse HW\\hours}" "\shortstack{Spouse HW\\hours}" "\shortstack{Spouse HW\\hours}" "\shortstack{Spouse HW\\hours}" "\shortstack{Spouse HW\\hours}" "\shortstack{Spouse HW\\hours}") ///
substitute("\_" "_" "{l}{\footnotesize" "{p{17cm}}{\footnotesize" ) ///
addnotes("\textit{Notes}: The table presents coefficient estimates from equation \ref{eq:housework} using data from the American Time Use Survey and the Current Population Survey. Columns 1 and 2 consider all married households, while columns 3--4 and 5--6 subset to married men and women, respectively. Control variables are the number of children in the household, number of adults, whether the individual works part-time. Odd columns also control for family income (net of own and spouse's labor income) decile. Standard errors are clustered at the household level. \sym{*}, \sym{**}, and \sym{***} denote statistical significance at the 10\%, 5\%, and 1\% levels, respectively.")

*********************************************************
*ATUS variables do not exist: if spouse was in ATUS, head was not

*********************************************************
*********************************************************
* SPOUSE'S LABOUR MARKET PARTICIPATION
*CPS
use cps_atus_merged_76_21, clear

// Married: general
*With income controls
*Without individual FE: considers all individuals for whom we observe income at least once (= those who enter the March ASEC supplement)
reghdfe employed_sp pter nchild nadults i.famincome_married_decile pt if married == 1 & employed == 1, absorb(year) vce(cluster cpsid) nocons

sum employed_sp if married == 1 & employed == 1
local mean = r(mean)
estadd scalar mean = `mean'
estadd local pfe "N"
estadd local yfe "Y"
estadd local ymfe "N"
estadd local controls "Y"
estadd local income "Y"
eststo esm, refresh 

*With income controls
*With individual FE: considers only individuals who have two income observations (= who happen to be interviewed in the March ASEC twice)

reghdfe employed_sp pter nchild nadults i.famincome_married_decile pt if married == 1 & employed == 1, absorb(cpsidp year) vce(cluster cpsid) nocons

sum employed_sp if married == 1 & employed == 1
local mean = r(mean)
estadd scalar mean = `mean'
estadd local pfe "Y"
estadd local yfe "Y"
estadd local ymfe "N"
estadd local controls "Y"
estadd local income "Y"
eststo esmfe, refresh 

*Without income controls
reghdfe employed_sp pter nchild nadults pt if married == 1 & employed == 1, absorb(cpsidp monthly_date) vce(cluster cpsid) nocons

// here we need to have year-month FE since observations come from basic monthly cps 

sum employed_sp if married == 1 & employed == 1
local mean = r(mean)
estadd scalar mean = `mean'
estadd local pfe "Y"
estadd local yfe "N"
estadd local ymfe "Y"
estadd local controls "Y"
estadd local income "N"
eststo esmni, refresh 

//Married Men

*With income controls
*Without individual FE
reghdfe employed_sp pter nchild nadults i.famincome_married_decile pt if married == 1 & employed == 1 & female == 0, absorb(year) vce(cluster cpsid) nocons

sum employed_sp if married == 1 & employed == 1 & female == 0
local mean = r(mean)
estadd scalar mean = `mean'
estadd local pfe "N"
estadd local yfe "Y"
estadd local ymfe "N"
estadd local controls "Y"
estadd local income "Y"
eststo esmm, refresh 

*With income controls
*With individual FE
reghdfe employed_sp pter nchild nadults i.famincome_married_decile pt if married == 1 & employed == 1 & female == 0, absorb(cpsidp year) vce(cluster cpsid) nocons

sum employed_sp if married == 1 & employed == 1 & female == 0
local mean = r(mean)
estadd scalar mean = `mean'
estadd local pfe "Y"
estadd local yfe "Y"
estadd local ymfe "N"
estadd local controls "Y"
estadd local income "Y"
eststo esmmfe, refresh 

*Without income controls
reghdfe employed_sp pter nchild nadults pt if married == 1 & employed == 1 & female == 0, absorb(cpsidp monthly_date) vce(cluster cpsid) nocons

sum employed_sp if married == 1 & employed == 1 & female == 0
local mean = r(mean)
estadd scalar mean = `mean'
estadd local pfe "Y"
estadd local yfe "N"
estadd local ymfe "Y"
estadd local controls "Y"
estadd local income "N"
eststo esmmni, refresh 

// Married women
*With income controls
*Without individual FE
reghdfe employed_sp pter nchild nadults i.famincome_married_decile pt if married == 1 & employed == 1 & female == 1, absorb(year) vce(cluster cpsid) nocons

sum employed_sp if married == 1 & employed == 1 & female == 1
local mean = r(mean)
estadd scalar mean = `mean'
estadd local pfe "N"
estadd local yfe "Y"
estadd local ymfe "N"
estadd local controls "Y"
estadd local income "Y"
eststo esmw, refresh 

*With income controls
*With individual FE
reghdfe employed_sp pter nchild nadults i.famincome_married_decile pt if married == 1 & employed == 1 & female == 1, absorb(cpsidp year) vce(cluster cpsid) nocons

sum employed_sp if married == 1 & employed == 1 & female == 1
local mean = r(mean)
estadd scalar mean = `mean'
estadd local pfe "Y"
estadd local yfe "Y"
estadd local ymfe "N"
estadd local controls "Y"
estadd local income "Y"
eststo esmwfe, refresh 

*Without income controls
reghdfe employed_sp pter nchild nadults pt if married == 1 & employed == 1 & female == 1, absorb(cpsidp monthly_date) vce(cluster cpsid) nocons

sum employed_sp  if married == 1 & employed == 1 & female == 1
local mean = r(mean)
estadd scalar mean = `mean'
estadd local pfe "Y"
estadd local yfe "N"
estadd local ymfe "Y"
estadd local controls "Y"
estadd local income "N"
eststo esmwni, refresh 

esttab esm esmfe esmni esmm esmmfe esmmni esmw esmwfe esmwni using eq2_lfpspouse_cps.tex, replace se r2 label scalars("mean Dep. var. mean" "pfe Person FE" "yfe Year FE" "ymfe Year-month FE" "controls Controls" "income Income") nonotes star(* 0.10 ** 0.05 *** 0.01) ///
keep(pter) booktabs ///
mgroups("Overall" "Men" "Women",pattern(1 0 0 1 0 0 1 0) span prefix(\multicolumn{@span}{c}{) suffix(}) end(\cmidrule(lr){2-4}\cmidrule(lr){5-7}\cmidrule(lr){8-10})) ///
mtitle("\shortstack{Spouse\\working}" "\shortstack{Spouse \\working}" "\shortstack{Spouse\\working}" "\shortstack{Spouse\\working}" "\shortstack{Spouse \\working}" "\shortstack{Spouse\\working}" "\shortstack{Spouse\\working}" "\shortstack{Spouse \\working}" "\shortstack{Spouse\\working}") ///
substitute("\_" "_" "{l}{\footnotesize" "{p{17cm}}{\footnotesize" ) ///
addnotes("\textit{Notes}: The table presents coefficient estimates from equation \ref{eq:XXX} using data from the Current Population Survey. Columns 1--3 consider all married households, while columns 4--6 and 7--9 subset to married men and women, respectively. Control variables are the number of children in the household, number of adults, whether the individual works part-time. Columns 1--2, 4--5, 7--8 also control for family income (net of own and spouse's labor income) decile. Standard errors are clustered at the household level. \sym{*}, \sym{**}, and \sym{***} denote statistical significance at the 10\%, 5\%, and 1\% levels, respectively.")

******************************************************
*ATUS
*Doesn't have a panel dimension but can be run for comparison
*Won't run this for now
/*
 use xxx
 
// Married general
*With income controls
 
reghdfe employed_sp_atus pter_atus hh_numkids hh_adults i.net_famincome_married_decile pt_atus if married_atus == 1 & employed_atus == 1, absorb(year) vce(robust) nocons // pter couple and employed spouse from atus

sum employed_sp_atus
local mean = r(mean)
estadd scalar mean = `mean'
estadd local pfe "N"
estadd local yfe "Y"
estadd local controls "Y"
eststo aesm, refresh 


*Without income controls
 
reghdfe employed_sp_atus pter_atus hh_numkids hh_adults pt_atus if married_atus == 1 & employed_atus == 1, absorb(year) vce(robust) nocons // pter couple and employed spouse from atus

sum employed_sp_atus
local mean = r(mean)
estadd scalar mean = `mean'
estadd local pfe "N"
estadd local yfe "Y"
estadd local controls "Y"
eststo aesmni, refresh 

// Married men
*With income controls
 
reghdfe employed_sp_atus pter_atus hh_numkids hh_adults i.net_famincome_married_decile pt_atus if married_atus == 1 & employed_atus == 1 & female_atus == 0, absorb(year) vce(robust) nocons // pter couple and employed spouse from atus

sum employed_sp_atus
local mean = r(mean)
estadd scalar mean = `mean'
estadd local pfe "N"
estadd local yfe "Y"
estadd local controls "Y"
eststo aesmm, refresh 

*Without income controls
 
reghdfe employed_sp_atus pter_atus hh_numkids hh_adults pt_atus if married_atus == 1 & employed_atus == 1 & female_atus == 0, absorb(year) vce(robust) nocons // pter couple and employed spouse from atus

sum employed_sp_atus
local mean = r(mean)
estadd scalar mean = `mean'
estadd local pfe "N"
estadd local yfe "Y"
estadd local controls "Y"
eststo aesmmni, refresh 

// Married women
*With income controls
 
reghdfe employed_sp_atus pter_atus hh_numkids hh_adults i.net_famincome_married_decile pt_atus if married_atus == 1 & employed_atus == 1 & female_atus == 1, absorb(year) vce(robust) nocons // pter couple and employed spouse from atus

sum employed_sp_atus
local mean = r(mean)
estadd scalar mean = `mean'
estadd local pfe "N"
estadd local yfe "Y"
estadd local controls "Y"
eststo aesmw, refresh 

*Without income controls
 
reghdfe employed_sp_atus pter_atus hh_numkids hh_adults pt_atus if married_atus == 1 & employed_atus == 1 & female_atus == 1, absorb(year) vce(robust) nocons

sum employed_sp_atus
local mean = r(mean)
estadd scalar mean = `mean'
estadd local pfe "N"
estadd local yfe "Y"
estadd local controls "Y"
eststo aesmwni, refresh 

esttab aesm aesmni easmm easmmni easmw easmwni using eq2_lfpspouse_atus.tex, replace se r2 label scalars("mean Dep. var. mean" "pfe Person FE" "yfe Year FE" "controls Controls") nonotes star(* 0.10 ** 0.05 *** 0.01) ///
keep(homeworkhrs_sp) booktabs ///
mgroups("Overall" "Men" "Women",pattern(1 0 1 0 1 0) span prefix(\multicolumn{@span}{c}{) suffix(}) end(\cmidrule(lr){2-3}\cmidrule(lr){4-5}\cmidrule(lr){6-7})) ///
mtitle("\shortstack{Spouse\\working}" "\shortstack{Spouse \\working}" "\shortstack{Spouse\\working}" "\shortstack{Spouse\\working}" "\shortstack{Spouse \\working}" "\shortstack{Spouse\\working}") ///
substitute("\_" "_" "{l}{\footnotesize" "{p{17cm}}{\footnotesize" ) ///
addnotes("\textit{Notes}: The table presents coefficient estimates from equation \ref{eq:XXX} using data from the American Time Use Survey. Columns 1 and 2 consider all married households, while columns 3--4 and 5--6 subset to married men and women, respectively. Control variables are the number of children in the household, number of adults, whether the individual works part-time. Odd columns also control for family income (net of own and spouse's labor income) decile. Heteroskedasticity-robust standard errors are reported. \sym{*}, \sym{**}, and \sym{***} denote statistical significance at the 10\%, 5\%, and 1\% levels, respectively.")
*/
*********************************************************
*********************************************************
*SPOUSE LABOR MARKET HOURS
* ahrsworkt -- hours worked last week as it was hours worked variable with less missing values

*CPS
use cps_atus_merged_76_21, clear

//Married general 
*With income controls
*Without individual FE to exploit all obs with nonmissing income
reghdfe ahrsworkt_sp pter nchild nadults i.famincome_married_decile pt if married == 1 & employed == 1, absorb(year) vce(cluster cpsid) nocons

sum ahrsworkt_sp if married == 1 & employed == 1
local mean = r(mean)
estadd scalar mean = `mean'
estadd local pfe "N"
estadd local yfe "Y"
estadd local ymfe "N"
estadd local controls "Y"
estadd local income "Y"
eststo hrwsm, refresh 

*With income controls
*With individual FE -- only individuals entering twice ASEC March 
reghdfe ahrsworkt_sp pter nchild nadults i.famincome_married_decile pt if married == 1 & employed == 1, absorb(cpsidp year) vce(cluster cpsid) nocons

sum ahrsworkt_sp if married == 1 & employed == 1
local mean = r(mean)
estadd scalar mean = `mean'
estadd local pfe "Y"
estadd local yfe "Y"
estadd local ymfe "N"
estadd local controls "Y"
estadd local income "Y"
eststo hrwsmfe, refresh 


*Without income controls
reghdfe ahrsworkt_sp pter nchild nadults pt if married == 1 & employed == 1, absorb(cpsidp monthly_date) vce(cluster cpsid) nocons

sum ahrsworkt_sp if married == 1 & employed == 1
local mean = r(mean)
estadd scalar mean = `mean'
estadd local pfe "Y"
estadd local yfe "N"
estadd local ymfe "Y"
estadd local controls "Y"
estadd local income "N"
eststo hrwsmni, refresh 

// Married men
*With income controls
*Without individual FE
reghdfe ahrsworkt_sp pter nchild nadults i.famincome_married_decile pt if married == 1 & employed == 1 & female == 0, absorb(year) vce(cluster cpsid) nocons

sum ahrsworkt_sp if married == 1 & employed == 1 & female == 0
local mean = r(mean)
estadd scalar mean = `mean'
estadd local pfe "N"
estadd local yfe "Y"
estadd local ymfe "N"
estadd local controls "Y"
estadd local income "Y"
eststo hrwsmm, refresh 

*With income controls
*Without individual FE
reghdfe ahrsworkt_sp pter nchild nadults i.famincome_married_decile pt if married == 1 & employed == 1 & female == 0, absorb(cpsidp year) vce(cluster cpsid) nocons

sum ahrsworkt_sp if married == 1 & employed == 1 & female == 0
local mean = r(mean)
estadd scalar mean = `mean'
estadd local pfe "Y"
estadd local yfe "Y"
estadd local ymfe "N"
estadd local controls "Y"
estadd local income "Y"
eststo hrwsmmfe, refresh 


*Without income controls
reghdfe ahrsworkt_sp pter nchild nadults pt if married == 1 & employed == 1 & female == 0, absorb(cpsidp monthly_date) vce(cluster cpsid) nocons

sum ahrsworkt_sp if married == 1 & employed == 1 & female == 0
local mean = r(mean)
estadd scalar mean = `mean'
estadd local pfe "Y"
estadd local yfe "N"
estadd local ymfe "Y"
estadd local controls "Y"
estadd local income "N"
eststo hrwsmmni, refresh 

// Married women 

*With income controls
*Without individual FE
reghdfe ahrsworkt_sp pter nchild nadults i.famincome_married_decile pt if married == 1 & employed == 1 & female == 1, absorb(year) vce(cluster cpsid) nocons

sum ahrsworkt_sp if married == 1 & employed == 1 & female == 1
local mean = r(mean)
estadd scalar mean = `mean'
estadd local pfe "N"
estadd local yfe "Y"
estadd local ymfe "N"
estadd local controls "Y"
estadd local income "Y"
eststo hrwsmw, refresh 

*With income controls
*Without individual FE
reghdfe ahrsworkt_sp pter nchild nadults i.famincome_married_decile pt if married == 1 & employed == 1 & female == 1, absorb(cpsidp year) vce(cluster cpsid) nocons

sum ahrsworkt_sp if married == 1 & employed == 1 & female == 1
local mean = r(mean)
estadd scalar mean = `mean'
estadd local pfe "Y"
estadd local yfe "Y"
estadd local ymfe "N"
estadd local controls "Y"
estadd local income "Y"
eststo hrwsmwfe, refresh 

*Without income controls
reghdfe ahrsworkt_sp pter nchild nadults pt if married == 1 & employed == 1 & female == 1, absorb(cpsidp monthly_date) vce(cluster cpsid) nocons

sum ahrsworkt_sp if married == 1 & employed == 1 & female == 1
local mean = r(mean)
estadd scalar mean = `mean'
estadd local pfe "Y"
estadd local yfe "N"
estadd local ymfe "Y"
estadd local controls "Y"
estadd local income "N"
eststo hrwsmwni, refresh 

esttab hrwsm hrwsmfe hrwsmni hrwsmm hrwsmmfe hrwsmmni hrwsmw hrwsmwfe hrwsmwni using eq2_hoursworked_spouse_cps.tex, replace se r2 label scalars("mean Dep. var. mean" "pfe Person FE" "yfe Year FE" "ymfe Year-month FE" "controls Controls" "income Income") nonotes star(* 0.10 ** 0.05 *** 0.01) ///
keep(pter) booktabs ///
mgroups("Overall" "Men" "Women",pattern(1 0 0 1 0 0 1 0 0) span prefix(\multicolumn{@span}{c}{) suffix(}) end(\cmidrule(lr){2-4}\cmidrule(lr){5-7}\cmidrule(lr){8-10})) ///
mtitle("\shortstack{Spouse work\\hours}" "\shortstack{Spouse work\\hours}" "\shortstack{Spouse work\\hours}" "\shortstack{Spouse work\\hours}" "\shortstack{Spouse work\\hours}" "\shortstack{Spouse work\\hours}" "\shortstack{Spouse work\\hours}" "\shortstack{Spouse work\\hours}" "\shortstack{Spouse work\\hours}") ///
substitute("\_" "_" "{l}{\footnotesize" "{p{17cm}}{\footnotesize" ) ///
addnotes("\textit{Notes}: The table presents coefficient estimates from equation \ref{eq:XXX} using data from the Current Population Survey. Columns 1--3 consider all married households, while columns 4--6 and 7--9 subset to married men and women, respectively. Control variables are the number of children in the household, number of adults, whether the individual works part-time. Columns 1--2, 4--5, 7--8 also control for family income (net of own and spouse's labor income) decile. Standard errors are clustered at the household level. \sym{*}, \sym{**}, and \sym{***} denote statistical significance at the 10\%, 5\%, and 1\% levels, respectively.")

*********************************************************
*ATUS
*Doesn't have a panel dimension but can be run for comparison
*Won't run this for now
/*
 use xxx
 
 //Married general 
*With income controls
reghdfe spusualhrs pter_atus hh_numkids hh_adults i.net_famincome_married_decile pt_atus if married_atus == 1 & employed_atus == 1, absorb(year) vce(robust) nocons

sum spusualhrs
local mean = r(mean)
estadd scalar mean = `mean'
estadd local pfe "N"
estadd local yfe "Y"
estadd local controls "Y"
eststo suhrm, refresh 

*Without income controls
reghdfe spusualhrs pter_atus hh_numkids hh_adults pt_atus if married_atus == 1 & employed_atus == 1, absorb(year) vce(robust) nocons

sum spusualhrs
local mean = r(mean)
estadd scalar mean = `mean'
estadd local pfe "N"
estadd local yfe "Y"
estadd local controls "Y"
eststo suhrmni, refresh 

//Married men
*With income controls
reghdfe spusualhrs pter_atus hh_numkids hh_adults i.net_famincome_married_decile pt_atus if married_atus == 1 & employed_atus == 1 & female_atus == 0, absorb(year) vce(robust) nocons

sum spusualhrs
local mean = r(mean)
estadd scalar mean = `mean'
estadd local pfe "N"
estadd local yfe "Y"
estadd local controls "Y"
eststo suhrmm, refresh 

*Without income controls
reghdfe spusualhrs pter_atus hh_numkids hh_adults pt_atus if married_atus == 1 & employed_atus == 1 & female_atus == 0, absorb(year) vce(robust) nocons

sum spusualhrs
local mean = r(mean)
estadd scalar mean = `mean'
estadd local pfe "N"
estadd local yfe "Y"
estadd local controls "Y"
eststo suhrmmni, refresh 

// Married women
*With income controls
reghdfe spusualhrs pter_atus hh_numkids hh_adults i.net_famincome_married_decile pt_atus if married_atus == 1 & employed_atus == 1 & female_atus == 1, absorb(year) vce(robust) nocons

sum spusualhrs
local mean = r(mean)
estadd scalar mean = `mean'
estadd local pfe "N"
estadd local yfe "Y"
estadd local controls "Y"
eststo suhrmw, refresh 

*Without income controls
reghdfe spusualhrs pter_atus hh_numkids hh_adults pt_atus if married_atus == 1 & employed_atus == 1 & female_atus == 1, absorb(year) vce(robust) nocons

sum spusualhrs
local mean = r(mean)
estadd scalar mean = `mean'
estadd local pfe "N"
estadd local yfe "Y"
estadd local controls "Y"
eststo suhrmwni, refresh 

esttab suhrm suhrmni suhrmm suhrmmni suhrmw suhrmwni using eq2_hoursworked_spouse_atus.tex, replace se r2 label scalars("mean Dep. var. mean" "pfe Person FE" "yfe Year FE" "controls Controls") nonotes star(* 0.10 ** 0.05 *** 0.01) ///
keep(homeworkhrs_sp) booktabs ///
mgroups("Overall" "Men" "Women",pattern(1 0 1 0 1 0) span prefix(\multicolumn{@span}{c}{) suffix(}) end(\cmidrule(lr){2-3}\cmidrule(lr){4-5}\cmidrule(lr){6-7})) ///
mtitle("\shortstack{Spouse work\\hours}" "\shortstack{Spouse work\\hours}" "\shortstack{Spouse work\\hours}" "\shortstack{Spouse work\\hours}" "\shortstack{Spouse work\\hours}" "\shortstack{Spouse work\\hours}") ///
substitute("\_" "_" "{l}{\footnotesize" "{p{17cm}}{\footnotesize" ) ///
addnotes("\textit{Notes}: The table presents coefficient estimates from equation \ref{eq:XXX} using data from the American Time Use Survey. Columns 1 and 2 consider all married households, while columns 3--4 and 5--6 subset to married men and women, respectively. Control variables are the number of children in the household, number of adults, whether the individual works part-time. Odd columns also control for family income (net of own and spouse's labor income) decile. Heteroskedasticity-robust standard errors are reported. \sym{*}, \sym{**}, and \sym{***} denote statistical significance at the 10\%, 5\%, and 1\% levels, respectively.")

*/

********************************************************
* COULD RUN VERSIONS WITH: EITHER SPOUSE PTER INSTEAD OF PTER, CONTROLLING FOR SPOUSE PTER, BECOMING PTER

* Final table
*Version 1 : Full sample
*Version 2 : Uniform sample for CPS, ATUS across columns
*Version 3 : ATUS sample only

*Version 1
use cps_atus_merged_76_21, clear

global demographic_atus "age_atus female_atus black highschool_atus somecollege_atus collegeup_atus"
global demographic_cps " age female black highschool somecollege collegeup"

*Single
* Head work hours
reghdfe ahrsworkt pter nchild nadults if single == 1 & employed == 1, absorb(monthly_date#statefip cpsidp) vce(cluster cpsid) nocons

sum ahrsworkt if e(sample) == 1
local mean = r(mean)
estadd scalar mean = `mean'
estadd local pfe "Y"
estadd local yfe "N"
estadd local ymsfe "Y"
estadd local controls "Y"
estadd local income "N"
eststo s1, refresh 
gen s1 = e(sample)

save cps_atus_merged_76_21, replace // to save s1

* Head HW hours
use atus_clean_03_20, clear


reghdfe homeworkhrs pter_atus hh_numkids hh_adults i.net_famincome_decile $demographic_atus if single_atus == 1 & employed_atus == 1, absorb(month_atus#year_atus#statefip) vce(robust) nocons

sum homeworkhrs if e(sample) == 1
local mean = r(mean)
estadd scalar mean = `mean'
estadd local pfe "N"
estadd local yfe "N"
estadd local ymsfe "Y"
estadd local controls "Y"
estadd local income "Y" // should I add income controls here?
eststo s2, refresh 
gen s2 = e(sample)

save atus_clean_03_20, replace

*Married
* Head work hours
use cps_atus_merged_76_21, clear

reghdfe ahrsworkt pter nchild nadults if married == 1 & employed == 1, absorb(monthly_date#statefip cpsidp) vce(cluster cpsid) nocons

sum ahrsworkt if e(sample) == 1
local mean = r(mean)
estadd scalar mean = `mean'
estadd local pfe "Y"
estadd local yfe "N"
estadd local ymsfe "Y"
estadd local controls "Y"
estadd local income "N"
eststo m1, refresh 
gen m1 = e(sample)

save cps_atus_merged_76_21, replace

* Head HW hours

use atus_clean_03_20, clear

reghdfe homeworkhrs pter_atus hh_numkids hh_adults i.net_famincome_decile $demographic_atus if married_atus == 1 & employed_atus == 1, absorb(month_atus#year_atus#statefip) vce(robust) nocons

sum homeworkhrs if e(sample) == 1
local mean = r(mean)
estadd scalar mean = `mean'
estadd local pfe "N"
estadd local yfe "N"
estadd local ymsfe "Y"
estadd local controls "Y"
estadd local income "Y" // should I add income controls here?
eststo m2, refresh 
gen m2 = e(sample)

save atus_clean_03_20, replace


* Spouse work hours
use cps_atus_merged_76_21, clear

reghdfe ahrsworkt_sp pter nchild nadults if married == 1 & employed == 1, absorb(cpsidp monthly_date#statefip) vce(cluster cpsid) nocons

sum ahrsworkt_sp if e(sample) == 1
local mean = r(mean)
estadd scalar mean = `mean'
estadd local pfe "Y"
estadd local yfe "N"
estadd local ymsfe "Y"
estadd local controls "Y"
estadd local income "N"
eststo m3, refresh 
gen m3 = e(sample)


*Spouse HW hours
reghdfe homeworkhrs_sp pter nchild nadults $demographic_cps if married == 1 & employed == 1, absorb(monthly_date#statefip) vce(cluster cpsid) nocons

sum homeworkhrs_sp if e(sample) == 1
local mean = r(mean)
estadd scalar mean = `mean'
estadd local pfe "N"
estadd local yfe "N"
estadd local ymsfe "Y"
estadd local controls "Y"
estadd local income "N"
eststo m4, refresh 
gen m4 = e(sample)

*Spouse LMP
reghdfe employed_sp pter nchild nadults if married == 1 & employed == 1, absorb(cpsidp monthly_date#statefip) vce(cluster cpsid) nocons

sum employed_sp if e(sample) == 1
local mean = r(mean)
estadd scalar mean = `mean'
estadd local pfe "Y"
estadd local yfe "N"
estadd local ymsfe "Y"
estadd local controls "Y"
estadd local income "N"
eststo m5, refresh 
gen m5 = e(sample)

save cps_atus_merged_76_21, replace


esttab s1 s2 m1 m2 m3 m4 m5 using cps_atus_v1.tex, replace se r2 label scalars("mean Dep. var. mean" "pfe Person FE" "yfe Year FE" "ymsfe Year-month-state FE" "controls Controls" "income Income") nonotes star(* 0.10 ** 0.05 *** 0.01) ///
keep(pter pter_atus) booktabs ///
mgroups("Single" "Married",pattern(1 0 1 0 0 0 0) span prefix(\multicolumn{@span}{c}{) suffix(}) end(\cmidrule(lr){2-3}\cmidrule(lr){4-8})) ///
mtitle("\shortstack{Own work\\hours}" "\shortstack{Own HW\\hours}" "\shortstack{Own work\\hours}" "\shortstack{Own HW\\hours}" "\shortstack{Spouse work\\hours}" "\shortstack{Spouse HW\\hours}" "\shortstack{Spouse\\LMP}") ///
substitute("\_" "_" "{l}{\footnotesize" "{p{17cm}}{\footnotesize" ) ///
addnotes("\textit{Notes}: The table presents coefficient estimates from equation \ref{eq:housework} using data from the American Time Use Survey and the Current Population Survey. Columns 1 and 2 consider single households, while columns 3--7 consider married households. Control variables are the number of children in the household, number of adults. When individual fixed effects are not present controls for age, gender, race and education are included. Columns 2 and 4 also control for family income (net of own and spouse's labor income if married) decile. Standard errors are clustered at the household level in all columns but columns 2 and 4, where heteroskedasticity-robust standard errors are reported. \sym{*}, \sym{**}, and \sym{***} denote statistical significance at the 10\%, 5\%, and 1\% levels, respectively.")


*****************************************************
* V2 : Uniform sample for CPS, uniform sample for ATUS
* This equals keeping married observations in cps for individuals who also provide info on their spouse
* For atus, this means keeping only the atus obs for spouse homework hours 

*Version 2
use cps_atus_merged_76_21, clear

global demographic_atus "age_atus female_atus black highschool_atus somecollege_atus collegeup_atus"
global demographic_cps " age female black highschool somecollege collegeup"

*Single
* Head work hours // same as before
reghdfe ahrsworkt pter nchild nadults if single == 1 & employed == 1, absorb(monthly_date#statefip cpsidp) vce(cluster cpsid) nocons

sum ahrsworkt if e(sample) == 1
local mean = r(mean)
estadd scalar mean = `mean'
estadd local pfe "Y"
estadd local yfe "N"
estadd local ymsfe "Y"
estadd local controls "Y"
estadd local income "N"
eststo s12, refresh 

* Head HW hours // same as before
use atus_clean_03_20, clear

reghdfe homeworkhrs pter_atus hh_numkids hh_adults i.net_famincome_decile $demographic_atus if single_atus == 1 & employed_atus == 1, absorb(month_atus#year_atus#statefip) vce(robust) nocons

sum homeworkhrs if e(sample) == 1
local mean = r(mean)
estadd scalar mean = `mean'
estadd local pfe "N"
estadd local yfe "N"
estadd local ymsfe "Y"
estadd local controls "Y"
estadd local income "Y" // should I add income controls here?
eststo s22, refresh 

*Married
* Head work hours // restricted to those with nonmissing spouse observations
use cps_atus_merged_76_21, clear

keep if m1 == 1 & m5 ==1 // = in sample in specification m1, m5. If I were to restrict also to being in sample for m3 it would be = to conditioning on spouse lmp = 1

reghdfe ahrsworkt pter nchild nadults if married == 1 & employed == 1, absorb(monthly_date#statefip cpsidp) vce(cluster cpsid) nocons

sum ahrsworkt if e(sample) == 1
local mean = r(mean)
estadd scalar mean = `mean'
estadd local pfe "Y"
estadd local yfe "N"
estadd local ymsfe "Y"
estadd local controls "Y"
estadd local income "N"
eststo m12, refresh 

* Head HW hours

use atus_clean_03_20, clear

reghdfe homeworkhrs pter_atus hh_numkids hh_adults i.net_famincome_decile $demographic_atus if married_atus == 1 & employed_atus == 1, absorb(month_atus#year_atus#statefip) vce(robust) nocons

sum homeworkhrs if e(sample) == 1
local mean = r(mean)
estadd scalar mean = `mean'
estadd local pfe "N"
estadd local yfe "N"
estadd local ymsfe "Y"
estadd local controls "Y"
estadd local income "Y" // should I add income controls here?
eststo m22, refresh 


* Spouse work hours
use cps_atus_merged_76_21, clear

keep if m1 == 1 & m3 == 1 & m5 ==1 // = in sample in specification m1, m3, m5

reghdfe ahrsworkt_sp pter nchild nadults if married == 1 & employed == 1, absorb(cpsidp monthly_date#statefip) vce(cluster cpsid) nocons

sum ahrsworkt_sp if e(sample) == 1
local mean = r(mean)
estadd scalar mean = `mean'
estadd local pfe "Y"
estadd local yfe "N"
estadd local ymsfe "Y"
estadd local controls "Y"
estadd local income "N"
eststo m32, refresh 

*Spouse HW hours
use cps_atus_merged_76_21, clear

keep if homeworkhrs_sp != . // keeping only spouse obs from atus. Now this info is repeated over all cps months

by cpsidp_sp (mish), sort: gen byte last_obs = (_n == _N)
order last_obs, after(mish)

keep if last_obs == 1 // keeping only one obs per individual -- the last is the closest to atus survey

reghdfe homeworkhrs_sp pter nchild nadults $demographic_cps if married == 1 & employed == 1, absorb(monthly_date#statefip) vce(cluster cpsid) nocons

sum homeworkhrs_sp if e(sample) == 1
local mean = r(mean)
estadd scalar mean = `mean'
estadd local pfe "N"
estadd local yfe "N"
estadd local ymsfe "Y"
estadd local controls "Y"
estadd local income "N"
eststo m42, refresh 

*Spouse LMP
use cps_atus_merged_76_21, clear

keep if m1 == 1 & m5 ==1 

reghdfe employed_sp pter nchild nadults if married == 1 & employed == 1, absorb(cpsidp monthly_date#statefip) vce(cluster cpsid) nocons

sum employed_sp if e(sample) == 1
local mean = r(mean)
estadd scalar mean = `mean'
estadd local pfe "Y"
estadd local yfe "N"
estadd local ymsfe "Y"
estadd local controls "Y"
estadd local income "N"
eststo m52, refresh 


esttab s12 s22 m12 m22 m32 m42 m52 using cps_atus_v2.tex, replace se r2 label scalars("mean Dep. var. mean" "pfe Person FE" "yfe Year FE" "ymsfe Year-month-state FE" "controls Controls" "income Income") nonotes star(* 0.10 ** 0.05 *** 0.01) ///
keep(pter pter_atus) booktabs ///
mgroups("Single" "Married",pattern(1 0 1 0 0 0 0) span prefix(\multicolumn{@span}{c}{) suffix(}) end(\cmidrule(lr){2-3}\cmidrule(lr){4-8})) ///
mtitle("\shortstack{Own work\\hours}" "\shortstack{Own HW\\hours}" "\shortstack{Own work\\hours}" "\shortstack{Own HW\\hours}" "\shortstack{Spouse work\\hours}" "\shortstack{Spouse HW\\hours}" "\shortstack{Spouse\\LMP}") ///
substitute("\_" "_" "{l}{\footnotesize" "{p{17cm}}{\footnotesize" ) ///
addnotes("\textit{Notes}: The table presents coefficient estimates from equation \ref{eq:housework} using data from the American Time Use Survey and the Current Population Survey. Columns 1 and 2 consider single households, while columns 3--7 consider married households. Control variables are the number of children in the household, number of adults. When individual fixed effects are not present controls for age, gender, race and education are included. Columns 2 and 4 also control for family income (net of own and spouse's labor income if married) decile. Standard errors are clustered at the household level in all columns but columns 2 and 4, where heteroskedasticity-robust standard errors are reported. \sym{*}, \sym{**}, and \sym{***} denote statistical significance at the 10\%, 5\%, and 1\% levels, respectively.")

*****************************************************
* V3 : ATUS only (+ related cps covariates)
* = keeping only subsample which enters atus
* do we want to keep only one cps wave or all of them?
* keep all of them for now
*keep married obs which have all info on spouse

*Version 3
use cps_atus_merged_76_21, clear

keep if homeworkhrs != . | homeworkhrs_sp != .
drop if m1 == 0 & married == 1 | m5 == 0 & married ==1 

global demographic_atus "age_atus female_atus black highschool_atus somecollege_atus collegeup_atus"
global demographic_cps " age female black highschool somecollege collegeup"

*Single
* Head work hours // same as before
reghdfe ahrsworkt pter nchild nadults if single == 1 & employed == 1, absorb(monthly_date#statefip cpsidp) vce(cluster cpsid) nocons

sum ahrsworkt if e(sample) == 1
local mean = r(mean)
estadd scalar mean = `mean'
estadd local pfe "Y"
estadd local yfe "N"
estadd local ymsfe "Y"
estadd local controls "Y"
estadd local income "N"
eststo s13, refresh 

* Head HW hours // same as before

reghdfe homeworkhrs pter_atus hh_numkids hh_adults i.net_famincome_decile $demographic_atus if single_atus == 1 & employed_atus == 1, absorb(month_atus#year_atus#statefip) vce(cluster cpsid) nocons

sum homeworkhrs if e(sample) == 1
local mean = r(mean)
estadd scalar mean = `mean'
estadd local pfe "N"
estadd local yfe "N"
estadd local ymsfe "Y"
estadd local controls "Y"
estadd local income "Y" // should I add income controls here?
eststo s23, refresh 

*Married
* Head work hours

reghdfe ahrsworkt pter nchild nadults if married == 1 & employed == 1, absorb(monthly_date#statefip cpsidp) vce(cluster cpsid) nocons

sum ahrsworkt if e(sample) == 1
local mean = r(mean)
estadd scalar mean = `mean'
estadd local pfe "Y"
estadd local yfe "N"
estadd local ymsfe "Y"
estadd local controls "Y"
estadd local income "N"
eststo m13, refresh 

* Head HW hours

reghdfe homeworkhrs pter_atus hh_numkids hh_adults i.net_famincome_decile $demographic_atus if married_atus == 1 & employed_atus == 1, absorb(month_atus#year_atus#statefip) vce(cluster cpsid) nocons

sum homeworkhrs if e(sample) == 1
local mean = r(mean)
estadd scalar mean = `mean'
estadd local pfe "N"
estadd local yfe "N"
estadd local ymsfe "Y"
estadd local controls "Y"
estadd local income "Y" // should I add income controls here?
eststo m23, refresh 


* Spouse work hours

reghdfe ahrsworkt_sp pter nchild nadults if married == 1 & employed == 1, absorb(cpsidp monthly_date#statefip) vce(cluster cpsid) nocons

sum ahrsworkt_sp if e(sample) == 1
local mean = r(mean)
estadd scalar mean = `mean'
estadd local pfe "Y"
estadd local yfe "N"
estadd local ymsfe "Y"
estadd local controls "Y"
estadd local income "N"
eststo m33, refresh 

*Spouse HW hours

reghdfe homeworkhrs_sp pter nchild nadults $demographic_cps if married == 1 & employed == 1, absorb(monthly_date#statefip) vce(cluster cpsid) nocons

sum homeworkhrs_sp if e(sample) == 1
local mean = r(mean)
estadd scalar mean = `mean'
estadd local pfe "N"
estadd local yfe "N"
estadd local ymsfe "Y"
estadd local controls "Y"
estadd local income "N"
eststo m43, refresh 

*Spouse LMP

reghdfe employed_sp pter nchild nadults if married == 1 & employed == 1, absorb(cpsidp monthly_date#statefip) vce(cluster cpsid) nocons

sum employed_sp if e(sample) == 1
local mean = r(mean)
estadd scalar mean = `mean'
estadd local pfe "Y"
estadd local yfe "N"
estadd local ymsfe "Y"
estadd local controls "Y"
estadd local income "N"
eststo m53, refresh 


esttab s13 s23 m13 m23 m33 m43 m53 using cps_atus_v3.tex, replace se r2 label scalars("mean Dep. var. mean" "pfe Person FE" "yfe Year FE" "ymsfe Year-month-state FE" "controls Controls" "income Income") nonotes star(* 0.10 ** 0.05 *** 0.01) ///
keep(pter pter_atus) booktabs ///
mgroups("Single" "Married",pattern(1 0 1 0 0 0 0) span prefix(\multicolumn{@span}{c}{) suffix(}) end(\cmidrule(lr){2-3}\cmidrule(lr){4-8})) ///
mtitle("\shortstack{Own work\\hours}" "\shortstack{Own HW\\hours}" "\shortstack{Own work\\hours}" "\shortstack{Own HW\\hours}" "\shortstack{Spouse work\\hours}" "\shortstack{Spouse HW\\hours}" "\shortstack{Spouse\\LMP}") ///
substitute("\_" "_" "{l}{\footnotesize" "{p{17cm}}{\footnotesize" ) ///
addnotes("\textit{Notes}: The table presents coefficient estimates from equation \ref{eq:housework} using data from the American Time Use Survey and the Current Population Survey. The sample is restricted to individuals in the American Time Use Survey. Columns 1 and 2 consider single households, while columns 3--7 consider married households. Control variables are the number of children in the household, number of adults. When individual fixed effects are not present controls for age, gender, race and education are included. Columns 2 and 4 also control for family income (net of own and spouse's labor income if married) decile. Standard errors are clustered at the household level in all columns but columns 2 and 4, where heteroskedasticity-robust standard errors are reported. \sym{*}, \sym{**}, and \sym{***} denote statistical significance at the 10\%, 5\%, and 1\% levels, respectively.")

****************************************************
* V4 : ATUS only (+ related cps covariates)
* = keeping only subsample which enters atus
* keep only last cps wave 

*Version 4
use cps_atus_merged_76_21, clear

keep if homeworkhrs != . | homeworkhrs_sp != .

by cpsidp (mish), sort: gen byte last_obs = (_n == _N)
order last_obs, after(mish)
keep if last_obs == 1 

global demographic_atus "age_atus female_atus black highschool_atus somecollege_atus collegeup_atus"
global demographic_cps " age female black highschool somecollege collegeup"

*Single
* Head work hours // same as before
reghdfe ahrsworkt pter nchild nadults if single == 1 & employed == 1, absorb(monthly_date#statefip) vce(cluster cpsid) nocons

sum ahrsworkt if e(sample) == 1
local mean = r(mean)
estadd scalar mean = `mean'
estadd local pfe "N"
estadd local yfe "N"
estadd local ymsfe "Y"
estadd local controls "Y"
estadd local income "N"
eststo s14, refresh 

* Head HW hours // same as before

reghdfe homeworkhrs pter_atus hh_numkids hh_adults i.net_famincome_decile $demographic_atus if single_atus == 1 & employed_atus == 1, absorb(month_atus#year_atus#statefip) vce(cluster cpsid) nocons

sum homeworkhrs if e(sample) == 1
local mean = r(mean)
estadd scalar mean = `mean'
estadd local pfe "N"
estadd local yfe "N"
estadd local ymsfe "Y"
estadd local controls "Y"
estadd local income "Y" // should I add income controls here?
eststo s24, refresh 

*Married
* Head work hours

reghdfe ahrsworkt pter nchild nadults if married == 1 & employed == 1, absorb(monthly_date#statefip) vce(cluster cpsid) nocons

sum ahrsworkt if e(sample) == 1
local mean = r(mean)
estadd scalar mean = `mean'
estadd local pfe "N"
estadd local yfe "N"
estadd local ymsfe "Y"
estadd local controls "Y"
estadd local income "N"
eststo m14, refresh 

* Head HW hours

reghdfe homeworkhrs pter_atus hh_numkids hh_adults i.net_famincome_decile $demographic_atus if married_atus == 1 & employed_atus == 1, absorb(month_atus#year_atus#statefip) vce(cluster cpsid) nocons

sum homeworkhrs if e(sample) == 1
local mean = r(mean)
estadd scalar mean = `mean'
estadd local pfe "N"
estadd local yfe "N"
estadd local ymsfe "Y"
estadd local controls "Y"
estadd local income "Y" // should I add income controls here?
eststo m24, refresh 


* Spouse work hours

reghdfe ahrsworkt_sp pter nchild nadults if married == 1 & employed == 1, absorb(monthly_date#statefip) vce(cluster cpsid) nocons

sum ahrsworkt_sp if e(sample) == 1
local mean = r(mean)
estadd scalar mean = `mean'
estadd local pfe "N"
estadd local yfe "N"
estadd local ymsfe "Y"
estadd local controls "Y"
estadd local income "N"
eststo m34, refresh 

*Spouse HW hours

reghdfe homeworkhrs_sp pter nchild nadults $demographic_cps if married == 1 & employed == 1, absorb(monthly_date#statefip) vce(cluster cpsid) nocons

sum homeworkhrs_sp if e(sample) == 1
local mean = r(mean)
estadd scalar mean = `mean'
estadd local pfe "N"
estadd local yfe "N"
estadd local ymsfe "Y"
estadd local controls "Y"
estadd local income "N"
eststo m44, refresh 

*Spouse LMP

reghdfe employed_sp pter nchild nadults if married == 1 & employed == 1, absorb(monthly_date#statefip) vce(cluster cpsid) nocons

sum employed_sp if e(sample) == 1
local mean = r(mean)
estadd scalar mean = `mean'
estadd local pfe "N"
estadd local yfe "N"
estadd local ymsfe "Y"
estadd local controls "Y"
estadd local income "N"
eststo m54, refresh 


esttab s14 s24 m14 m24 m34 m44 m54 using cps_atus_v4.tex, replace se r2 label scalars("mean Dep. var. mean" "pfe Person FE" "yfe Year FE" "ymsfe Year-month-state FE" "controls Controls" "income Income") nonotes star(* 0.10 ** 0.05 *** 0.01) ///
keep(pter pter_atus) booktabs ///
mgroups("Single" "Married",pattern(1 0 1 0 0 0 0) span prefix(\multicolumn{@span}{c}{) suffix(}) end(\cmidrule(lr){2-3}\cmidrule(lr){4-8})) ///
mtitle("\shortstack{Own work\\hours}" "\shortstack{Own HW\\hours}" "\shortstack{Own work\\hours}" "\shortstack{Own HW\\hours}" "\shortstack{Spouse work\\hours}" "\shortstack{Spouse HW\\hours}" "\shortstack{Spouse\\LMP}") ///
substitute("\_" "_" "{l}{\footnotesize" "{p{17cm}}{\footnotesize" ) ///
addnotes("\textit{Notes}: The table presents coefficient estimates from equation \ref{eq:housework} using data from the American Time Use Survey and the Current Population Survey. The sample is restricted to individuals in the American Time Use Survey. Columns 1 and 2 consider single households, while columns 3--7 consider married households. Control variables are the number of children in the household, number of adults. When individual fixed effects are not present controls for age, gender, race and education are included. Columns 2 and 4 also control for family income (net of own and spouse's labor income if married) decile. Standard errors are clustered at the household level in all columns but columns 2 and 4, where heteroskedasticity-robust standard errors are reported. \sym{*}, \sym{**}, and \sym{***} denote statistical significance at the 10\%, 5\%, and 1\% levels, respectively.")
xxx
**************************************************************************************************************
* Restricted sample: drop self employed, keep if otpay == 1

* Final table
*Version 1 : Full sample
*Version 2 : Uniform sample for CPS, ATUS across columns
*Version 3 : ATUS sample only

*Version 1R
use cps_atus_merged_76_21, clear
keep if selfempl == 0
keep if otpay == 1
// 572000 obs

global demographic_atus "age_atus female_atus black highschool_atus somecollege_atus collegeup_atus"
global demographic_cps " age female black highschool somecollege collegeup"

*Single
* Head work hours
reghdfe ahrsworkt pter nchild nadults if single == 1 & employed == 1, absorb(year#statefip cpsidp) vce(cluster cpsid) nocons

sum ahrsworkt if e(sample) == 1
local mean = r(mean)
estadd scalar mean = `mean'
estadd local pfe "Y" // without this obs = 135k
estadd local yfe "N"
estadd local ysfe "Y" // months is either 8 or 4
estadd local controls "Y"
estadd local income "N"
eststo s1r, refresh 
gen s1r = e(sample)

save cps_atus_temp, replace // to save s1

* Head HW hours
/*
use atus_clean_03_20, clear

keep if selfempl_atus == 0
keep if otpay_atus == 1
// 6900 obs, with only 60 PTER -- we can't run this analysis with atus only and dropping selfemployed and otpay = 0
*/

tab pter_atus, m // 231
tab pter, m

reghdfe homeworkhrs pter_atus hh_numkids hh_adults i.net_famincome_decile $demographic_atus if single_atus == 1 & employed_atus == 1, absorb(year_atus#statefip) vce(cluster cpsid) nocons

sum homeworkhrs if e(sample) == 1
local mean = r(mean)
estadd scalar mean = `mean'
estadd local pfe "N"
estadd local yfe "N"
estadd local ysfe "Y"
estadd local controls "Y"
estadd local income "Y" // should I add income controls here?
eststo s2r, refresh 
gen s2r = e(sample)

*Married
* Head work hours

reghdfe ahrsworkt pter nchild nadults if married == 1 & employed == 1, absorb(year#statefip cpsidp) vce(cluster cpsid) nocons

sum ahrsworkt if e(sample) == 1
local mean = r(mean)
estadd scalar mean = `mean'
estadd local pfe "Y"
estadd local yfe "N"
estadd local ysfe "Y"
estadd local controls "Y"
estadd local income "N"
eststo m1r, refresh 
gen m1r = e(sample)


* Head HW hours

reghdfe homeworkhrs pter_atus hh_numkids hh_adults i.net_famincome_decile $demographic_atus if married_atus == 1 & employed_atus == 1, absorb(year_atus#statefip) vce(cluster cpsid) nocons

sum homeworkhrs if e(sample) == 1
local mean = r(mean)
estadd scalar mean = `mean'
estadd local pfe "N"
estadd local yfe "N"
estadd local ymfe "Y"
estadd local controls "Y"
estadd local income "Y" // should I add income controls here?
eststo m2r, refresh 
gen m2r = e(sample)


* Spouse work hours

reghdfe ahrsworkt_sp pter nchild nadults if married == 1 & employed == 1, absorb(cpsidp year#statefip) vce(cluster cpsid) nocons

sum ahrsworkt_sp if e(sample) == 1
local mean = r(mean)
estadd scalar mean = `mean'
estadd local pfe "Y"
estadd local yfe "N"
estadd local ymfe "Y"
estadd local controls "Y"
estadd local income "N"
eststo m3r, refresh 
gen m3r = e(sample)


*Spouse HW hours
reghdfe homeworkhrs_sp pter nchild nadults $demographic_cps if married == 1 & employed == 1, absorb(year#statefip) vce(cluster cpsid) nocons

sum homeworkhrs_sp if e(sample) == 1
local mean = r(mean)
estadd scalar mean = `mean'
estadd local pfe "N"
estadd local yfe "N"
estadd local ysfe "Y"
estadd local controls "Y"
estadd local income "N"
eststo m4r, refresh 
gen m4r = e(sample)

*Spouse LMP
reghdfe employed_sp pter nchild nadults if married == 1 & employed == 1, absorb(cpsidp year#statefip) vce(cluster cpsid) nocons

sum employed_sp if e(sample) == 1
local mean = r(mean)
estadd scalar mean = `mean'
estadd local pfe "Y"
estadd local yfe "N"
estadd local ysfe "Y"
estadd local controls "Y"
estadd local income "N"
eststo m5r, refresh 
gen m5r = e(sample)


esttab s1r s2r m1r m2r m3r m4r m5r using cps_atus_restricted.tex, replace se r2 label scalars("mean Dep. var. mean" "pfe Person FE" "yfe Year FE" "ysfe Year-state FE" "controls Controls" "income Income") nonotes star(* 0.10 ** 0.05 *** 0.01) ///
keep(pter pter_atus) booktabs ///
mgroups("Single" "Married",pattern(1 0 1 0 0 0 0) span prefix(\multicolumn{@span}{c}{) suffix(}) end(\cmidrule(lr){2-3}\cmidrule(lr){4-8})) ///
mtitle("\shortstack{Own work\\hours}" "\shortstack{Own HW\\hours}" "\shortstack{Own work\\hours}" "\shortstack{Own HW\\hours}" "\shortstack{Spouse work\\hours}" "\shortstack{Spouse HW\\hours}" "\shortstack{Spouse\\LMP}") ///
substitute("\_" "_" "{l}{\footnotesize" "{p{17cm}}{\footnotesize" ) ///
addnotes("\textit{Notes}: The table presents coefficient estimates from equation \ref{eq:housework} using data from the American Time Use Survey and the Current Population Survey. Columns 1 and 2 consider single households, while columns 3--7 consider married households. Control variables are the number of children in the household, number of adults. When individual fixed effects are not present controls for age, gender, race and education are included. Columns 2 and 4 also control for family income (net of own and spouse's labor income if married) decile. Standard errors are clustered at the household level. \sym{*}, \sym{**}, and \sym{***} denote statistical significance at the 10\%, 5\%, and 1\% levels, respectively.")


*****************************************************
* V2 : Uniform sample for CPS, uniform sample for ATUS
* This equals keeping married observations in cps for individuals who also provide info on their spouse
* For atus, this means keeping only the atus obs for spouse homework hours 

*Version 2
use cps_atus_merged_76_21, clear

global demographic_atus "age_atus female_atus black highschool_atus somecollege_atus collegeup_atus"
global demographic_cps " age female black highschool somecollege collegeup"

*Single
* Head work hours // same as before
reghdfe ahrsworkt pter nchild nadults if single == 1 & employed == 1, absorb(monthly_date#statefip cpsidp) vce(cluster cpsid) nocons

sum ahrsworkt if e(sample) == 1
local mean = r(mean)
estadd scalar mean = `mean'
estadd local pfe "Y"
estadd local yfe "N"
estadd local ymsfe "Y"
estadd local controls "Y"
estadd local income "N"
eststo s12, refresh 

* Head HW hours // same as before
use atus_clean_03_20, clear

reghdfe homeworkhrs pter_atus hh_numkids hh_adults i.net_famincome_decile $demographic_atus if single_atus == 1 & employed_atus == 1, absorb(month_atus#year_atus#statefip) vce(robust) nocons

sum homeworkhrs if e(sample) == 1
local mean = r(mean)
estadd scalar mean = `mean'
estadd local pfe "N"
estadd local yfe "N"
estadd local ymsfe "Y"
estadd local controls "Y"
estadd local income "Y" // should I add income controls here?
eststo s22, refresh 

*Married
* Head work hours // restricted to those with nonmissing spouse observations
use cps_atus_merged_76_21, clear

keep if m1 == 1 & m5 ==1 // = in sample in specification m1, m5. If I were to restrict also to being in sample for m3 it would be = to conditioning on spouse lmp = 1

reghdfe ahrsworkt pter nchild nadults if married == 1 & employed == 1, absorb(monthly_date#statefip cpsidp) vce(cluster cpsid) nocons

sum ahrsworkt if e(sample) == 1
local mean = r(mean)
estadd scalar mean = `mean'
estadd local pfe "Y"
estadd local yfe "N"
estadd local ymsfe "Y"
estadd local controls "Y"
estadd local income "N"
eststo m12, refresh 

* Head HW hours

use atus_clean_03_20, clear

reghdfe homeworkhrs pter_atus hh_numkids hh_adults i.net_famincome_decile $demographic_atus if married_atus == 1 & employed_atus == 1, absorb(month_atus#year_atus#statefip) vce(robust) nocons

sum homeworkhrs if e(sample) == 1
local mean = r(mean)
estadd scalar mean = `mean'
estadd local pfe "N"
estadd local yfe "N"
estadd local ymsfe "Y"
estadd local controls "Y"
estadd local income "Y" // should I add income controls here?
eststo m22, refresh 


* Spouse work hours
use cps_atus_merged_76_21, clear

keep if m1 == 1 & m3 == 1 & m5 ==1 // = in sample in specification m1, m3, m5

reghdfe ahrsworkt_sp pter nchild nadults if married == 1 & employed == 1, absorb(cpsidp monthly_date#statefip) vce(cluster cpsid) nocons

sum ahrsworkt_sp if e(sample) == 1
local mean = r(mean)
estadd scalar mean = `mean'
estadd local pfe "Y"
estadd local yfe "N"
estadd local ymsfe "Y"
estadd local controls "Y"
estadd local income "N"
eststo m32, refresh 

*Spouse HW hours
use cps_atus_merged_76_21, clear

keep if homeworkhrs_sp != . // keeping only spouse obs from atus. Now this info is repeated over all cps months

by cpsidp_sp (mish), sort: gen byte last_obs = (_n == _N)
order last_obs, after(mish)

keep if last_obs == 1 // keeping only one obs per individual -- the last is the closest to atus survey

reghdfe homeworkhrs_sp pter nchild nadults $demographic_cps if married == 1 & employed == 1, absorb(monthly_date#statefip) vce(cluster cpsid) nocons

sum homeworkhrs_sp if e(sample) == 1
local mean = r(mean)
estadd scalar mean = `mean'
estadd local pfe "N"
estadd local yfe "N"
estadd local ymsfe "Y"
estadd local controls "Y"
estadd local income "N"
eststo m42, refresh 

*Spouse LMP
use cps_atus_merged_76_21, clear

keep if m1 == 1 & m5 ==1 

reghdfe employed_sp pter nchild nadults if married == 1 & employed == 1, absorb(cpsidp monthly_date#statefip) vce(cluster cpsid) nocons

sum employed_sp if e(sample) == 1
local mean = r(mean)
estadd scalar mean = `mean'
estadd local pfe "Y"
estadd local yfe "N"
estadd local ymsfe "Y"
estadd local controls "Y"
estadd local income "N"
eststo m52, refresh 


esttab s12 s22 m12 m22 m32 m42 m52 using cps_atus_v2.tex, replace se r2 label scalars("mean Dep. var. mean" "pfe Person FE" "yfe Year FE" "ymsfe Year-month-state FE" "controls Controls" "income Income") nonotes star(* 0.10 ** 0.05 *** 0.01) ///
keep(pter pter_atus) booktabs ///
mgroups("Single" "Married",pattern(1 0 1 0 0 0 0) span prefix(\multicolumn{@span}{c}{) suffix(}) end(\cmidrule(lr){2-3}\cmidrule(lr){4-8})) ///
mtitle("\shortstack{Own work\\hours}" "\shortstack{Own HW\\hours}" "\shortstack{Own work\\hours}" "\shortstack{Own HW\\hours}" "\shortstack{Spouse work\\hours}" "\shortstack{Spouse HW\\hours}" "\shortstack{Spouse\\LMP}") ///
substitute("\_" "_" "{l}{\footnotesize" "{p{17cm}}{\footnotesize" ) ///
addnotes("\textit{Notes}: The table presents coefficient estimates from equation \ref{eq:housework} using data from the American Time Use Survey and the Current Population Survey. Columns 1 and 2 consider single households, while columns 3--7 consider married households. Control variables are the number of children in the household, number of adults. When individual fixed effects are not present controls for age, gender, race and education are included. Columns 2 and 4 also control for family income (net of own and spouse's labor income if married) decile. Standard errors are clustered at the household level in all columns but columns 2 and 4, where heteroskedasticity-robust standard errors are reported. \sym{*}, \sym{**}, and \sym{***} denote statistical significance at the 10\%, 5\%, and 1\% levels, respectively.")

*****************************************************
* V3 : ATUS only (+ related cps covariates)
* = keeping only subsample which enters atus
* do we want to keep only one cps wave or all of them?
* keep all of them for now
*keep married obs which have all info on spouse

*Version 3
use cps_atus_merged_76_21, clear

keep if homeworkhrs != . | homeworkhrs_sp != .
drop if m1 == 0 & married == 1 | m5 == 0 & married ==1 

global demographic_atus "age_atus female_atus black highschool_atus somecollege_atus collegeup_atus"
global demographic_cps " age female black highschool somecollege collegeup"

*Single
* Head work hours // same as before
reghdfe ahrsworkt pter nchild nadults if single == 1 & employed == 1, absorb(monthly_date#statefip cpsidp) vce(cluster cpsid) nocons

sum ahrsworkt if e(sample) == 1
local mean = r(mean)
estadd scalar mean = `mean'
estadd local pfe "Y"
estadd local yfe "N"
estadd local ymsfe "Y"
estadd local controls "Y"
estadd local income "N"
eststo s13, refresh 

* Head HW hours // same as before

reghdfe homeworkhrs pter_atus hh_numkids hh_adults i.net_famincome_decile $demographic_atus if single_atus == 1 & employed_atus == 1, absorb(month_atus#year_atus#statefip) vce(cluster cpsid) nocons

sum homeworkhrs if e(sample) == 1
local mean = r(mean)
estadd scalar mean = `mean'
estadd local pfe "N"
estadd local yfe "N"
estadd local ymsfe "Y"
estadd local controls "Y"
estadd local income "Y" // should I add income controls here?
eststo s23, refresh 

*Married
* Head work hours

reghdfe ahrsworkt pter nchild nadults if married == 1 & employed == 1, absorb(monthly_date#statefip cpsidp) vce(cluster cpsid) nocons

sum ahrsworkt if e(sample) == 1
local mean = r(mean)
estadd scalar mean = `mean'
estadd local pfe "Y"
estadd local yfe "N"
estadd local ymsfe "Y"
estadd local controls "Y"
estadd local income "N"
eststo m13, refresh 

* Head HW hours

reghdfe homeworkhrs pter_atus hh_numkids hh_adults i.net_famincome_decile $demographic_atus if married_atus == 1 & employed_atus == 1, absorb(month_atus#year_atus#statefip) vce(cluster cpsid) nocons

sum homeworkhrs if e(sample) == 1
local mean = r(mean)
estadd scalar mean = `mean'
estadd local pfe "N"
estadd local yfe "N"
estadd local ymsfe "Y"
estadd local controls "Y"
estadd local income "Y" // should I add income controls here?
eststo m23, refresh 


* Spouse work hours

reghdfe ahrsworkt_sp pter nchild nadults if married == 1 & employed == 1, absorb(cpsidp monthly_date#statefip) vce(cluster cpsid) nocons

sum ahrsworkt_sp if e(sample) == 1
local mean = r(mean)
estadd scalar mean = `mean'
estadd local pfe "Y"
estadd local yfe "N"
estadd local ymsfe "Y"
estadd local controls "Y"
estadd local income "N"
eststo m33, refresh 

*Spouse HW hours

reghdfe homeworkhrs_sp pter nchild nadults $demographic_cps if married == 1 & employed == 1, absorb(monthly_date#statefip) vce(cluster cpsid) nocons

sum homeworkhrs_sp if e(sample) == 1
local mean = r(mean)
estadd scalar mean = `mean'
estadd local pfe "N"
estadd local yfe "N"
estadd local ymsfe "Y"
estadd local controls "Y"
estadd local income "N"
eststo m43, refresh 

*Spouse LMP

reghdfe employed_sp pter nchild nadults if married == 1 & employed == 1, absorb(cpsidp monthly_date#statefip) vce(cluster cpsid) nocons

sum employed_sp if e(sample) == 1
local mean = r(mean)
estadd scalar mean = `mean'
estadd local pfe "Y"
estadd local yfe "N"
estadd local ymsfe "Y"
estadd local controls "Y"
estadd local income "N"
eststo m53, refresh 


esttab s13 s23 m13 m23 m33 m43 m53 using cps_atus_v3.tex, replace se r2 label scalars("mean Dep. var. mean" "pfe Person FE" "yfe Year FE" "ymsfe Year-month-state FE" "controls Controls" "income Income") nonotes star(* 0.10 ** 0.05 *** 0.01) ///
keep(pter pter_atus) booktabs ///
mgroups("Single" "Married",pattern(1 0 1 0 0 0 0) span prefix(\multicolumn{@span}{c}{) suffix(}) end(\cmidrule(lr){2-3}\cmidrule(lr){4-8})) ///
mtitle("\shortstack{Own work\\hours}" "\shortstack{Own HW\\hours}" "\shortstack{Own work\\hours}" "\shortstack{Own HW\\hours}" "\shortstack{Spouse work\\hours}" "\shortstack{Spouse HW\\hours}" "\shortstack{Spouse\\LMP}") ///
substitute("\_" "_" "{l}{\footnotesize" "{p{17cm}}{\footnotesize" ) ///
addnotes("\textit{Notes}: The table presents coefficient estimates from equation \ref{eq:housework} using data from the American Time Use Survey and the Current Population Survey. The sample is restricted to individuals in the American Time Use Survey. Columns 1 and 2 consider single households, while columns 3--7 consider married households. Control variables are the number of children in the household, number of adults. When individual fixed effects are not present controls for age, gender, race and education are included. Columns 2 and 4 also control for family income (net of own and spouse's labor income if married) decile. Standard errors are clustered at the household level in all columns but columns 2 and 4, where heteroskedasticity-robust standard errors are reported. \sym{*}, \sym{**}, and \sym{***} denote statistical significance at the 10\%, 5\%, and 1\% levels, respectively.")

****************************************************
* V4 : ATUS only (+ related cps covariates)
* = keeping only subsample which enters atus
* keep only last cps wave 

*Version 4
use cps_atus_merged_76_21, clear

keep if homeworkhrs != . | homeworkhrs_sp != .

by cpsidp (mish), sort: gen byte last_obs = (_n == _N)
order last_obs, after(mish)
keep if last_obs == 1 

global demographic_atus "age_atus female_atus black highschool_atus somecollege_atus collegeup_atus"
global demographic_cps " age female black highschool somecollege collegeup"

*Single
* Head work hours // same as before
reghdfe ahrsworkt pter nchild nadults if single == 1 & employed == 1, absorb(monthly_date#statefip) vce(cluster cpsid) nocons

sum ahrsworkt if e(sample) == 1
local mean = r(mean)
estadd scalar mean = `mean'
estadd local pfe "N"
estadd local yfe "N"
estadd local ymsfe "Y"
estadd local controls "Y"
estadd local income "N"
eststo s14, refresh 

* Head HW hours // same as before

reghdfe homeworkhrs pter_atus hh_numkids hh_adults i.net_famincome_decile $demographic_atus if single_atus == 1 & employed_atus == 1, absorb(month_atus#year_atus#statefip) vce(cluster cpsid) nocons

sum homeworkhrs if e(sample) == 1
local mean = r(mean)
estadd scalar mean = `mean'
estadd local pfe "N"
estadd local yfe "N"
estadd local ymsfe "Y"
estadd local controls "Y"
estadd local income "Y" // should I add income controls here?
eststo s24, refresh 

*Married
* Head work hours

reghdfe ahrsworkt pter nchild nadults if married == 1 & employed == 1, absorb(monthly_date#statefip) vce(cluster cpsid) nocons

sum ahrsworkt if e(sample) == 1
local mean = r(mean)
estadd scalar mean = `mean'
estadd local pfe "N"
estadd local yfe "N"
estadd local ymsfe "Y"
estadd local controls "Y"
estadd local income "N"
eststo m14, refresh 

* Head HW hours

reghdfe homeworkhrs pter_atus hh_numkids hh_adults i.net_famincome_decile $demographic_atus if married_atus == 1 & employed_atus == 1, absorb(month_atus#year_atus#statefip) vce(cluster cpsid) nocons

sum homeworkhrs if e(sample) == 1
local mean = r(mean)
estadd scalar mean = `mean'
estadd local pfe "N"
estadd local yfe "N"
estadd local ymsfe "Y"
estadd local controls "Y"
estadd local income "Y" // should I add income controls here?
eststo m24, refresh 


* Spouse work hours

reghdfe ahrsworkt_sp pter nchild nadults if married == 1 & employed == 1, absorb(monthly_date#statefip) vce(cluster cpsid) nocons

sum ahrsworkt_sp if e(sample) == 1
local mean = r(mean)
estadd scalar mean = `mean'
estadd local pfe "N"
estadd local yfe "N"
estadd local ymsfe "Y"
estadd local controls "Y"
estadd local income "N"
eststo m34, refresh 

*Spouse HW hours

reghdfe homeworkhrs_sp pter nchild nadults $demographic_cps if married == 1 & employed == 1, absorb(monthly_date#statefip) vce(cluster cpsid) nocons

sum homeworkhrs_sp if e(sample) == 1
local mean = r(mean)
estadd scalar mean = `mean'
estadd local pfe "N"
estadd local yfe "N"
estadd local ymsfe "Y"
estadd local controls "Y"
estadd local income "N"
eststo m44, refresh 

*Spouse LMP

reghdfe employed_sp pter nchild nadults if married == 1 & employed == 1, absorb(monthly_date#statefip) vce(cluster cpsid) nocons

sum employed_sp if e(sample) == 1
local mean = r(mean)
estadd scalar mean = `mean'
estadd local pfe "N"
estadd local yfe "N"
estadd local ymsfe "Y"
estadd local controls "Y"
estadd local income "N"
eststo m54, refresh 


esttab s14 s24 m14 m24 m34 m44 m54 using cps_atus_v4.tex, replace se r2 label scalars("mean Dep. var. mean" "pfe Person FE" "yfe Year FE" "ymsfe Year-month-state FE" "controls Controls" "income Income") nonotes star(* 0.10 ** 0.05 *** 0.01) ///
keep(pter pter_atus) booktabs ///
mgroups("Single" "Married",pattern(1 0 1 0 0 0 0) span prefix(\multicolumn{@span}{c}{) suffix(}) end(\cmidrule(lr){2-3}\cmidrule(lr){4-8})) ///
mtitle("\shortstack{Own work\\hours}" "\shortstack{Own HW\\hours}" "\shortstack{Own work\\hours}" "\shortstack{Own HW\\hours}" "\shortstack{Spouse work\\hours}" "\shortstack{Spouse HW\\hours}" "\shortstack{Spouse\\LMP}") ///
substitute("\_" "_" "{l}{\footnotesize" "{p{17cm}}{\footnotesize" ) ///
addnotes("\textit{Notes}: The table presents coefficient estimates from equation \ref{eq:housework} using data from the American Time Use Survey and the Current Population Survey. The sample is restricted to individuals in the American Time Use Survey. Columns 1 and 2 consider single households, while columns 3--7 consider married households. Control variables are the number of children in the household, number of adults. When individual fixed effects are not present controls for age, gender, race and education are included. Columns 2 and 4 also control for family income (net of own and spouse's labor income if married) decile. Standard errors are clustered at the household level in all columns but columns 2 and 4, where heteroskedasticity-robust standard errors are reported. \sym{*}, \sym{**}, and \sym{***} denote statistical significance at the 10\%, 5\%, and 1\% levels, respectively.")
