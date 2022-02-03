clear all
set more off, permanently
cd /hpc/household_finance/BoardResearch/HP/WorkDir/Revision

use pooled.dta,clear
keep if year > 1967 

winsor2 log_headwage, cuts(1 99) replace 
winsor2 faminc, cuts(1 99) replace 
bys year: quantiles faminc, gen(decile_faminc) n(10)

tsset pid year

gen chg_hwhead = hwhead - l.hwhead
gen chg_log_hwhead = loghwhead - l.loghwhead
gen chg_headwage = headwage - l.headwage
gen chg_log_faminc = chglog_faminc
gen single_female = (headmarried == 0 & gender == 2)
gen adults = famsize - children
gen hw = hwhead + hwwife
gen wifework = (wifehour > 0 & wifehour ~= .)
gen wifepartime = (wifehour > 0 & wifehour < 1820)
gen wifewage = wifelabor / wifehour if wifelabor > 0 & wifelabor ~= .
replace wifewage = 0 if wifewage == .
gen log_wifewage = log(wifewage)
replace log_wifewage = 0 if log_wifewage == .
gen logfoodout = log(foodout + 1)
gen logfood = log(foodin + foodout)
gen headage_cubic = headage ^ 3
egen count_u = count(pid) if headmarried == 0, by(pid)
egen count_m = count(pid) if headmarried == 1, by(pid)

local indep_vars = "construp constrdown logfood headblack i.headedu children adults single_female partime i.decile_faminc headage headage_squared headage_cubic"
areg foodoutratio `indep_vars' i.year if headmarried==0, vce(cluster pid) absorb(year)
estimates store food1
tobit foodoutratio `indep_vars' i.year if headmarried==0, vce(cluster pid) ll(0) ul(100)
estimates store food2
xtreg foodoutratio construp constrdown logfood children adults partime i.decile_faminc i.year if headmarried == 0 & count_u > 6, fe  
estimates store food3

local indep_vars = "construp constrdown logfood headblack i.headedu i.wifeedu children adults partime i.decile_faminc headage headage_squared headage_cubic"
areg foodoutratio `indep_vars' if headmarried == 1, vce(cluster pid) absorb(year)  
estimates store food4
tobit foodoutratio `indep_vars' i.year if headmarried == 1, ll(0)  
estimates store food5
xtreg foodoutratio construp constrdown logfood children adults partime i.decile_faminc i.year if headmarried == 1 & count_m > 6, fe  
estimates store food6
estout food1 food2 food3 food4 food5 food6 using "/href/research2/m1gxl01/BoardResearch/HP/Output/Revision/Foodpct.tex", style(tex) starlevels(* 0.1 ** 0.05 *** 0.01) cells(b(star fmt(3)) se(par fmt(3))) stats(r2 N, labels(R-squared) fmt(3 0)) replace  

local indep_vars = "construp constrdown logfood headblack i.headedu children adults single_female partime i.decile_faminc headage headage_squared headage_cubic"
areg foodoutratio `indep_vars' if headmarried==0 & extrapay == 1, vce(cluster pid) absorb(year)
estimates store food7
tobit foodoutratio `indep_vars' i.year if headmarried==0 & extrapay == 1, vce(cluster pid) ll(0) ul(100)
estimates store food8
xtreg foodoutratio construp constrdown logfood children adults partime i.decile_faminc i.year if headmarried == 0 & extrapay == 1 & count_u > 6, fe  
estimates store food9

local indep_vars = "construp constrdown logfood headblack i.headedu i.wifeedu children adults partime i.decile_faminc headage headage_squared headage_cubic"
areg foodoutratio `indep_vars' if headmarried == 1 & extrapay == 1, vce(cluster pid) absorb(year)  
estimates store food10
tobit foodoutratio `indep_vars' i.year if headmarried == 1 & extrapay == 1, ll(0)  
estimates store food11
xtreg foodoutratio construp constrdown logfood children adults partime i.decile_faminc i.year if headmarried == 1 & extrapay == 1 & count_m > 6, fe  
estimates store food12
estout food7 food8 food9 food10 food11 food12 using "/href/research2/m1gxl01/BoardResearch/HP/Output/Revision/Foodpct_extra.tex", style(tex) starlevels(* 0.1 ** 0.05 *** 0.01) cells(b(star fmt(3)) se(par fmt(3))) stats(r2 N, labels(R-squared) fmt(3 0)) replace  


use rand_wife_edu.dta, clear
replace wave = wave / 2
tsset hhidpn wave
gen partime = (headhour < 1800)
gen headage3 = headage ^ 3
tobit foodpct construp constrdown logfood headage headage2 headage3 white highschool somecollege college partime famsize p2 - p10 i.wave , vce(cluster hhidpn) ll(0)  
estimates store food13
tobit foodpct construp constrdown logfood headage headage2 headage3 white highschool somecollege college partime famsize p2 - p10 i.wave if howpaid == 2 | ot == 1, vce(cluster hhidpn) ll(0)  
estimates store food14
estout food2 food5 food8 food13 food14 food11 using "/href/research2/m1gxl01/BoardResearch/HP/Output/Revision/Foodpct_table.tex", style(tex) starlevels(* 0.1 ** 0.05 *** 0.01) cells(b(star fmt(3)) se(par fmt(3))) stats(r2 N, labels(R-squared) fmt(3 0)) replace  