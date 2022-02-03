
/*   Table 2   -- Regression results for constraint transitions   */
/*	 Split sample by part-time and full-time workers at time t-1, then
	 exclude thos who were unemployed in previous period.*/
use "$analysisin\pooled.dta",clear

//the change variables exclude observations that don't have an 
//immediate predecessor in the period before.
//The Sameemp_months variable is only available 68, 76-78,81-86
//so it excludes observations in a number of years.
keep if lag_headparttime==1

local indep_vars_all = /*
	*/"headage headage_squared headblack i.headedu became_married stay_married became_div_sep chg_num_children chg_nonlabor_inc chg_log_headwage chglog_headhour became_hmowner dislimithswrk headsecjob unemp_to_ft unemp_to_pt ft_to_pt pt_to_ft pt_to_pt became_hourlywaged"
local addl_vars = "chgd_jobs relocated got_addl_job chgd_union_status chg_foodout chg_housework_hours"
areg became_uc `indep_vars_all' if headstatus==1 & lag_construp!=1 /*
	*/[aweight=wgt], vce(cluster pid) absorb(year)
sum became_uc if headstatus==1 & lag_construp!=1 [aweight=wgt]
outreg2 using $analyisout\table2_robustness_pt, excel label replace /*
	*/addtext(Year FE, Yes) addstat(Dep. var. mean, r(mean)) /*
	*/ctitle(Became UC) title(Part time workers)
areg became_uc `indep_vars_all' `addl_vars' [aweight=wgt] /*
	*/if headstatus==1 & lag_construp!=1 ,vce(cluster pid) absorb(year)
sum became_uc if headstatus==1 & lag_construp!=1 
outreg2 using $analyisout\table2_robustness_pt, excel label append /*
	*/addtext(Year FE, Yes) addstat(Dep. var. mean, r(mean)) /*
	*/ctitle(Became UC)
	
local indep_vars_married = /*
	*/"headage headage_squared headblack i.headedu chg_num_children chg_nonlabor_inc chg_log_headwage chglog_headhour chglog_wifehour became_hmowner dislimithswrk headsecjob unemp_to_ft unemp_to_pt ft_to_pt pt_to_ft pt_to_pt became_hourlywaged wifeage i.wifeedu"
local addl_vars_marr = "chgd_jobs relocated got_addl_job chgd_union_status wife_enters_workforce chg_foodout chg_housework_hours"
areg became_uc `indep_vars_married' [aweight=wgt] /*
	*/if headmarried==1 & lag_headmarried==1 & headstatus==1 /*
	*/& lag_construp!=1 ,vce(cluster pid) absorb(year)
sum became_uc if headmarried==1 & lag_headmarried==1 & headstatus==1 /*
	*/& lag_construp!=1 
outreg2 using $analyisout\table2_robustness_pt, excel label append /*
	*/addtext(Year FE, Yes) addstat(Dep. var. mean, r(mean)) /*
	*/ctitle(Became UC)
areg became_uc `indep_vars_married' `addl_vars_marr' [aweight=wgt] /*
	*/if headmarried==1 & lag_headmarried==1 & headstatus==1 /*
	*/& lag_construp!=1 ,vce(cluster pid) absorb(year)
sum became_uc if headmarried==1 & lag_headmarried==1 & headstatus==1 /*
	*/& lag_construp!=1 
outreg2 using $analyisout\table2_robustness_pt, excel label append /*
	*/addtext(Year FE, Yes) addstat(Dep. var. mean, r(mean)) /*
	*/ctitle(Became UC)	
	
local indep_vars_esc = /*
	*/"headage headage_squared headblack i.headedu became_married stay_married became_div_sep chg_num_children chg_nonlabor_inc chg_log_headwage chglog_headhour became_hmowner dislimithswrk headsecjob ft_to_unemp pt_to_unemp ft_to_pt pt_to_ft pt_to_pt became_hourlywaged"
