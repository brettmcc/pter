/*This program charts the share and number of hourly waged and salaried workers in the PSID
Brett McCully, July 2015*/

cd /href/research3/m1bam03/homeProdHourConstraints/analysis/code/psid

clear all
set more off
set graphics off

use "../../../build/output/pooled.dta",clear
keep if year>1968

collapse (sum) headhourly headsalary (count) headstatus if headstatus==1 [iweight=wgt], by(year)
gen pct_waged = headhourly / headstatus
gen pct_salary = headsalary / headstatus

twoway line (headhourly headsalary year), name(num,replace) title(Number)
twoway line (pct_waged pct_salary year), name(pct,replace) title(Share)

graph combine num pct, title(Number and Share Hourly-wage and Salaried) note(Source: PSID. All figures weighted.) name(num_shr,replace)
graph export ../../temp/share_hourly_salary.ps, name(num_shr) replace orientation(landscape) mag(200) tmargin(.1) lmargin(.1)
!ps2pdf ../../temp/share_hourly_salary.ps ../../output/share_hourly_salary.pdf
