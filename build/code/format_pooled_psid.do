clear all
set more off

use "../output/pooled.dta",clear


label define empstat 1 "Employed" 2 "Temporarily laid off" 3 "Looking for work, unemployed"
label values headstatus empstat

gen headhourweekly = headhour/52

save "../output/pooled.dta",replace
