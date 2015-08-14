/*This program looks at changes in hours constraints over the business cycle in the HRS
Brett McCully, June 2015*/
cd "/href/research3/m1bam03/homeProdHourConstraints/analysis/code/hrs"

  set more off
  set graphics off
clear all

use ../../input/hrsdata.dta,clear

//wave is year variable

/*Numbers*/
*moregap, no zeros
preserve 
collapse (mean) mean_moregap=moregap (semean) se_moregap=moregap [fweight=wgt] if moregap!=0, by(wave)
gen lw = mean_moregap - se_moregap
gen hi = mean_moregap + se_moregap
twoway rarea lw hi wave, title("Hours Gap, Ideal and Actual") note("Conditional on gap being nonzero; SE bands charted") ///
	ytitle("hours/year") name(moregap_nozero,replace) 
restore

*moregap, with zeros
preserve 
collapse (mean) mean_moregap=moregap (semean) se_moregap=moregap [fweight=wgt], by(wave)
gen lw = mean_moregap - se_moregap
gen hi = mean_moregap + se_moregap
twoway rarea lw hi wave, title("Hours Gap, Ideal and Actual") note("Unconditional; SE bands charted") ytitle("hours/year") ///
	name(moregap_withzeros,replace) 
restore

*Number underemployed
preserve
collapse (sum) construp [iweight=wgt], by(wave)
replace construp = construp / 1000000
twoway line (construp wave), title("Number underemployed") ytitle("Millions of persons") name(num_construp,replace)
restore

/*Proportion*/
preserve
collapse (sum) construp (count) headstatus [iweight=wgt], by(wave)
gen prop_pter = construp/headstatus
twoway line (prop_pter wave), title("Percent underemployed") ytitle("Percent") name(pct_construp,replace) note(Denominator is all employed persons)
restore

graph combine moregap_nozero moregap_withzeros num_construp pct_construp, name(moregap,replace) ///
	title("Underemployed Workers (HRS)") note(Source: HRS. All figures weighted.)
graph export ../../output/moregap.ps, name(moregap) replace orientation(landscape) mag(200) tmargin(.1) lmargin(.1)
!ps2pdf ../../output/moregap.ps ../../output/moregap.pdf
