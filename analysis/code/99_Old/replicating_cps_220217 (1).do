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

* HOME WORK HOURS - SELF

* CPS variables

use cps_atus_merged_76_21, clear

// Single
*With income controls
**ADD NUMBER OF ADULTS

reghdfe homeworkhrs pter nchild i.famincome_decile pt if single == 1 & employed==1, absorb(cpsidp year) vce(cluster cpsid) // pter dummy from cps

estimates store m10

*Without income controls
reghdfe homeworkhrs pter nchild pt if single == 1 & employed==1, absorb(cpsidp year) vce(cluster cpsid) // pter dummy from cps

estimates store m11

// Married
* CPS variables
*With income controls


reghdfe homeworkhrs pter nchild i.famincome_married_decile pt if married == 1 & employed == 1, absorb(cpsipd year) vce(cluster cpsid) // pter couple from cps

estimates store m12

*Without income controls
reghdfe homeworkhrs pter nchild pt if married == 1 & employed == 1, absorb(cpsipd year) vce(cluster cpsid) // pter couple from cps

estimates store m13

// Married men

*With income controls

reghdfe homeworkhrs pter nchild i.famincome_married_decile pt if married == 1 & employed == 1 & female == 0, absorb(cpsipd year) vce(cluster cpsid) // pter couple from cps

estimates store m14

*Without income controls
reghdfe homeworkhrs pter nchild pt if married == 1 & employed == 1 & female == 0, absorb(cpsipd year) vce(cluster cpsid) // pter couple from cps

estimates store m15

// Married women

*With income controls

reghdfe homeworkhrs pter nchild i.famincome_married_decile pt if married == 1 & employed == 1 & female == 1, absorb(cpsipd year) vce(cluster cpsid) // pter couple from cps

estimates store m16

*Without income controls
reghdfe homeworkhrs pter nchild pt if married == 1 & employed == 1 & female == 1, absorb(cpsipd year) vce(cluster cpsid) // pter couple from cps

estimates store m17

*********************************************************
*ATUS variables
use atus_clean_03_20, clear

// Single

*With income controls

reghdfe homeworkhrs pter_atus hh_numkids i.net_famincome_decile pt if single_atus == 1 & employed_atus == 1, absorb(year) vce(robust) // pter dummy from atus
*ATUS DATA = no individual FE, no vce(cluster household) because there is only one observation per household

estimates store m18

*Without income controls
reghdfe homeworkhrs pter_atus hh_numkids pt if single_atus == 1 & employed_atus == 1, absorb(year) vce(robust) // pter dummy from atus

estimates store m19


// Married 

*With income controls

reghdfe homworkhrs pter_atus hh_numkids i.net_famincome_married_decile pt_atus if married_atus == 1 & employed_atus == 1, absorb(year) vce(robust) // pter couple from atus

estimates store mode20

*Without income controls
reghdfe homeworkhrs pter_atus hh_numkids pt if married_atus == 1 & employed_atus == 1, absorb(year) vce(robust) // pter dummy from atus

estimates store m21

// Married men

*With income controls

reghdfe homworkhrs pter_atus hh_numkids i.net_famincome_married_decile pt_atus if married_atus == 1 & employed_atus == 1 & female_atus == 0, absorb(year) vce(robust) // pter couple from atus

estimates store mode22

*Without income controls
reghdfe homeworkhrs pter_atus hh_numkids pt if married_atus == 1 & employed_atus == 1 & female_atus == 0, absorb(year) vce(robust) // pter dummy from atus

estimates store m23


// Married women

*With income controls

reghdfe homworkhrs pter_atus hh_numkids i.net_famincome_married_decile pt_atus if married_atus == 1 & employed_atus == 1 & female_atus == 1, absorb(year) vce(robust) // pter couple from atus

estimates store mode24

*Without income controls
reghdfe homeworkhrs pter_atus hh_numkids pt if married_atus == 1 & employed_atus == 1 & female_atus == 1, absorb(year) vce(robust) // pter dummy from atus

estimates store m25


eststo clear
*********************************************************
* HOME WORK HOURS - SPOUSE

* CPS variables

use cps_atus_merged_76_21, clear

// Single
*With income controls
**ADD NUMBER OF ADULTS

reghdfe homeworkhrs_sp pter nchild i.famincome_decile pt if single == 1 & employed==1, absorb(cpsidp year) vce(cluster cpsid) // pter dummy from cps


