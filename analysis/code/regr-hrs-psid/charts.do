global buildout "C:\Users\bmccully\Documents\pter-master\build\output"
global charts "C:\Users\bmccully\Documents\pter-master\analysis\output\charts\"

/*Create charts for FEDS note and paper*/
set more off
//set graphics off
clear all

*compare PSID to CPS PTER measure
use "${dir}\build\output/psid_construp35_yrly.dta",clear
merge 1:1 year using "${dir}\build\output\bls_pter_yearly.dta"
keep if _merge==3
drop _merge
label var propPter_cps "BLS PTER"
label var prop_underemp_lt35_psid "PSID"
corr propPter_cps prop_underemp_lt35_psid
twoway (connected propPter_cps prop_underemp_lt35_psid year,lpattern(solid dash) lcolor(blue red) msymbol(oh dh)), title("Part Time for Economic Reasons by Data Source") graphregion(color(white)) bgcolor(white) xtitle(" ") 
graph export "${dir}\analysis\output\charts\psid_pter.png",replace
	
*compare part-time vs full-time measure from PSID
use "${dir}\build\output/psid_construp35_yrly.dta",clear
merge 1:1 year using "${dir}\build\output\psid_construp_ft_yrly.dta"
drop _merge
label var prop_underemp_lt35_psid "Part time"
label var prop_underemp_ft_psid "Full time"
corr prop_underemp_lt35_psid prop_underemp_ft_psid
twoway (connected prop_underemp_lt35_psid prop_underemp_ft_psid year,lpattern(dash dash_dot) lcolor(blue dknavy) msymbol(dh Dh)), graphregion(color(white)) bgcolor(white)
graph export "${dir}\analysis\output\charts\psid_pt_vs_ft.png",replace

*compare PSID to CPS, using expansive underemployment measure

*Proportion of underemployed by hours bins and share underemployed by hours bin.
use "${dir}\analysis\input\pooled_all.dta",clear
drop if headhours_bin==""

collapse (mean) construp [aweight=wgt],by(headhours_bin)
graph bar construp ,over(headhours_bin) ytitle("") /*
	*/b1title(Hours per week) graphregion(color(white)) bgcolor(white)
graph export "${dir}\analysis\output\charts\fraction_underemployed_by_hours.png",/*
	*/replace

use "${dir}\analysis\input\pooled_all.dta",clear
drop if headhours_bin==""

egen total_underemp = total(construp*wgt)
bysort headhours_bin: egen underemp_byhours = total(construp*wgt)
contract total_underemp underemp_byhours headhours_bin

gen share_construp_by_hours = underemp_byhours/total_underemp
label variable share_construp_by_hours /*
	*/"Share of underemployed in each hours bin"

graph bar share_construp_by_hours,over(headhours_bin) /*
	*/b1title(Hours per week) graphregion(color(white)) bgcolor(white) /*
	*/ ytitle(" ")
graph export "${dir}\analysis\output\charts\share_of_underemployed_by_hours.png",/*
	*/replace
	
/* Industry and Occupation Effects on Hours Constraints */
use "${dir}\analysis\input\pooled.dta",clear
graph bar (mean) construp if headind!=0, over(headind, /*
	*/label(angle(70)) sort((mean) construp)) name(construp_ind,replace) graphregion(color(white)) bgcolor(white) ytitle("Fraction Upside Constrained")
graph export "${dir}\analysis\output\charts\construp_ind.png",replace 



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
