*Replicating figure IIa from Quach 2021
*2022.01.29


global build "C:\Users\39328\Dropbox\Hours constraints and home prod\build"

global analysis "C:\Users\39328\Dropbox\Hours constraints and home prod\analysis"

cd "$build\output"

clear all

use clean_ipums_cpsatus

*Analysis using CPS-based weekly base pay and ATUS-based weekly base pay

rename year_cps year_cps8
rename month_cps month_cps8

label define timelab 0 "April 2016" 1 "December 2016"

global survey "_atus _cps8"

foreach survey in $survey{
	
*Generating time variables starting from April and December 2016 and then progressively adding one month period on each side

gen time1`survey' = .

replace time1`survey' = 0 if year`survey' == 2016 & month`survey' == 4 
replace time1`survey' = 1 if year`survey' == 2016 & month`survey' == 12 

label values time1`survey' timelab

gen time2`survey' = .

replace time2`survey' = 0 if year`survey' == 2016 & month`survey' == 4 | year`survey' == 2016 & month`survey' == 3
replace time2`survey' = 1 if year`survey' == 2016 & month`survey' == 12 | year`survey' == 2017 & month`survey' == 1

gen time3`survey' = .

replace time3`survey' = 0 if year`survey' == 2016 & month`survey' == 4 | year`survey' == 2016 & month`survey' == 3 | year`survey' == 2016 & month`survey' == 2
replace time3`survey' = 1 if year`survey' == 2016 & month`survey' == 12 | year`survey' == 2017 & month`survey' == 1 | year`survey' == 2017 & month`survey' == 2

gen time4`survey' = .

replace time4`survey' = 0 if year`survey' == 2016 & month`survey' == 4 | year`survey' == 2016 & month`survey' == 3 | year`survey' == 2016 & month`survey' == 2 | year`survey' == 2016 & month`survey' == 1
replace time4`survey' = 1 if year`survey' == 2016 & month`survey' == 12 | year`survey' == 2017 & month`survey' == 1 | year`survey' == 2017 & month`survey' == 2 | year`survey' == 2017 & month`survey' == 3

gen time5`survey' = .

replace time5`survey' = 0 if year`survey' == 2016 & month`survey' == 4 | year`survey' == 2016 & month`survey' == 3 | year`survey' == 2016 & month`survey' == 2 | year`survey' == 2016 & month`survey' == 1 | year`survey' == 2015 & month`survey' == 12
replace time5`survey' = 1 if year`survey' == 2016 & month`survey' == 12 | year`survey' == 2017 & month`survey' == 1 | year`survey' == 2017 & month`survey' == 2 | year`survey' == 2017 & month`survey' == 3 | year`survey' == 2017 & month`survey' == 4

gen time6`survey' = .

replace time6`survey' = 0 if year`survey' == 2016 & month`survey' == 4 | year`survey' == 2016 & month`survey' == 3 | year`survey' == 2016 & month`survey' == 2 | year`survey' == 2016 & month`survey' == 1 | year`survey' == 2015 & month`survey' == 12 | year`survey' == 2015 & month`survey' == 11
replace time6`survey' = 1 if year`survey' == 2016 & month`survey' == 12 | year`survey' == 2017 & month`survey' == 1 | year`survey' == 2017 & month`survey' == 2 | year`survey' == 2017 & month`survey' == 3 | year`survey' == 2017 & month`survey' == 4 | year`survey' == 2017 & month`survey' == 5

gen time7`survey' = .

replace time7`survey' = 0 if year`survey' == 2016 & month`survey' == 4 | year`survey' == 2016 & month`survey' == 3 | year`survey' == 2016 & month`survey' == 2 | year`survey' == 2016 & month`survey' == 1 | year`survey' == 2015 & month`survey' == 12 | year`survey' == 2015 & month`survey' == 11 | year`survey' == 2015 & month`survey' == 10
replace time7`survey' = 1 if year`survey' == 2016 & month`survey' == 12 | year`survey' == 2017 & month`survey' == 1 | year`survey' == 2017 & month`survey' == 2 | year`survey' == 2017 & month`survey' == 3 | year`survey' == 2017 & month`survey' == 4 | year`survey' == 2017 & month`survey' == 5 | year`survey' == 2017 & month`survey' == 6

gen time8`survey' = .

replace time8`survey' = 0 if year`survey' == 2016 & month`survey' == 4 | year`survey' == 2016 & month`survey' == 3 | year`survey' == 2016 & month`survey' == 2 | year`survey' == 2016 & month`survey' == 1 | year`survey' == 2015 & month`survey' == 12 | year`survey' == 2015 & month`survey' == 11 | year`survey' == 2015 & month`survey' == 10 | year`survey' == 2015 & month`survey' == 9
replace time8`survey' = 1 if year`survey' == 2016 & month`survey' == 12 | year`survey' == 2017 & month`survey' == 1 | year`survey' == 2017 & month`survey' == 2 | year`survey' == 2017 & month`survey' == 3 | year`survey' == 2017 & month`survey' == 4 | year`survey' == 2017 & month`survey' == 5 | year`survey' == 2017 & month`survey' == 6 | year`survey' == 2017 & month`survey' == 7

gen time9`survey' = .

replace time9`survey' = 0 if year`survey' == 2016 & month`survey' == 4 | year`survey' == 2016 & month`survey' == 3 | year`survey' == 2016 & month`survey' == 2 | year`survey' == 2016 & month`survey' == 1 | year`survey' == 2015 & month`survey' == 12 | year`survey' == 2015 & month`survey' == 11 | year`survey' == 2015 & month`survey' == 10 | year`survey' == 2015 & month`survey' == 9 | year`survey' == 2015 & month`survey' == 8
replace time9`survey' = 1 if year`survey' == 2016 & month`survey' == 12 | year`survey' == 2017 & month`survey' == 1 | year`survey' == 2017 & month`survey' == 2 | year`survey' == 2017 & month`survey' == 3 | year`survey' == 2017 & month`survey' == 4 | year`survey' == 2017 & month`survey' == 5 | year`survey' == 2017 & month`survey' == 6 | year`survey' == 2017 & month`survey' == 7 | year`survey' == 2017 & month`survey' == 8

gen time10`survey' = .

replace time10`survey' = 0 if year`survey' == 2016 & month`survey' == 4 | year`survey' == 2016 & month`survey' == 3 | year`survey' == 2016 & month`survey' == 2 | year`survey' == 2016 & month`survey' == 1 | year`survey' == 2015 & month`survey' == 12 | year`survey' == 2015 & month`survey' == 11 | year`survey' == 2015 & month`survey' == 10 | year`survey' == 2015 & month`survey' == 9 | year`survey' == 2015 & month`survey' == 8 | year`survey' == 2015 & month`survey' == 7
replace time10`survey' = 1 if year`survey' == 2016 & month`survey' == 12 | year`survey' == 2017 & month`survey' == 1 | year`survey' == 2017 & month`survey' == 2 | year`survey' == 2017 & month`survey' == 3 | year`survey' == 2017 & month`survey' == 4 | year`survey' == 2017 & month`survey' == 5 | year`survey' == 2017 & month`survey' == 6 | year`survey' == 2017 & month`survey' == 7 | year`survey' == 2017 & month`survey' == 8 | year`survey' == 2017 & month`survey' == 9

gen time11`survey' = .

replace time11`survey' = 0 if year`survey' == 2016 & month`survey' == 4 | year`survey' == 2016 & month`survey' == 3 | year`survey' == 2016 & month`survey' == 2 | year`survey' == 2016 & month`survey' == 1 | year`survey' == 2015 & month`survey' == 12 | year`survey' == 2015 & month`survey' == 11 | year`survey' == 2015 & month`survey' == 10 | year`survey' == 2015 & month`survey' == 9 | year`survey' == 2015 & month`survey' == 8 | year`survey' == 2015 & month`survey' == 7 | year`survey' == 2015 & month`survey' == 6 
replace time11`survey' = 1 if year`survey' == 2016 & month`survey' == 12 | year`survey' == 2017 & month`survey' == 1 | year`survey' == 2017 & month`survey' == 2 | year`survey' == 2017 & month`survey' == 3 | year`survey' == 2017 & month`survey' == 4 | year`survey' == 2017 & month`survey' == 5 | year`survey' == 2017 & month`survey' == 6 | year`survey' == 2017 & month`survey' == 7 | year`survey' == 2017 & month`survey' == 8 | year`survey' == 2017 & month`survey' == 9 | year`survey' == 2017 & month`survey' == 10 

gen time12`survey' = .

replace time12`survey' = 0 if year`survey' == 2016 & month`survey' == 4 | year`survey' == 2016 & month`survey' == 3 | year`survey' == 2016 & month`survey' == 2 | year`survey' == 2016 & month`survey' == 1 | year`survey' == 2015 & month`survey' == 12 | year`survey' == 2015 & month`survey' == 11 | year`survey' == 2015 & month`survey' == 10 | year`survey' == 2015 & month`survey' == 9 | year`survey' == 2015 & month`survey' == 8 | year`survey' == 2015 & month`survey' == 7 | year`survey' == 2015 & month`survey' == 6 | year`survey' == 2015 & month`survey' == 5
replace time12`survey' = 1 if year`survey' == 2016 & month`survey' == 12 | year`survey' == 2017 & month`survey' == 1 | year`survey' == 2017 & month`survey' == 2 | year`survey' == 2017 & month`survey' == 3 | year`survey' == 2017 & month`survey' == 4 | year`survey' == 2017 & month`survey' == 5 | year`survey' == 2017 & month`survey' == 6 | year`survey' == 2017 & month`survey' == 7 | year`survey' == 2017 & month`survey' == 8 | year`survey' == 2017 & month`survey' == 9 | year`survey' == 2017 & month`survey' == 10 | year`survey' == 2017 & month`survey' == 11




*svyset [iweight = earnwt_cps]
*svy, subpop(salaried_atus): mean weekly_base_pay_atus

*count if salaried_atus == 1 & weekly_base_pay_atus <= 2500 & time_atus == 1
*count if salaried_atus == 1 & weekly_base_pay_atus <= 2500 & time_atus == 0

/*
* Distribution of weekly base pay over time and type
cd "$analysis\output"

cap gen wt = earnwt_cps * 1000000
*Salaried
hist weekly_base_pay`survey' if salaried`survey' == 1 & weekly_base_pay`survey' <= 2500 & weekly_base_pay`survey'!= . [fweight = wt], by(time1`survey', title("Weekly base pay") subtitle("Salaried Workers")) width(96.15) binrescale ///
xlabel(0(500)2500) xtitle("Weekly base pay (`survey')") graphregion(color(white))