areg escaped_uc `indep_vars_esc' if lag_headstatus==1 & lag_construp==1 /*
	*/[aweight=wgt], vce(cluster pid) absorb(year)
sum escaped_uc if lag_headstatus==1 & lag_construp==1 [aweight=wgt]
outreg2 using $analyisout\table2_robustness_pt, excel label append /*
	*/addtext(Year FE, Yes) addstat(Dep. var. mean, r(mean)) /*
	*/ctitle(Escaped UC)
areg escaped_uc `indep_vars_esc' `addl_vars' [aweight=wgt] /*
	*/if lag_headstatus==1 & lag_construp==1, vce(cluster pid) absorb(year)
sum escaped_uc if lag_headstatus==1 & lag_construp==1 [aweight=wgt]
outreg2 using $analyisout\table2_robustness_pt, excel label append /*
	*/addtext(Year FE, Yes) addstat(Dep. var. mean, r(mean)) /*
	*/ctitle(Escaped UC)
local indep_vars_marriedesc = /*
	*/"headage headage_squared headblack i.headedu chg_num_children chg_nonlabor_inc chg_log_headwage chglog_headhour chglog_wifehour became_hmowner dislimithswrk headsecjob ft_to_unemp pt_to_unemp ft_to_pt pt_to_ft pt_to_pt became_hourlywaged wifeage i.wifeedu"
areg escaped_uc `indep_vars_marriedesc' [aweight=wgt] /*
	*/if headmarried==1 & lag_headmarried==1 & lag_headstatus==1 & /*
	*/lag_construp==1, vce(cluster pid) absorb(year)
sum escaped_uc if headmarried==1 & lag_headmarried==1 & lag_headstatus==1 & /*
	*/lag_construp==1 [aweight=wgt]
outreg2 using $analyisout\table2_robustness_pt, excel label append /*
	*/addtext(Year FE, Yes) addstat(Dep. var. mean, r(mean)) /*
	*/ctitle(Escaped UC)
areg escaped_uc `indep_vars_marriedesc' `addl_vars_marr' [aweight=wgt] /*
	*/if headmarried==1 & lag_headmarried==1 & lag_headstatus==1 & /*
	*/lag_construp==1, vce(cluster pid) absorb(year)
sum escaped_uc if headmarried==1 & lag_headmarried==1 & lag_headstatus==1 & /*
	*/lag_construp==1 [aweight=wgt]
outreg2 using $analyisout\table2_robustness_pt, excel label append /*
	*/addtext(Year FE, Yes) addstat(Dep. var. mean, r(mean)) /*
	*/ctitle(Escaped UC)


	
	
/****FULL-TIME*/	
use "$analysisin\pooled.dta",clear

keep if lag_headfulltime==1

local indep_vars_all = /*
	*/"headage headage_squared headblack i.headedu became_married stay_married became_div_sep chg_num_children chg_nonlabor_inc chg_log_headwage chglog_headhour became_hmowner dislimithswrk headsecjob unemp_to_ft unemp_to_pt ft_to_pt pt_to_ft pt_to_pt became_hourlywaged"
local addl_vars = "chgd_jobs relocated got_addl_job chgd_union_status chg_foodout chg_housework_hours"
areg became_uc `indep_vars_all' if headstatus==1 & lag_construp!=1 /*
	*/[aweight=wgt], vce(cluster pid) absorb(year)
sum became_uc if headstatus==1 & lag_construp!=1 [aweight=wgt]
outreg2 using $analyisout\table2_robustness_ft, excel label replace /*
	*/addtext(Year FE, Yes) addstat(Dep. var. mean, r(mean)) /*
	*/ctitle(Became UC) title(Full time workers)
areg became_uc `indep_vars_all' `addl_vars' [aweight=wgt] /*
	*/if headstatus==1 & lag_construp!=1 ,vce(cluster pid) absorb(year)
sum became_uc if headstatus==1 & lag_construp!=1 
outreg2 using $analyisout\table2_robustness_ft, excel label append /*
	*/addtext(Year FE, Yes) addstat(Dep. var. mean, r(mean)) /*
	*/ctitle(Became UC)
	
local indep_vars_married = /*
	*/"headage headage_squared headblack i.headedu chg_num_children chg_nonlabor_inc chg_log_headwage chglog_headhour chglog_wifehour became_hmowner dislimithswrk headsecjob unemp_to_ft unemp_to_pt ft_to_pt pt_to_ft pt_to_pt became_hourlywaged wifeage i.wifeedu"
