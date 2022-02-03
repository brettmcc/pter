*Replicating figure IIa from Quach 2021
*2022.01.21

global build "C:\Users\39328\Dropbox\Hours constraints and home prod\build"

global analysis "C:\Users\39328\Dropbox\Hours constraints and home prod\analysis"

cd "$build\output"

clear all

use merged_atuscps


*can't use noninteger frequency weights in most graphs commands (hist, binscatter)
* so multiply weight by 10 to make them integer. Note that all multiples of the original weight will give the same results for mean and percentages
order TUFNWGTP, after(TUCASEID)
format TUFNWGTP %15.0g
gen double wt = TUFNWGTP * 1000000000
order wt, after(TUFNWGTP)
format wt %20.0g
replace wt = round(wt)
order weekly_base_pay, after(wt)


*Pre and post treatment window

tab TUMONTH if HRYEAR4 == 2016 [aweight = TUFNWGTP]
tab salaried_worker if HRYEAR4 == 2016 & TUMONTH == 12  & weekly_base_pay < 2500 & weekly_base_pay != . [aweight = TUFNWGTP] // looks like there are no salaried_workers observed in December 2016 (and only 3 hourly workers)


gen time = .

replace time = 0 if HRYEAR4 == 2016 & TUMONTH == 4 | HRYEAR4 == 2016 & TUMONTH == 3 | HRYEAR4 == 2016 & TUMONTH == 2 | HRYEAR4 == 2016 & TUMONTH == 1 | HRYEAR4 == 2015 & TUMONTH == 12 | HRYEAR4 == 2015 & TUMONTH == 11 | HRYEAR4 == 2015 & TUMONTH == 10 | HRYEAR4 == 2015 & TUMONTH == 9 | HRYEAR4 == 2015 & TUMONTH == 8 | HRYEAR4 == 2015 & TUMONTH == 7 | HRYEAR4 == 2015 & TUMONTH == 6 | HRYEAR4 == 2015 & TUMONTH == 5 // 1 year period ending April 2016 to get a bigger sample

replace time = 1 if HRYEAR4 == 2016 & TUMONTH == 12 | HRYEAR4 == 2017 & TUMONTH == 1 | HRYEAR4 == 2017 & TUMONTH == 2 | HRYEAR4 == 2017 & TUMONTH == 3 | HRYEAR4 == 2017 & TUMONTH == 4 | HRYEAR4 == 2017 & TUMONTH == 5 | HRYEAR4 == 2017 & TUMONTH == 6 | HRYEAR4 == 2017 & TUMONTH == 7 | HRYEAR4 == 2017 & TUMONTH == 8 | HRYEAR4 == 2017 & TUMONTH == 9 | HRYEAR4 == 2017 & TUMONTH == 10 | HRYEAR4 == 2017 & TUMONTH == 11 //  1 year period starting Dec 2016 to get a bigger sample


tab salaried_worker time if  weekly_base_pay < 2500 & weekly_base_pay != . [iweight = TUFNWGTP]

tab PEERNHRY time if  weekly_base_pay < 2500 & weekly_base_pay != . [iweight = TUFNWGTP] // overall picture does not change if we look at the other measure for hourly vs salaried worker we have


* Distribution of weekly base pay over time and type
cd "$analysis\output"

*Salaried
hist weekly_base_pay if salaried_worker == 1 & weekly_base_pay <= 2500 & weekly_base_pay!= . [fweight = wt], by(time, title("Weekly base pay") subtitle("Salaried Workers")) width(96.15) binrescale ///
xlabel(0(500)2500) xtitle("Weekly base pay") graphregion(color(white))

graph export hist_weeklybasepay_salaried.png, as(png) replace


*Hourly
hist weekly_base_pay if salaried_worker == 0 & weekly_base_pay <= 2500 & weekly_base_pay!= . [fweight = wt], by(time, title("Weekly base pay") subtitle("Hourly Workers")) width(96.15) binrescale ///
xlabel(0(500)2500) xtitle("Weekly base pay") graphregion(color(white))

