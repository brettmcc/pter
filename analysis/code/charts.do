cd /href/research3/m1bam03/homeProdHourConstraints/analysis/code/

/*Create charts for FEDS note and paper*/
set more off
set graphics off
clear all

*plot underemployed proportion for all ages & ages 50-70 those working <=35 hours/week, in the PSID. Calculate the correlation.
use "../../build/output/psid_construp35_yrly.dta",clear
merge 1:1 year using ../../build/output/psid_construp35_age50to70_yrly.dta,nogen
twoway line (prop_underemp_lt35_psid prop_underemp_50to70_psid year), name(psid_construp35_oldvsall,replace) title(PSID) note(<35 hours/week)
corr prop_underemp_lt35_psid prop_underemp_50to70_psid

*plot underemployed proportion for all ages part-time (<35 hours per week) vs. everyone, in the PSID. Calculate the correlation.
use ../../build/output/psid_construp35_yrly.dta,clear
merge 1:1 year using ../../build/output/psid_construp_yrly.dta,nogen
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