local addl_vars_marr = "chgd_jobs relocated got_addl_job chgd_union_status wife_enters_workforce chg_foodout chg_housework_hours"
areg became_uc `indep_vars_married' [aweight=wgt] /*
	*/if headmarried==1 & lag_headmarried==1 & headstatus==1 /*
	*/& lag_construp!=1 ,vce(cluster pid) absorb(year)
sum became_uc if headmarried==1 & lag_headmarried==1 & headstatus==1 /*
	*/& lag_construp!=1 
outreg2 using $analyisout\table2_robustness_ft, excel label append /*
	*/addtext(Year FE, Yes) addstat(Dep. var. mean, r(mean)) /*
	*/ctitle(Became UC)
areg became_uc `indep_vars_married' `addl_vars_marr' [aweight=wgt] /*
	*/if headmarried==1 & lag_headmarried==1 & headstatus==1 /*
	*/& lag_construp!=1 ,vce(cluster pid) absorb(year)
sum became_uc if headmarried==1 & lag_headmarried==1 & headstatus==1 /*
	*/& lag_construp!=1 
outreg2 using $analyisout\table2_robustness_ft, excel label append /*
	*/addtext(Year FE, Yes) addstat(Dep. var. mean, r(mean)) /*
	*/ctitle(Became UC)
	
local indep_vars_esc = /*
	*/"headage headage_squared headblack i.headedu became_married stay_married became_div_sep chg_num_children chg_nonlabor_inc chg_log_headwage chglog_headhour became_hmowner dislimithswrk headsecjob ft_to_unemp pt_to_unemp ft_to_pt pt_to_ft pt_to_pt became_hourlywaged"
areg escaped_uc `indep_vars_esc' if lag_headstatus==1 & lag_construp==1 /*
	*/[aweight=wgt], vce(cluster pid) absorb(year)
sum escaped_uc if lag_headstatus==1 & lag_construp==1 [aweight=wgt]
outreg2 using $analyisout\table2_robustness_ft, excel label append /*
	*/addtext(Year FE, Yes) addstat(Dep. var. mean, r(mean)) /*
	*/ctitle(Escaped UC)
areg escaped_uc `indep_vars_esc' `addl_vars' [aweight=wgt] /*
	*/if lag_headstatus==1 & lag_construp==1, vce(cluster pid) absorb(year)
sum escaped_uc if lag_headstatus==1 & lag_construp==1 [aweight=wgt]
outreg2 using $analyisout\table2_robustness_ft, excel label append /*
	*/addtext(Year FE, Yes) addstat(Dep. var. mean, r(mean)) /*
	*/ctitle(Escaped UC)
local indep_vars_marriedesc = /*
	*/"headage headage_squared headblack i.headedu chg_num_children chg_nonlabor_inc chg_log_headwage chglog_headhour chglog_wifehour became_hmowner dislimithswrk headsecjob ft_to_unemp pt_to_unemp ft_to_pt pt_to_ft pt_to_pt became_hourlywaged wifeage i.wifeedu"
areg escaped_uc `indep_vars_marriedesc' [aweight=wgt] /*
	*/if headmarried==1 & lag_headmarried==1 & lag_headstatus==1 & /*
	*/lag_construp==1, vce(cluster pid) absorb(year)
sum escaped_uc if headmarried==1 & lag_headmarried==1 & lag_headstatus==1 & /*
	*/lag_construp==1 [aweight=wgt]
outreg2 using $analyisout\table2_robustness_ft, excel label append /*
	*/addtext(Year FE, Yes) addstat(Dep. var. mean, r(mean)) /*
	*/ctitle(Escaped UC)
areg escaped_uc `indep_vars_marriedesc' `addl_vars_marr' [aweight=wgt] /*
	*/if headmarried==1 & lag_headmarried==1 & lag_headstatus==1 & /*
	*/lag_construp==1, vce(cluster pid) absorb(year)
sum escaped_uc if headmarried==1 & lag_headmarried==1 & lag_headstatus==1 & /*
	*/lag_construp==1 [aweight=wgt]
outreg2 using $analyisout\table2_robustness_ft, excel label append /*
	*/addtext(Year FE, Yes) addstat(Dep. var. mean, r(mean)) /*
	*/ctitle(Escaped UC)

	
	
	
