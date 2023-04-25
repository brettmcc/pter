/*Brett McCully, June 2018
  
*/
cd "~\Dropbox\Hours constraints and home prod"
clear all
set more off, permanently

use "analysis\input\pooled.dta",clear

global indep_vars partime single_female headage headage_squared headage_cubic headblack i.headeduchildren adults i.decile_faminc
global indep_vars_personfe children adults i.decile_faminc partime
global indepvarsFEchg children adults age2 age6 age12 age18 dislimithswrk i.decile_faminc
**main estimates
//changes in logs, unweighted
reghdfe chg_logheadhours become_construp become_constrdown ${indep_vars_personfe} if headmarried==0,absorb(pid year) vce(cluster pid) nocons
estadd local pfe "Y"
estadd local yfe "Y"
estadd local controls "Y"
eststo logchghhuw, refresh 
reghdfe chg_logheadhwhour become_construp become_constrdown ${indep_vars_personfe} if headmarried==0,absorb(pid year) vce(cluster pid) nocons
estadd local pfe "Y"
estadd local yfe "Y"
estadd local controls "Y"
eststo logchghhwuw, refresh 
foreach var of varlist chg_logheadhours chg_logheadhwhour chg_logwifehours chg_logwifehwhour wife_enters_workforce {
	reghdfe `var' become_construp become_constrdown ${indep_vars_personfe} if headmarried==1,absorb(pid year) vce(cluster pid) nocons
	estadd local pfe "Y"
	estadd local yfe "Y"
	estadd local controls "Y"
	eststo `var'uw, refresh 
}
esttab logchghhuw logchghhwuw chg_logheadhoursuw chg_logheadhwhouruw chg_logwifehwhouruw chg_logwifehoursuw wife_enters_workforceuw using ///
	"analysis/output/tables/effects_of_constr_logchguw.tex", replace se r2 label scalars("pfe Person FE" "yfe Year FE" "controls Controls") nonotes star(* 0.10 ** 0.05 *** 0.01) ///
	keep(become_construp become_constrdown) booktabs ///
	mgroups("Single" "Married",pattern(1 0 1 0 0 0 0) span prefix(\multicolumn{@span}{c}{) suffix(}) end(\cmidrule(lr){2-3}\cmidrule(lr){4-8})) mtitle("\shortstack{Chg. log\\head work\\hours}" "\shortstack{Chg. log\\head HW\\hours}" "\shortstack{Chg. log\\head work\\hours}" "\shortstack{Chg. log\\head HW\\hours}" "\shortstack{Chg. log\\wife work\\hours}" "\shortstack{Chg. log\\wife HW\\hours}" "\shortstack{=1 if\\wife starts\\working}") ///
	substitute("\_" "_" "{l}{\footnotesize" "{p{16cm}}{\footnotesize" ) ///
	addnotes("\textit{Notes:} The table presents coefficient estimates from equation \ref{eq:housework} using data from the Panel Study of Income Dynamics. Columns 1 and 2 subset to single-headed households, while columns 3--7 subset to married households. Estimates are unweighted, with standard errors clustered at the household-head level. \sym{*}, \sym{**}, and \sym{***} denote statistical significance at the 10\%, 5\%, and 1\% levels, respectively.")
//level changes, unweighted
reghdfe chg_headhours become_construp become_constrdown ${indep_vars_personfe},absorb(pid year) vce(cluster pid) nocons
estadd local pfe "Y"
estadd local yfe "Y"
estadd local controls "Y"
eststo chghhuw, refresh 
reghdfe chg_headhwhour become_construp become_constrdown ${indep_vars_personfe},absorb(pid year) vce(cluster pid) nocons
estadd local pfe "Y"
estadd local yfe "Y"
estadd local controls "Y"
eststo chghwuw, refresh 
foreach var of varlist chg_headhours chg_headhwhour chg_wifehwhour chg_wifehours wife_enters_workforce {
	reghdfe `var' become_construp become_constrdown ${indep_vars_personfe} if headmarried==1,absorb(pid year) vce(cluster pid) nocons
	estadd local pfe "Y"
	estadd local yfe "Y"
	estadd local controls "Y"
	eststo `var'uw, refresh 
}
esttab chghhuw chghwuw chg_headhoursuw chg_headhwhouruw chg_wifehwhouruw chg_wifehoursuw wife_enters_workforceuw using ///
	"analysis/output/tables/effects_of_constr_chguw.tex", replace se r2 label scalars("pfe Person FE" "yfe Year FE" "controls Controls") nonotes star(* 0.10 ** 0.05 *** 0.01) ///
	keep(become_construp become_constrdown) booktabs ///
	mgroups("Single" "Married",pattern(1 0 1 0 0 0 0) span prefix(\multicolumn{@span}{c}{) suffix(}) end(\cmidrule(lr){2-3}\cmidrule(lr){4-8})) mtitle("\shortstack{Chg.\\head work\\hours}" "\shortstack{Chg.\\head HW\\hours}" "\shortstack{Chg.\\head work\\hours}" "\shortstack{Chg.\\head HW\\hours}" "\shortstack{Chg.\\wife work\\hours}" "\shortstack{Chg.\\wife HW\\hours}" "\shortstack{=1 if\\wife starts\\working}") ///
	substitute("\_" "_" "{l}{\footnotesize" "{p{16cm}}{\footnotesize" ) ///
	addnotes("\textit{Notes:} The table presents coefficient estimates from equation \ref{eq:housework} using data from the Panel Study of Income Dynamics. Columns 1 and 2 subset to single-headed households, while columns 3--7 subset to married households. Estimates are unweighted, with standard errors clustered at the household-head level. \sym{*}, \sym{**}, and \sym{***} denote statistical significance at the 10\%, 5\%, and 1\% levels, respectively.")
