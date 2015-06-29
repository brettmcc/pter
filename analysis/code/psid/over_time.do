/*This program looks at changes in hours constraints over the business cycle in the PSID
Brett McCully, June 2015*/

cd /href/research3/m1bam03/homeProdHourConstraints/analysis/code/psid

clear all
set more off
set graphics off



program ovrtime
args cond ttl
	use "../../../build/output/pooled.dta",clear

	gen all = 1

	keep if `cond'==1

	preserve
	collapse (sum) construp headstatus if headstatus==1 [iweight=wgt], by(year)
	gen prop_underemp = construp/headstatus

	twoway line (construp year), name(num_underemp,replace) title(Number underemployed) xtitle()
	twoway line (prop_underemp year), name(prop_underemp,replace) title(Proportion underemployed) xtitle()
	restore

	preserve
	replace construp = . if headhourweekly<35
	collapse (sum) construp headstatus if headstatus==1 [iweight=wgt], by(year)
	gen prop_underemp = construp/headstatus

	twoway line (construp year), name(num_underemp_lt35,replace) title(Number underemployed) ///
		note(<35 hours per week to be considered PTER) xtitle()
	twoway line (prop_underemp year), name(prop_underemp_lt35,replace) title(Proportion underemployed) ///
		note(<35 hours per week to be considered PTER) xtitle()
	restore 


	graph combine num_underemp prop_underemp num_underemp_lt35 prop_underemp_lt35, title(Underemployed `ttl' Workers (PSID)) ///
		note(Source: PSID. All figures weighted.) name(underemp_psid,replace)
	graph export ../../output/psid_underemp_`ttl'.ps, name(underemp_psid) replace orientation(landscape) mag(200) ///
		tmargin(.1) lmargin(.1)
	!ps2pdf ../../output/psid_underemp_`ttl'.ps ../../output/psid_underemp_`ttl'.pdf
end

*entire sample
ovrtime all All

*salaried workers
ovrtime headsalary Salaried
*hourly workers
ovrtime headhourly Hourly
