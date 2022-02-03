*make a few adjustments to dataset after SAS program
//Brett McCully, June 2015

cd /href/research3/m1bam03/homeProdHourConstraints/build/code/

clear all
set more off

use ../output/hrsdata.dta,clear

label define status 1 "works FT" 2 "works PT" 3 "unemployed" 4 "partly retired"
label values headstatus status

gen headhourweekly = headhour/52

gen lt35hrs = (headhourweekly<35)
gen construp35 = (lt35hrs == 1 & construp==1)

save ../../analysis/input/hrsdata.dta,replace

/*output time series datasets*/
*underemployed and part time
preserve
collapse (sum) construp35 (count) headstatus [iweight=wgt], by(wave)
rename wave year
gen prop_pterlt35_hrs = construp35/headstatus
label var prop_pterlt35_hrs "HRS"
save ../../analysis/input/hrs_construp35_yrly.dta,replace
restore

*underemployed, full and part time
preserve
use ../../build/output/hrsdata,clear
collapse (sum) construp (count) headstatus [iweight=wgt], by(wave)
rename wave year
gen prop_pter_hrs = construp/headstatus
save ../../analysis/input/hrs_construp_yrly.dta,replace
restore