//changes in logs, weighted
reghdfe chg_logheadhours become_construp become_constrdown ${indep_vars_personfe} [aw=wgt],absorb(pid year) vce(cluster pid) nocons
estadd local pfe "Y"
estadd local yfe "Y"
estadd local controls "Y"
eststo logchghhw, refresh
reghdfe chg_logheadhwhour become_construp become_constrdown ${indep_vars_personfe} [aw=wgt],absorb(pid year) vce(cluster pid) nocons
estadd local pfe "Y"
estadd local yfe "Y"
estadd local controls "Y"
eststo logchghhww, refresh
foreach var of varlist chg_logheadhours chg_logheadhwhour chg_logwifehwhour chg_logwifehours wife_enters_workforce {
	reghdfe `var' become_construp become_constrdown ${indep_vars_personfe} if headmarried==1 [aw=wgt],absorb(pid year) vce(cluster pid) nocons
	estadd local pfe "Y"
	estadd local yfe "Y"
	estadd local controls "Y"
	eststo `var'w, refresh
}
esttab logchghhw logchghhww chg_logheadhoursw chg_logheadhwhourw chg_logwifehwhourw chg_logwifehoursw wife_enters_workforcew using ///
	"analysis/output/tables/effects_of_constr_logchgw.tex", replace se r2 label scalars("pfe Person FE" "yfe Year FE" "controls Controls") nonotes star(* 0.10 ** 0.05 *** 0.01) ///
	keep(become_construp become_constrdown) booktabs ///
	mgroups("Single" "Married",pattern(1 0 1 0 0 0 0) span prefix(\multicolumn{@span}{c}{) suffix(}) end(\cmidrule(lr){2-3}\cmidrule(lr){4-8})) mtitle("\shortstack{Chg. log\\head work\\hours}" "\shortstack{Chg. log\\head HW\\hours}" "\shortstack{Chg. log\\head work\\hours}" "\shortstack{Chg. log\\head HW\\hours}" "\shortstack{Chg. log\\wife work\\hours}" "\shortstack{Chg. log\\wife HW\\hours}" "\shortstack{=1 if\\wife starts\\working}") ///
	substitute("\_" "_" "{l}{\footnotesize" "{p{16cm}}{\footnotesize" ) ///
	addnotes("\textit{Notes:} The table presents coefficient estimates from equation \ref{eq:housework} using data from the Panel Study of Income Dynamics. Columns 1 and 2 subset to single-headed households, while columns 3--7 subset to married households. Estimates are weighted, with standard errors clustered at the household-head level. \sym{*}, \sym{**}, and \sym{***} denote statistical significance at the 10\%, 5\%, and 1\% levels, respectively.")
