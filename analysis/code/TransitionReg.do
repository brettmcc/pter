clear all
set more off, permanently
cd /hpc/household_finance/BoardResearch/HP/WorkDir/Revision

use pooled.dta,clear
keep if year > 1967
tsset pid year
gen chg_headwage = headwage - l.headwage
gen chg_log_faminc = chglog_faminc

winsor2 chg_nonlabor_inc, cuts(1 99) replace 
winsor2 chg_log_nonlabor_inc, cuts(1 99) replace 
winsor2 chg_log_faminc, cuts(1 99) replace 
winsor2 chg_headwage, cuts(1 99) replace 
winsor2 chg_log_headwage, cuts(1 99) replace 
winsor2 chg_headhour , cuts(1 99) replace 

gen chg_log_nonlabor_inc_p = chg_log_nonlabor_inc * (chg_nonlabor_inc >= 0)
gen chg_log_nonlabor_inc_n = chg_log_nonlabor_inc * (chg_nonlabor_inc < 0)
gen chg_log_headwage_p = chg_log_headwage * (chg_log_headwage >= 0)
gen chg_log_headwage_n = chg_log_headwage * (chg_log_headwage < 0)
gen chg_headhour_p = chg_headhour * (chg_headhour >= 0)
gen chg_headhour_n = chg_headhour * (chg_headhour < 0)

*local indep_vars_all = "headage headage_squared headblack i.headedu became_hmowner became_married stay_married became_div_sep chg_num_children chg_log_nonlabor_inc_p chg_log_nonlabor_inc_n chg_log_headwage_p chg_log_headwage_n"
local indep_vars_all = "headage headage_squared headblack i.headedu became_hmowner became_married stay_married became_div_sep chg_num_children chg_log_faminc chg_log_headwage"
areg became_uc `indep_vars_all' partime if headstatus==1 & l.headstatus==1 & lag_construp!=1, vce(cluster pid) absorb(year)
areg became_uc `indep_vars_all' ft_to_pt pt_to_ft pt_to_pt if headstatus==1 & l.headstatus==1 & lag_construp!=1, vce(cluster pid) absorb(year)
logistic became_uc `indep_vars_all' partime i.year if headstatus==1 & l.headstatus==1 & lag_construp!=1, vce(cluster pid)
logistic became_uc `indep_vars_all' ft_to_pt pt_to_ft pt_to_pt i.year if headstatus==1 & l.headstatus==1 & lag_construp!=1, vce(cluster pid)
estimate store uc1

areg became_uc `indep_vars_all' partime if extrapay ==1 & headstatus==1 & l.headstatus==1 & lag_construp!=1, vce(cluster pid) absorb(year)
areg became_uc `indep_vars_all' ft_to_pt pt_to_ft pt_to_pt if extrapay ==1 & headstatus==1 & l.headstatus==1 & lag_construp!=1, vce(cluster pid) absorb(year)
logistic became_uc `indep_vars_all' partime i.year if extrapay ==1 & headstatus==1 & l.headstatus==1 & lag_construp!=1, vce(cluster pid)
logistic became_uc `indep_vars_all' ft_to_pt pt_to_ft pt_to_pt i.year if extrapay ==1 & headstatus==1 & l.headstatus==1 & lag_construp!=1, vce(cluster pid)
estimate store uc2

local indep_vars_all = "headage headage_squared headblack i.headedu became_hmowner became_married stay_married became_div_sep chg_num_children chg_log_faminc chg_log_headwage chgd_jobs got_addl_job"
areg escaped_uc `indep_vars_all' partime if headstatus==1 & l.headstatus==1 & lag_construp==1, vce(cluster pid) absorb(year)
areg escaped_uc `indep_vars_all' ft_to_pt pt_to_ft pt_to_pt if headstatus==1 & l.headstatus==1 & lag_construp==1, vce(cluster pid) absorb(year)
logistic escaped_uc `indep_vars_all' partime i.year if headstatus==1 & l.headstatus==1 & lag_construp==1, vce(cluster pid)
logistic escaped_uc `indep_vars_all' ft_to_pt pt_to_ft pt_to_pt i.year if headstatus==1 & l.headstatus==1 & lag_construp==1, vce(cluster pid)
estimate store uc3
areg escaped_uc `indep_vars_all' partime if extrapay ==1 & headstatus==1 & l.headstatus==1 & lag_construp==1, vce(cluster pid) absorb(year)
areg escaped_uc `indep_vars_all' ft_to_pt pt_to_ft pt_to_pt if extrapay ==1 & headstatus==1 & l.headstatus==1 & lag_construp==1, vce(cluster pid) absorb(year)
logistic escaped_uc `indep_vars_all' partime i.year if extrapay ==1 & headstatus==1 & l.headstatus==1 & lag_construp==1, vce(cluster pid) 
logistic escaped_uc `indep_vars_all' ft_to_pt pt_to_ft pt_to_pt i.year if extrapay ==1 & headstatus==1 & l.headstatus==1 & lag_construp==1, vce(cluster pid) 
estimate store uc4
estout uc1 uc2 uc3 uc4 using "/href/research2/m1gxl01/BoardResearch/HP/Output/Revision/Transition.tex", eform style(tex) starlevels(* 0.1 ** 0.05 *** 0.01) cells(b(star fmt(3)) se(par fmt(3))) ///
       stats(r2 N, labels(R-squared) fmt(0)) replace  