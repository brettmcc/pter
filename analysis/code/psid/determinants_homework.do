/*Brett McCully, June 2018
  
*/

clear all
set more off, permanently

use "${dir}\analysis\input\pooled.dta",clear

global indep_vars headfemale headage headage_squared headblack i.headedu headsecjob age2 age6 age12 age18 nonlabor_inc log_headwage //dislimithswrk 
global indep_vars_personfe headage headage_squared i.headedu headsecjob age2 age6 age12 age18 nonlabor_inc //dislimithswrk
	
/*Level of Head housework hours*/
reg hwheadweekly construp constrdown [aweight=wgt], vce(cluster pid)
sum hwheadweekly [aweight=wgt] 
// outreg2 using /*
// 	*/C:\Users\bmccully\Documents\pter-master\analysis\output\determinants_homework /*
// 	*/,label replace ctitle("Head Wkly HW") /*
// 	*/title(Determinants of Home Work Hours) addtext(Controls, No, Year FE, No, Person FE, No) /*
// 	*/addstat(Dep. var. mean, r(mean)) keep(construp constrdown)
reg hwheadweekly construp constrdown ${indep_vars} [aweight=wgt],/*
	*/vce(cluster pid)
sum hwheadweekly [aweight=wgt] 
// outreg2 using /*
// 	*/C:\Users\bmccully\Documents\pter-master\analysis\output\determinants_homework /*
// 	*/,label tex(frag) append ctitle("Head Wkly HW") /*
// 	*/addtext(Controls, Yes, Year FE, No, Person FE, No) /*
// 	*/addstat(Dep. var. mean, r(mean)) keep(construp constrdown)
areg hwheadweekly construp constrdown ${indep_vars} /*
	*/[aweight=wgt], vce(cluster pid) absorb(year)
sum hwheadweekly [aweight=wgt] 
// outreg2 using /*
// 	*/C:\Users\bmccully\Documents\pter-master\analysis\output\determinants_homework /*
// 	*/,label tex(frag) append ctitle("Head Wkly HW") /*
// 	*/addtext(Controls, Yes, Year FE, Yes, Person FE, No) /*
// 	*/addstat(Dep. var. mean, r(mean)) keep(construp constrdown) 
areg hwheadweekly construp constrdown ${indep_vars_personfe} i.year /*
	*/[aweight=wgt], vce(cluster pid) absorb(pid)
sum hwheadweekly [aweight=wgt] 
// outreg2 using /*
// 	*/C:\Users\bmccully\Documents\pter-master\analysis\output\determinants_homework /*
// 	*/,label tex(frag) append ctitle("Head Wkly HW") /*
// 	*/addtext(Controls, Yes, Year FE, Yes, Person FE, Yes) /*
// 	*/addstat(Dep. var. mean, r(mean)) keep(construp constrdown)

	
/*Log of Head housework hours*/
reg loghwhead construp constrdown [aweight=wgt], vce(cluster pid)
// outreg2 using /*
// 	*/C:\Users\bmccully\Documents\pter-master\analysis\output\determinants_homework_log /*
// 	*/,label replace ctitle("Ln Head HW") /*
// 	*/addtext(Controls, No, Year FE, No, Person FE, No) /*
// 	*/keep(construp constrdown)
reg loghwhead construp constrdown `indep_vars' [aweight=wgt],/*
	*/vce(cluster pid)
// outreg2 using /*
// 	*/C:\Users\bmccully\Documents\pter-master\analysis\output\determinants_homework_log /*
// 	*/,label tex(frag) append ctitle("Ln Head HW") /*
// 	*/addtext(Controls, Yes, Year FE, No, Person FE, No) /*
// 	*/ keep(construp constrdown)
areg loghwhead construp constrdown `indep_vars' /*
	*/[aweight=wgt], vce(cluster pid) absorb(year)
// outreg2 using /*
// 	*/C:\Users\bmccully\Documents\pter-master\analysis\output\determinants_homework_log /*
// 	*/,label tex(frag) append ctitle("Ln Head HW") /*
// 	*/addtext(Controls, Yes, Year FE, Yes, Person FE, No) /*
// 	*/keep(construp constrdown) 
areg loghwhead construp constrdown `indep_vars_personfe' i.year /*
	*/[aweight=wgt], vce(cluster pid) absorb(pid)
// outreg2 using /*
// 	*/C:\Users\bmccully\Documents\pter-master\analysis\output\determinants_homework_log /*
// 	*/,label tex(frag) append ctitle("Ln Head HW") /*
// 	*/addtext(Controls, Yes, Year FE, Yes, Person FE, Yes) /*
// 	*/ keep(construp constrdown)
	
	
local indep_vars = /*
	*/"headfemale headage headage_squared headblack i.headedu dislimithswrk headsecjob age2 age6 age12 age18 nonlabor_inc log_headwage"
local indep_vars_personfe = /*
	*/"headage headage_squared i.headedu dislimithswrk headsecjob age2 age6 age12 age18 nonlabor_inc"
	
reg hwheadweekly c.construp##c.headhourweekly /*
	*/c.constrdown##c.headhourweekly [aweight=wgt], vce(cluster pid)
reg hwheadweekly c.construp##c.headhourweekly /*
	*/c.constrdown##c.headhourweekly `indep_vars' [aweight=wgt],/*
	*/vce(cluster pid)
