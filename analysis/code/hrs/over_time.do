/*This program looks at changes in hours constraints over the business cycle
Brett McCully, June 2015*/
  set more off
clear all

use ../../input/hrsdata.dta,clear

//wave is year variable

*moregap, no zeros
preserve 
collapse (mean) mean_moregap=moregap [iweight=wgt] if moregap!=0, by(wave)
twoway line (mean_moregap wave), title("Conditional on gap being nonzero") ytitle("hours/year") ///
	name(moregap_nozero,replace) 
restore
preserve 
collapse (mean) mean_moregap=moregap (sd) sd_moregap=moregap [iweight=wgt] if moregap!=0, by(wave)
gen lw = mean_moregap - sd_moregap
gen up = mean_moregap + sd_moregap
twoway (line up lw mean_moregap wave), ytitle("hours/year") legend(off) ///
	name(moregap_sd_nozero,replace) title("Conditional on gap being nonzero") subtitle("With Standard Deviation lines")
restore

*moregap, with zeros
preserve 
collapse (mean) mean_moregap=moregap [iweight=wgt] , by(wave)
twoway line (mean_moregap wave), title("Unconditional") ytitle("hours/year") ///
	name(moregap_withzeros,replace) 
restore
preserve
collapse (mean) mean_moregap=moregap (sd) sd_moregap=moregap [iweight=wgt], by(wave)
gen lw = mean_moregap - sd_moregap
gen up = mean_moregap + sd_moregap
twoway (line up lw mean_moregap wave), ytitle("hours/year") legend(off) ///
	name(moregap_sd_withzeros,replace) title("Unconditional") subtitle("With Standard Deviation lines")
restore

graph combine moregap_nozero moregap_sd_nozero moregap_withzeros moregap_sd_withzeros, name(moregap,replace) title("Underemployed Workers (HRS)" "Gap Between Actual and Ideal Hours")
graph export ../../output/moregap.ps, name(moregap) replace

