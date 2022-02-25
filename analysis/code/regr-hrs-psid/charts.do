global buildout "C:\Users\bmccully\Documents\pter-master\build\output"
global charts "C:\Users\bmccully\Documents\pter-master\analysis\output\charts\"

/*Create charts for FEDS note and paper*/
set more off
//set graphics off
clear all

*compare PSID to CPS PTER measure
use "build\output/psid_construp35_yrly.dta",clear
merge 1:1 year using "build\output\bls_pter_yearly.dta"
keep if _merge==3
drop _merge
label var propPter_cps "BLS PTER"
label var prop_underemp_lt35_psid "PSID"
corr propPter_cps prop_underemp_lt35_psid
twoway (connected propPter_cps prop_underemp_lt35_psid year,lpattern(solid dash) lcolor(blue red) msymbol(oh dh)), title("Part Time for Economic Reasons by Data Source") graphregion(color(white)) bgcolor(white) xtitle(" ") 
graph export "analysis\output\charts\psid_pter.png",replace
	
*compare part-time vs full-time measure from PSID
use "build\output/psid_construp35_yrly.dta",clear
merge 1:1 year using "build\output\psid_construp_ft_yrly.dta"
drop _merge
label var prop_underemp_lt35_psid "Part time"
label var prop_underemp_ft_psid "Full time"
corr prop_underemp_lt35_psid prop_underemp_ft_psid
twoway (connected prop_underemp_lt35_psid prop_underemp_ft_psid year,lpattern(dash dash_dot) lcolor(blue dknavy) msymbol(dh Dh)), graphregion(color(white)) bgcolor(white)
graph export "analysis\output\charts\psid_pt_vs_ft.png",replace

*compare PSID & HRS to CPS, using expansive underemployment measure
use "build\output\combined_yrly_series.dta",clear
twoway (connected prop_pter_cps year,msymbol(oh) color(forest_green)) ///
	(connected prop_pter_hrs year,lpattern(dash) msymbol(Dh) color(blue)) ///
	(connected prop_underemp_psid year,lpattern(shortdash) msymbol(Th) color(cranberry)), ///
	graphregion(color(white)) bgcolor(white) legend(order(1 "CPS PTER" 2 "HRS" 3 "PSID") region(lwidth(none) color(white)))
graph export "analysis\output\charts\pter_vs_expansive_measure.png",replace

*compare CPS PTER with HRS & PSID PTER
twoway (connected prop_pter_cps year,msymbol(oh) color(forest_green)) ///
	(connected prop_pterlt35_hrs year,lpattern(dash_dot) msymbol(dh) color(navy)) ///
	(connected prop_underemp_lt35_psid year,lpattern(shortdash_dot) msymbol(th) color(red)), ///
	graphregion(color(white)) bgcolor(white) legend(order(1 "CPS PTER" 2 "HRS" 3 "PSID") region(lwidth(none) color(white)))
graph export "analysis\output\charts\pter_validation.png",replace


*plot difference between desired and actual hours worked from HRS
use "build\output\hrsdata.dta",clear
collapse (sum) sum_moregap=moregap (mean) mean_moregap=moregap (semean) se_moregap=moregap (sd) sd_moregap=moregap [fweight=wgt], by(wave)
replace sum_moregap=sum_moregap/1000000
label variable sum_moregap "Additional hours desired (millions)"
format sum_moregap %15.0gc
twoway connected sum_moregap wave, xtitle(" ") graphregion(color(white)) bgcolor(white)
graph export "analysis\output\charts\addl_hours_desired_hrs.png",replace


*Proportion of underemployed by hours bins and share underemployed by hours bin.
//HRS
use "analysis\input\hrsdata.dta",clear
drop if headhours_bin==""
collapse (mean) construp (sum) num_construp=construp [aweight=wgt],by(headhours_bin)
egen total_underemp = total(num_construp)
gen share_construp_by_hours = num_construp/total_underemp
label variable share_construp_by_hours /*
	*/"Share of underemployed in each hours bin"
graph bar share_construp_by_hours,over(headhours_bin) /*
	*/b1title(Hours per week) graphregion(color(white)) bgcolor(white) /*
	*/ ytitle(" ")
graph export "analysis\output\charts\share_of_underemployed_by_hours_hrs.png",/*
	*/replace
	
//PSID
use "analysis\input\pooled_all.dta",clear
drop if headhours_bin==""
collapse (mean) construp (sum) num_construp=construp [aweight=wgt],by(headhours_bin)
egen total_underemp = total(num_construp)
gen share_construp_by_hours = num_construp/total_underemp
label variable share_construp_by_hours /*
	*/"Share of underemployed in each hours bin"
