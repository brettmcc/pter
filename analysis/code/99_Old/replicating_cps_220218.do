* Estimating equation 1 and 2 using CPS

global build "C:\Users\39328\Dropbox\Hours constraints and home prod\build"

global analysis "C:\Users\39328\Dropbox\Hours constraints and home prod\analysis"

cd "$build\output"

cd "C:\Users\lucafavero\Desktop\Ilaria" // workstation

clear all

use cps_atus_merged_76_21, clear

// TO be pasted in other dofile when available
*need to add: number of adults

*SHOULD I ADD DEPENDENT VARIABLE MEAN BY GROUPS?




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

*cd "$analysis\output"

xtset cpsidp mish

// ADD RESTRICTIONS: HEAD EMPLOYED == 1, REMOVE IF HOUSEWORK HOURS > 80 / WEEK

// Should I cluster standard errors to the individual / household level in equation 1?

*** 1. ASEC + Basic Monthly, controlling for log income and log wage

reghdfe into_pter $demographic $educ $lifecycle $income i.industry $employment if employed == 1, absorb(monthly_date) vce(robust) nocons

sum into_pter
local mean = r(mean)
estadd scalar mean = `mean'
estadd local pfe "N"
estadd local yfe "Y"
estadd local controls "Y"
eststo eq11, refresh 

*Male only

reghdfe into_pter $demographic2 $educ $lifecycle $income i.industry $employment if employed == 1 & female == 0, absorb(monthly_date) vce(robust) nocons

sum into_pter
local mean = r(mean)
estadd scalar mean = `mean'
estadd local pfe "N"
estadd local yfe "Y"
estadd local controls "Y"
eststo eq11m, refresh 


*Female only 

reghdfe into_pter $demographic2 $educ $lifecycle $income i.industry $employment if employed == 1 & female == 1, absorb(monthly_date) vce(robust) nocons

sum into_pter
local mean = r(mean)
estadd scalar mean = `mean'
estadd local pfe "N"
estadd local yfe "Y"
estadd local controls "Y"
eststo eq11w, refresh 


*** 2. ASEC + Basic Monthly, without controlling for log income and log wage

reghdfe into_pter $demographic $educ $lifecycle i.industry $employment if employed == 1, absorb(monthly_date) vce(robust) nocons

sum into_pter
local mean = r(mean)
estadd scalar mean = `mean'
estadd local pfe "N"
estadd local yfe "Y"
estadd local controls "Y"
eststo eq12, refresh 

*Male only
reghdfe into_pter $demographic2 $educ $lifecycle i.industry $employment if employed == 1 & female == 0, absorb(monthly_date) vce(robust) nocons

sum into_pter
local mean = r(mean)
estadd scalar mean = `mean'
estadd local pfe "N"
estadd local yfe "Y"
estadd local controls "Y"
eststo eq12m, refresh 

*Female only
reghdfe into_pter $demographic2 $educ $lifecycle i.industry $employment if employed == 1 & female == 1, absorb(monthly_date) vce(robust) nocons

sum into_pter
local mean = r(mean)
estadd scalar mean = `mean'
estadd local pfe "N"
estadd local yfe "Y"
estadd local controls "Y"
eststo eq12w, refresh 


*** 3. ASEC + Basic Monthly, without controlling for log income and log wage + individual FE
* Substituting n_child_chg with children_chg and pt_always with pt (otherwise omitted because of collinearity)

reghdfe into_pter $demographic $educ $lifecycle2 i.industry $employment2 if employed == 1, absorb(cpsidp monthly_date) vce(robust) nocons

sum into_pter
local mean = r(mean)
estadd scalar mean = `mean'
estadd local pfe "Y"
estadd local yfe "Y"
estadd local controls "Y"
eststo eq13, refresh 

*Male only
reghdfe into_pter $demographic2 $educ $lifecycle2 i.industry $employment2 if employed == 1 & female == 0, absorb(cpsidp monthly_date) vce(robust) nocons

sum into_pter
local mean = r(mean)
estadd scalar mean = `mean'
estadd local pfe "Y"
estadd local yfe "Y"
estadd local controls "Y"
eststo eq13m, refresh 

*Female only
reghdfe into_pter $demographic2 $educ $lifecycle2 i.industry $employment2 if employed == 1 & female == 1, absorb(cpsidp monthly_date) vce(robust) nocons

