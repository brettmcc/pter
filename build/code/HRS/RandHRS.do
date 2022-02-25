*make a few adjustments to dataset after SAS program
//Brett McCully, June 2015

clear all
set more off

use "build\output\hrsdata.dta",clear

bys wave: quantiles Faminc, gen(decile_faminc) n(10)
gen partime = (headhourweekly<=35 & headhourweekly>0 & headstatus==1)

gen foodoutratio = foodout/(foodout+foodhm)*100
label variable construp "Upside constrained"
label variable constrdown "Downside constrained"

*hours bin variable
gen headhours_bin = ""
replace headhours_bin = "0-35" if headhourweekly>0 & headhourweekly<35
replace headhours_bin = "35-40" if headhourweekly>=35 & headhourweekly<40
replace headhours_bin = "40-45" if headhourweekly>=40 & headhourweekly<45
replace headhours_bin = "45-50" if headhourweekly>=45 & headhourweekly<50
replace headhours_bin = "50-55" if headhourweekly>=50 & headhourweekly<55
replace headhours_bin = "55-60" if headhourweekly>=55 & headhourweekly<60
replace headhours_bin = "60-65" if headhourweekly>=60 & headhourweekly<65
replace headhours_bin = "65-70" if headhourweekly>=65 & headhourweekly<70
replace headhours_bin = "70-75" if headhourweekly>=70 & headhourweekly<75
replace headhours_bin = "75-80" if headhourweekly>=75 & headhourweekly<=80

keep if headwork==1
keep if headage>=22 & headage<65
keep if headselfemp==0

save "analysis\input\hrsdata.dta",replace

/*output time series datasets*/
*underemployed and part time
use "build\output\hrsdata.dta",clear
collapse (sum) construp35 (count) headstatus [iweight=wgt], by(wave)
rename wave year
gen prop_pterlt35_hrs = construp35/headstatus
label var prop_pterlt35_hrs "HRS"
save "${dir}/analysis/input/hrs_construp35_yrly.dta",replace


*underemployed, full and part time
use "build\output\hrsdata.dta",clear
collapse (sum) construp (count) headstatus [iweight=wgt], by(wave)
rename wave year
gen prop_pter_hrs = construp/headstatus
save "${dir}/analysis/input/hrs_construp_yrly.dta",replace

