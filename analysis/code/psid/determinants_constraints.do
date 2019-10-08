clear all
set more off, permanently

global analysisout "C:\Users\bmccully\Documents\pter-master\analysis\output"
global build "C:\Users\bmccully\Documents\pter-master\build\output\"
global analysisin "C:\Users\bmccully\Documents\pter-master\analysis\input"

use "$analysisin\pooled.dta",clear
label variable children "Num. children in HH"

/*Transition into/out of upward constrained status*/
local indep_vars_all = /*
	*/"became_married stay_married became_div_sep chg_num_children chg_nonlabor_inc chg_log_headwage became_hmowner dislimithswrk chglog_headhour chgd_jobs headage headage_squared headblack i.headedu"
local indep_vars_fe = "became_married stay_married became_div_sep chg_num_children chg_nonlabor_inc chg_log_headwage became_hmowner chglog_headhour chgd_jobs"
	
areg became_uc `indep_vars_all' if headstatus==1 & lag_construp!=1 /*
	*/[aweight=wgt], vce(cluster pid) absorb(year)
sum became_uc if headstatus==1 & lag_construp!=1 [aweight=wgt]	
outreg2 using $analysisout\determinants_constraints_trans, label replace /*
	*/addtext(Year FE, Yes, Person FE, No) addstat(Dep. var. mean, r(mean)) /*
	*/ctitle(Became UC) keep(headage headage_squared headblack i.headedu /*
		*/became_married stay_married became_div_sep chg_num_children /*
		*/chg_nonlabor_inc chg_log_headwage chglog_headhour chgd_jobs /*
		*/2.headedu 3.headedu 4.headedu)

areg became_uc `indep_vars_fe' i.year if headstatus==1 & lag_construp!=1 /*
	*/[aweight=wgt],vce(cluster pid) absorb(pid)
sum became_uc if headstatus==1 & lag_construp!=1 [aweight=wgt]	
outreg2 using $analysisout\determinants_constraints_trans, label append /*
	*/tex(frag) addtext(Year FE, Yes, Person FE, Yes) ///
	addstat(Dep. var. mean, r(mean)) /*
	*/ctitle(Became UC) keep(became_married stay_married became_div_sep /*
	*/chg_num_children chg_nonlabor_inc chg_log_headwage  /*
	*/chglog_headhour chgd_jobs)
	
areg escaped_uc `indep_vars_all' if headstatus==1 & lag_construp==1 /*
	*/[aweight=wgt], vce(cluster pid) absorb(year)
sum escaped_uc if headstatus==1 & lag_construp==1 [aweight=wgt]	
outreg2 using $analysisout\determinants_constraints_trans, label append /*
	*/tex(frag) addtext(Year FE, Yes, Person FE, No) addstat(Dep. var. mean, r(mean)) /*
	*/ctitle(Escaped UC) keep(headage headage_squared headblack i.headedu /*
		*/became_married stay_married became_div_sep chg_num_children /*
		*/chg_nonlabor_inc chg_log_headwage chglog_headhour chgd_jobs /*
		*/2.headedu 3.headedu 4.headedu)
areg escaped_uc `indep_vars_fe' i.year if headstatus==1 & lag_construp==1 /*
	*/[aweight=wgt],vce(cluster pid) absorb(pid)
sum escaped_uc if headstatus==1 & lag_construp==1 [aweight=wgt]	
outreg2 using $analysisout\determinants_constraints_trans, label append /*
	*/tex(frag) addtext(Year FE, Yes, Person FE, Yes) addstat(Dep. var. mean, r(mean)) /*
	*/ctitle(Escaped UC) keep(became_married stay_married became_div_sep /*
	*/chg_num_children chg_nonlabor_inc chg_log_headwage  /*
	*/chglog_headhour chgd_jobs) addnote(Clustered at person level.) ///
	title("Determinants of Constraint Transitions, Full Sample")
	
	
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
