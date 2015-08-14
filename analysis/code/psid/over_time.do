/*This program looks at changes in hours constraints over the business cycle in the PSID
Brett McCully, June 2015*/

cd /href/research3/m1bam03/homeProdHourConstraints/analysis/code/psid

clear all
set more off
set graphics off



program ovrtime
args cond ttl cond2
	use "../../../build/output/pooled.dta",clear

	gen all = 1

	keep if `cond'==1
	`cond2'

	preserve
	collapse (sum) construp headstatus if headstatus==1 [iweight=wgt], by(year)
	gen prop_underemp = construp/headstatus

	twoway line (construp year), name(num_underemp,replace) title(Number underemployed) xtitle()
	twoway line (prop_underemp year), name(prop_underemp,replace) title(Proportion underemployed) xtitle()
	restore

	preserve
	collapse (sum) construp35 headstatus if headstatus==1 [iweight=wgt], by(year)
	gen prop_underemp = construp35/headstatus

	twoway line (construp35 year), name(num_underemp_lt35,replace) title(Number underemployed) ///
		note(<35 hours per week to be considered PTER) xtitle()
	twoway line (prop_underemp year), name(prop_underemp_lt35,replace) title(Proportion underemployed) ///
		note(<35 hours per week to be considered PTER) xtitle()
	restore 


	graph combine num_underemp prop_underemp num_underemp_lt35 prop_underemp_lt35, title(Underemployed `ttl' Workers (PSID)) ///
		note(Source: PSID. All figures weighted.) name(underemp_psid,replace)
	graph export ../../temp/psid_underemp_`ttl'.ps, name(underemp_psid) replace orientation(landscape) mag(200) ///
		tmargin(.1) lmargin(.1)
end

*entire sample
ovrtime all All

*salaried workers
ovrtime headsalary Salaried
*hourly workers
ovrtime headhourly Hourly

/*calculate for HRS age group*/
*entire sample
ovrtime all "All_age50-70" "keep if headage>=50 & headage<70"

*salaried workers
ovrtime headsalary "Salaried_aged50-70" "keep if headage>=50 & headage<70"
*hourly workers
ovrtime headhourly "Hourly_aged50-70" "keep if headage>=50 & headage<70"

!cat ../../temp/psid_underemp_*.ps > ../../temp/psid_underemp.ps
!ps2pdf ../../temp/psid_underemp.ps ../../output/psid_underemp.pdf