sum into_pter
local mean = r(mean)
estadd scalar mean = `mean'
estadd local pfe "Y"
estadd local yfe "Y"
estadd local controls "Y"
eststo eq13w, refresh 
i.black female highschool somecollege collegeup becom_homeowner s_to_m remain_married m_to_d n_child_chg children_chg log_faminc log_wage ft_pt pt_ft pt_always pt

esttab eq11 eq12 eq13 eq11m eq12m eq13m eq11w eq12w eq13w using eq1.tex, replace se r2 label scalars("mean Dep. var. mean" "pfe Person FE" "yfe Year FE" "controls Controls") nonotes star(* 0.10 ** 0.05 *** 0.01) ///
keep($demographic $demographic2 $educ $lifecycle $lifecycle2 $income $employment $employment2 , relax ) booktabs ///
mgroups("Overall" "Men" "Women",pattern(1 0 0 1 0 0 1 0 0) span prefix(\multicolumn{@span}{c}{) suffix(}) end(\cmidrule(lr){2-4}\cmidrule(lr){5-7}\cmidrule(lr){8-10})) mtitle("\shortstack{Becoming PTER}" "\shortstack{Becoming PTER}" "\shortstack{Becoming PTER}" "\shortstack{Becoming PTER}" "\shortstack{Becoming PTER}" "\shortstack{Becoming PTER}" "\shortstack{Becoming PTER}" "\shortstack{Becoming PTER}" "\shortstack{Becoming PTER}") /// WORK ON THIS
	substitute("\_" "_" "{l}{\footnotesize" "{p{17cm}}{\footnotesize" ) ///
	addnotes("\textit{Notes}: The table presents coefficient estimates from equation \ref{eq:EQUATION 1 CPS} using data from the Current Population Survey. Columns 4 -- 6 subset to male workers, while columns 7 -- 9 subset to female workers. Control variables are age, race, educational attainment, howeowner status, marital status and number of children changes, full-time, part-time changes. Columns 1 -- 3 also control for gender. Columns 1, 4 and 7 control for the logarithm of family income (net of head labor income) and the logarithm of head labor income. Columns 3, 6 and 9 control for changes in number of children instead of number of children changes. Heteroskedasticity-robust standard errors are reported. \sym{*}, \sym{**}, and \sym{***} denote statistical significance at the 10\%, 5\%, and 1\% levels, respectively.") // work on this
	
*ADD MEAN OF DEP VAR BY GROUP

********************************************************************************
*EQUATION 2 -- to be revised

* HOME WORK HOURS - SELF

* CPS variables

use cps_atus_merged_76_21, clear

// Single
*With income controls

reghdfe homeworkhrs pter nchild nadults i.famincome_decile  if single == 1 & employed==1, absorb(year) vce(robust) nocons 
// NO DUMMY FOR PT BECAUSEE IT  with pter

sum homeworkhrs if single == 1 & employed==1
local mean = r(mean) 
estadd scalar mean = `mean'
estadd local pfe "N"
estadd local yfe "Y"
estadd local controls "Y"
estadd local income "Y"
eststo eq2s, refresh

*Without income controls
reghdfe homeworkhrs pter nchild nadults pt if single == 1 & employed==1, absorb(cpsidp year) vce(cluster cpsid) nocons // pter dummy from cps

sum homeworkhrs if single == 1 & employed==1
local mean = r(mean)
estadd scalar mean = `mean'
estadd local pfe "Y"
estadd local yfe "Y"
estadd local controls "Y"
estadd local income "N"
eststo eq2sni, refresh

// Married
* CPS variables
*With income controls


reghdfe homeworkhrs pter nchild nadults i.famincome_married_decile pt if married == 1 & employed == 1, absorb(cpsipd year) vce(cluster cpsid) nocons // pter couple from cps

sum homeworkhrs if married == 1 & employed == 1
local mean = r(mean)
estadd scalar mean = `mean'
estadd local pfe "Y"
estadd local yfe "Y"
estadd local controls "Y"
estadd local income "Y"
eststo eq2m, refresh

*Without income controls
reghdfe homeworkhrs pter nchild nadults pt if married == 1 & employed == 1, absorb(cpsipd year) vce(cluster cpsid) nocons

sum homeworkhrs if married == 1 & employed == 1
local mean = r(mean)
estadd scalar mean = `mean'
estadd local pfe "Y"
estadd local yfe "Y"
estadd local controls "Y"
estadd local income "N"
eststo eq2mni, refresh

// Married men

*With income controls

reghdfe homeworkhrs pter nchild nadults i.famincome_married_decile pt if married == 1 & employed == 1 & female == 0, absorb(cpsipd year) vce(cluster cpsid) nocons // pter couple from cps

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

*********************************************************
*ATUS variables
use atus_clean_03_20, clear

// Single

*With income controls

reghdfe homeworkhrs pter_atus hh_numkids i.net_famincome_decile pt if single_atus == 1 & employed_atus == 1, absorb(year) vce(robust) nocons // pter dummy from atus
*ATUS DATA = no individual FE, no vce(cluster household) because there is only one observation per household

sum homeworkhrs
local mean = r(mean)
estadd scalar mean = `mean'
estadd local pfe "N"
estadd local yfe "Y"
estadd local controls "Y"
eststo 2as, refresh 

