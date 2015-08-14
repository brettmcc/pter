clear all
set more off

cd "/href/research3/m1bam03/homeProdHourConstraints/build/code/"
!st ../output/pooled.sas7bdat ../output/pooled.dta -y

use "../output/pooled.dta",clear


label define empstat 1 "Employed" 2 "Temporarily laid off" 3 "Looking for work, unemployed"
label values headstatus empstat

gen headhourweekly = headhour/52

gen lt35hrs = (headhourweekly<35)
gen construp35 = (lt35hrs == 1 & construp==1)

save "../output/pooled.dta",replace


/*output time series datasets*/
*underemployed and part time
preserve
collapse (sum) construp35 headstatus if headstatus==1 [iweight=wgt], by(year)
gen prop_underemp_lt35_psid = construp35/headstatus
label var prop_underemp_lt35_psid "PSID, all"
save ../output/psid_construp35_yrly.dta,replace
restore

*underemployed, part time, age 50-70 
preserve
collapse (sum) construp35 headstatus if headstatus==1 & headage>=50 & headage<=70 [iweight=wgt], by(year)
gen prop_underemp_50to70_psid = construp35/headstatus 
label var prop_underemp_50to70_psid "PSID, ages 50-70"
save ../output/psid_construp35_age50to70_yrly.dta,replace
restore

*underemployed, full and part time
preserve
collapse (sum) construp headstatus if headstatus==1 [iweight=wgt], by(year)
gen prop_underemp_psid = construp/headstatus
label var prop_underemp_psid "PSID, all"
save ../output/psid_construp_yrly.dta,replace
restore