*Without income controls
reghdfe homeworkhrs_sp pter nchild pt if single == 1 & employed==1, absorb(cpsidp year) vce(cluster cpsid) // pter dummy from cps


// Married
* CPS variables
*With income controls

reghdfe homeworkhrs_sp pter nchild i.famincome_married_decile pt if married == 1 & employed == 1, absorb(cpsipd year) vce(cluster cpsid) // pter couple from cps


*Without income controls
reghdfe homeworkhrs_sp pter nchild pt if married == 1 & employed == 1, absorb(cpsipd year) vce(cluster cpsid) // pter couple from cps

// Married men

*With income controls

reghdfe homeworkhrs_sp pter nchild i.famincome_married_decile pt if married == 1 & employed == 1 & female == 0, absorb(cpsipd year) vce(cluster cpsid) // pter couple from cps


*Without income controls
reghdfe homeworkhrs_sp pter nchild pt if married == 1 & employed == 1 & female == 0, absorb(cpsipd year) vce(cluster cpsid) // pter couple from cps


// Married women

*With income controls

reghdfe homeworkhrs_sp pter nchild i.famincome_married_decile pt if married == 1 & employed == 1 & female == 1, absorb(cpsipd year) vce(cluster cpsid) // pter couple from cps


*Without income controls
reghdfe homeworkhrs_sp pter nchild pt if married == 1 & employed == 1 & female == 1, absorb(cpsipd year) vce(cluster cpsid) // pter couple from cps


*********************************************************
*ATUS variables
use atus_clean_03_20, clear

// Single

*With income controls

reghdfe homeworkhrs_sp pter_atus hh_numkids i.net_famincome_decile pt if single_atus == 1 & employed_atus == 1, absorb(year) vce(robust) // pter dummy from atus
*ATUS DATA = no individual FE, no vce(cluster household) because there is only one observation per household


*Without income controls
reghdfe homeworkhrs_sp pter_atus hh_numkids pt if single_atus == 1 & employed_atus == 1, absorb(year) vce(robust) // pter dummy from atus



// Married 

*With income controls

reghdfe homeworkhrs_sp pter_atus hh_numkids i.net_famincome_married_decile pt_atus if married_atus == 1 & employed_atus == 1, absorb(year) vce(robust) // pter couple from atus


*Without income controls
reghdfe homeworkhrs_sp pter_atus hh_numkids pt if married_atus == 1 & employed_atus == 1, absorb(year) vce(robust) // pter dummy from atus


// Married men

*With income controls

reghdfe homeworkhrs_sp pter_atus hh_numkids i.net_famincome_married_decile pt_atus if married_atus == 1 & employed_atus == 1 & female_atus == 0, absorb(year) vce(robust) // pter couple from atus


*Without income controls
reghdfe homeworkhrs_sp pter_atus hh_numkids pt if married_atus == 1 & employed_atus == 1 & female_atus == 0, absorb(year) vce(robust) // pter dummy from atus



// Married women

*With income controls

reghdfe homeworkhrs_sp pter_atus hh_numkids i.net_famincome_married_decile pt_atus if married_atus == 1 & employed_atus == 1 & female_atus == 1, absorb(year) vce(robust) // pter couple from atus


*Without income controls
reghdfe homeworkhrs_sp pter_atus hh_numkids pt if married_atus == 1 & employed_atus == 1 & female_atus == 1, absorb(year) vce(robust) // pter dummy from atus

*********************************************************
*********************************************************
* SPOUSE'S LABOUR MARKET PARTICIPATION
*CPS
use cps_atus_merged_76_21, clear

// Married: general
*With income controls
reghdfe employed_sp pter nchild i.famincome_married_decile pt if married == 1 & employed == 1, absorb(cpsidp year) vce(cluster cpsid) 

*Without income controls
reghdfe employed_sp pter nchild pt if married == 1 & employed == 1, absorb(cpsidp year) vce(cluster cpsid) 

//Married Men

*With income controls
reghdfe employed_sp pter nchild i.famincome_married_decile pt if married == 1 & employed == 1 & female == 0, absorb(cpsidp year) vce(cluster cpsid) 

*Without income controls
reghdfe employed_sp pter nchild pt if married == 1 & employed == 1 & female == 0, absorb(cpsidp year) vce(cluster cpsid) 


// Married women
*With income controls
reghdfe employed_sp pter nchild i.famincome_married_decile pt if married == 1 & employed == 1 & female == 1, absorb(cpsidp year) vce(cluster cpsid) 