*Without income controls
reghdfe homeworkhrs pter_atus hh_numkids pt if single_atus == 1 & employed_atus == 1, absorb(year) vce(robust) nocons // pter dummy from atus

sum homeworkhrs
local mean = r(mean)
estadd scalar mean = `mean'
estadd local pfe "N"
estadd local yfe "Y"
estadd local controls "Y"
eststo 2asni, refresh 


// Married 

*With income controls

reghdfe homworkhrs pter_atus hh_numkids i.net_famincome_married_decile pt_atus if married_atus == 1 & employed_atus == 1, absorb(year) vce(robust) nocons // pter couple from atus

sum homeworkhrs
local mean = r(mean)
estadd scalar mean = `mean'
estadd local pfe "N"
estadd local yfe "Y"
estadd local controls "Y"
eststo 2am, refresh 

*Without income controls
reghdfe homeworkhrs pter_atus hh_numkids pt if married_atus == 1 & employed_atus == 1, absorb(year) vce(robust) nocons // pter dummy from atus

sum homeworkhrs
local mean = r(mean)
estadd scalar mean = `mean'
estadd local pfe "N"
estadd local yfe "Y"
estadd local controls "Y"
eststo 2amni, refresh 

// Married men

*With income controls

reghdfe homworkhrs pter_atus hh_numkids i.net_famincome_married_decile pt_atus if married_atus == 1 & employed_atus == 1 & female_atus == 0, absorb(year) vce(robust) nocons // pter couple from atus

sum homeworkhrs
local mean = r(mean)
estadd scalar mean = `mean'
estadd local pfe "N"
estadd local yfe "Y"
estadd local controls "Y"
eststo 2amm, refresh 

*Without income controls
reghdfe homeworkhrs pter_atus hh_numkids pt if married_atus == 1 & employed_atus == 1 & female_atus == 0, absorb(year) vce(robust) nocons // pter dummy from atus

sum homeworkhrs
local mean = r(mean)
estadd scalar mean = `mean'
estadd local pfe "N"
estadd local yfe "Y"
estadd local controls "Y"
eststo 2ammni, refresh 


// Married women

*With income controls

reghdfe homworkhrs pter_atus hh_numkids i.net_famincome_married_decile pt_atus if married_atus == 1 & employed_atus == 1 & female_atus == 1, absorb(year) vce(robust) nocons // pter couple from atus

sum homeworkhrs
local mean = r(mean)
estadd scalar mean = `mean'
estadd local pfe "N"
estadd local yfe "Y"
estadd local controls "Y"
eststo 2amw, refresh 

*Without income controls
reghdfe homeworkhrs pter_atus hh_numkids pt if married_atus == 1 & employed_atus == 1 & female_atus == 1, absorb(year) vce(robust) nocons // pter dummy from atus