//changes in levels, weighted
reghdfe chg_headhours become_construp become_constrdown ${indep_vars_personfe} [aw=wgt],absorb(pid year) vce(cluster pid) nocons
estadd local pfe "Y"
estadd local yfe "Y"
estadd local controls "Y"
eststo chghhw, refresh 
reghdfe chg_headhwhour become_construp become_constrdown ${indep_vars_personfe} [aw=wgt],absorb(pid year) vce(cluster pid) nocons
estadd local pfe "Y"
estadd local yfe "Y"
estadd local controls "Y"
eststo chghww, refresh 
foreach var of varlist chg_headhours chg_headhwhour chg_wifehwhour chg_wifehours wife_enters_workforce {
	reghdfe `var' become_construp become_constrdown ${indep_vars_personfe} if headmarried==1 [aw=wgt],absorb(pid year) vce(cluster pid) nocons
	estadd local pfe "Y"
	estadd local yfe "Y"
	estadd local controls "Y"
	eststo `var'w, refresh 
}
esttab chghhw chghww chg_headhoursw chg_headhwhourw chg_wifehwhourw chg_wifehoursw wife_enters_workforcew using ///
	"analysis/output/tables/effects_of_constr_chgw.tex", replace se r2 label scalars("pfe Person FE" "yfe Year FE" "controls Controls") nonotes star(* 0.10 ** 0.05 *** 0.01) ///
	keep(become_construp become_constrdown) booktabs ///
	mgroups("Single" "Married",pattern(1 0 1 0 0 0 0) span prefix(\multicolumn{@span}{c}{) suffix(}) end(\cmidrule(lr){2-3}\cmidrule(lr){4-8})) mtitle("\shortstack{Chg.\\head work\\hours}" "\shortstack{Chg.\\head HW\\hours}" "\shortstack{Chg.\\head work\\hours}" "\shortstack{Chg.\\head HW\\hours}" "\shortstack{Chg.\\wife work\\hours}" "\shortstack{Chg.\\wife HW\\hours}" "\shortstack{=1 if\\wife starts\\working}") ///
	substitute("\_" "_" "{l}{\footnotesize" "{p{16cm}}{\footnotesize" ) ///
	addnotes("\textit{Notes:} The table presents coefficient estimates from equation \ref{eq:housework} using data from the Panel Study of Income Dynamics. Columns 1 and 2 subset to single-headed households, while columns 3--7 subset to married households. Estimates are weighted, with standard errors clustered at the household-head level. \sym{*}, \sym{**}, and \sym{***} denote statistical significance at the 10\%, 5\%, and 1\% levels, respectively.")
//logs, unweighted
ppmlhdfe headhourweekly construp constrdown ${indep_vars_personfe} if headmarried==0 & headhwweekly!=.,absorb(pid year) vce(cluster pid) nocons
estadd local pfe "Y"
estadd local yfe "Y"
estadd local controls "Y"
eststo loghhuw, refresh 
ppmlhdfe headhwweekly construp constrdown ${indep_vars_personfe} if headmarried==0,absorb(pid year) vce(cluster pid) nocons
estadd local pfe "Y"
estadd local yfe "Y"
estadd local controls "Y"
eststo loghhwuw, refresh 
foreach var of varlist headhourweekly headhwweekly wifehourweekly wifehwweekly wifelfp {
	ppmlhdfe `var' construp constrdown ${indep_vars_personfe} if headmarried==1 & headhwweekly!=.,absorb(pid year) vce(cluster pid) nocons
	estadd local pfe "Y"
	estadd local yfe "Y"
	estadd local controls "Y"
	eststo `var'uw, refresh 
}
esttab loghhuw loghhwuw headhourweeklyuw headhwweeklyuw wifehourweeklyuw wifehwweeklyuw wifelfpuw using ///
	"analysis/output/tables/effects_of_constr_ppmluw.tex", replace se r2 label scalars("pfe Person FE" "yfe Year FE" "controls Controls") nonotes star(* 0.10 ** 0.05 *** 0.01) ///
	keep(construp constrdown) booktabs ///
	mgroups("Single" "Married",pattern(1 0 1 0 0 0 0) span prefix(\multicolumn{@span}{c}{) suffix(}) end(\cmidrule(lr){2-3}\cmidrule(lr){4-8})) mtitle("\shortstack{Head work\\hours}" "\shortstack{Head HW\\hours}" "\shortstack{Head work\\hours}" "\shortstack{Head HW\\hours}" "\shortstack{Wife work\\hours}" "\shortstack{Wife HW\\hours}" "\shortstack{Wife\\working}") ///
	substitute("\_" "_" "{l}{\footnotesize" "{p{16cm}}{\footnotesize" ) ///
	addnotes("\textit{Notes:} The table presents PPML coefficient estimates from equation \ref{eq:housework} using data from the Panel Study of Income Dynamics. Columns 1 and 2 subset to single-headed households, while columns 3--7 subset to married households. Estimates are unweighted, with standard errors clustered at the household-head level. \sym{*}, \sym{**}, and \sym{***} denote statistical significance at the 10\%, 5\%, and 1\% levels, respectively.")
