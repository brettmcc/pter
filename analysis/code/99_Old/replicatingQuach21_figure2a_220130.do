*Replicating figure IIa from Quach 2021
*2022.01.29


global build "C:\Users\39328\Dropbox\Hours constraints and home prod\build"

global analysis "C:\Users\39328\Dropbox\Hours constraints and home prod\analysis"

global figure2a "C:\Users\39328\Dropbox\Hours constraints and home prod\analysis\output\Figure2a"

cd "$build\output"

clear all

use clean_ipums_cpsatus

*Analysis using CPS-based weekly base pay and ATUS-based weekly base pay

keep if mish_cps == 8 | mish_cps == 4
sort cpsidp 
quietly by cpsidp:  gen dup = cond(_N==1,0,_n)

isid cpsidp

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
gen bin1`survey' = .
replace bin1`survey' = 1 if weekly_base_pay`survey' < 47.65
replace bin1`survey' = 2 if weekly_base_pay`survey' >= 47.65 & weekly_base_pay`survey' < 143.8
replace bin1`survey' = 3 if weekly_base_pay`survey' >= 143.8 & weekly_base_pay`survey' < 239.95
replace bin1`survey' = 4 if weekly_base_pay`survey' >= 239.95 & weekly_base_pay`survey' < 336.1
replace bin1`survey' = 5 if weekly_base_pay`survey' >= 336.1 & weekly_base_pay`survey' < 432.25
replace bin1`survey' = 6 if weekly_base_pay`survey' >= 432.25 & weekly_base_pay`survey' < 528.4
replace bin1`survey' = 7 if weekly_base_pay`survey' >= 528.4 & weekly_base_pay`survey' < 624.55
replace bin1`survey' = 8 if weekly_base_pay`survey' >= 624.55 & weekly_base_pay`survey' < 720.7
replace bin1`survey' = 9 if weekly_base_pay`survey' >= 720.7 & weekly_base_pay`survey' < 816.85
replace bin1`survey' = 10 if weekly_base_pay`survey' >= 816.85 & weekly_base_pay`survey' < 913
replace bin1`survey' = 11 if weekly_base_pay`survey' >= 913 & weekly_base_pay`survey' < 1009.15 // bin1 starting at 913$
replace bin1`survey' = 12 if weekly_base_pay`survey' >= 1009.15 & weekly_base_pay`survey' < 1105.3
replace bin1`survey' = 13 if weekly_base_pay`survey' >= 1105.3 & weekly_base_pay`survey' < 1201.45
replace bin1`survey' = 14 if weekly_base_pay`survey' >= 1201.45 & weekly_base_pay`survey' < 1297.6
replace bin1`survey' = 15 if weekly_base_pay`survey' >= 1297.6 & weekly_base_pay`survey' < 1393.75
replace bin1`survey' = 16 if weekly_base_pay`survey' >= 1393.75 & weekly_base_pay`survey' < 1489.9
replace bin1`survey' = 17 if weekly_base_pay`survey' >= 1489.9 & weekly_base_pay`survey' < 1586.05
replace bin1`survey' = 18 if weekly_base_pay`survey' >= 1586.05 & weekly_base_pay`survey' < 1682.2
replace bin1`survey' = 19 if weekly_base_pay`survey' >= 1682.2 & weekly_base_pay`survey' < 1778.35
replace bin1`survey' = 20 if weekly_base_pay`survey' >= 1778.35 & weekly_base_pay`survey' < 1874.5
replace bin1`survey' = 21 if weekly_base_pay`survey' >= 1874.5 & weekly_base_pay`survey' < 1970.65
replace bin1`survey' = 22 if weekly_base_pay`survey' >= 1970.65 & weekly_base_pay`survey' < 2066.8
replace bin1`survey' = 23 if weekly_base_pay`survey' >= 2066.8 & weekly_base_pay`survey' < 2162.95
replace bin1`survey' = 24 if weekly_base_pay`survey' >= 2162.95 & weekly_base_pay`survey' < 2259.1
replace bin1`survey' = 25 if weekly_base_pay`survey' >= 2259.1 & weekly_base_pay`survey' < 2355.25
replace bin1`survey' = 26 if weekly_base_pay`survey' >= 2355.25 & weekly_base_pay`survey' < 2451.4
replace bin1`survey' = 27 if weekly_base_pay`survey' >= 2451.4 & weekly_base_pay`survey' <= 2500 // Weekly base pay distribution truncated at 2500$