/*REMOVE UNEMPLOYED IN TIME t*/
use "$analysisin\pooled.dta",clear

keep if headstatus==1

local indep_vars_all = /*
	*/"headage headage_squared headblack i.headedu became_married stay_married became_div_sep chg_num_children chg_nonlabor_inc chg_log_headwage chglog_headhour became_hmowner dislimithswrk headsecjob unemp_to_ft unemp_to_pt ft_to_pt pt_to_ft pt_to_pt became_hourlywaged"
local addl_vars = "chgd_jobs relocated got_addl_job chgd_union_status chg_foodout chg_housework_hours"
areg became_uc `indep_vars_all' if headstatus==1 & lag_construp!=1 /*
	*/[aweight=wgt], vce(cluster pid) absorb(year)
sum became_uc if headstatus==1 & lag_construp!=1 [aweight=wgt]
outreg2 using $analyisout\table2_robustness_emp1, excel label replace /*
	*/addtext(Year FE, Yes) addstat(Dep. var. mean, r(mean)) /*
	*/ctitle(Became UC) title(No Unemployed time t)
areg became_uc `indep_vars_all' `addl_vars' [aweight=wgt] /*
	*/if headstatus==1 & lag_construp!=1 ,vce(cluster pid) absorb(year)
sum became_uc if headstatus==1 & lag_construp!=1 
outreg2 using $analyisout\table2_robustness_emp1, excel label append /*
	*/addtext(Year FE, Yes) addstat(Dep. var. mean, r(mean)) /*
	*/ctitle(Became UC)
	
local indep_vars_married = /*
	*/"headage headage_squared headblack i.headedu chg_num_children chg_nonlabor_inc chg_log_headwage chglog_headhour chglog_wifehour became_hmowner dislimithswrk headsecjob unemp_to_ft unemp_to_pt ft_to_pt pt_to_ft pt_to_pt became_hourlywaged wifeage i.wifeedu"
local addl_vars_marr = "chgd_jobs relocated got_addl_job chgd_union_status wife_enters_workforce chg_foodout chg_housework_hours"
areg became_uc `indep_vars_married' [aweight=wgt] /*
	*/if headmarried==1 & lag_headmarried==1 & headstatus==1 /*
	*/& lag_construp!=1 ,vce(cluster pid) absorb(year)
sum became_uc if headmarried==1 & lag_headmarried==1 & headstatus==1 /*
	*/& lag_construp!=1 
outreg2 using $analyisout\table2_robustness_emp1, excel label append /*
	*/addtext(Year FE, Yes) addstat(Dep. var. mean, r(mean)) /*
	*/ctitle(Became UC)
areg became_uc `indep_vars_married' `addl_vars_marr' [aweight=wgt] /*
	*/if headmarried==1 & lag_headmarried==1 & headstatus==1 /*
	*/& lag_construp!=1 ,vce(cluster pid) absorb(year)
sum became_uc if headmarried==1 & lag_headmarried==1 & headstatus==1 /*
	*/& lag_construp!=1 
outreg2 using $analyisout\table2_robustness_emp1, excel label append /*
	*/addtext(Year FE, Yes) addstat(Dep. var. mean, r(mean)) /*
	*/ctitle(Became UC)
	
local indep_vars_esc = /*
	*/"headage headage_squared headblack i.headedu became_married stay_married became_div_sep chg_num_children chg_nonlabor_inc chg_log_headwage chglog_headhour became_hmowner dislimithswrk headsecjob ft_to_unemp pt_to_unemp ft_to_pt pt_to_ft pt_to_pt became_hourlywaged"
areg escaped_uc `indep_vars_esc' if lag_headstatus==1 & lag_construp==1 /*
	*/[aweight=wgt], vce(cluster pid) absorb(year)
sum escaped_uc if lag_headstatus==1 & lag_construp==1 [aweight=wgt]
outreg2 using $analyisout\table2_robustness_emp1, excel label append /*
	*/addtext(Year FE, Yes) addstat(Dep. var. mean, r(mean)) /*
	*/ctitle(Escaped UC)
areg escaped_uc `indep_vars_esc' `addl_vars' [aweight=wgt] /*
	*/if lag_headstatus==1 & lag_construp==1, vce(cluster pid) absorb(year)
