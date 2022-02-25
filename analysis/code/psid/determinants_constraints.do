clear all
set more off, permanently


use "analysis\input\pooled_all.dta",clear
label variable children "Num. children in HH"

/*Transition into/out of upward constrained status*/
global indep_vars_all = /*
	*/"became_married stay_married became_div_sep chg_num_children chg_nonlabor_inc chg_log_headwage became_hmowner dislimithswrk chglog_headhour chgd_jobs headage headage_squared headblack i.headedu"
global indep_vars_fe = "became_married stay_married became_div_sep chg_num_children chg_nonlabor_inc chg_log_headwage became_hmowner chglog_headhour chgd_jobs"
	
reghdfe became_uc $indep_vars_all if headstatus==1 & lag_construp!=1 [aweight=wgt], vce(cluster pid) absorb(year)
sum became_uc if headstatus==1 & lag_construp!=1 [aweight=wgt]
local mean = r(mean)
estadd scalar mean = `mean'
estadd local pfe "N"
estadd local yfe "Y"
estadd local controls "Y"
eststo lvlw1, refresh 
reghdfe became_uc $indep_vars_fe if headstatus==1 & lag_construp!=1 [aweight=wgt], vce(cluster pid) absorb(year pid)
sum became_uc if headstatus==1 & lag_construp!=1 [aweight=wgt]	
local mean = r(mean)
estadd scalar mean = `mean'
estadd local pfe "Y"
estadd local yfe "Y"
estadd local controls "Y"
eststo lvlw2, refresh
reghdfe escaped_uc $indep_vars_all if headstatus==1 & lag_construp==1 [aweight=wgt], vce(cluster pid) absorb(year)
sum escaped_uc if headstatus==1 & lag_construp==1 [aweight=wgt]	
local mean = r(mean)
estadd scalar mean = `mean'
estadd local pfe "N"
estadd local yfe "Y"
estadd local controls "Y"
eststo lvlw3, refresh 
reghdfe escaped_uc $indep_vars_fe if headstatus==1 & lag_construp==1 [aweight=wgt], vce(cluster pid) absorb(year pid)
sum escaped_uc if headstatus==1 & lag_construp==1 [aweight=wgt]	
local mean = r(mean)
estadd scalar mean = `mean'
estadd local pfe "Y"
estadd local yfe "Y"
estadd local controls "Y"
eststo lvlw4, refresh 
esttab lvlw1 lvlw2 lvlw3 lvlw4 using ///
	"analysis/output/tables/determinants_of_constr.tex", replace se r2 label scalars("mean Dep. var. mean" "controls Controls" "yfe Year FE" "pfe Person FE") nonotes star(* 0.10 ** 0.05 *** 0.01) ///
	drop(_cons 1.headedu) booktabs ///
	mgroups("Become Upside Constrained" "Escaped Upside Constraint",pattern(1 0 1 0) span prefix(\multicolumn{@span}{c}{) suffix(}) end(\cmidrule(lr){2-3}\cmidrule(lr){4-5})) ///
	substitute("\_" "_" "{l}{\footnotesize" "{p{17cm}}{\footnotesize" ) ///
	addnotes("\textit{Notes}: The table presents coefficient estimates from equation \ref{eq:det_constraints} using data from the Panel Study of Income Dynamics. Estimates are weighted, with standard errors clustered at the household-head level. \sym{*}, \sym{**}, and \sym{***} denote statistical significance at the 10\%, 5\%, and 1\% levels, respectively.")
	
	
/*Cross-section of constraints*/
local indep_vars_all = /*
	*/"headmarried age2 children nonlabor_inc log_headwage homeowner dislimithswrk headhourweekly headage headage_squared headblack i.headedu"
local indep_vars_fe = "headmarried age2 children nonlabor_inc log_headwage homeowner dislimithswrk headhourweekly"
	
