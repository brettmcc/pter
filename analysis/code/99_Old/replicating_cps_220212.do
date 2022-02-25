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