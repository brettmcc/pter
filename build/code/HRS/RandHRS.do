*make a few adjustments to dataset after SAS program
//Brett McCully, June 2015

clear all
set more off

use "${dir}\build\output\hrsdata.dta",clear

label define status 1 "works FT" 2 "works PT" 3 "unemployed" 4 "partly retired"
label values headstatus status

gen headhourweekly = headhour/52

gen lt35hrs = (headhourweekly<35)
gen construp35 = (lt35hrs == 1 & construp==1)

save ../../analysis/input/hrsdata.dta,replace

/*output time series datasets*/
*underemployed and part time
use "${dir}\build\output\hrsdata.dta",clear
collapse (sum) construp35 (count) headstatus [iweight=wgt], by(wave)
rename wave year
gen prop_pterlt35_hrs = construp35/headstatus
label var prop_pterlt35_hrs "HRS"
save ../../analysis/input/hrs_construp35_yrly.dta,replace


*underemployed, full and part time
use "${dir}\build\output\hrsdata.dta",clear
collapse (sum) construp (count) headstatus [iweight=wgt], by(wave)
rename wave year
gen prop_pter_hrs = construp/headstatus
save ../../analysis/input/hrs_construp_yrly.dta,replace