graph export hist_weeklybasepay_salaried`survey'.png, as(png) replace


*Hourly
hist weekly_base_pay`survey' if salaried`survey' == 0 & weekly_base_pay`survey' <= 2500 & weekly_base_pay`survey'!= . [fweight = wt], by(time1`survey', title("Weekly base pay") subtitle("Hourly Workers")) width(96.15) binrescale ///
xlabel(0(500)2500) xtitle("Weekly base pay (`survey')") graphregion(color(white))

graph export hist_weeklybasepay_hourly`survey'.png, as(png) replace
*/


*Manually generating bins so that they match Quach 2021
gen bin`survey' = .
replace bin`survey' = 1 if weekly_base_pay`survey' < 47.65
replace bin`survey' = 2 if weekly_base_pay`survey' >= 47.65 & weekly_base_pay`survey' < 143.8
replace bin`survey' = 3 if weekly_base_pay`survey' >= 143.8 & weekly_base_pay`survey' < 239.95
replace bin`survey' = 4 if weekly_base_pay`survey' >= 239.95 & weekly_base_pay`survey' < 336.1
replace bin`survey' = 5 if weekly_base_pay`survey' >= 336.1 & weekly_base_pay`survey' < 432.25
replace bin`survey' = 6 if weekly_base_pay`survey' >= 432.25 & weekly_base_pay`survey' < 528.4
replace bin`survey' = 7 if weekly_base_pay`survey' >= 528.4 & weekly_base_pay`survey' < 624.55
replace bin`survey' = 8 if weekly_base_pay`survey' >= 624.55 & weekly_base_pay`survey' < 720.7
replace bin`survey' = 9 if weekly_base_pay`survey' >= 720.7 & weekly_base_pay`survey' < 816.85
replace bin`survey' = 10 if weekly_base_pay`survey' >= 816.85 & weekly_base_pay`survey' < 913
replace bin`survey' = 11 if weekly_base_pay`survey' >= 913 & weekly_base_pay`survey' < 1009.15 // bin starting at 913$
replace bin`survey' = 12 if weekly_base_pay`survey' >= 1009.15 & weekly_base_pay`survey' < 1105.3
replace bin`survey' = 13 if weekly_base_pay`survey' >= 1105.3 & weekly_base_pay`survey' < 1201.45
replace bin`survey' = 14 if weekly_base_pay`survey' >= 1201.45 & weekly_base_pay`survey' < 1297.6
replace bin`survey' = 15 if weekly_base_pay`survey' >= 1297.6 & weekly_base_pay`survey' < 1393.75
replace bin`survey' = 16 if weekly_base_pay`survey' >= 1393.75 & weekly_base_pay`survey' < 1489.9
replace bin`survey' = 17 if weekly_base_pay`survey' >= 1489.9 & weekly_base_pay`survey' < 1586.05
replace bin`survey' = 18 if weekly_base_pay`survey' >= 1586.05 & weekly_base_pay`survey' < 1682.2
replace bin`survey' = 19 if weekly_base_pay`survey' >= 1682.2 & weekly_base_pay`survey' < 1778.35
replace bin`survey' = 20 if weekly_base_pay`survey' >= 1778.35 & weekly_base_pay`survey' < 1874.5
replace bin`survey' = 21 if weekly_base_pay`survey' >= 1874.5 & weekly_base_pay`survey' < 1970.65
replace bin`survey' = 22 if weekly_base_pay`survey' >= 1970.65 & weekly_base_pay`survey' < 2066.8
replace bin`survey' = 23 if weekly_base_pay`survey' >= 2066.8 & weekly_base_pay`survey' < 2162.95
replace bin`survey' = 24 if weekly_base_pay`survey' >= 2162.95 & weekly_base_pay`survey' < 2259.1
replace bin`survey' = 25 if weekly_base_pay`survey' >= 2259.1 & weekly_base_pay`survey' < 2355.25
replace bin`survey' = 26 if weekly_base_pay`survey' >= 2355.25 & weekly_base_pay`survey' < 2451.4
replace bin`survey' = 27 if weekly_base_pay`survey' >= 2451.4 & weekly_base_pay`survey' <= 2500 // Weekly base pay distribution truncated at 2500$

