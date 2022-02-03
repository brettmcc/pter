global input "C:\Users\bmccully\Documents\pter-master\build\input"

import delimited $input\cps_00003,clear

/*Calculate PTER series over time*/
preserve
import delimited $input\cps_asec62-77,clear
tempfile tmp
save "`tmp'"
restore

append using "`tmp'"

//keep only those in the labor force
keep if labforce==2

//defintion comes from pages 7-8 of 
//https://www.richmondfed.org/-/media/richmondfedorg/publications/research/economic_quarterly/2014/q2/kudlyak.pdf
gen pter = ((inlist(whyptlwk,60,10,50,51,52)==1 & year<1994) | /*
	*/(inlist(whyptlwk,60,10,50,51,52,20)==1 & year>=1994)

gen yearmonth = ym(year,month)
format yearmonth %tm

preserve
collapse (mean) pter [aweight=wtfinl], by(year) 
replace pter = . if year==1994
line pter year
restore

preserve
keep if age>=25 & age<=65
keep if pernum==1 //presumably head of household
collapse (mean) pter [aweight=wtfinl], by(year) 
replace pter = . if year==1994
line pter year
restore

