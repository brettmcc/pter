/*Calculate fraction of underemployed who work less than 35 hours in a week
Brett McCully, June 2015*/
cd "/href/research3/m1bam03/homeProdHourConstraints/analysis/code/"

  set more off
  set graphics off
clear all

*PSID
use "../../build/output/pooled.dta",clear

keep if construp==1

collapse (sum) construp lt35hrs [iweight=wgt], by(year)
gen pct_underemp_lt35hrs = lt35hrs/construp

twoway line (pct_underemp year), title(PSID) name(psid_pctlt35,replace)


*HRS
use ../input/hrsdata.dta,clear

keep if construp==1

collapse (sum) construp lt35hrs [fweight=wgt], by(wave)
gen pct_underemp_lt35hrs = lt35hrs/construp

twoway line (pct_underemp wave), title(HRS) name(hrs_pctlt35,replace)


*combine
graph combine psid_pctlt35 hrs_pctlt35, title(Percent of Underemployed Working <35 Hours) name(pctlt35,replace)
graph export ../output/pctlt35.ps, name(pctlt35) replace orientation(landscape) mag(200) tmargin(.1) lmargin(.1)
!ps2pdf ../output/pctlt35.ps ../output/pctlt35.pdf