//levels, unweighted
reghdfe headhourweekly construp constrdown ${indep_vars_personfe} if headmarried==0 & headhwweekly!=.,absorb(pid year) vce(cluster pid) nocons
sum headhourweekly
local mean = r(mean)
estadd scalar mean = `mean'
estadd local pfe "Y"
estadd local yfe "Y"
estadd local controls "Y"
eststo hhuw, refresh 
reghdfe headhwweekly construp constrdown ${indep_vars_personfe} if headmarried==0,absorb(pid year) vce(cluster pid) nocons
sum headhwweekly
local mean = r(mean)
estadd scalar mean = `mean'
estadd local pfe "Y"
estadd local yfe "Y"
estadd local controls "Y"
eststo hhwuw, refresh 
foreach var of varlist headhourweekly headhwweekly wifehourweekly wifehwweekly wifelfp {
	reghdfe `var' construp constrdown ${indep_vars_personfe} if headmarried==1 & headhwweekly!=.,absorb(pid year) vce(cluster pid) nocons
	sum `var'
	local mean = r(mean)
	estadd scalar mean = `mean'
	estadd local pfe "Y"
	estadd local yfe "Y"
	estadd local controls "Y"
	eststo `var'uw, refresh 
}
esttab hhuw hhwuw headhourweeklyuw headhwweeklyuw wifehourweeklyuw wifehwweeklyuw wifelfpuw using ///
	"analysis/output/tables/effects_of_constr_lvluw.tex", replace se r2 label scalars("mean Dep. var. mean" "pfe Person FE" "yfe Year FE" "controls Controls") nonotes star(* 0.10 ** 0.05 *** 0.01) ///
	keep(construp constrdown) booktabs ///
	mgroups("Single" "Married",pattern(1 0 1 0 0 0 0) span prefix(\multicolumn{@span}{c}{) suffix(}) end(\cmidrule(lr){2-3}\cmidrule(lr){4-8})) mtitle("\shortstack{Head work\\hours}" "\shortstack{Head HW\\hours}" "\shortstack{Head work\\hours}" "\shortstack{Head HW\\hours}" "\shortstack{Wife work\\hours}" "\shortstack{Wife HW\\hours}" "\shortstack{Wife\\working}") ///
	substitute("\_" "_" "{l}{\footnotesize" "{p{17cm}}{\footnotesize" ) ///
	addnotes("\textit{Notes:} The table presents coefficient estimates from equation \ref{eq:housework} using data from the Panel Study of Income Dynamics. Columns 1 and 2 subset to single-headed households, while columns 3--7 subset to married households. Estimates are unweighted, with standard errors clustered at the household-head level. \sym{*}, \sym{**}, and \sym{***} denote statistical significance at the 10\%, 5\%, and 1\% levels, respectively.")
//logs, weighted
ppmlhdfe headhourweekly construp constrdown ${indep_vars_personfe} if headmarried==0 & headhwweekly!=. [pw=wgt],absorb(pid year) vce(cluster pid) nocons
estadd local pfe "Y"
estadd local yfe "Y"
estadd local controls "Y"
eststo loghhuw, refresh 
ppmlhdfe headhwweekly construp constrdown ${indep_vars_personfe} if headmarried==0 [pw=wgt],absorb(pid year) vce(cluster pid) nocons
estadd local pfe "Y"
estadd local yfe "Y"
estadd local controls "Y"
eststo loghhwuw, refresh 
foreach var of varlist headhourweekly headhwweekly wifehourweekly wifehwweekly wifelfp {
	ppmlhdfe `var' construp constrdown ${indep_vars_personfe} if headmarried==1 & headhwweekly!=. [pw=wgt],absorb(pid year) vce(cluster pid) nocons
	estadd local pfe "Y"
	estadd local yfe "Y"
	estadd local controls "Y"
	eststo `var'uw, refresh 
}
esttab loghhuw loghhwuw headhourweeklyuw headhwweeklyuw wifehourweeklyuw wifehwweeklyuw wifelfpuw using ///
	"analysis/output/tables/effects_of_constr_ppmlw.tex", replace se r2 label scalars("pfe Person FE" "yfe Year FE" "controls Controls") nonotes star(* 0.10 ** 0.05 *** 0.01) ///
	keep(construp constrdown) booktabs ///
	mgroups("Single" "Married",pattern(1 0 1 0 0 0 0) span prefix(\multicolumn{@span}{c}{) suffix(}) end(\cmidrule(lr){2-3}\cmidrule(lr){4-8})) mtitle("\shortstack{Head work\\hours}" "\shortstack{Head HW\\hours}" "\shortstack{Head work\\hours}" "\shortstack{Head HW\\hours}" "\shortstack{Wife work\\hours}" "\shortstack{Wife HW\\hours}" "\shortstack{Wife\\working}") ///
	substitute("\_" "_" "{l}{\footnotesize" "{p{16cm}}{\footnotesize" ) ///
	addnotes("\textit{Notes}: The table presents PPML coefficient estimates from equation \ref{eq:housework} using data from the Panel Study of Income Dynamics. Columns 1 and 2 subset to single-headed households, while columns 3--7 subset to married households. Estimates are weighted, with standard errors clustered at the household-head level. \sym{*}, \sym{**}, and \sym{***} denote statistical significance at the 10\%, 5\%, and 1\% levels, respectively.")