sum homeworkhrs
local mean = r(mean)
estadd scalar mean = `mean'
estadd local pfe "N"
estadd local yfe "Y"
estadd local controls "Y"
eststo 2amwni, refresh 


esttab 2as 2asni 2am 2amni 2amm 2ammni 2amw 2amwni using eq2_homeworkhours_atus.tex, replace se r2 label scalars("mean Dep. var. mean" "pfe Person FE" "yfe Year FE" "controls Controls") nonotes star(* 0.10 ** 0.05 *** 0.01) ///
keep(pter) booktabs ///
mgroups("Single" "Married",pattern(1 0 1 0 0 0 0 0) span prefix(\multicolumn{@span}{c}{) suffix(}) end(\cmidrule(lr){2-3}\cmidrule(lr){4-9})) ///
mgroups("Men" "Women",pattern(0 0 0 0 1 0 1 0) span prefix(\multicolumn{@span}{c}{) suffix(}) end(\cmidrule(lr){6-7}\cmidrule(lr){8-9})) ///
mtitle("\shortstack{Homework\\hours}" "\shortstack{Homework\\hours}" "\shortstack{Homework\\hours}" "\shortstack{Homework\\hours}" "\shortstack{Homework\\hours}" "\shortstack{Homework\\hours}" "\shortstack{Homework\\hours}" "\shortstack{Homework\\hours}") ///
substitute("\_" "_" "{l}{\footnotesize" "{p{17cm}}{\footnotesize" ) ///
addnotes("\textit{Notes}: The table presents coefficient estimates from equation \ref{eq:housework} using data from the American Time Use Survey. Columns 1 and 2 subset to single-headed households, while columns 3--8 subset to married households. Columns 5 and 6 refer to men in married households, while columns 7 and 8 to women in married households. Control variables are the number of children in the household, number of adults, whether the individual works part-time. Odd columns also control for family income (net of own labor income and, if married, of spouse's labour income) decile. Heteroskedasticity-robust standard errors are reported. \sym{*}, \sym{**}, and \sym{***} denote statistical significance at the 10\%, 5\%, and 1\% levels, respectively.")

*********************************************************
* HOME WORK HOURS - SPOUSE

* CPS variables

use cps_atus_merged_76_21, clear


// Married
*With income controls

reghdfe homeworkhrs_sp pter nchild i.famincome_married_decile pt if married == 1 & employed == 1, absorb(cpsipd year) vce(cluster cpsid) nocons

sum homeworkhrs_sp
local mean = r(mean)
estadd scalar mean = `mean'
estadd local pfe "Y"
estadd local yfe "Y"
estadd local controls "Y"
eststo hsm, refresh 

*Without income controls
reghdfe homeworkhrs_sp pter nchild pt if married == 1 & employed == 1, absorb(cpsipd year) vce(cluster cpsid) nocons

sum homeworkhrs_sp
local mean = r(mean)
estadd scalar mean = `mean'
estadd local pfe "Y"
estadd local yfe "Y"
estadd local controls "Y"
eststo hsmni, refresh 

// Married men

*With income controls

reghdfe homeworkhrs_sp pter nchild i.famincome_married_decile pt if married == 1 & employed == 1 & female == 0, absorb(cpsipd year) vce(cluster cpsid) nocons

sum homeworkhrs_sp
local mean = r(mean)
estadd scalar mean = `mean'
estadd local pfe "Y"
estadd local yfe "Y"
estadd local controls "Y"
eststo hsmm, refresh 

*Without income controls
reghdfe homeworkhrs_sp pter nchild pt if married == 1 & employed == 1 & female == 0, absorb(cpsipd year) vce(cluster cpsid) nocons

sum homeworkhrs_sp
local mean = r(mean)
estadd scalar mean = `mean'
estadd local pfe "Y"
estadd local yfe "Y"
estadd local controls "Y"
eststo hsmmni, refresh 

// Married women

*With income controls

reghdfe homeworkhrs_sp pter nchild i.famincome_married_decile pt if married == 1 & employed == 1 & female == 1, absorb(cpsipd year) vce(cluster cpsid) nocons

sum homeworkhrs_sp
local mean = r(mean)
estadd scalar mean = `mean'
estadd local pfe "Y"
estadd local yfe "Y"
estadd local controls "Y"
eststo hsmw, refresh 

*Without income controls
reghdfe homeworkhrs_sp pter nchild pt if married == 1 & employed == 1 & female == 1, absorb(cpsipd year) vce(cluster cpsid) nocons

sum homeworkhrs_sp
local mean = r(mean)
estadd scalar mean = `mean'
estadd local pfe "Y"
estadd local yfe "Y"
estadd local controls "Y"
eststo hsmwni, refresh 


esttab hsm hsmni hsmm hsmmni hsmw hsmwni using eq2_homeworkhours_spouse_cps.tex, replace se r2 label scalars("mean Dep. var. mean" "pfe Person FE" "yfe Year FE" "controls Controls") nonotes star(* 0.10 ** 0.05 *** 0.01) ///
keep(homeworkhrs_sp) booktabs ///
mgroups("Overall" "Men" "Women",pattern(1 0 1 0 1 0) span prefix(\multicolumn{@span}{c}{) suffix(}) end(\cmidrule(lr){2-3}\cmidrule(lr){4-5}\cmidrule(lr){6-7})) ///
mtitle("\shortstack{Spouse HW\\hours}" "\shortstack{Spouse HW\\hours}" "\shortstack{Spouse HW\\hours}" "\shortstack{Spouse HW\\hours}" "\shortstack{Spouse HW\\hours}" "\shortstack{Spouse HW\\hours}") ///
substitute("\_" "_" "{l}{\footnotesize" "{p{17cm}}{\footnotesize" ) ///
addnotes("\textit{Notes}: The table presents coefficient estimates from equation \ref{eq:housework} using data from the American Time Use Survey and the Current Population Survey. Columns 1 and 2 consider all married households, while columns 3--4 and 5--6 subset to married men and women, respectively. Control variables are the number of children in the household, number of adults, whether the individual works part-time. Odd columns also control for family income (net of own and spouse's labor income) decile. Standard errors are clustered at the household level. \sym{*}, \sym{**}, and \sym{***} denote statistical significance at the 10\%, 5\%, and 1\% levels, respectively.")

*********************************************************
*ATUS variables
use atus_clean_03_20, clear

// Married 

*With income controls

reghdfe homeworkhrs_sp pter_atus hh_numkids i.net_famincome_married_decile pt_atus if married_atus == 1 & employed_atus == 1, absorb(year) vce(robust) nocons // pter couple from atus

sum homeworkhrs_sp
local mean = r(mean)
estadd scalar mean = `mean'
estadd local pfe "N"
estadd local yfe "Y"
estadd local controls "Y"
eststo ahsm, refresh 

