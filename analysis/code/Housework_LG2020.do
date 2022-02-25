clear all
set more off, permanently
cd /hpc/household_finance/BoardResearch/HP/WorkDir/Revision

use "${dir}\analysis\input\pooled_orig.dta",clear
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
egen count_u = count(pid) if headmarried == 0, by(pid)
replace count_u = 0 if count_u == .
egen count_m = count(pid) if headmarried == 1, by(pid)
replace count_m = 0 if count_m == .
egen count_u_extra = count(pid) if headmarried == 0 & extrapay == 1, by(pid)
replace count_u_extra = 0 if count_u_extra == .
egen count_m_extra = count(pid) if headmarried == 1 & extrapay == 1, by(pid)
replace count_m_extra = 0 if count_m_extra == .
gen construp_partime = construp * partime
gen constrdown_partime = constrdown * partime
gen headage_cubic = headage ^ 3
******Singles can adjust housework hours only
local indep_vars = "construp construp_partime constrdown constrdown_partime partime headblack i.headedu children adults single_female i.decile_faminc headage headage_squared headage_cubic i.year"
areg hwhead `indep_vars' if headmarried == 0, vce(cluster pid) absorb(year)  
estimates store hw1
tobit hwhead `indep_vars'   if headmarried == 0, ll(0)  
estimates store hw2
estimates esample
xtreg hwhead construp construp_partime constrdown constrdown_partime partime children adults i.decile_faminc i.year if headmarried == 0 & e(sample) == 1, fe  
estimates store hw3
xtreg hwhead construp construp_partime constrdown constrdown_partime partime children adults i.decile_faminc i.year if headmarried == 0 & e(sample) == 1 & count_u > 5, fe  
estimates store hw4

areg hwhead `indep_vars'   if headmarried == 0 & extrapay == 1, vce(cluster pid) absorb(year)  
estimates store hw5
tobit hwhead `indep_vars'  if headmarried == 0 & extrapay == 1, ll(0)  
estimates store hw6
estimates esample
xtreg hwhead construp construp_partime constrdown constrdown_partime partime children adults i.decile_faminc i.year if headmarried == 0 & extrapay == 1 & e(sample) == 1, fe  
estimates store hw7
xtreg hwhead construp construp_partime constrdown constrdown_partime partime children adults i.decile_faminc i.year if headmarried == 0 & extrapay == 1 & e(sample) == 1 & count_u_extra > 5, fe  
estimates store hw8

estout hw1 hw2 hw3 hw4 hw5 hw6 hw7 hw8 using "/href/research2/m1gxl01/BoardResearch/HP/Output/Revision/HWSingle.tex", style(tex) starlevels(* 0.1 ** 0.05 *** 0.01) cells(b(star fmt(1)) se(par fmt(1))) stats(r2 N, labels(R-squared) fmt(2 0)) replace  

******Married can adjust housework hours and wife work hours
local indep_vars = "construp construp_partime constrdown constrdown_partime partime headblack i.headedu i.wifeedu children adults i.decile_faminc headage headage_squared headage_cubic i.year"
areg hwhead `indep_vars'   if headmarried == 1, vce(cluster pid) absorb(year)  
estimates store hw9
tobit hwhead `indep_vars' if headmarried == 1, ll(0)  
estimates store hw10
estimates esample
xtreg hwhead construp construp_partime constrdown constrdown_partime partime children adults i.decile_faminc i.year if headmarried == 1, fe  
estimates store hw11
xtreg hwhead construp construp_partime constrdown constrdown_partime partime children adults i.decile_faminc i.year if headmarried == 1 & count_m > 5, fe  
estimates store hw12

areg hwhead `indep_vars'   if headmarried == 1 & extrapay == 1, vce(cluster pid) absorb(year)  
estimates store hw13
tobit hwhead `indep_vars'  if headmarried == 1 & extrapay == 1, ll(0)  
estimates store hw14
estimates esample
xtreg hwhead construp construp_partime constrdown constrdown_partime partime children adults i.decile_faminc i.year if headmarried == 1 & extrapay == 1, fe  
estimates store hw15
xtreg hwhead construp construp_partime constrdown constrdown_partime partime children adults i.decile_faminc i.year if headmarried == 1 & extrapay == 1 & count_m_extra > 5, fe  
estimates store hw16
estout hw9 hw10 hw11 hw12 hw13 hw14 hw15 hw16 using "/href/research2/m1gxl01/BoardResearch/HP/Output/Revision/HWMarried.tex", style(tex) starlevels(* 0.1 ** 0.05 *** 0.01) cells(b(star fmt(1)) se(par fmt(1))) stats(r2 N, labels(R-squared) fmt(2 0)) replace  