*Without income controls
reghdfe employed_sp pter nchild pt if married == 1 & employed == 1 & female == 1, absorb(cpsidp year) vce(cluster cpsid) 



******************************************************
*ATUS
 use xxx
 
// Married general
*With income controls
 
reghdfe employed_sp_atus pter_atus hh_numkids i.net_famincome_married_decile pt_atus if married_atus == 1 & employed_atus == 1, absorb(year) vce(robust) // pter couple and employed spouse from atus

*Without income controls
 
reghdfe employed_sp_atus pter_atus hh_numkids pt_atus if married_atus == 1 & employed_atus == 1, absorb(year) vce(robust) // pter couple and employed spouse from atus


// Married men
*With income controls
 
reghdfe employed_sp_atus pter_atus hh_numkids i.net_famincome_married_decile pt_atus if married_atus == 1 & employed_atus == 1 & female_atus == 0, absorb(year) vce(robust) // pter couple and employed spouse from atus

*Without income controls
 
reghdfe employed_sp_atus pter_atus hh_numkids pt_atus if married_atus == 1 & employed_atus == 1 & female_atus == 0, absorb(year) vce(robust) // pter couple and employed spouse from atus

// Married women
*With income controls
 
reghdfe employed_sp_atus pter_atus hh_numkids i.net_famincome_married_decile pt_atus if married_atus == 1 & employed_atus == 1 & female_atus == 1, absorb(year) vce(robust) // pter couple and employed spouse from atus

*Without income controls
 
reghdfe employed_sp_atus pter_atus hh_numkids pt_atus if married_atus == 1 & employed_atus == 1 & female_atus == 1, absorb(year) vce(robust) // pter couple and employed spouse from atus

*********************************************************
*********************************************************
*SPOUSE LABOR MARKET HOURS
* ahrsworkt -- hours worked last week as it was hours worked variable with less missing values

*CPS
use cps_atus_merged_76_21, clear

//Married general 
*With income controls
reghdfe ahrsworkt_sp pter nchild i.famincome_married_decile pt if married == 1 & employed == 1, absorb(cpsidp year) vce(cluster cpsid)

*Without income controls
reghdfe ahrsworkt_sp pter nchild pt if married == 1 & employed == 1, absorb(cpsidp year) vce(cluster cpsid)


// Married men
*With income controls
reghdfe ahrsworkt_sp pter nchild i.famincome_married_decile pt if married == 1 & employed == 1 & female == 0, absorb(cpsidp year) vce(cluster cpsid)

*Without income controls
reghdfe ahrsworkt_sp pter nchild pt if married == 1 & employed == 1 & female == 0, absorb(cpsidp year) vce(cluster cpsid)


// Married women 

*With income controls
reghdfe ahrsworkt_sp pter nchild i.famincome_married_decile pt if married == 1 & employed == 1 & female == 1, absorb(cpsidp year) vce(cluster cpsid)

*Without income controls
reghdfe ahrsworkt_sp pter nchild pt if married == 1 & employed == 1 & female == 1, absorb(cpsidp year) vce(cluster cpsid)

*********************************************************
*ATUS
 use xxx
 
 //Married general 
*With income controls
reghdfe spusualhrs pter_atus hh_numkids i.net_famincome_married_decile pt_atus if married_atus == 1 & employed_atus == 1, absorb(year) vce(robust)

*Without income controls
reghdfe spusualhrs pter_atus hh_numkids pt_atus if married_atus == 1 & employed_atus == 1, absorb(year) vce(robust)

//Married men
*With income controls
reghdfe spusualhrs pter_atus hh_numkids i.net_famincome_married_decile pt_atus if married_atus == 1 & employed_atus == 1 & female_atus == 0, absorb(year) vce(robust)

*Without income controls
reghdfe spusualhrs pter_atus hh_numkids pt_atus if married_atus == 1 & employed_atus == 1 & female_atus == 0, absorb(year) vce(robust)

// Married women
*With income controls
reghdfe spusualhrs pter_atus hh_numkids i.net_famincome_married_decile pt_atus if married_atus == 1 & employed_atus == 1 & female_atus == 1, absorb(year) vce(robust)

*Without income controls
reghdfe spusualhrs pter_atus hh_numkids pt_atus if married_atus == 1 & employed_atus == 1 & female_atus == 1, absorb(year) vce(robust)

********************************************************
* RUN VERSIONS WITH: EITHER SPOUSE PTER INSTEAD OF PTER, CONTROLLING FOR SPOUSE PTER, BECOMING PTER