areg hwheadweekly c.construp##c.headhourweekly /*
	*/c.constrdown##c.headhourweekly `indep_vars' /*
	*/[aweight=wgt], vce(cluster pid) absorb(year)
areg hwheadweekly c.construp##c.headhourweekly /*
	*/c.constrdown##c.headhourweekly `indep_vars_personfe' i.year /*
	*/[aweight=wgt], vce(cluster pid) absorb(pid)
	
reg loghwhead construp constrdown [aweight=wgt], vce(cluster pid)
reg loghwhead construp constrdown `indep_vars' [aweight=wgt],/*
	*/vce(cluster pid)
areg loghwhead construp constrdown `indep_vars' /*
	*/[aweight=wgt], vce(cluster pid) absorb(year)
areg loghwhead construp constrdown `indep_vars_personfe' i.year /*
	*/[aweight=wgt], vce(cluster pid) absorb(pid)

	
/*Robustness check -- do for those working <55 hours/week*/
use "$analysisin\pooled.dta",clear
drop if headhourweekly>55

local indep_vars = /*
	*/"headfemale headage headage_squared headblack i.headedu dislimithswrk headsecjob age2 age6 age12 age18 nonlabor_inc log_headwage"
local indep_vars_personfe = /*
	*/"headage headage_squared i.headedu dislimithswrk headsecjob age2 age6 age12 age18 nonlabor_inc"
	
/*Level of Head housework hours*/
reg hwheadweekly construp constrdown [aweight=wgt], vce(cluster pid)
sum hwheadweekly [aweight=wgt] 
outreg2 using /*
	*/C:\Users\bmccully\Documents\pter-master\analysis\output\determinants_homework_lt55hr /*
	*/,label replace ctitle("Head Wkly HW") /*
	*/title(Determinants of Home Work Hours) addtext(Controls, No, Year FE, No, Person FE, No) /*
	*/addstat(Dep. var. mean, r(mean)) keep(construp constrdown)
reg hwheadweekly construp constrdown `indep_vars' [aweight=wgt],/*
	*/vce(cluster pid)
sum hwheadweekly [aweight=wgt] 
outreg2 using /*
	*/C:\Users\bmccully\Documents\pter-master\analysis\output\determinants_homework_lt55hr /*
	*/,label tex(frag) append ctitle("Head Wkly HW") /*
	*/addtext(Controls, Yes, Year FE, No, Person FE, No) /*
	*/addstat(Dep. var. mean, r(mean)) keep(construp constrdown)
areg hwheadweekly construp constrdown `indep_vars' /*
	*/[aweight=wgt], vce(cluster pid) absorb(year)
sum hwheadweekly [aweight=wgt] 
outreg2 using /*
	*/C:\Users\bmccully\Documents\pter-master\analysis\output\determinants_homework_lt55hr /*
	*/,label tex(frag) append ctitle("Head Wkly HW") /*
	*/addtext(Controls, Yes, Year FE, Yes, Person FE, No) /*
	*/addstat(Dep. var. mean, r(mean)) keep(construp constrdown) 
areg hwheadweekly construp constrdown `indep_vars_personfe' i.year /*
	*/[aweight=wgt], vce(cluster pid) absorb(pid)
sum hwheadweekly [aweight=wgt] 
outreg2 using /*
	*/C:\Users\bmccully\Documents\pter-master\analysis\output\determinants_homework_lt55hr /*
	*/,label tex(frag) append ctitle("Head Wkly HW") /*
	*/addtext(Controls, Yes, Year FE, Yes, Person FE, Yes) /*
	*/addstat(Dep. var. mean, r(mean)) keep(construp constrdown)

	
/*Log of Head housework hours*/
reg loghwhead construp constrdown [aweight=wgt], vce(cluster pid)
outreg2 using /*
	*/C:\Users\bmccully\Documents\pter-master\analysis\output\determinants_homework_log_lt55hr /*
	*/,label replace ctitle("Ln Head HW") /*
	*/addtext(Controls, No, Year FE, No, Person FE, No) /*
	*/keep(construp constrdown)
reg loghwhead construp constrdown `indep_vars' [aweight=wgt],/*
	*/vce(cluster pid)
outreg2 using /*
	*/C:\Users\bmccully\Documents\pter-master\analysis\output\determinants_homework_log_lt55hr /*
	*/,label tex(frag) append ctitle("Ln Head HW") /*
	*/addtext(Controls, Yes, Year FE, No, Person FE, No) /*
	*/ keep(construp constrdown)
areg loghwhead construp constrdown `indep_vars' /*
	*/[aweight=wgt], vce(cluster pid) absorb(year)
outreg2 using /*
	*/C:\Users\bmccully\Documents\pter-master\analysis\output\determinants_homework_log_lt55hr /*
	*/,label tex(frag) append ctitle("Ln Head HW") /*
	*/addtext(Controls, Yes, Year FE, Yes, Person FE, No) /*
	*/keep(construp constrdown) 
areg loghwhead construp constrdown `indep_vars_personfe' i.year /*
	*/[aweight=wgt], vce(cluster pid) absorb(pid)
outreg2 using /*
	*/C:\Users\bmccully\Documents\pter-master\analysis\output\determinants_homework_log_lt55hr /*
	*/,label tex(frag) append ctitle("Ln Head HW") /*
	*/addtext(Controls, Yes, Year FE, Yes, Person FE, Yes) /*
	*/ keep(construp constrdown)
