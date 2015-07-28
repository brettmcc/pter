*make a few adjustments to dataset after SAS program
//Brett McCully, June 2015

cd /href/research3/m1bam03/homeProdHourConstraints/build/code/

clear all
set more off

use ../../analysis/input/hrsdata.dta,clear

label define status 1 "works FT" 2 "works PT" 3 "unemployed" 4 "partly retired"
label values headstatus status

gen headhourweekly = headhour/52

gen lt35hrs = (headhourweekly<35)
gen construp35 = (lt35hrs == 1 & construp==1)

save ../../analysis/input/hrsdata.dta,replace