//levels, weighted
reghdfe headhour construp constrdown ${indep_vars_personfe} if headmarried==0 & headhwweekly!=. [aw=wgt],absorb(pid year) vce(cluster pid) nocons
sum headhour if headmarried==0 & headhwweekly!=. [aw=wgt]
local mean = r(mean)
estadd scalar mean = `mean'
estadd local pfe "Y"
estadd local yfe "Y"
estadd local controls "Y"
eststo lvlw1, refresh 
reghdfe hwhead construp constrdown ${indep_vars_personfe} if headmarried==0 [aw=wgt],absorb(pid year) vce(cluster pid) nocons
sum hwhead if headmarried==0 [aw=wgt]
local mean = r(mean)
estadd scalar mean = `mean'
estadd local pfe "Y"
estadd local yfe "Y"
estadd local controls "Y"
eststo lvlw2, refresh 
local i = 3
foreach var of varlist headhour hwhead wifehour hwwife wifelfp {
	reghdfe `var' construp constrdown ${indep_vars_personfe} if headmarried==1 & headhwweekly!=. [aw=wgt],absorb(pid year) vce(cluster pid) nocons
	sum `var' if headmarried==1 & headhwweekly!=.  [aw=wgt]
	local mean = r(mean)
	estadd scalar mean = `mean'
	estadd local pfe "Y"
	estadd local yfe "Y"
	estadd local controls "Y"
	eststo lvlw`i', refresh 
	local i = `i'+1
}
reghdfe headhour construp constrdown ${indep_vars_personfe} if headmarried==1 & headhwweekly!=.,absorb(pid year) vce(cluster pid)
sort pid year
capture bysort pid: egen awgt = mean(wgt)
xtreg headhour construp constrdown ${indep_vars_personfe} if headmarried==1 & headhwweekly!=.,fe vce(cluster pid)
xtlogit wifelfp construp constrdown ${indep_vars_personfe} if headmarried==1 [iw=awgt],fe vce(oim) nocons
esttab lvlw1 lvlw2 lvlw3 lvlw4 lvlw5 lvlw6 lvlw7 using ///
	"analysis/output/tables/effects_of_constr_lvlw.tex", replace se r2 label scalars("mean Dep. var. mean" "pfe Person FE" "yfe Year FE" "controls Controls") nonotes star(* 0.10 ** 0.05 *** 0.01) ///
	keep(construp constrdown) booktabs ///
	mgroups("Single" "Married",pattern(1 0 1 0 0 0 0) span prefix(\multicolumn{@span}{c}{) suffix(}) end(\cmidrule(lr){2-3}\cmidrule(lr){4-8})) mtitle("\shortstack{Head work\\hours}" "\shortstack{Head HW\\hours}" "\shortstack{Head work\\hours}" "\shortstack{Head HW\\hours}" "\shortstack{Wife work\\hours}" "\shortstack{Wife HW\\hours}" "\shortstack{Wife\\working}") ///
	substitute("\_" "_" ) 

**effect of unemployment on wife FLFP
global wgt [aw=wgt]
global ifcond & headhwweekly!=. & headage>=22 & headage<68
use if headage>=22 & headage<70 & selfemployed!=1 using "analysis\input\pooled_all.dta",clear
gen unemployed = headstatus==2
reghdfe headhour unemployed ${indep_vars_personfe} if headmarried==0 ${ifcond} ${wgt},absorb(pid year) vce(cluster pid) nocons
sum headhour if headmarried==0 ${ifcond} ${wgt}
local mean = r(mean)
estadd scalar mean = `mean'
estadd local pfe "Y"
estadd local yfe "Y"
estadd local controls "Y"
eststo unemp1, refresh 
reghdfe hwhead unemployed ${indep_vars_personfe} if headmarried==0 ${ifcond} ${wgt},absorb(pid year) vce(cluster pid) nocons
sum hwhead if headmarried==0 ${ifcond} ${wgt}
local mean = r(mean)
estadd scalar mean = `mean'
estadd local pfe "Y"
estadd local yfe "Y"
estadd local controls "Y"
eststo unemp2, refresh 
local i = 3
foreach var of varlist headhour hwhead wifehour hwwife wifelfp {
	reghdfe `var' unemployed ${indep_vars_personfe} if headmarried==1 ${ifcond} ${wgt},absorb(pid year) vce(cluster pid) nocons
	sum `var' if headmarried==1 ${ifcond} ${wgt}
	local mean = r(mean)
	estadd scalar mean = `mean'
	estadd local pfe "Y"
	estadd local yfe "Y"
	estadd local controls "Y"
	eststo unemp`i', refresh 
	local i = `i'+1
}
esttab unemp1 unemp2 unemp3 unemp4 unemp5 unemp6 unemp7 using ///
	"analysis/output/tables/effects_of_unemp_psid_22to67.tex", replace se r2 label scalars("mean Dep. var. mean" "pfe Person FE" "yfe Year FE" "controls Controls") nonotes star(* 0.10 ** 0.05 *** 0.01) ///
	keep(unemployed) booktabs ///
	mgroups("Single" "Married",pattern(1 0 1 0 0 0 0) span prefix(\multicolumn{@span}{c}{) suffix(}) end(\cmidrule(lr){2-3}\cmidrule(lr){4-8})) mtitle("\shortstack{Head work\\hours}" "\shortstack{Head HW\\hours}" "\shortstack{Head work\\hours}" "\shortstack{Head HW\\hours}" "\shortstack{Wife work\\hours}" "\shortstack{Wife HW\\hours}" "\shortstack{Wife\\working}") ///
	substitute("\_" "_" ) 