areg hwhead `indep_vars'  if headmarried == 1, vce(cluster pid) absorb(year)  
estimates store hw7
tobit hwhead `indep_vars' i.year  if headmarried == 1, ll(0)  
estimates store hw8
xtreg hwhead construp constrdown children adults i.decile_faminc partime i.year if headmarried == 1 & count_m > 6, fe  
estimates store hw9

areg hwhead `indep_vars'  if headmarried == 1 & extrapay == 1, vce(cluster pid) absorb(year)  
estimates store hw10
tobit hwhead `indep_vars' i.year  if headmarried == 1 & extrapay == 1, ll(0)  
estimates store hw11
xtreg hwhead construp constrdown children adults i.decile_faminc partime i.year if headmarried == 1 & extrapay == 1 & count_m_extra > 6, fe  
estimates store hw12

logistic wifework `indep_vars' i.year if headmarried == 1 & l.wifework == 0, vce(cluster pid)  
estimates store hw13
areg wifehour `indep_vars'  if headmarried == 1 & l.wifework == 1, vce(cluster pid) absorb(year)  
estimates store hw14
xtreg wifehour construp constrdown children adults i.decile_faminc partime i.year if headmarried == 1 & l.wifework == 1 & count_m > 6, fe  
estimates store hw15

logistic wifework `indep_vars' i.year if headmarried == 1 & l.wifework == 0 & extrapay == 1, vce(cluster pid)  
estimates store hw16
areg wifehour `indep_vars'  if headmarried == 1 & l.wifework == 1 & extrapay == 1, vce(cluster pid) absorb(year)  
estimates store hw17
xtreg wifehour construp constrdown children adults i.decile_faminc partime i.year if headmarried == 1 & l.wifework == 1 & extrapay == 1 & count_m_extra > 6, fe
estimates store hw18
estout hw7 hw8 hw9 hw13 hw14 hw15 using "/href/research2/m1gxl01/BoardResearch/HP/Output/Revision/HWMarried.tex", style(tex) starlevels(* 0.1 ** 0.05 *** 0.01) cells(b(star fmt(2)) se(par fmt(2))) stats(r2 N, labels(R-squared) fmt(2 0)) replace  
estout hw13 hw14 hw15 hw16 hw17 hw18 using "/href/research2/m1gxl01/BoardResearch/HP/Output/Revision/WifeWork.tex", style(tex) starlevels(* 0.1 ** 0.05 *** 0.01) cells(b(star fmt(2)) se(par fmt(2))) stats(r2 N, labels(R-squared) fmt(2 0)) replace  


*areg hwhead `indep_vars', vce(cluster pid) absorb(year)  
*tobit hwhead `indep_vars' i.year, ll(0)  
*xtreg hwhead `indep_vars' i.year, fe  
*areg hwhead `indep_vars' if extrapay == 1, vce(cluster pid) absorb(year)  
*tobit hwhead `indep_vars' i.year if extrapay == 1, ll(0)  
*xtreg hwhead `indep_vars' i.year if extrapay == 1, fe  
*local indep_vars_all = "headage headage_squared headblack i.headedu partime became_hmowner became_married stay_married became_div_sep chg_num_children chg_log_faminc chg_log_headwage"
*areg chg_hwhead became_uc `indep_vars_all' if l.construp == 0, vce(cluster pid) absorb(year)  
*local indep_vars_all = "headage headage_squared headblack i.headedu partime became_hmowner became_married stay_married became_div_sep chg_num_children chg_log_faminc chg_log_headwage"
*areg chg_hwhead became_uc `indep_vars_all' if extrapay == 1 & l.construp == 0, vce(cluster pid) absorb(year)  