areg construp `indep_vars_all' if headstatus==1 /*
	*/[aweight=wgt], vce(cluster pid) absorb(year)
sum construp if headstatus==1 [aweight=wgt]	
outreg2 using $analysisout\determinants_constraints, label replace /*
	*/addtext(Year FE, Yes, Person FE, No) addstat(Dep. var. mean, r(mean)) /*
	*/ctitle(Upward Constr.) /*
	*/keep(`indep_vars_all' 2.headedu 3.headedu 4.headedu)
	
areg construp `indep_vars_fe' i.year if headstatus==1 /*
	*/[aweight=wgt], vce(cluster pid) absorb(pid)
sum construp if headstatus==1 [aweight=wgt]	
outreg2 using $analysisout\determinants_constraints, label append /*
	*/addtext(Year FE, Yes, Person FE, Yes) addstat(Dep. var. mean, r(mean)) /*
	*/ctitle(Upward Constr.) /*
	*/tex(frag) keep(`indep_vars_fe')
	
areg constrdown `indep_vars_all' if headstatus==1 /*
	*/[aweight=wgt], vce(cluster pid) absorb(year)
sum constrdown if headstatus==1 [aweight=wgt]	
outreg2 using $analysisout\determinants_constraints, label append /*
	*/addtext(Year FE, Yes, Person FE, No) addstat(Dep. var. mean, r(mean)) /*
	*/ctitle(Downward Constr.) /*
	*/tex(frag) keep(`indep_vars_all' 2.headedu 3.headedu 4.headedu)
	
areg constrdown `indep_vars_fe' i.year if headstatus==1 /*
	*/[aweight=wgt], vce(cluster pid) absorb(pid)
sum constrdown if headstatus==1 [aweight=wgt]	
outreg2 using $analysisout\determinants_constraints, label append /*
	*/addtext(Year FE, Yes, Person FE, Yes) addstat(Dep. var. mean, r(mean)) /*
	*/ctitle(Downward Constr.) /*
	*/tex(frag) keep(`indep_vars_fe') ///
	addnote(Std. errors clustered at person level.) ///
	title("Determinants of Hours Constraints, Full Sample")
	
	
/*Robustness check -- keep only those working fewer than 55 hours/week*/

use "$analysisin\pooled.dta",clear
drop if headhourweekly>55
label variable children "Num. children in HH"

/*Transition into/out of upward constrained status*/
local indep_vars_all = /*
	*/"became_married stay_married became_div_sep chg_num_children chg_nonlabor_inc chg_log_headwage became_hmowner dislimithswrk chglog_headhour chgd_jobs headage headage_squared headblack i.headedu"
local indep_vars_fe = "became_married stay_married became_div_sep chg_num_children chg_nonlabor_inc chg_log_headwage became_hmowner chglog_headhour chgd_jobs"
	
areg became_uc `indep_vars_all' if headstatus==1 & lag_construp!=1 /*
	*/[aweight=wgt], vce(cluster pid) absorb(year)
sum became_uc if headstatus==1 & lag_construp!=1 [aweight=wgt]	
outreg2 using $analysisout\determinants_constraints_trans_lt55hr, label replace /*
	*/addtext(Year FE, Yes, Person FE, No) addstat(Dep. var. mean, r(mean)) /*
	*/ctitle(Became UC) keep(headage headage_squared headblack i.headedu /*
		*/became_married stay_married became_div_sep chg_num_children /*
		*/chg_nonlabor_inc chg_log_headwage chglog_headhour chgd_jobs /*
		*/2.headedu 3.headedu 4.headedu)

areg became_uc `indep_vars_fe' i.year if headstatus==1 & lag_construp!=1 /*
	*/[aweight=wgt],vce(cluster pid) absorb(pid)
sum became_uc if headstatus==1 & lag_construp!=1 [aweight=wgt]	
outreg2 using $analysisout\determinants_constraints_trans_lt55hr, label append /*
	*/tex(frag) addtext(Year FE, Yes, Person FE, Yes) addstat(Dep. var. mean, r(mean)) /*
	*/ctitle(Became UC) keep(became_married stay_married became_div_sep /*
	*/chg_num_children chg_nonlabor_inc chg_log_headwage  /*
	*/chglog_headhour chgd_jobs)
	