//foodout ratio
*psid
use "analysis\input\pooled.dta",clear
label variable construp "Upside constrained"
label variable constrdown "Downside constrained"
reghdfe foodoutratio construp constrdown ${indep_vars_personfe} if headmarried==0 & headhwweekly!=. [aw=wgt],absorb(pid year) vce(cluster pid) nocons
sum foodoutratio if headmarried==0 & headhwweekly!=. [aw=wgt]
local mean = r(mean)
estadd scalar mean = `mean'
estadd local pfe "Y"
estadd local yfe "Y"
estadd local controls "Y"
eststo psidfo1, refresh 
reghdfe foodoutratio construp constrdown ${indep_vars_personfe} if headmarried==1 & headhwweekly!=. [aw=wgt],absorb(pid year) vce(cluster pid) nocons
sum foodoutratio if headmarried==1 & headhwweekly!=. [aw=wgt]
local mean = r(mean)
estadd scalar mean = `mean'
estadd local pfe "Y"
estadd local yfe "Y"
estadd local controls "Y"
eststo psidfo2, refresh 
*hrs
use "analysis\input\hrsdata.dta",clear
reghdfe foodoutratio construp constrdown famsize i.decile_faminc partime if married==0 [aw=wgt],absorb(hhidpn wave) vce(cluster hhidpn) nocons
sum foodoutratio if married==0 [aw=wgt]
local mean = r(mean)
estadd scalar mean = `mean'
estadd local pfe "Y"
estadd local yfe "Y"
estadd local controls "Y"
eststo hrsfo1, refresh 
reghdfe foodoutratio construp constrdown famsize i.decile_faminc partime if married==1 [aw=wgt],absorb(hhidpn wave) vce(cluster hhidpn) nocons
sum foodoutratio if married==1 [aw=wgt]
local mean = r(mean)
estadd scalar mean = `mean'
estadd local pfe "Y"
estadd local yfe "Y"
estadd local controls "Y"
eststo hrsfo2, refresh
esttab psidfo1 psidfo2 hrsfo1 hrsfo2 using ///
	"analysis/output/tables/foodout.tex", replace se r2 label scalars("mean Dep. var. mean" "pfe Person FE" "yfe Year FE" "controls Controls") nonotes star(* 0.10 ** 0.05 *** 0.01) ///
	keep(construp constrdown) booktabs ///
	mgroups("PSID" "HRS",pattern(1 0 1 0) span prefix(\multicolumn{@span}{c}{) suffix(}) end(\cmidrule(lr){2-3}\cmidrule(lr){4-5})) mtitle("Single" "Married" "Single" "Married" ) ///
	substitute("\_" "_")

/*Level of Head housework hours*
reg headhwweekly construp constrdown [aweight=wgt], vce(cluster pid)
sum headhwweekly [aweight=wgt] 
// outreg2 using /*
// 	*/C:\Users\bmccully\Documents\pter-master\analysis\output\determinants_homework /*
// 	*/,label replace ctitle("Head Wkly HW") /*
// 	*/title(Determinants of Home Work Hours) addtext(Controls, No, Year FE, No, Person FE, No) /*
// 	*/addstat(Dep. var. mean, r(mean)) keep(construp constrdown)
reg headhwweekly construp constrdown ${indep_vars} [aweight=wgt],/*
	*/vce(cluster pid)