graph export hist_weeklybasepay_hourly.png, as(png) replace



/*
*Double checking numerosity
preserve
keep if salaried_worker == 1
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


*Figure 2a
*Collapsing to obtain bin mean
preserve

keep if salaried_worker == 1
drop if bin == .

drop if time == .

gen count = 1

collapse (mean) weekly_base_pay (count) count [pweight = TUFNWGTP], by(bin time)

format count %16.0g
gen count2 = count / 100000000

*Graph
cd "$analysis\output"

twoway (scatter count2 weekly_base_pay if time == 0, m(circle) mc(blue) c(l)) ///
(scatter count2 weekly_base_pay if time == 1, m(triangle) mc(red) c(l) ///
legend(order(1 "April 2016 and before" 2 "December 2016 and after")) ///
title("Figure II a") subtitle("Frequency distribution of Base Pay - Salaried workers") ytitle("Weighted count") xtitle("Weekly base pay") graphregion(color(white)) ///
xline(455, lcolor(gs1) lpattern(dash)) xline(913, lcolor(red) lpattern(dash)))

graph export figure2a.png, as(png) replace

restore

*Extracting info on how many observations in each bin

preserve

keep if salaried_worker == 1
drop if bin == .

drop if time == .

gen count = 1

collapse (mean) weekly_base_pay (count) count, by(bin time)
sort time bin

save count_obs_bin.dta, replace

restore

********************************************************************************
* IPUMS data, Conservative approach = ATUS data

global build "C:\Users\39328\Dropbox\Hours constraints and home prod\build"

global analysis "C:\Users\39328\Dropbox\Hours constraints and home prod\analysis"

cd "$build\output"

clear all

use merged_ipums_cpsatus

order weekly_base_pay salaried hourly annualwt_cps wt06_atus, after(cpsidp)

gen time = .

replace time = 0 if year_atus == 2016 & month_atus == 4 
replace time = 1 if year_atus == 2016 & month_atus == 12 
order time, after(wt06_atus)

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

keep if salaried == 1
drop if bin == .

drop if time == .

gen count = 1

/*
           |         time
       bin |         0          1 |     Total
-----------+----------------------+----------
         1 |        13          0 |        13 
         2 |        10         11 |        21 
         3 |        15         22 |        37 
         4 |        24         40 |        64 
         5 |        32         48 |        80 
         6 |        37         37 |        74 
         7 |        50         59 |       109 
         8 |        57         41 |        98 
         9 |        64         61 |       125 
        10 |        24         24 |        48 
        11 |       106         70 |       176 
        12 |        60         68 |       128 
        13 |        51         67 |       118 
        14 |        56         34 |        90 
        15 |        24         51 |        75 
        16 |        44         30 |        74 
        17 |        53         33 |        86 
        18 |        23         20 |        43 
        19 |        57         46 |       103 
        20 |        43         32 |        75 
        21 |        68         40 |       108 
        22 |        37         48 |        85 
        23 |        14         28 |        42 
        24 |        23          8 |        31 
        25 |        30         30 |        60 
        26 |         0         16 |        16 
        27 |        15         29 |        44 
-----------+----------------------+----------
     Total |     1,030        993 |     2,023 
*****/

collapse (mean) weekly_base_pay (count) count [pweight = earnwt_cps], by(bin time)
sort time bin

format count %13.0g
gen count2 = count / 100000

*Graph
cd "$analysis\output"

twoway (scatter count weekly_base_pay if time == 0, m(circle) mc(blue) c(l)) ///
(scatter count weekly_base_pay if time == 1, m(triangle) mc(red) c(l) ///
legend(order(1 "April 2016" 2 "December 2016")) ///
title("Figure II a") subtitle("Frequency distribution of Base Pay - Salaried workers") ytitle("Weighted count") xtitle("Weekly base pay") graphregion(color(white)) ///
xline(455, lcolor(gs1) lpattern(dash)) xline(913, lcolor(red) lpattern(dash)))

graph export figure2a_ipums.png, as(png) replace

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