*Without income controls
reghdfe homeworkhrs_sp pter_atus hh_numkids pt if married_atus == 1 & employed_atus == 1, absorb(year) vce(robust) nocons // pter dummy from atus

sum homeworkhrs_sp
local mean = r(mean)
estadd scalar mean = `mean'
estadd local pfe "N"
estadd local yfe "Y"
estadd local controls "Y"
eststo ahsmni, refresh 

// Married men

*With income controls

reghdfe homeworkhrs_sp pter_atus hh_numkids i.net_famincome_married_decile pt_atus if married_atus == 1 & employed_atus == 1 & female_atus == 0, absorb(year) vce(robust) nocons // pter couple from atus

sum homeworkhrs_sp
local mean = r(mean)
estadd scalar mean = `mean'
estadd local pfe "N"
estadd local yfe "Y"
estadd local controls "Y"
eststo ahsmm, refresh 

*Without income controls
reghdfe homeworkhrs_sp pter_atus hh_numkids pt if married_atus == 1 & employed_atus == 1 & female_atus == 0, absorb(year) vce(robust) nocons // pter dummy from atus

sum homeworkhrs_sp
local mean = r(mean)
estadd scalar mean = `mean'
estadd local pfe "N"
estadd local yfe "Y"
estadd local controls "Y"
eststo ahsmmni, refresh 


// Married women

*With income controls

reghdfe homeworkhrs_sp pter_atus hh_numkids i.net_famincome_married_decile pt_atus if married_atus == 1 & employed_atus == 1 & female_atus == 1, absorb(year) vce(robust) nocons // pter couple from atus

sum homeworkhrs_sp
local mean = r(mean)
estadd scalar mean = `mean'
estadd local pfe "N"
estadd local yfe "Y"
estadd local controls "Y"
eststo ahsmw, refresh 

*Without income controls
reghdfe homeworkhrs_sp pter_atus hh_numkids pt if married_atus == 1 & employed_atus == 1 & female_atus == 1, absorb(year) vce(robust) nocons // pter dummy from atus

sum homeworkhrs_sp
local mean = r(mean)
estadd scalar mean = `mean'
estadd local pfe "N"
estadd local yfe "Y"
estadd local controls "Y"
eststo ahsmwni, refresh 

esttab ahsm ahsmni ahsmm ahsmmni ahsmw ahsmwni using eq2_homeworkhours_spouse_atus.tex, replace se r2 label scalars("mean Dep. var. mean" "pfe Person FE" "yfe Year FE" "controls Controls") nonotes star(* 0.10 ** 0.05 *** 0.01) ///
keep(homeworkhrs_sp) booktabs ///
mgroups("Overall" "Men" "Women",pattern(1 0 1 0 1 0) span prefix(\multicolumn{@span}{c}{) suffix(}) end(\cmidrule(lr){2-3}\cmidrule(lr){4-5}\cmidrule(lr){6-7})) ///
mtitle("\shortstack{Spouse HW\\hours}" "\shortstack{Spouse HW\\hours}" "\shortstack{Spouse HW\\hours}" "\shortstack{Spouse HW\\hours}" "\shortstack{Spouse HW\\hours}" "\shortstack{Spouse HW\\hours}") ///
substitute("\_" "_" "{l}{\footnotesize" "{p{17cm}}{\footnotesize" ) ///
addnotes("\textit{Notes}: The table presents coefficient estimates from equation \ref{eq:housework} using data from the American Time Use Survey. Columns 1 and 2 consider all married households, while columns 3--4 and 5--6 subset to married men and women, respectively. Control variables are the number of children in the household, number of adults, whether the individual works part-time. Odd columns also control for family income (net of own and spouse's labor income) decile. Heteroskedasticity-robust standard errors are reported. \sym{*}, \sym{**}, and \sym{***} denote statistical significance at the 10\%, 5\%, and 1\% levels, respectively.")


*********************************************************
*********************************************************
* SPOUSE'S LABOUR MARKET PARTICIPATION
*CPS
use cps_atus_merged_76_21, clear

// Married: general
*With income controls
reghdfe employed_sp pter nchild i.famincome_married_decile pt if married == 1 & employed == 1, absorb(cpsidp year) vce(cluster cpsid) nocons

sum employed_sp
local mean = r(mean)
estadd scalar mean = `mean'
estadd local pfe "Y"
estadd local yfe "Y"
estadd local controls "Y"
eststo esm, refresh 

