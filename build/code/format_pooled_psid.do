clear all
set more off

cd "/href/research3/m1bam03/homeProdHourConstraints/build/code/"
!st ../output/pooled.sas7bdat ../output/pooled.dta -y

use "../output/pooled.dta",clear


label define empstat 1 "Employed" 2 "Temporarily laid off" 3 "Looking for work, unemployed"
label values headstatus empstat

gen headhourweekly = headhour/52

gen lt35hrs = (headhourweekly<35)
gen construp35 = (lt35hrs == 1 & construp==1)

save "../output/pooled.dta",replace