graph bar share_construp_by_hours,over(headhours_bin) /*
	*/b1title(Hours per week) graphregion(color(white)) bgcolor(white) /*
	*/ ytitle(" ")
graph export "analysis\output\charts\share_of_underemployed_by_hours_psid.png",/*
	*/replace
	
	
/* Industry and Occupation Effects on Hours Constraints */
//ind
use "analysis\input\pooled_all.dta",clear
graph bar (mean) construp if headind!=0, over(headind, /*
	*/label(angle(70)) sort((mean) construp)) name(construp_ind,replace) graphregion(color(white)) bgcolor(white) ytitle("Fraction Upside Constrained")
graph export "analysis\output\charts\construp_ind.png",replace 
//occ
use "analysis\input\pooled_all.dta",clear
graph bar (mean) construp if headocc!=0, over(headocc, /*
	*/label(angle(70)) sort((mean) construp)) graphregion(color(white)) bgcolor(white) ytitle("Fraction Upside Constrained")
graph export "analysis\output\charts\construp_occ.png",replace 


*plot underemployed proportion for all ages & ages 50-70 those working <=35 hours/week, in the PSID. Calculate the correlation.
use "$buildout/psid_construp35_yrly.dta",clear
merge 1:1 year using ../../build/output/psid_construp35_age50to70_yrly.dta,nogen
twoway line (prop_underemp_lt35_psid prop_underemp_50to70_psid year), name(psid_construp35_oldvsall,replace) title(PSID) note(<35 hours/week)
corr prop_underemp_lt35_psid prop_underemp_50to70_psid

*plot underemployed proportion for all ages part-time (<35 hours per week) vs. everyone, in the PSID. Calculate the correlation.
use "$buildout/psid_construp35_yrly.dta",clear
merge 1:1 year using $buildout/psid_construp_yrly.dta,nogen
label var prop_underemp_lt35 "Part-time"
label var prop_underemp_psid "Full-time"
twoway line (prop_underemp_lt35 prop_underemp_psid year), name(psid_construp35vsall,replace) title(PSID - Part vs Full Time)
corr prop_underemp_lt35 prop_underemp_psid

*plot those age 50-70 in the PSID, HRS, and BLS, <35 hours/week
import delimited /href/research3/m1bam03/homeProdHourConstraints/build/input/bls_pter.csv,clear
keep if year>=1967 & year<=2015
rename proppter proppter_bls
rename proppter55plusnonagr proppter55plusnonagr_bls
merge 1:1 year using ../../build/output/psid_construp35_yrly, nogen
merge 1:1 year using ../input/hrs_construp35_yrly, nogen
label var proppter_bls "BLS, all"
label var proppter55plusnonagr_bls "BLS, 55+, non-agr"
twoway line (prop_pterlt35_hrs prop_underemp_lt35_psid proppter_bls proppter55plusnonagr_bls year), name(all,replace) title(Proportion PTER) note(<35 hours/week)
corr proppter_bls prop_pterlt35_hrs
corr prop_underemp_lt35_psid proppter_bls

*plot PSID & HRS Baseline & BLS
import delimited /href/research3/m1bam03/homeProdHourConstraints/build/input/bls_pter.csv,clear
keep if year>=1967 & year<=2015
rename proppter proppter_bls
rename proppter55plusnonagr proppter55plusnonagr_bls
merge 1:1 year using ../../build/output/psid_construp_yrly, nogen
merge 1:1 year using ../input/hrs_construp_yrly, nogen
label var proppter_bls "BLS, all"
twoway line (prop_pter_hrs prop_underemp_psid proppter55plusnonagr_bls proppter_bls year), name(baseline,replace) title(baseline)


*plot salaried & hourly on the same figure and correlation
use "../../build/output/pooled.dta",clear
keep if year>1968
collapse (sum) headhourly headsalary (count) headstatus if headstatus==1 [iweight=wgt], by(year)
gen pct_waged = headhourly / headstatus
gen pct_salary = headsalary / headstatus
label var headhourly "hourly"
label var headsalary "salaried"
twoway line (headhourly headsalary year), name(num,replace) title(Number of Workers by Type in the PSID)

*combine all
graph combine psid_construp35vsall psid_construp35_oldvsall all baseline, name(notecharts,replace)
graph export ../temp/charts.ps, name(notecharts) replace tmargin(.1) lmargin(.1) mag(200) orientation(landscape)

!ps2pdf ../temp/charts.ps ../output/charts.pdf