sum headhwweekly [aweight=wgt] 
// outreg2 using /*
// 	*/C:\Users\bmccully\Documents\pter-master\analysis\output\determinants_homework /*
// 	*/,label tex(frag) append ctitle("Head Wkly HW") /*
// 	*/addtext(Controls, Yes, Year FE, No, Person FE, No) /*
// 	*/addstat(Dep. var. mean, r(mean)) keep(construp constrdown)
areg headhwweekly construp constrdown ${indep_vars} /*
	*/[aweight=wgt], vce(cluster pid) absorb(year)
sum headhwweekly [aweight=wgt] 
// outreg2 using /*
// 	*/C:\Users\bmccully\Documents\pter-master\analysis\output\determinants_homework /*
// 	*/,label tex(frag) append ctitle("Head Wkly HW") /*
// 	*/addtext(Controls, Yes, Year FE, Yes, Person FE, No) /*
// 	*/addstat(Dep. var. mean, r(mean)) keep(construp constrdown) 
areg headhwweekly construp constrdown ${indep_vars_personfe} i.year /*
	*/[aweight=wgt], vce(cluster pid) absorb(pid)
sum headhwweekly [aweight=wgt] 
// outreg2 using /*
// 	*/C:\Users\bmccully\Documents\pter-master\analysis\output\determinants_homework /*
// 	*/,label tex(frag) append ctitle("Head Wkly HW") /*
// 	*/addtext(Controls, Yes, Year FE, Yes, Person FE, Yes) /*
// 	*/addstat(Dep. var. mean, r(mean)) keep(construp constrdown)

	
/*Log of Head housework hours*/
reg logheadhwweekly construp constrdown [aweight=wgt], vce(cluster pid)
// outreg2 using /*
// 	*/C:\Users\bmccully\Documents\pter-master\analysis\output\determinants_homework_log /*
// 	*/,label replace ctitle("Ln Head HW") /*
// 	*/addtext(Controls, No, Year FE, No, Person FE, No) /*
// 	*/keep(construp constrdown)
reg logheadhwweekly construp constrdown ${indep_vars} [aweight=wgt],/*
	*/vce(cluster pid)
// outreg2 using /*
// 	*/C:\Users\bmccully\Documents\pter-master\analysis\output\determinants_homework_log /*
// 	*/,label tex(frag) append ctitle("Ln Head HW") /*
// 	*/addtext(Controls, Yes, Year FE, No, Person FE, No) /*
// 	*/ keep(construp constrdown)
areg logheadhwweekly construp constrdown ${indep_vars} /*
	*/[aweight=wgt], vce(cluster pid) absorb(year)
// outreg2 using /*
// 	*/C:\Users\bmccully\Documents\pter-master\analysis\output\determinants_homework_log /*
// 	*/,label tex(frag) append ctitle("Ln Head HW") /*
// 	*/addtext(Controls, Yes, Year FE, Yes, Person FE, No) /*
// 	*/keep(construp constrdown) 
areg logheadhwweekly construp constrdown ${indep_vars_personfe} i.year /*
	*/[aweight=wgt], vce(cluster pid) absorb(pid)
// outreg2 using /*
// 	*/C:\Users\bmccully\Documents\pter-master\analysis\output\determinants_homework_log /*
// 	*/,label tex(frag) append ctitle("Ln Head HW") /*
// 	*/addtext(Controls, Yes, Year FE, Yes, Person FE, Yes) /*
// 	*/ keep(construp constrdown)
	
	
local indep_vars = /*
	*/"headfemale headage headage_squared headblack i.headedu dislimithswrk headsecjob age2 age6 age12 age18 nonlabor_inc log_headwage"
local indep_vars_personfe = /*
	*/"headage headage_squared i.headedu dislimithswrk headsecjob age2 age6 age12 age18 nonlabor_inc"
	
reg headhwweekly c.construp##c.headhourweekly /*
	*/c.constrdown##c.headhourweekly [aweight=wgt], vce(cluster pid)
reg headhwweekly c.construp##c.headhourweekly /*
	*/c.constrdown##c.headhourweekly `indep_vars' [aweight=wgt],/*
	*/vce(cluster pid)
areg headhwweekly c.construp##c.headhourweekly /*
	*/c.constrdown##c.headhourweekly `indep_vars' /*
	*/[aweight=wgt], vce(cluster pid) absorb(year)
areg headhwweekly c.construp##c.headhourweekly /*
	*/c.constrdown##c.headhourweekly `indep_vars_personfe' i.year /*
	*/[aweight=wgt], vce(cluster pid) absorb(pid)
	
reg logheadhwweekly construp constrdown [aweight=wgt], vce(cluster pid)
reg logheadhwweekly construp constrdown `indep_vars' [aweight=wgt],/*
	*/vce(cluster pid)
areg logheadhwweekly construp constrdown `indep_vars' /*
	*/[aweight=wgt], vce(cluster pid) absorb(year)