*Bins which avoid pooling 913 and 1000
gen bin2`survey' = .
replace bin2`survey' = 1 if weekly_base_pay`survey' < 83
replace bin2`survey' = 2 if weekly_base_pay`survey' >= 83 & weekly_base_pay`survey' < 166
replace bin2`survey' = 3 if weekly_base_pay`survey' >= 166 & weekly_base_pay`survey' < 249
replace bin2`survey' = 4 if weekly_base_pay`survey' >= 249 & weekly_base_pay`survey' < 332
replace bin2`survey' = 5 if weekly_base_pay`survey' >= 332 & weekly_base_pay`survey' < 415
replace bin2`survey' = 6 if weekly_base_pay`survey' >= 415 & weekly_base_pay`survey' < 498
replace bin2`survey' = 7 if weekly_base_pay`survey' >= 498 & weekly_base_pay`survey' < 581
replace bin2`survey' = 8 if weekly_base_pay`survey' >= 581 & weekly_base_pay`survey' < 664
replace bin2`survey' = 9 if weekly_base_pay`survey' >= 664 & weekly_base_pay`survey' < 747
replace bin2`survey' = 10 if weekly_base_pay`survey' >= 747 & weekly_base_pay`survey' < 830
replace bin2`survey' = 11 if weekly_base_pay`survey' >= 830 & weekly_base_pay`survey' < 913
replace bin2`survey' = 12 if weekly_base_pay`survey' >= 913 & weekly_base_pay`survey' < 996
replace bin2`survey' = 13 if weekly_base_pay`survey' >= 996 & weekly_base_pay`survey' < 1079
replace bin2`survey' = 14 if weekly_base_pay`survey' >= 1079 & weekly_base_pay`survey' < 1162
replace bin2`survey' = 15 if weekly_base_pay`survey' >= 1162 & weekly_base_pay`survey' < 1245
replace bin2`survey' = 16 if weekly_base_pay`survey' >= 1245 & weekly_base_pay`survey' < 1328
replace bin2`survey' = 17 if weekly_base_pay`survey' >= 1328 & weekly_base_pay`survey' < 1411
replace bin2`survey' = 18 if weekly_base_pay`survey' >= 1411 & weekly_base_pay`survey' < 1494
replace bin2`survey' = 19 if weekly_base_pay`survey' >= 1494 & weekly_base_pay`survey' < 1577
replace bin2`survey' = 20 if weekly_base_pay`survey' >= 1577 & weekly_base_pay`survey' < 1660
replace bin2`survey' = 21 if weekly_base_pay`survey' >= 1660 & weekly_base_pay`survey' < 1743
replace bin2`survey' = 22 if weekly_base_pay`survey' >= 1743 & weekly_base_pay`survey' < 1826
replace bin2`survey' = 23 if weekly_base_pay`survey' >= 1826 & weekly_base_pay`survey' < 1909
replace bin2`survey' = 24 if weekly_base_pay`survey' >= 1909 & weekly_base_pay`survey' < 1992
replace bin2`survey' = 25 if weekly_base_pay`survey' >= 1992 & weekly_base_pay`survey' < 2075
replace bin2`survey' = 26 if weekly_base_pay`survey' >= 2075 & weekly_base_pay`survey' < 2158
replace bin2`survey' = 27 if weekly_base_pay`survey' >= 2158 & weekly_base_pay`survey' < 2241
replace bin2`survey' = 28 if weekly_base_pay`survey' >= 2241 & weekly_base_pay`survey' < 2324
replace bin2`survey' = 29 if weekly_base_pay`survey' >= 2324 & weekly_base_pay`survey' < 2407
replace bin2`survey' = 30 if weekly_base_pay`survey' >= 2407 & weekly_base_pay`survey' <= 2500 // last bin extended to include 2500.