*Without income controls
reghdfe employed_sp pter nchild pt if married == 1 & employed == 1, absorb(cpsidp year) vce(cluster cpsid) nocons

sum employed_sp
local mean = r(mean)
estadd scalar mean = `mean'
estadd local pfe "Y"
estadd local yfe "Y"
estadd local controls "Y"
eststo esmni, refresh 

//Married Men

*With income controls
reghdfe employed_sp pter nchild i.famincome_married_decile pt if married == 1 & employed == 1 & female == 0, absorb(cpsidp year) vce(cluster cpsid) nocons

sum employed_sp
local mean = r(mean)
estadd scalar mean = `mean'
estadd local pfe "Y"
estadd local yfe "Y"
estadd local controls "Y"
eststo esmm, refresh 

*Without income controls
reghdfe employed_sp pter nchild pt if married == 1 & employed == 1 & female == 0, absorb(cpsidp year) vce(cluster cpsid) nocons

sum employed_sp
local mean = r(mean)
estadd scalar mean = `mean'
estadd local pfe "Y"
estadd local yfe "Y"
estadd local controls "Y"
eststo esmmni, refresh 

// Married women
*With income controls
reghdfe employed_sp pter nchild i.famincome_married_decile pt if married == 1 & employed == 1 & female == 1, absorb(cpsidp year) vce(cluster cpsid) nocons

sum employed_sp
local mean = r(mean)
estadd scalar mean = `mean'
estadd local pfe "Y"
estadd local yfe "Y"
estadd local controls "Y"
eststo esmw, refresh 

*Without income controls
reghdfe employed_sp pter nchild pt if married == 1 & employed == 1 & female == 1, absorb(cpsidp year) vce(cluster cpsid) nocons

sum employed_sp
local mean = r(mean)
estadd scalar mean = `mean'
estadd local pfe "Y"
estadd local yfe "Y"
estadd local controls "Y"
eststo esmwni, refresh 

esttab esm esmni esmm esmmni esmw esmwni using eq2_lfpspouse_cps.tex, replace se r2 label scalars("mean Dep. var. mean" "pfe Person FE" "yfe Year FE" "controls Controls") nonotes star(* 0.10 ** 0.05 *** 0.01) ///
keep(employed_sp) booktabs ///
mgroups("Overall" "Men" "Women",pattern(1 0 1 0 1 0) span prefix(\multicolumn{@span}{c}{) suffix(}) end(\cmidrule(lr){2-3}\cmidrule(lr){4-5}\cmidrule(lr){6-7})) ///
mtitle("\shortstack{Spouse\\working}" "\shortstack{Spouse \\working}" "\shortstack{Spouse\\working}" "\shortstack{Spouse\\working}" "\shortstack{Spouse \\working}" "\shortstack{Spouse\\working}") ///
substitute("\_" "_" "{l}{\footnotesize" "{p{17cm}}{\footnotesize" ) ///
addnotes("\textit{Notes}: The table presents coefficient estimates from equation \ref{eq:XXX} using data from the Current Population Survey. Columns 1 and 2 consider all married households, while columns 3--4 and 5--6 subset to married men and women, respectively. Control variables are the number of children in the household, number of adults, whether the individual works part-time. Odd columns also control for family income (net of own and spouse's labor income) decile. Standard errors are clustered at the household level. \sym{*}, \sym{**}, and \sym{***} denote statistical significance at the 10\%, 5\%, and 1\% levels, respectively.")

******************************************************
*ATUS
 use xxx
 
// Married general
*With income controls
 
reghdfe employed_sp_atus pter_atus hh_numkids i.net_famincome_married_decile pt_atus if married_atus == 1 & employed_atus == 1, absorb(year) vce(robust) nocons // pter couple and employed spouse from atus

sum employed_sp_atus
local mean = r(mean)
estadd scalar mean = `mean'
estadd local pfe "N"
estadd local yfe "Y"
estadd local controls "Y"
eststo aesm, refresh 