areg logheadhwweekly construp constrdown `indep_vars_personfe' i.year /*
	*/[aweight=wgt], vce(cluster pid) absorb(pid)

	
/*Robustness check -- do for those working <55 hours/week*/
use "$analysisin\pooled.dta",clear
drop if headhourweekly>55

local indep_vars = /*
	*/"headfemale headage headage_squared headblack i.headedu dislimithswrk headsecjob age2 age6 age12 age18 nonlabor_inc log_headwage"
local indep_vars_personfe = /*
	*/"headage headage_squared i.headedu dislimithswrk headsecjob age2 age6 age12 age18 nonlabor_inc"
	
/*Level of Head housework hours*/
reg headhwweekly construp constrdown [aweight=wgt], vce(cluster pid)
sum headhwweekly [aweight=wgt] 
outreg2 using /*
	*/C:\Users\bmccully\Documents\pter-master\analysis\output\determinants_homework_lt55hr /*
	*/,label replace ctitle("Head Wkly HW") /*
	*/title(Determinants of Home Work Hours) addtext(Controls, No, Year FE, No, Person FE, No) /*
	*/addstat(Dep. var. mean, r(mean)) keep(construp constrdown)
reg headhwweekly construp constrdown `indep_vars' [aweight=wgt],/*
	*/vce(cluster pid)
sum headhwweekly [aweight=wgt] 
outreg2 using /*
	*/C:\Users\bmccully\Documents\pter-master\analysis\output\determinants_homework_lt55hr /*
	*/,label tex(frag) append ctitle("Head Wkly HW") /*
	*/addtext(Controls, Yes, Year FE, No, Person FE, No) /*
	*/addstat(Dep. var. mean, r(mean)) keep(construp constrdown)
areg headhwweekly construp constrdown `indep_vars' /*
	*/[aweight=wgt], vce(cluster pid) absorb(year)
sum headhwweekly [aweight=wgt] 
outreg2 using /*
	*/C:\Users\bmccully\Documents\pter-master\analysis\output\determinants_homework_lt55hr /*
	*/,label tex(frag) append ctitle("Head Wkly HW") /*
	*/addtext(Controls, Yes, Year FE, Yes, Person FE, No) /*
	*/addstat(Dep. var. mean, r(mean)) keep(construp constrdown) 
areg headhwweekly construp constrdown `indep_vars_personfe' i.year /*
	*/[aweight=wgt], vce(cluster pid) absorb(pid)
sum headhwweekly [aweight=wgt] 
outreg2 using /*
	*/C:\Users\bmccully\Documents\pter-master\analysis\output\determinants_homework_lt55hr /*
	*/,label tex(frag) append ctitle("Head Wkly HW") /*
	*/addtext(Controls, Yes, Year FE, Yes, Person FE, Yes) /*
	*/addstat(Dep. var. mean, r(mean)) keep(construp constrdown)

	
/*Log of Head housework hours*/
reg logheadhwweekly construp constrdown [aweight=wgt], vce(cluster pid)
outreg2 using /*
	*/C:\Users\bmccully\Documents\pter-master\analysis\output\determinants_homework_log_lt55hr /*
	*/,label replace ctitle("Ln Head HW") /*
	*/addtext(Controls, No, Year FE, No, Person FE, No) /*
	*/keep(construp constrdown)
reg logheadhwweekly construp constrdown `indep_vars' [aweight=wgt],/*
	*/vce(cluster pid)
outreg2 using /*
	*/C:\Users\bmccully\Documents\pter-master\analysis\output\determinants_homework_log_lt55hr /*
	*/,label tex(frag) append ctitle("Ln Head HW") /*
	*/addtext(Controls, Yes, Year FE, No, Person FE, No) /*
	*/ keep(construp constrdown)
areg logheadhwweekly construp constrdown `indep_vars' /*
	*/[aweight=wgt], vce(cluster pid) absorb(year)
outreg2 using /*
	*/C:\Users\bmccully\Documents\pter-master\analysis\output\determinants_homework_log_lt55hr /*
	*/,label tex(frag) append ctitle("Ln Head HW") /*
	*/addtext(Controls, Yes, Year FE, Yes, Person FE, No) /*
	*/keep(construp constrdown) 
areg logheadhwweekly construp constrdown `indep_vars_personfe' i.year /*
	*/[aweight=wgt], vce(cluster pid) absorb(pid)
outreg2 using /*
	*/C:\Users\bmccully\Documents\pter-master\analysis\output\determinants_homework_log_lt55hr /*
	*/,label tex(frag) append ctitle("Ln Head HW") /*
	*/addtext(Controls, Yes, Year FE, Yes, Person FE, Yes) /*
	*/ keep(construp constrdown)
