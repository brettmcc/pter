* Estimating equation 1 and 2 using CPS

global build "C:\Users\39328\Dropbox\Hours constraints and home prod\build"

global analysis "C:\Users\39328\Dropbox\Hours constraints and home prod\analysis"

cd "$build\output"

cd "C:\Users\lucafavero\Desktop\Ilaria" // workstation

clear all

use cps_atus_merged_76_21, clear

// TO be pasted in other dofile when available
*need to add: number of adults, decile of family income, number of children 

*number of adults: I only have info from atus (missing for most of obs), need to download it.

* decile of family income --create?

*number of children use nchild 


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

global income "log_famin log_wage"

*cd "$analysis\output"

xtset cpsidp mish

// ADD RESTRICTIONS: HEAD EMPLOYED == 1, REMOVE IF HOUSEWORK HOURS > 80 / WEEK

*** 1. ASEC + Basic Monthly, controlling for log income and log wage

reghdfe into_pter $demographic $educ $lifecycle $income i.industry $employment if employed == 1, absorb(monthly_date) vce(robust)

estimates store model1

*Male only

reghdfe into_pter $demographic2 $educ $lifecycle $income i.industry $employment if employed == 1 & female == 0, absorb(monthly_date) vce(robust)

estimates store model2


*Female only 

reghdfe into_pter $demographic2 $educ $lifecycle $income i.industry $employment if employed == 1 & female == 1, absorb(monthly_date) vce(robust)

estimates store model3


*** 2. ASEC + Basic Monthly, without controlling for log income and log wage

reghdfe into_pter $demographic $educ $lifecycle i.industry $employment if employed == 1, absorb(monthly_date) vce(robust)

estimates store model4

*Male only
reghdfe into_pter $demographic2 $educ $lifecycle i.industry $employment if employed == 1 & female == 0, absorb(monthly_date) vce(robust)

estimates store model5

*Female only
reghdfe into_pter $demographic2 $educ $lifecycle i.industry $employment if employed == 1 & female == 1, absorb(monthly_date) vce(robust)

estimates store model6


*** 3. ASEC + Basic Monthly, without controlling for log income and log wage + individual FE
* Substituting n_child_chg with children_chg and pt_always with pt (otherwise omitted because of collinearity)

reghdfe into_pter $demographic $educ $lifecycle2 i.industry $employment2 if employed == 1, absorb(cpsidp monthly_date) vce(robust)

estimates store model7

*Male only
reghdfe into_pter $demographic2 $educ $lifecycle2 i.industry $employment2 if employed == 1 & female == 0, absorb(cpsidp monthly_date) vce(robust)

estimates store model8

*Female only
reghdfe into_pter $demographic2 $educ $lifecycle2 i.industry $employment2 if employed == 1 & female == 1, absorb(cpsidp monthly_date) vce(robust)

estimates store model9

estfe . model1 model2 model3 model4 model5 model6 model7 model8 model9, labels(monthly_date "Year-month FE" cpsdip "Individual FE")

esttab . model1 model2 model3 model4 model5 model6 model7 model8 model9 using eq1.csv, indicate(`r(indicate_fe)' ) p  // don't show industry dummies, add latex structure

eststo clear


********************************************************************************
*EQUATION 2 -- to be revised

* HOME WORK HOURS



*add vce(cluster householdid)

global demographic_head "age_head i.female_head i.black_head"
global educ_head "i.highschool_head i.somecollege_head i.collegeup_head" //omitted: less than high school

global demographic_atus "age i.female i.black"
global educ_atus "i.highschool i.somecollege i.collegeup" //omitted: less than high school


global income_married "i.famincome income income_sp"
global income_single "i.famincome income"

// Single
* CPS variables

use cps_atus_merged_headspouse, clear

reghdfe act_hhact pter_head $demographic_head $educ_head $income_single i.industry if single_head == 1, absorb(year_head) vce(robust) // pter dummy from cps

estimates store model6

*ATUS variables
use atus_clean_03_20, clear

reghdfe act_hhact pter_atus $demographic_atus $educ_atus $income_single i.industry if single == 1, absorb(year) vce(robust) // pter dummy from atus

estimates store model7

// Married
* CPS variables

use cps_atus_merged_headspouse, clear

reghdfe act_hhact pter_cps_couple $demographic_head $educ_head $income_married i.industry if married_head == 1, absorb(year_head) vce(robust) // pter couple from cps

estimates store model4

*ATUS variables
use atus_clean_03_20, clear

reghdfe act_hhact pter_atus_couple $demographic_atus $educ_atus $income_married i.industry if married == 1, absorb(year) vce(robust) // pter couple from atus

estimates store model5

// Married men

// Married women



estfe . model4 model5 model6 model7, labels(year "Year FE" year_head "Year FE")

esttab . model4 model5 model6 model7 using eq2_homeworkhours.csv, indicate(`r(indicate_fe)' ) p

eststo clear

****************************
* SPOUSE'S LABOUR MARKET PARTICIPATION

use cps_atus_merged_headspouse, clear

// Married: general

*reghdfe employed_spouse pter_cps_couple $demographic_head $educ_head $income_married i.industry_head if married_head == 1, absorb(year_head) vce(robust) // pter couple and employed_spouse from cps --> CPS only has employed individuals (because of sample definition from above), so this can't run. Need to go back and avoid dropping unemployed, rematch and rerun.

*estimates store model 1

reghdfe employed_sp pter_atus_couple $demographic_atus $educ_atus $income_married i.industry if married == 1, absorb(year) vce(robust) // pter couple and employed spouse from atus

eststo model8

// Married men

// Married women

estfe . model8, labels( year "Year FE")

esttab . model8 using eq2_spouselmp.csv, indicate(`r(indicate_fe)' ) p

eststo clear

***********************************************************
*SPOUSE LABOR MARKET HOURS

use cps_atus_merged_headspouse, clear

//Married general 

*add cps hours as dependent

reghdfe spusualhrs pter_atus_couple $demographic_atus $educ_atus $income_married i.industry if married == 1, absorb(year) vce(robust) // pter couple and hours worked by spouse from atus

eststo model9

// Married men


// Married women 

estfe . model9, labels(year "Year FE")

esttab . model9 using eq2_spousehoursworked.csv, indicate(`r(indicate_fe)' ) p

eststo clear
*********************************************************
