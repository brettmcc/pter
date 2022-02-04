/*This program looks at changes in hours constraints over the business cycle in the HRS, 
using the BLS condition of <35 hours per week
Brett McCully, June 2015*/

  set more off
  set graphics off
clear all


//wave is year variable

/*Numbers*/
*moregap, no zeros
use "${dir}\build\output\hrsdata.dta",clear
keep if headhourweekly<35 
collapse (mean) mean_moregap=moregap (semean) se_moregap=moregap (sd) sd_moregap=moregap [fweight=wgt] if moregap!=0, by(wave)
gen lw = mean_moregap - se_moregap
gen hi = mean_moregap + se_moregap
twoway connected mean_moregap wave, title("Hours Gap, Ideal and Actual") note("Conditional on gap being nonzero.") ytitle("hours/year") name(moregap_nozero,replace) 

*moregap, with zeros
use "${dir}\build\output\hrsdata.dta",clear
keep if headhourweekly<35 
collapse (mean) mean_moregap=moregap (semean) se_moregap=moregap [fweight=wgt], by(wave)
gen lw = mean_moregap - se_moregap
gen hi = mean_moregap + se_moregap
twoway connected mean_moregap wave, title("Hours Gap, Ideal and Actual") note("Unconditional.") ytitle("hours/year") ///
	name(moregap_withzeros,replace) 

*Number underemployed
use "${dir}\build\output\hrsdata.dta",clear
collapse (sum) construp35 [iweight=wgt], by(wave)
replace construp35 = construp35 / 1000000
twoway line (construp35 wave), title("Number underemployed") ytitle("Millions of persons") name(num_construp,replace)

/*Proportion*/
use "${dir}\build\output\hrsdata.dta",clear

collapse (sum) construp35 (count) headstatus [iweight=wgt], by(wave)
gen prop_pter = construp35/headstatus
twoway line (prop_pter wave), title("Percent underemployed") ytitle("Percent") name(pct_construp,replace) note(Denominator is all employed persons)

graph combine moregap_nozero moregap_withzeros num_construp pct_construp, name(moregap_lt35,replace) ///
	title("Underemployed Workers - Working <35 hours/week (HRS)") note(Source: HRS. All figures weighted.)
graph export ../../output/moregap_lt35.ps, name(moregap_lt35) replace orientation(landscape) mag(200) tmargin(.1) lmargin(.1)
!ps2pdf ../../output/moregap_lt35.ps ../../output/moregap_lt35.pdf
