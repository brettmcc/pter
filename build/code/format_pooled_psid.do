clear all
set more off

use "E:\pter\build\output\pooled.dta",clear


label define empstat 1 "Employed" 2 "Temporarily laid off" 3 "Looking for work, unemployed"
label values headstatus empstat

gen headhourweekly = headhour/52

gen lt35hrs = (headhourweekly<35)
gen construp35 = (lt35hrs == 1 & construp==1)

//label vars
label define empstatus 1 "Working/Temp. laid off" 2 "looking for work, unemployed" 3 "retired/permanently disabled" 4 "housewife" 5 "student" 6 "other"
label values headstatus empstatus
label define educ 1 "Dropped out before completing high school" 2 "High school grad" 3 "Some post-secondary education" 4 "College or higher degree"
label values headedu educ
label define occ 0 "Inap.: unemployed, retired, permanently disabled, housewife, or student" 1 "Professional, technical or kindred workers" 2 "Managers and Administrators, except Farm" 3 "Sales Workers" 4 "Clerical and kindred workers" 5 "craftsman and kindred workers" 6 "operatives, except transport" 7 "Transport equipment operatives" 8 "laborers, except farm" 9 "farmers and farm managers" 10 "farm laborers and farm foremen" 11 "services workers, except private household" 12 "private household workers"
label values headocc occ
label define ind 0 "Inap.: unemployed, retired, permanently disabled, housewife, or student" 1 "Agriculture, forestry, and fisheries" 2"mining" 3 "construction" 4 "manufacturing" 5 "transportation communication and other public utilities" 6 "wholesale and retail trade" 7 "finance, insurance, and real estate" 8 "business and repair services" 9 "personal services" 10 "entertainment and recreation services" 11 "Professional and related services" 12 "public administration" 
label values headind ind

save "E:\pter\build\output\pooled.dta",replace


/*output time series datasets*/
*underemployed and part time
preserve
collapse (sum) construp35 headstatus if headstatus==1 [iweight=wgt], by(year)
gen prop_underemp_lt35_psid = construp35/headstatus
label var prop_underemp_lt35_psid "PSID, all"
save E:\pter\build\output\psid_construp35_yrly.dta,replace
restore

*underemployed, part time, age 50-70 
preserve
collapse (sum) construp35 headstatus if headstatus==1 & headage>=50 & headage<=70 [iweight=wgt], by(year)
gen prop_underemp_50to70_psid = construp35/headstatus 
label var prop_underemp_50to70_psid "PSID, ages 50-70"
save E:\pter\build\output\psid_construp35_age50to70_yrly.dta,replace
restore

*underemployed, full and part time
preserve
collapse (sum) construp headstatus if headstatus==1 [iweight=wgt], by(year)
gen prop_underemp_psid = construp/headstatus
label var prop_underemp_psid "PSID, all"
save E:\pter\build\output\psid_construp_yrly.dta,replace
restore