sum escaped_uc if lag_headstatus==1 & lag_construp==1 [aweight=wgt]
outreg2 using $analyisout\table2_robustness_emp1, excel label append /*
	*/addtext(Year FE, Yes) addstat(Dep. var. mean, r(mean)) /*
	*/ctitle(Escaped UC)
local indep_vars_marriedesc = /*
	*/"headage headage_squared headblack i.headedu chg_num_children chg_nonlabor_inc chg_log_headwage chglog_headhour chglog_wifehour became_hmowner dislimithswrk headsecjob ft_to_unemp pt_to_unemp ft_to_pt pt_to_ft pt_to_pt became_hourlywaged wifeage i.wifeedu"
areg escaped_uc `indep_vars_marriedesc' [aweight=wgt] /*
	*/if headmarried==1 & lag_headmarried==1 & lag_headstatus==1 & /*
	*/lag_construp==1, vce(cluster pid) absorb(year)
sum escaped_uc if headmarried==1 & lag_headmarried==1 & lag_headstatus==1 & /*
	*/lag_construp==1 [aweight=wgt]
outreg2 using $analyisout\table2_robustness_emp1, excel label append /*
	*/addtext(Year FE, Yes) addstat(Dep. var. mean, r(mean)) /*
	*/ctitle(Escaped UC)
areg escaped_uc `indep_vars_marriedesc' `addl_vars_marr' [aweight=wgt] /*
	*/if headmarried==1 & lag_headmarried==1 & lag_headstatus==1 & /*
	*/lag_construp==1, vce(cluster pid) absorb(year)
sum escaped_uc if headmarried==1 & lag_headmarried==1 & lag_headstatus==1 & /*
	*/lag_construp==1 [aweight=wgt]
outreg2 using $analyisout\table2_robustness_emp1, excel label append /*
	*/addtext(Year FE, Yes) addstat(Dep. var. mean, r(mean)) /*
	*/ctitle(Escaped UC)
	
	
/*REMOVE UNEMPLOYED IN TIME t-1*/
use "$analysisin\pooled.dta",clear

drop if unemp_to_ft==1 | unemp_to_pt==1

local indep_vars_all = /*
	*/"headage headage_squared headblack i.headedu became_married stay_married became_div_sep chg_num_children chg_nonlabor_inc chg_log_headwage chglog_headhour became_hmowner dislimithswrk headsecjob unemp_to_ft unemp_to_pt ft_to_pt pt_to_ft pt_to_pt became_hourlywaged"
local addl_vars = "chgd_jobs relocated got_addl_job chgd_union_status chg_foodout chg_housework_hours"
areg became_uc `indep_vars_all' if headstatus==1 & lag_construp!=1 /*
	*/[aweight=wgt], vce(cluster pid) absorb(year)
sum became_uc if headstatus==1 & lag_construp!=1 [aweight=wgt]
outreg2 using $analyisout\table2_robustness_emp2, excel label replace /*
	*/addtext(Year FE, Yes) addstat(Dep. var. mean, r(mean)) /*
	*/ctitle(Became UC) title(No Unemployed time t-1)
areg became_uc `indep_vars_all' `addl_vars' [aweight=wgt] /*
	*/if headstatus==1 & lag_construp!=1 ,vce(cluster pid) absorb(year)
sum became_uc if headstatus==1 & lag_construp!=1 
outreg2 using $analyisout\table2_robustness_emp2, excel label append /*
	*/addtext(Year FE, Yes) addstat(Dep. var. mean, r(mean)) /*
	*/ctitle(Became UC)
	
local indep_vars_married = /*
	*/"headage headage_squared headblack i.headedu chg_num_children chg_nonlabor_inc chg_log_headwage chglog_headhour chglog_wifehour became_hmowner dislimithswrk headsecjob unemp_to_ft unemp_to_pt ft_to_pt pt_to_ft pt_to_pt became_hourlywaged wifeage i.wifeedu"
