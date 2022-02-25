* Estimating equation 1 and 2 using CPS

global build "C:\Users\39328\Dropbox\Hours constraints and home prod\build"

global analysis "C:\Users\39328\Dropbox\Hours constraints and home prod\analysis"

cd "$build\output"

cd "C:\Users\ilariamalisan\Downloads"

clear all

use asec_monthly_76_21, clear


*EQUATION 1


*Option 1:
*Sample ASEC + basic monthly, only those who appear twice in asec have nonmissing change in earnings
*ASEC + Basic Monthly, Use log earnings as a control --> bigger longitudinal sample
*ssc install reghdfe
ssc install erepost
ssc install estout

global demographic "age i.black i.female"
global educ "i.highschool i.somecollege i.collegeup" //omitted: less than high school
global lifecycle "becom_homeowner s_to_m remain_married m_to_d n_child_chg" // omitted: remained single

global lifecycle2 "becom_homeowner s_to_m remain_married m_to_d children_chg" // omitted: remained single.
*Change in the number of children instead of number of children change

global employment "ft_pt pt_ft pt_always" // omitted: FT always
global employment2 "ft_pt pt_ft pt" // omitted: FT.

global income "log_famin log_wage"

*cd "$analysis\output"

xtset cpsidp mish

*** 1. ASEC + Basic Monthly, controlling for log income and log wage

reghdfe into_pter $demographic $educ $lifecycle $income i.industry $employment , absorb(monthly_date) vce(robust)

estimates store model1


*** 2. ASEC + Basic Monthly, without controlling for log income and log wage

reghdfe into_pter $demographic $educ $lifecycle i.industry $employment , absorb(monthly_date) vce(robust)

estimates store model2

*** 3. ASEC + Basic Monthly, without controlling for log income and log wage + individual FE

*reghdfe into_pter $demographic $educ $lifecycle i.industry $employment , absorb(cpsidp monthly_date) vce(robust)

*estimates store model3

*** 4. ASEC + Basic Monthly, without controlling for log income and log wage + individual FE
* Substituting n_child_chg with children_chg and pt_always with pt (otherwise omitted because of collinearity)

reghdfe into_pter $demographic $educ $lifecycle2 i.industry $employment2 , absorb(cpsidp monthly_date) vce(robust)

estimates store model4 //rerun with this as model3

estfe . model*, labels(monthly_date "Year-month FE" cpsdip "Individual FE")

esttab . model*, indicate(`r(indicate_fe)' )

/*
esttab ///
title (Equation 1) ///
nonumber mtitles ("Controlling for log income, log wage" "Without controlling for log income, log wage" "Individual FE" "Individual FE, substituting collinear regressors") ///
addnote ("All columns include year-month FE")
*/
eststo clear


********************************************************************************
*EQUATION 2

* HOME WORK HOURS

global demographic_head "age_head i.female_head i.black_head"
global educ_head "i.highschool_head i.somecollege_head i.collegeup_head" //omitted: less than high school

global demographic_atus "age i.female i.black"
global educ_atus "i.highschool i.somecollege i.collegeup" //omitted: less than high school


global income_married "i.famincome income income_sp"
global income_single "i.famincome income"

*Issue: famincome (ATUS) is categorical, but hhincome (CPS) is missing for lots of individuals. For the time being use categorical famincome + head and spouse wage as controls

// Married
* CPS variables

use cps_atus_merged_headspouse, clear

reghdfe act_hhact pter_cps_couple $demographic_head $educ_head $income_married i.industry if married == 1, absorb(year_head) vce(robust) // pter couple from cps

estimates store model1

*ATUS variables
use atus_clean_03_20, clear

reghdfe act_hhact pter_atus_couple $demographic_atus $educ_atus $income_married i.industry if married == 1, absorb(year) vce(robust) // pter couple from atus

estimates store model2

// Single
* CPS variables

use cps_atus_merged_headspouse, clear

reghdfe act_hhact pter_head $demographic_head $educ_head $income_single i.industry if single == 1, absorb(year_head) vce(robust) // pter dummy from cps

estimates store model3

*ATUS variables
use atus_clean_03_20, clear

reghdfe act_hhact pter_atus $demographic_atus $educ_atus $income_single i.industry if single == 1, absorb(year) vce(robust) // pter dummy from atus

estimates store model4



estfe . model*, labels(year "Year FE" year_head "Year FE")

esttab . model* using eq2_homeworkhours.csv, indicate(`r(indicate_fe)' )

eststo clear

****************************
* SPOUSE'S LABOUR MARKET PARTICIPATION

use cps_atus_merged_headspouse, clear

* I'm interpreting labor force participation = employed based on paper draft, discuss

*reghdfe employed_spouse pter_cps_couple $demographic_head $educ_head $income_married i.industry_head if married_head == 1, absorb(year_head) vce(robust) // pter couple and employed_spouse from cps --> CPS only has employed individuals (because of sample definition from above), so this can't run. Need to go back and avoid dropping unemployed, rematch and rerun.

*estimates store model 1

reghdfe employed_sp pter_atus_couple $demographic_atus $educ_atus $income_married i.industry if married == 1, absorb(year_head) vce(robust) // pter couple and employed spouse from atus

eststo model5


estfe . model5, labels( year_head "Year FE")

esttab . model5 using eq2_spouselmp.csv, indicate(`r(indicate_fe)' )

eststo clear

***********************************************************
*SPOUSE LABOR MARKET HOURS

use cps_atus_merged_headspouse, clear

*Usual hours worked by spouse from ATUS. CPS also has this info but I didn't pull it for this sample --> add while rerunning to keep employed == 0

reghdfe spusualhrs pter_atus_couple $demographic_atus $educ_atus $income_married i.industry if married == 1, absorb(year) vce(robust) // pter couple and hours worked by spouse from atus

eststo model6

estfe . model6, labels( year "Year FE")

esttab . model6 using eq2_spousehoursworked.csv, indicate(`r(indicate_fe)' )

eststo clear
*********************************************************
