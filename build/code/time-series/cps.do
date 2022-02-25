/*Calculate PTER series over time*/

import delimited "${dir}\build\input\CPS-ATUS\cps_asec62-77.csv",clear
save "${dir}\build\temp\cps_asec62-77.dta",replace

import delimited "${dir}\build\input\CPS-ATUS\cps_00008",clear

append using "${dir}\build\temp\cps_asec62-77.dta"

//keep only those working
keep if labforce==2
// drop if uhrsworkt==999
// //keep those between age 22 and 65
// keep if age>=22 & age<=65
// //drop self-employed
// drop if classwkr>=10 & classwkr<=14

//defintion comes from pages 7-8 of 
//https://www.richmondfed.org/-/media/richmondfedorg/publications/research/economic_quarterly/2014/q2/kudlyak.pdf
gen pter = (inlist(whyptlwk,60,10,50,51,52)==1 & year<1994) | (inlist(whyptlwk,60,10,50,51,52,20)==1 & year>=1994)

gen yearmonth = ym(year,month)
format yearmonth %tm

save "${dir}\build\output\cps_pter.dta",replace

use "${dir}\build\output\cps_pter.dta",clear
collapse (mean) pter [aweight=wtfinl], by(year) 
replace pter = . if year==1994
line pter year

use "${dir}\build\output\cps_pter.dta",clear
keep if age>=25 & age<=65
keep if pernum==1 //presumably head of household
collapse (mean) pter [aweight=wtfinl], by(year) 
replace pter = . if year==1994
line pter year