*Without income controls
 
reghdfe employed_sp_atus pter_atus hh_numkids pt_atus if married_atus == 1 & employed_atus == 1, absorb(year) vce(robust) nocons // pter couple and employed spouse from atus

sum employed_sp_atus
local mean = r(mean)
estadd scalar mean = `mean'
estadd local pfe "N"
estadd local yfe "Y"
estadd local controls "Y"
eststo aesmni, refresh 

// Married men
*With income controls
 
reghdfe employed_sp_atus pter_atus hh_numkids i.net_famincome_married_decile pt_atus if married_atus == 1 & employed_atus == 1 & female_atus == 0, absorb(year) vce(robust) nocons // pter couple and employed spouse from atus

sum employed_sp_atus
local mean = r(mean)
estadd scalar mean = `mean'
estadd local pfe "N"
estadd local yfe "Y"
estadd local controls "Y"
eststo aesmm, refresh 

*Without income controls
 
reghdfe employed_sp_atus pter_atus hh_numkids pt_atus if married_atus == 1 & employed_atus == 1 & female_atus == 0, absorb(year) vce(robust) nocons // pter couple and employed spouse from atus

sum employed_sp_atus
local mean = r(mean)
estadd scalar mean = `mean'
estadd local pfe "N"
estadd local yfe "Y"
estadd local controls "Y"
eststo aesmmni, refresh 

// Married women
*With income controls
 
reghdfe employed_sp_atus pter_atus hh_numkids i.net_famincome_married_decile pt_atus if married_atus == 1 & employed_atus == 1 & female_atus == 1, absorb(year) vce(robust) nocons // pter couple and employed spouse from atus

sum employed_sp_atus
local mean = r(mean)
estadd scalar mean = `mean'
estadd local pfe "N"
estadd local yfe "Y"
estadd local controls "Y"
eststo aesmw, refresh 

*Without income controls
 
reghdfe employed_sp_atus pter_atus hh_numkids pt_atus if married_atus == 1 & employed_atus == 1 & female_atus == 1, absorb(year) vce(robust) nocons

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

*********************************************************
*********************************************************
*SPOUSE LABOR MARKET HOURS
* ahrsworkt -- hours worked last week as it was hours worked variable with less missing values

*CPS
use cps_atus_merged_76_21, clear

//Married general 
*With income controls
reghdfe ahrsworkt_sp pter nchild i.famincome_married_decile pt if married == 1 & employed == 1, absorb(cpsidp year) vce(cluster cpsid) nocons

sum ahrsworkt_sp
local mean = r(mean)
estadd scalar mean = `mean'
estadd local pfe "Y"
estadd local yfe "Y"
estadd local controls "Y"
eststo hrwsm, refresh 


*Without income controls
reghdfe ahrsworkt_sp pter nchild pt if married == 1 & employed == 1, absorb(cpsidp year) vce(cluster cpsid) nocons

sum ahrsworkt_sp
local mean = r(mean)
estadd scalar mean = `mean'
estadd local pfe "Y"
estadd local yfe "Y"
estadd local controls "Y"
eststo hrwsmni, refresh 

// Married men
*With income controls
reghdfe ahrsworkt_sp pter nchild i.famincome_married_decile pt if married == 1 & employed == 1 & female == 0, absorb(cpsidp year) vce(cluster cpsid) nocons

sum ahrsworkt_sp
local mean = r(mean)
estadd scalar mean = `mean'
estadd local pfe "Y"
estadd local yfe "Y"
estadd local controls "Y"
eststo hrwsmm, refresh 

*Without income controls
reghdfe ahrsworkt_sp pter nchild pt if married == 1 & employed == 1 & female == 0, absorb(cpsidp year) vce(cluster cpsid) nocons

sum ahrsworkt_sp
local mean = r(mean)
estadd scalar mean = `mean'
estadd local pfe "Y"
estadd local yfe "Y"
estadd local controls "Y"
eststo hrwsmmni, refresh 

// Married women 

*With income controls
reghdfe ahrsworkt_sp pter nchild i.famincome_married_decile pt if married == 1 & employed == 1 & female == 1, absorb(cpsidp year) vce(cluster cpsid) nocons