*looping through bin design
foreach j of numlist 1/2 {


*looping through time span around treatment
foreach i of numlist 1/12 {

*Double checking numerosity
preserve
keep if salaried`survey' == 1
drop if bin`j'`survey' == .
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
drop if bin`j'`survey' == .

drop if time`i'`survey' == .

gen count = 1

cap drop weight
gen weight = (earnwt_cps / `i')

/*
*Histogram
gen wt = weight * 1000000000
*Salaried
hist weekly_base_pay`survey' if salaried`survey' == 1 & weekly_base_pay`survey' <= 2500 & weekly_base_pay`survey'!= . [fweight = wt], by(time`i'`survey', title("Weekly base pay") subtitle("Salaried Workers")) width(96.15) binrescale ///
xlabel(0(500)2500) xtitle("Weekly base pay (`survey')") graphregion(color(white))

graph export hist_weeklybasepay_salaried`survey'`i'.png, as(png) replace
*/

collapse (mean) weekly_base_pay`survey' (count) count [pweight = weight], by(bin`j'`survey' time`i'`survey')
sort time`i'`survey' bin`j'`survey'

format count %13.0g
*replace count = (count / `i')

tab time`i'`survey' bin`j'`survey'

*Graph (whole country)
cd "$figure2a"
cap mkdir "./`survey'/"
cap mkdir "./`survey'/bin`j'"

cd "./`survey'/bin`j'"

twoway (scatter count weekly_base_pay`survey' if time`i'`survey' == 0, m(circle) mc(blue) c(l)) ///
(scatter count weekly_base_pay`survey' if time`i'`survey' == 1, m(triangle) mc(red) c(l) ///
legend(order(1 "April 2016 `i'" 2 "December 2016 `i'")) ///
title("Figure II a") subtitle("Frequency distribution of Base Pay - Salaried workers") ytitle("Weighted count") xtitle("Weekly base pay (`survey', bin`j')") graphregion(color(white)) ///
xline(455, lcolor(gs1) lpattern(dash)) xline(913, lcolor(red) lpattern(dash)))

graph export figure2a`survey'_`i'bin`j'.png, as(png) replace

restore



*Graph selected countries (= which did not change MW)

cd "$figure2a"
cap mkdir "./`survey'"
cap mkdir "./`survey'/bin`j'"
cap mkdir "./`survey'/bin`j'/no_mw_changes_states"

cd "./`survey'/bin`j'/no_mw_changes_states"

preserve

keep if salaried`survey' == 1
drop if bin`j'`survey' == .

drop if time`i'`survey' == .

gen count = 1

keep if states_nomwc == 1

cap drop weight
gen weight = (earnwt_cps / `i')

/*
*Histogram
gen wt = weight * 1000000000
*Salaried
hist weekly_base_pay`survey' if salaried`survey' == 1 & weekly_base_pay`survey' <= 2500 & weekly_base_pay`survey'!= . [fweight = wt], by(time`i'`survey', title("Weekly base pay") subtitle("Salaried Workers")) width(96.15) binrescale ///
xlabel(0(500)2500) xtitle("Weekly base pay (`survey')") graphregion(color(white))

graph export hist_weeklybasepay_salaried`survey'`i'.png, as(png) replace
*/


collapse (mean) weekly_base_pay`survey' (count) count [pweight = weight], by(bin`j'`survey' time`i'`survey')
sort time`i'`survey' bin`j'`survey'

format count %13.0g
*replace count = (count / `i')


twoway (scatter count weekly_base_pay`survey' if time`i'`survey' == 0, m(circle) mc(blue) c(l)) ///
(scatter count weekly_base_pay`survey' if time`i'`survey' == 1, m(triangle) mc(red) c(l) ///
legend(order(1 "April 2016 `i'" 2 "December 2016 `i'")) ///
title("Figure II a") subtitle("Frequency distribution of Base Pay - Salaried workers") ytitle("Weighted count") xtitle("Weekly base pay (`survey'bin`j')") graphregion(color(white)) ///
xline(455, lcolor(gs1) lpattern(dash)) xline(913, lcolor(red) lpattern(dash)))

graph export figure2a`survey'_`i'bin`j'_nomwc.png, as(png) replace




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