*looping through time span around treatment
foreach i of numlist 1/12 {

*Double checking numerosity
preserve
keep if salaried`survey' == 1
drop if bin`survey' == .
drop if weekly_base_pay`survey'==.

tab time`i'`survey', m 

restore


/*
   time1_atus |      Freq.     Percent        Cum.
--------------+-----------------------------------
   April 2016 |      1,030        3.10        3.10
December 2016 |        993        2.99        6.09
            . |     31,218       93.91      100.00
--------------+-----------------------------------
        Total |     33,241      100.00


 time2_atus |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |      1,743        5.24        5.24
          1 |      2,570        7.73       12.97
          . |     28,928       87.03      100.00
------------+-----------------------------------
      Total |     33,241      100.00

 time3_atus |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |      2,488        7.48        7.48
          1 |      3,654       10.99       18.48
          . |     27,099       81.52      100.00
------------+-----------------------------------
      Total |     33,241      100.00


           |         time
       bin |         0          1 |     Total
-----------+----------------------+----------
         1 |        32         28 |        60 
         2 |        61        128 |       189 
         3 |       129        143 |       272 
         4 |       180        201 |       381 
         5 |       131        206 |       337 
         6 |       216        180 |       396 
         7 |       144        193 |       337 
         8 |       203        250 |       453 
         9 |       162        205 |       367 
        10 |        81        126 |       207 
        11 |       170        117 |       287 
        12 |       109         83 |       192 
        13 |       103        105 |       208 
        14 |        92         74 |       166 
        15 |        57         66 |       123 
        16 |        54         67 |       121 
        17 |        79         75 |       154 
        18 |        48         68 |       116 
        19 |        60         54 |       114 
        20 |        57         40 |        97 
        21 |        68         56 |       124 
        22 |        45         56 |       101 
        23 |        28         28 |        56 
        24 |        23          8 |        31 
        25 |        35         30 |        65 
        26 |         0         16 |        16 
        27 |        15         37 |        52 
-----------+----------------------+----------
     Total |     2,382      2,640 |     5,022 
*/

*Figure 2a
*Collapsing to obtain bin mean
	
preserve

keep if salaried`survey' == 1
drop if bin`survey' == .

drop if time`i'`survey' == .

gen count = 1

cap drop weight
gen weight = (earnwt_cps / `i')

collapse (mean) weekly_base_pay`survey' (count) count [pweight = weight], by(bin`survey' time`i'`survey')
sort time`i'`survey' bin`survey'

format count %13.0g
*replace count = (count / `i')

tab time`i'`survey' bin`survey'

*Graph (whole country)
cap mkdir "$analysis\output\Figure2a\`survey'"
cd "$analysis\output\Figure2a\`survey'"

twoway (scatter count weekly_base_pay`survey' if time`i'`survey' == 0, m(circle) mc(blue) c(l)) ///
(scatter count weekly_base_pay`survey' if time`i'`survey' == 1, m(triangle) mc(red) c(l) ///
legend(order(1 "April 2016 `i'" 2 "December 2016 `i'")) ///
title("Figure II a") subtitle("Frequency distribution of Base Pay - Salaried workers") ytitle("Weighted count") xtitle("Weekly base pay (`survey')") graphregion(color(white)) ///
xline(455, lcolor(gs1) lpattern(dash)) xline(913, lcolor(red) lpattern(dash)))

graph export figure2a`survey'_`i'.png, as(png) replace

restore



*Graph selected countries (= which did not change MW)
cap mkdir "$analysis\output\Figure2a\`survey'\no_mw_changes_states"
cd "$analysis\output\Figure2a\`survey'\no_mw_changes_states"

preserve

keep if salaried`survey' == 1
drop if bin`survey' == .

drop if time`i'`survey' == .

gen count = 1

keep if states_nomwc == 1

cap drop weight
gen weight = (earnwt_cps / `i')

collapse (mean) weekly_base_pay`survey' (count) count [pweight = weight], by(bin`survey' time`i'`survey')
sort time`i'`survey' bin`survey'

format count %13.0g
*replace count = (count / `i')


twoway (scatter count weekly_base_pay`survey' if time`i'`survey' == 0, m(circle) mc(blue) c(l)) ///
(scatter count weekly_base_pay`survey' if time`i'`survey' == 1, m(triangle) mc(red) c(l) ///
legend(order(1 "April 2016 `i'" 2 "December 2016 `i'")) ///
title("Figure II a") subtitle("Frequency distribution of Base Pay - Salaried workers") ytitle("Weighted count") xtitle("Weekly base pay (`survey')") graphregion(color(white)) ///
xline(455, lcolor(gs1) lpattern(dash)) xline(913, lcolor(red) lpattern(dash)))

graph export figure2a`survey'_`i'.png, as(png) replace

restore

	}

}




xxx
* Quick try at figure II c (the same but for hourly workers)
preserve

keep if hourly == 1
drop if bin == .

drop if time == .

gen count = 1

collapse (mean) weekly_base_pay (count) count [pweight = earnwt_cps], by(bin time)
sort time bin

format count %13.0g
gen count2 = count / 100000

*Graph
cd "$analysis\output"

twoway (scatter count weekly_base_pay if time == 0, m(circle) mc(blue) c(l)) ///
(scatter count weekly_base_pay if time == 1, m(triangle) mc(red) c(l) ///
legend(order(1 "April 2016" 2 "December 2016")) ///
title("Figure II a") subtitle("Frequency distribution of Base Pay - Hourly workers") ytitle("Weighted count") xtitle("Weekly base pay") graphregion(color(white)) ///
xline(455, lcolor(gs1) lpattern(dash)) xline(913, lcolor(red) lpattern(dash)))

graph export figure2c_ipums.png, as(png) replace

restore

********************************************************************************
* CPS DATA

global build "C:\Users\39328\Dropbox\Hours constraints and home prod\build"

global analysis "C:\Users\39328\Dropbox\Hours constraints and home prod\analysis"

cd "$build\output"

clear all

use clean_ipums_cpsatus

order weekly_base_pay salaried hourly annualwt_cps wt06_atus, after(cpsidp)
order month*, after(year_cps)

gen time = .

replace time = 0 if year_cps == 2016 & month_cps8_atus == 4 
replace time = 1 if year_cps == 2016 & month_cps8_atus == 12 
order time, after(month_cps8_atus)

label define timelab 0 "April 2016" 1 "December 2016"
label values time timelab

svyset [iweight = earnwt_cps]
svy, subpop(salaried): mean weekly_base_pay

count if salaried == 1 & weekly_base_pay <= 2500 & time == 1
count if salaried == 1 & weekly_base_pay <= 2500 & time == 0


* Distribution of weekly base pay over time and type
cd "$analysis\output"

/*
*Salaried
hist weekly_base_pay if salaried == 1 & weekly_base_pay <= 2500 & weekly_base_pay!= . [fweight = wt], by(time, title("Weekly base pay") subtitle("Salaried Workers")) width(96.15) binrescale ///
xlabel(0(500)2500) xtitle("Weekly base pay") graphregion(color(white))

graph export hist_weeklybasepay_salaried.png, as(png) replace


*Hourly
hist weekly_base_pay if salaried == 0 & weekly_base_pay <= 2500 & weekly_base_pay!= . [fweight = wt], by(time, title("Weekly base pay") subtitle("Hourly Workers")) width(96.15) binrescale ///
xlabel(0(500)2500) xtitle("Weekly base pay") graphregion(color(white))

graph export hist_weeklybasepay_hourly.png, as(png) replace
*/


/*
*Double checking numerosity
preserve
keep if salaried == 1
drop if bin == .

tab time, m 

restore
*/

*Manually generating bins so that they match Quach 2021
gen bin = .
replace bin = 1 if weekly_base_pay < 47.65
replace bin = 2 if weekly_base_pay >= 47.65 & weekly_base_pay < 143.8
replace bin = 3 if weekly_base_pay >= 143.8 & weekly_base_pay < 239.95
replace bin = 4 if weekly_base_pay >= 239.95 & weekly_base_pay < 336.1
replace bin = 5 if weekly_base_pay >= 336.1 & weekly_base_pay < 432.25
replace bin = 6 if weekly_base_pay >= 432.25 & weekly_base_pay < 528.4
replace bin = 7 if weekly_base_pay >= 528.4 & weekly_base_pay < 624.55
replace bin = 8 if weekly_base_pay >= 624.55 & weekly_base_pay < 720.7
replace bin = 9 if weekly_base_pay >= 720.7 & weekly_base_pay < 816.85
replace bin = 10 if weekly_base_pay >= 816.85 & weekly_base_pay < 913
replace bin = 11 if weekly_base_pay >= 913 & weekly_base_pay < 1009.15 // bin starting at 913$
replace bin = 12 if weekly_base_pay >= 1009.15 & weekly_base_pay < 1105.3
replace bin = 13 if weekly_base_pay >= 1105.3 & weekly_base_pay < 1201.45
replace bin = 14 if weekly_base_pay >= 1201.45 & weekly_base_pay < 1297.6
replace bin = 15 if weekly_base_pay >= 1297.6 & weekly_base_pay < 1393.75
replace bin = 16 if weekly_base_pay >= 1393.75 & weekly_base_pay < 1489.9
replace bin = 17 if weekly_base_pay >= 1489.9 & weekly_base_pay < 1586.05
replace bin = 18 if weekly_base_pay >= 1586.05 & weekly_base_pay < 1682.2
replace bin = 19 if weekly_base_pay >= 1682.2 & weekly_base_pay < 1778.35
replace bin = 20 if weekly_base_pay >= 1778.35 & weekly_base_pay < 1874.5
replace bin = 21 if weekly_base_pay >= 1874.5 & weekly_base_pay < 1970.65
replace bin = 22 if weekly_base_pay >= 1970.65 & weekly_base_pay < 2066.8
replace bin = 23 if weekly_base_pay >= 2066.8 & weekly_base_pay < 2162.95
replace bin = 24 if weekly_base_pay >= 2162.95 & weekly_base_pay < 2259.1
replace bin = 25 if weekly_base_pay >= 2259.1 & weekly_base_pay < 2355.25
replace bin = 26 if weekly_base_pay >= 2355.25 & weekly_base_pay < 2451.4
replace bin = 27 if weekly_base_pay >= 2451.4 & weekly_base_pay <= 2500 // Weekly base pay distribution truncated at 2500$

tab bin time

/*

           |         time
       bin | April 201  December  |     Total
-----------+----------------------+----------
         1 |        24          4 |        28 
         2 |        70         75 |       145 
         3 |       160        113 |       273 
         4 |       173        132 |       305 
         5 |       175        183 |       358 
         6 |       216        138 |       354 
         7 |       251        133 |       384 
         8 |       223        147 |       370 
         9 |       171        117 |       288 
        10 |       119         63 |       182 
        11 |       189        148 |       337 
        12 |       118         80 |       198 
        13 |       111         83 |       194 
        14 |        98         32 |       130 
        15 |       124         39 |       163 
        16 |        61         67 |       128 
        17 |        81         63 |       144 
        18 |        58         14 |        72 
        19 |        56         43 |        99 
        20 |        61         20 |        81 
        21 |        48         43 |        91 
        22 |        20         31 |        51 
        23 |        50         28 |        78 
        24 |         8          3 |        11 
        25 |        19         22 |        41 
        26 |        20         12 |        32 
        27 |        24          3 |        27 
-----------+----------------------+----------
     Total |     2,728      1,836 |     4,564 

*/

*Figure 2a
*Collapsing to obtain bin mean
preserve

keep if salaried == 1
drop if bin == .

drop if time == .

gen count = 1

/*
      |         time
       bin | April 201  December  |     Total
-----------+----------------------+----------
         1 |        16          0 |        16 
         2 |        12         32 |        44 
         3 |        35         16 |        51 
         4 |        20         12 |        32 
         5 |        32         52 |        84 
         6 |        62         36 |        98 
         7 |        71         31 |       102 
         8 |        58         44 |       102 
         9 |        60         36 |        96 
        10 |        51         39 |        90 
        11 |       108         96 |       204 
        12 |        52         63 |       115 
        13 |        80         52 |       132 
        14 |        53         20 |        73 
        15 |       108         18 |       126 
        16 |        42         47 |        89 
        17 |        61         51 |       112 
        18 |        47          8 |        55 
        19 |        45         32 |        77 
        20 |        44         16 |        60 
        21 |        40         39 |        79 
        22 |        16         27 |        43 
        23 |        42         24 |        66 
        24 |         8          3 |        11 
        25 |        19         14 |        33 
        26 |        20         12 |        32 
        27 |        16          3 |        19 
-----------+----------------------+----------
     Total |     1,218        823 |     2,041 


*****/

collapse (mean) weekly_base_pay (count) count [pweight = earnwt_cps], by(bin time)

*Duplicating obs in time 1 to fill the blank in bin 1 in time 0 
set obs 54
replace time = 1 in 54
replace bin = 1 in 54
replace weekly_base_pay = weekly_base_pay if time == 0 & bin == 1 in 54
replace count = count if time == 0 & bin == 1 in 54

sort time bin

format count %13.0g

*Graph
cd "$analysis\output"

twoway (scatter count weekly_base_pay if time == 0, m(circle) mc(blue) c(l)) ///
(scatter count weekly_base_pay if time == 1, m(triangle) mc(red) c(l) ///
legend(order(1 "April 2016" 2 "December 2016")) ///
title("Figure II a") subtitle("Frequency distribution of Base Pay - Salaried workers") ytitle("Weighted count") xtitle("Weekly base pay (CPS data)") graphregion(color(white)) ///
xline(455, lcolor(gs1) lpattern(dash)) xline(913, lcolor(red) lpattern(dash)))

graph export figure2a_cps.png, as(png) replace

restore



* Quick try at figure II c (the same but for hourly workers)
preserve

keep if hourly == 1
drop if bin == .

drop if time == .

gen count = 1

collapse (mean) weekly_base_pay (count) count [pweight = earnwt_cps], by(bin time)
sort time bin

format count %13.0g
gen count2 = count / 100000

*Graph
cd "$analysis\output"

twoway (scatter count weekly_base_pay if time == 0, m(circle) mc(blue) c(l)) ///
(scatter count weekly_base_pay if time == 1, m(triangle) mc(red) c(l) ///
legend(order(1 "April 2016" 2 "December 2016")) ///
title("Figure II a") subtitle("Frequency distribution of Base Pay - Hourly workers") ytitle("Weighted count") xtitle("Weekly base pay") graphregion(color(white)) ///
xline(455, lcolor(gs1) lpattern(dash)) xline(913, lcolor(red) lpattern(dash)))

graph export figure2c_ipums.png, as(png) replace

restore