sum ahrsworkt_sp
local mean = r(mean)
estadd scalar mean = `mean'
estadd local pfe "Y"
estadd local yfe "Y"
estadd local controls "Y"
eststo hrwsmw, refresh 

*Without income controls
reghdfe ahrsworkt_sp pter nchild pt if married == 1 & employed == 1 & female == 1, absorb(cpsidp year) vce(cluster cpsid) nocons

sum ahrsworkt_sp
local mean = r(mean)
estadd scalar mean = `mean'
estadd local pfe "Y"
estadd local yfe "Y"
estadd local controls "Y"
eststo hrwsmwni, refresh 

esttab hrwsm hrwsmni hrwsmm hrwsmmni hrwsw hrwswni using eq2_hoursworked_spouse_cps.tex, replace se r2 label scalars("mean Dep. var. mean" "pfe Person FE" "yfe Year FE" "controls Controls") nonotes star(* 0.10 ** 0.05 *** 0.01) ///
keep(employed_sp) booktabs ///
mgroups("Overall" "Men" "Women",pattern(1 0 1 0 1 0) span prefix(\multicolumn{@span}{c}{) suffix(}) end(\cmidrule(lr){2-3}\cmidrule(lr){4-5}\cmidrule(lr){6-7})) ///
mtitle("\shortstack{Spouse work\\hours}" "\shortstack{Spouse work\\hours}" "\shortstack{Spouse work\\hours}" "\shortstack{Spouse work\\hours}" "\shortstack{Spouse work\\hours}" "\shortstack{Spouse work\\hours}") ///
substitute("\_" "_" "{l}{\footnotesize" "{p{17cm}}{\footnotesize" ) ///
addnotes("\textit{Notes}: The table presents coefficient estimates from equation \ref{eq:XXX} using data from the Current Population Survey. Columns 1 and 2 consider all married households, while columns 3--4 and 5--6 subset to married men and women, respectively. Control variables are the number of children in the household, number of adults, whether the individual works part-time. Odd columns also control for family income (net of own and spouse's labor income) decile. Standard errors are clustered at the household level. \sym{*}, \sym{**}, and \sym{***} denote statistical significance at the 10\%, 5\%, and 1\% levels, respectively.")

*********************************************************
*ATUS
 use xxx
 
 //Married general 
*With income controls
reghdfe spusualhrs pter_atus hh_numkids i.net_famincome_married_decile pt_atus if married_atus == 1 & employed_atus == 1, absorb(year) vce(robust) nocons

sum spusualhrs
local mean = r(mean)
estadd scalar mean = `mean'
estadd local pfe "N"
estadd local yfe "Y"
estadd local controls "Y"
eststo suhrm, refresh 

*Without income controls
reghdfe spusualhrs pter_atus hh_numkids pt_atus if married_atus == 1 & employed_atus == 1, absorb(year) vce(robust) nocons

sum spusualhrs
local mean = r(mean)
estadd scalar mean = `mean'
estadd local pfe "N"
estadd local yfe "Y"
estadd local controls "Y"
eststo suhrmni, refresh 

//Married men
*With income controls
reghdfe spusualhrs pter_atus hh_numkids i.net_famincome_married_decile pt_atus if married_atus == 1 & employed_atus == 1 & female_atus == 0, absorb(year) vce(robust) nocons

sum spusualhrs
local mean = r(mean)
estadd scalar mean = `mean'
estadd local pfe "N"
estadd local yfe "Y"
estadd local controls "Y"
eststo suhrmm, refresh 

*Without income controls
reghdfe spusualhrs pter_atus hh_numkids pt_atus if married_atus == 1 & employed_atus == 1 & female_atus == 0, absorb(year) vce(robust) nocons

sum spusualhrs
local mean = r(mean)
estadd scalar mean = `mean'
estadd local pfe "N"
estadd local yfe "Y"
estadd local controls "Y"
eststo suhrmmni, refresh 

// Married women
*With income controls
reghdfe spusualhrs pter_atus hh_numkids i.net_famincome_married_decile pt_atus if married_atus == 1 & employed_atus == 1 & female_atus == 1, absorb(year) vce(robust) nocons

sum spusualhrs
local mean = r(mean)
estadd scalar mean = `mean'
estadd local pfe "N"
estadd local yfe "Y"
estadd local controls "Y"
eststo suhrmw, refresh 

*Without income controls
reghdfe spusualhrs pter_atus hh_numkids pt_atus if married_atus == 1 & employed_atus == 1 & female_atus == 1, absorb(year) vce(robust) nocons

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

********************************************************
* RUN VERSIONS WITH: EITHER SPOUSE PTER INSTEAD OF PTER, CONTROLLING FOR SPOUSE PTER, BECOMING PTER