local addl_vars_marr = "chgd_jobs relocated got_addl_job chgd_union_status wife_enters_workforce chg_foodout chg_housework_hours"
areg became_uc `indep_vars_married' [aweight=wgt] /*
	*/if headmarried==1 & lag_headmarried==1 & headstatus==1 /*
	*/& lag_construp!=1 ,vce(cluster pid) absorb(year)
sum became_uc if headmarried==1 & lag_headmarried==1 & headstatus==1 /*
	*/& lag_construp!=1 
outreg2 using $analyisout\table2_robustness_emp2, excel label append /*
	*/addtext(Year FE, Yes) addstat(Dep. var. mean, r(mean)) /*
	*/ctitle(Became UC)
areg became_uc `indep_vars_married' `addl_vars_marr' [aweight=wgt] /*
	*/if headmarried==1 & lag_headmarried==1 & headstatus==1 /*
	*/& lag_construp!=1 ,vce(cluster pid) absorb(year)
sum became_uc if headmarried==1 & lag_headmarried==1 & headstatus==1 /*
	*/& lag_construp!=1 
outreg2 using $analyisout\table2_robustness_emp2, excel label append /*
	*/addtext(Year FE, Yes) addstat(Dep. var. mean, r(mean)) /*
	*/ctitle(Became UC)	
	
local indep_vars_esc = /*
	*/"headage headage_squared headblack i.headedu became_married stay_married became_div_sep chg_num_children chg_nonlabor_inc chg_log_headwage chglog_headhour became_hmowner dislimithswrk headsecjob ft_to_unemp pt_to_unemp ft_to_pt pt_to_ft pt_to_pt became_hourlywaged"
areg escaped_uc `indep_vars_esc' if lag_headstatus==1 & lag_construp==1 /*
	*/[aweight=wgt], vce(cluster pid) absorb(year)
sum escaped_uc if lag_headstatus==1 & lag_construp==1 [aweight=wgt]
outreg2 using $analyisout\table2_robustness_emp2, excel label append /*
	*/addtext(Year FE, Yes) addstat(Dep. var. mean, r(mean)) /*
	*/ctitle(Escaped UC)
areg escaped_uc `indep_vars_esc' `addl_vars' [aweight=wgt] /*
	*/if lag_headstatus==1 & lag_construp==1, vce(cluster pid) absorb(year)
sum escaped_uc if lag_headstatus==1 & lag_construp==1 [aweight=wgt]
outreg2 using $analyisout\table2_robustness_emp2, excel label append /*
	*/addtext(Year FE, Yes) addstat(Dep. var. mean, r(mean)) /*
	*/ctitle(Escaped UC)
local indep_vars_marriedesc = /*
	*/"headage headage_squared headblack i.headedu chg_num_children chg_nonlabor_inc chg_log_headwage chglog_headhour chglog_wifehour became_hmowner dislimithswrk headsecjob ft_to_unemp pt_to_unemp ft_to_pt pt_to_ft pt_to_pt became_hourlywaged wifeage i.wifeedu"
areg escaped_uc `indep_vars_marriedesc' [aweight=wgt] /*
	*/if headmarried==1 & lag_headmarried==1 & lag_headstatus==1 & /*
	*/lag_construp==1, vce(cluster pid) absorb(year)
sum escaped_uc if headmarried==1 & lag_headmarried==1 & lag_headstatus==1 & /*
	*/lag_construp==1 [aweight=wgt]
outreg2 using $analyisout\table2_robustness_emp2, excel label append /*
	*/addtext(Year FE, Yes) addstat(Dep. var. mean, r(mean)) /*
	*/ctitle(Escaped UC)
areg escaped_uc `indep_vars_marriedesc' `addl_vars_marr' [aweight=wgt] /*
	*/if headmarried==1 & lag_headmarried==1 & lag_headstatus==1 & /*
	*/lag_construp==1, vce(cluster pid) absorb(year)
sum escaped_uc if headmarried==1 & lag_headmarried==1 & lag_headstatus==1 & /*
	*/lag_construp==1 [aweight=wgt]
outreg2 using $analyisout\table2_robustness_emp2, excel label append /*
	*/addtext(Year FE, Yes) addstat(Dep. var. mean, r(mean)) /*
	*/ctitle(Escaped UC)