areg escaped_uc `indep_vars_all' if headstatus==1 & lag_construp==1 /*
	*/[aweight=wgt], vce(cluster pid) absorb(year)
sum escaped_uc if headstatus==1 & lag_construp==1 [aweight=wgt]	
outreg2 using $analysisout\determinants_constraints_trans_lt55hr, label append /*
	*/tex(frag) addtext(Year FE, Yes, Person FE, No) addstat(Dep. var. mean, r(mean)) /*
	*/ctitle(Escaped UC) keep(headage headage_squared headblack i.headedu /*
	*/became_married stay_married became_div_sep chg_num_children /*
	*/chg_nonlabor_inc chg_log_headwage chglog_headhour chgd_jobs /*
	*/2.headedu 3.headedu 4.headedu)
areg escaped_uc `indep_vars_fe' i.year if headstatus==1 & lag_construp==1 /*
	*/[aweight=wgt],vce(cluster pid) absorb(pid)
sum escaped_uc if headstatus==1 & lag_construp==1 [aweight=wgt]	
outreg2 using $analysisout\determinants_constraints_trans_lt55hr, label append /*
	*/tex(frag) addtext(Year FE, Yes, Person FE, Yes) ///
	addstat(Dep. var. mean, r(mean)) /*
	*/ctitle(Escaped UC) keep(became_married stay_married became_div_sep /*
	*/chg_num_children chg_nonlabor_inc chg_log_headwage  /*
	*/chglog_headhour chgd_jobs) ///
	addnote(Std. errors clustered at person level.) ///
	title("Determinants of Constraint Transitions, Working $<$55 hours/week")
	
	
/*Cross-section of constraints*/
local indep_vars_all = /*
	*/"headmarried age2 children nonlabor_inc log_headwage homeowner dislimithswrk headhourweekly headage headage_squared headblack i.headedu"
local indep_vars_fe = "headmarried age2 children nonlabor_inc log_headwage homeowner dislimithswrk headhourweekly"
	
areg construp `indep_vars_all' if headstatus==1 /*
	*/[aweight=wgt], vce(cluster pid) absorb(year)
sum construp if headstatus==1 [aweight=wgt]	
outreg2 using $analysisout\determinants_constraints_lt55hr, label replace /*
	*/addtext(Year FE, Yes, Person FE, No) addstat(Dep. var. mean, r(mean)) /*
	*/ctitle(Upward Constr.) /*
	*/keep(`indep_vars_all' 2.headedu 3.headedu 4.headedu)
	
areg construp `indep_vars_fe' i.year if headstatus==1 /*
	*/[aweight=wgt], vce(cluster pid) absorb(pid)
sum construp if headstatus==1 [aweight=wgt]	
outreg2 using $analysisout\determinants_constraints_lt55hr, label append /*
	*/addtext(Year FE, Yes, Person FE, Yes) addstat(Dep. var. mean, r(mean)) /*
	*/ctitle(Upward Constr.) /*
	*/tex(frag) keep(`indep_vars_fe')
	
areg constrdown `indep_vars_all' if headstatus==1 /*
	*/[aweight=wgt], vce(cluster pid) absorb(year)
sum constrdown if headstatus==1 [aweight=wgt]	
outreg2 using $analysisout\determinants_constraints_lt55hr, label append /*
	*/addtext(Year FE, Yes, Person FE, No) addstat(Dep. var. mean, r(mean)) /*
	*/ctitle(Downward Constr.) /*
	*/tex(frag) keep(`indep_vars_all' 2.headedu 3.headedu 4.headedu)
	
areg constrdown `indep_vars_fe' i.year if headstatus==1 /*
	*/[aweight=wgt], vce(cluster pid) absorb(pid)
sum constrdown if headstatus==1 [aweight=wgt]	
outreg2 using $analysisout\determinants_constraints_lt55hr, label append /*
	*/addtext(Year FE, Yes, Person FE, Yes) addstat(Dep. var. mean, r(mean)) /*
	*/ctitle(Downward Constr.) /*
	*/tex(frag) keep(`indep_vars_fe') ///
	title("Determinants of Hours Constraints, Working $<$55 hours/week")
