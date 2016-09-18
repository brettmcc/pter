/*Fill in statistics of tables Li Geng made.
December 2014*/

clear all
set more off

use "..\..\build\output\pooled.dta",clear
label define cstr 0 "unconstrained" 1 "up constr." 2 "down constr"
gen constr = 0
replace constr = 1 if construp==1
replace constr = 2 if constrdown==1
label values constr cstr

label define educ 1 "Dropped out before completing high school" 2 "High school grad" 3 "Some post-secondary education" 4 "College or higher degree"
label values headedu educ
gen lnwage = ln(headlabor/headhour*cpi)
gen lnwfwage = ln(wifelabor/wifehour*cpi)
gen lnnonlaborinc = ln((faminc-headlabor)*cpi)
replace lnnonlaborinc = 0 if faminc==headlabor

tsset pid year
tsfill, full

/*Table 2*/
*underemployed/upward constrained
preserve
keep if l1.construp==1
tab constr
restore

*"normal" or unconstrained
preserve
keep if !inlist(l1.construp,1,.) & !inlist(l1.constrdown,1,.)
tab constr
restore

*overemployed/downward constrained
preserve 
keep if l1.constrdown==1
tab constr
restore

/*Table 3*/
sort pid year
gen hour_diff = headhour - l1.headhour
*normal to underemployed
sum hour_diff if !inlist(l1.construp,1,.) & !inlist(l1.constrdown,1,.) & construp==1,detail
*normal to overemployed
sum hour_diff if !inlist(l1.construp,1,.) & !inlist(l1.constrdown,1,.) & constrdown==1,detail 
*underemployed to normal
sum hour_diff if !inlist(construp,1,.) & !inlist(constrdown,1,.) & l1.construp==1,detail 
*overemployed to normal
sum hour_diff if !inlist(construp,1,.) & !inlist(constrdown,1,.) & l1.constrdown==1,detail

/*Table 4*/
sort pid year
gen norm_to_under = (construp!=1 & constrdown!=1 & f1.construp==1) if f1.construp!=. & construp!=. & constrdown!=.
gen norm_to_over = (construp!=1 & constrdown!=1 & f1.constrdown==1) if f1.constrdown!=. & construp!=. & constrdown!=.
gen norm_to_norm = (construp!=1 & constrdown!=1 & f1.construp!=1 & f1.constrdown!=1) if construp!=. & constrdown!=. & f1.construp!=. & f1.constrdown!=.
gen agesq = headage^2/100
gen agecub = headage^3/100000
gen became_marr_t_t1 = (headmarried==0 & f1.headmarried==1)
gen became_marr_t1_t = (l1.headmarried==0 & headmarried==1)
gen became_div_t_t1 = (headmarried==1 & f1.headmarried==0)
gen became_div_t1_t = (l1.headmarried==1 & headmarried==0)
gen chg_faminc_t_t1 = f1.lnfaminc - lnfaminc
gen chg_faminc_t1_t = lnfaminc - l1.lnfaminc
gen chg_nlinc_t_t1 = f1.lnnonlaborinc - lnnonlaborinc
gen chg_nlinc_t1_t = lnnonlaborinc - l1.lnnonlaborinc
gen chg_wage_t_t1 = f1.lnwage - lnwage
gen chg_wage_t1_t = lnwage - l1.lnwage
gen chg_numkids_t_t1 = f1.children - children
gen chg_numkids_t1_t = children - l1.children
gen wfstartwrk_t_t1 = (f1.wifehour>0 & wifehour==0)
gen wfstartwrk_t1_t = (wifehour>0 & l1.wifehour==0)
gen wfstopwrk_t_t1 = (f1.wifehour==0 & wifehour>0)
gen wfstopwrk_t1_t = (wifehour==0 & l1.wifehour>0)
gen dislmthw_t_t1 = (disLimitHswrk!=f1.disLimitHswrk)
gen dislmthw_t1_t = (l1.disLimitHswrk!=disLimitHswrk)
gen jobchg_t_t1 = f1.jobchglastyr
gen jobchg_t1_t = jobchglastyr

*normal to underemployed
//compute without change in job variable since it doesn't exist in PSID as far as I can tell.
logit norm_to_under headage agesq agecub headwhite i.headedu became_marr* became_div* chg_faminc* chg_wage* chg_numkids* wfstartwrk* wfstopwrk* dislmthw* jobchg_*, vce(cluster pid)
*logit norm_to_under headage agesq agecub headwhite i.headedu became_marr* became_div* chg_nlinc* chg_numkids* wfstartwrk* wfstopwrk* dislmthw* jobchg_*, vce(cluster pid)
margins, dydx(*) atmeans post
outreg2 using ..\output\table4.xml, excel replace ctitle(Normal to Underemployed) addnote(Marginal effects at means; standard errors clustered at the person level.) 

*normal to overemployed
logit norm_to_over headage agesq agecub headwhite i.headedu became_marr* became_div* chg_faminc* chg_wage* chg_numkids* wfstartwrk* wfstopwrk* dislmthw* jobchg_*, vce(cluster pid)
*logit norm_to_over headage agesq agecub headwhite i.headedu became_marr* became_div* chg_nlinc* chg_numkids* wfstartwrk* wfstopwrk* dislmthw* jobchg_*, vce(cluster pid)
margins, dydx(*) atmeans post
outreg2 using ..\output\table4.xml, excel append ctitle(Normal to Overemployed) addnote(Marginal effects at means; standard errors clustered at the person level.)

*normal to normal
logit norm_to_norm headage agesq agecub headwhite i.headedu became_marr* became_div* chg_faminc* chg_wage* chg_numkids* wfstartwrk* wfstopwrk* dislmthw* jobchg_*, vce(cluster pid)
*logit norm_to_over headage agesq agecub headwhite i.headedu became_marr* became_div* chg_nlinc* chg_numkids* wfstartwrk* wfstopwrk* dislmthw* jobchg_*, vce(cluster pid)
margins, dydx(*) atmeans post
outreg2 using ..\output\table4.xml, excel append ctitle(Normal to Normal) addnote(Marginal effects at means; standard errors clustered at the person level.)

 

/*table 5*/
gen under_to_norm = (construp==1 & f1.construp==0 & f1.constrdown==0) if construp!=. & f1.construp!=. & f1.constrdown!=.
gen over_to_norm = (constrdown==1 & f1.construp==0 & f1.constrdown==0) if constrdown!=. & f1.construp!=. & f1.constrdown!=.
gen norm_to_norm = (constr==0 & f1.constr==0) if constr!=. & f1.constr!=.
gen secjob_t_t1 = (secjob==0 & f1.secjob==1)
gen secjob_t1_t = (l1.secjob==0 & secjob==1)

tab under_to_norm if headmarried==1 & l1.headmarried==1
tab under_to_norm if headmarried==1 & f1.headmarried==1
tab wfstartwrk_t_t1 if under_to_norm==1
tab wfstartwrk_t1_t if under_to_norm==1
tab wfstopwrk_t_t1 if under_to_norm==1
tab wfstopwrk_t1_t if under_to_norm==1
tab under_to_norm 
tab jobchg_t_t1 if under_to_norm==1
tab jobchg_t1_t if under_to_norm==1
tab secjob_t_t1 if under_to_norm==1
tab secjob_t1_t if under_to_norm==1

tab over_to_norm if headmarried==1 & l1.headmarried==1
tab over_to_norm if headmarried==1 & f1.headmarried==1
tab wfstartwrk_t_t1 if over_to_norm==1
tab wfstartwrk_t1_t if over_to_norm==1
tab wfstopwrk_t_t1 if over_to_norm==1
tab wfstopwrk_t1_t if over_to_norm==1
tab over_to_norm
tab jobchg_t_t1 if over_to_norm==1
tab jobchg_t1_t if over_to_norm==1
tab secjob_t_t1 if over_to_norm==1
tab secjob_t1_t if over_to_norm==1

tab norm_to_norm if headmarried==1 & l1.headmarried==1
tab norm_to_norm if headmarried==1 & f1.headmarried==1
tab wfstartwrk_t_t1 if norm_to_norm==1
tab wfstartwrk_t1_t if norm_to_norm==1
tab wfstopwrk_t_t1 if norm_to_norm==1
tab wfstopwrk_t1_t if norm_to_norm==1
tab norm_to_norm 
tab jobchg_t_t1 if norm_to_norm==1
tab jobchg_t1_t if norm_to_norm==1
tab secjob_t_t1 if norm_to_norm==1
tab secjob_t1_t if norm_to_norm==1

/*table 6*/
*use 1% threshold for wage changes
gen wagechg_t_tp1 = (abs((f1.mainwage-mainwage)/mainwage)>.01) if f1.tenure>1 & f1.tenure<9 & f1.mainwage!=. & mainwage!=.
gen wagechg_tm1_t = (abs((mainwage-l1.mainwage)/l1.mainwage)>.01) if tenure>1 & tenure<9 & mainwage!=. & l1.mainwage!=.
gen wagechg_tm2_tm1 = (abs((l1.mainwage-l2.mainwage)/l2.mainwage)>.01) if l1.tenure>1 & l1.tenure<9 & l1.mainwage!=. & l2.mainwage!=.
gen wagechg_tm1_tp1 = (abs((f1.mainwage-l1.mainwage)/l1.mainwage)>.01) if f1.tenure>2 & f1.tenure<9 & f1.mainwage!=. & l1.mainwage!=.

*same position, negative wage changes;
gen negwgchg_t_tp1 = ((f1.mainwage-mainwage)/mainwage<=-.01) if f1.tenure>1 & f1.tenure<9 & f1.mainwage!=. & mainwage!=.
gen negwgchg_tm1_t = ((mainwage-l1.mainwage)/l1.mainwage<=-.01) if tenure>1 & tenure<9 & mainwage!=. & l1.mainwage!=.
gen negwgchg_tm2_tm1 = ((l1.mainwage-l2.mainwage)/l2.mainwage<=-.01) if l1.tenure>1 & l1.tenure<9 & l1.mainwage!=. & l2.mainwage!=.
gen negwgchg_tm1_tp1 = ((f1.mainwage-l1.mainwage)/l1.mainwage<=-.01) if f1.tenure>2 & f1.tenure<9 & f1.mainwage!=. & l1.mainwage!=.

*same employer, no change;
gen wagechg2_t_tp1 = (abs((f1.mainwage-mainwage)/mainwage)>.01) if f1.sameemp_mths>11 & f1.sameemp_mths!=. & f1.mainwage!=. & mainwage!=.
gen wagechg2_tm1_t = (abs((mainwage-l1.mainwage)/l1.mainwage)>.01) if sameemp_mths>1 & sameemp_mths!=. & mainwage!=. & l1.mainwage!=.
gen wagechg2_tm2_tm1 = (abs((l1.mainwage-l2.mainwage)/l2.mainwage)>.01) if l1.sameemp_mths>1 & l1.sameemp_mths!=. & l1.mainwage!=. & l2.mainwage!=.
gen wagechg2_tm1_tp1 = (abs((f1.mainwage-l1.mainwage)/l1.mainwage)>.01) if f1.sameemp_mths>2 & f1.sameemp_mths!=. & f1.mainwage!=. & l1.mainwage!=.

*same employer, negative change;
gen negwgchg2_t_tp1 = ((f1.mainwage-mainwage)/mainwage<=-.01) if f1.sameemp_mths>11 & f1.sameemp_mths!=. & f1.mainwage!=. & mainwage!=.
gen negwgchg2_tm1_t = ((mainwage-l1.mainwage)/l1.mainwage<=-.01) if sameemp_mths>1 & sameemp_mths!=. & mainwage!=. & l1.mainwage!=.
gen negwgchg2_tm2_tm1 = ((l1.mainwage-l2.mainwage)/l2.mainwage<=-.01) if l1.sameemp_mths>1 & l1.sameemp_mths!=. & l1.mainwage!=. & l2.mainwage!=.
gen negwgchg2_tm1_tp1 = ((f1.mainwage-l1.mainwage)/l1.mainwage<=-.01) if f1.sameemp_mths>2 & f1.sameemp_mths!=. & f1.mainwage!=. & l1.mainwage!=.


gen f1_constr = f1.constr
label values f1_constr cstr

order pid year mainwage wagechg_t_tp1 wagechg_tm1_t wagechg_tm2_tm1 wagechg_tm1_tp1 *

/*ALL -- no change*/
*just hourly workers
preserve
keep if f1.headhourly==1
bysort f1_constr: sum wagechg_*
restore
*salaried worker wages
preserve 
keep if f1.headsalaried==1 
bysort f1_constr: sum wagechg_*
restore

/*By year group*/
*just hourly workers
*before 1976
preserve
keep if f1.headhourly==1 & year<1976
bysort f1_constr: sum wagechg_*
restore
*after 1976
preserve
keep if f1.headhourly==1 & year>=1976
bysort f1_constr: sum wagechg_*
restore

*salaried worker wages
*before 1976
preserve 
keep if f1.headsalaried==1 & year<1976
bysort f1_constr: sum wagechg_*
restore
*after 1976
preserve 
keep if f1.headsalaried==1 & year>=1976
bysort f1_constr: sum wagechg_*
restore

/*Same employer, not just position*/
preserve
keep if f1.headhourly==1
bysort f1_constr: sum wagechg2_*
restore
preserve
keep if f1.headsalaried==1
bysort f1_constr: sum wagechg2_*
restore


/*ALL - negative change*/
*just hourly workers
preserve
keep if f1.headhourly==1
bysort f1_constr: sum negwgchg_*
restore
*salaried worker wages
preserve 
keep if f1.headsalaried==1 
bysort f1_constr: sum negwgchg_*
restore

/*By year group*/
*just hourly workers
*before 1976
preserve
keep if f1.headhourly==1 & year<1976
bysort f1_constr: sum negwgchg_*
restore
*after 1976
preserve
keep if f1.headhourly==1 & year>=1976
bysort f1_constr: sum negwgchg_*
restore

*salaried worker wages
*before 1976
preserve 
keep if f1.headsalaried==1 & year<1976
bysort f1_constr: sum negwgchg_*
restore
*after 1976
preserve 
keep if f1.headsalaried==1 & year>=1976
bysort f1_constr: sum negwgchg_*
restore

/*Same employer, not just position*/
preserve
keep if f1.headhourly==1
bysort f1_constr: sum negwgchg2_*
restore
preserve
keep if f1.headsalaried==1
bysort f1_constr: sum negwgchg2_*
restore

/***
*Histogram of wage changes
***/
sort pid year
gen wgchg_t_tp1 = (f1.mainwage-mainwage)/mainwage if f1.tenure>1 & f1.tenure<9 & f1.mainwage!=. & mainwage!=.
replace wgchg_t_tp1 = .5 if wgchg_t_tp1>.5 & wgchg_t_tp1!=.
replace wgchg_t_tp1 = -.5 if wgchg_t_tp1<-.5 & wgchg_t_tp1!=.
gen wgchg_tm1_t = (mainwage-l1.mainwage)/l1.mainwage if tenure>1 & tenure<9 & mainwage!=. & l1.mainwage!=.
replace wgchg_tm1_t = .5 if wgchg_tm1_t>.5 & wgchg_tm1_t!=.
replace wgchg_tm1_t = -.5 if wgchg_tm1_t<-.5 & wgchg_tm1_t!=.
gen wgchg_tm2_tm1 = (l1.mainwage-l2.mainwage)/l2.mainwage if l1.tenure>1 & l1.tenure<9 & l1.mainwage!=. & l2.mainwage!=.
replace wgchg_tm2_tm1 = .5 if wgchg_tm2_tm1>.5 & wgchg_tm2_tm1!=.
replace wgchg_tm2_tm1 = -.5 if wgchg_tm2_tm1<-.5 & wgchg_tm2_tm1!=.
gen wgchg_tm1_tp1 = (f1.mainwage-l1.mainwage)/l1.mainwage if f1.tenure>2 & f1.tenure<9 & f1.mainwage!=. & l1.mainwage!=.
replace wgchg_tm1_tp1 = .5 if wgchg_tm1_tp1>.5 & wgchg_tm1_tp1!=.
replace wgchg_tm1_tp1 = -.5 if wgchg_tm1_tp1<-.5 & wgchg_tm1_tp1!=.

foreach var of varlist wgchg* {
	preserve
	keep if f1.headhourly==1
	sum `var' if `var'<0
	restore
}

/*all workers*/
  preserve
keep if f1.hearhourly==1
histogram wgchg_t_tp1, title("Distribution of nominal wage changes t,t+1") name(allt_tp1) xtitle(Percent wage change)
graph export ..\output\charts\wgchg_all_ttp1.ps, replace
histogram wgchg_tm1_t, title("Distribution of nominal wage changes t-1,t") name(alltm1_t) xtitle(Percent wage change)
graph export ..\output\charts\wgchg_all_tm1t.ps, replace
histogram wgchg_tm2_tm1, title("Distribution of nominal wage changes t-2,t-1") name(alltm2_tm1) xtitle(Percent wage change)
graph export ..\output\charts\wgchg_all_tm2tm1.ps, replace
histogram wgchg_tm1_tp1, title("Distribution of nominal wage changes t-1,t+1") name(alltm1_tp1) xtitle(Percent wage change)
graph export ..\output\charts\wgchg_all_tm1tp1.ps, replace
restore

foreach var of varlist wgchg* {
	preserve
	keep if f1.constr==0 & f1.headhourly==1
	sum `var' if `var'<0
	restore
}

/*unconstrained wage workers*/
preserve
keep if f1.constr==0 & f1.headhourly==1
histogram wgchg_t_tp1, title("Distribution of nominal wage changes t,t+1 (normal workers)") name(normt_tp1) xtitle(Percent wage change)
graph export ..\output\charts\wgchg_norm_ttp1.ps, replace
histogram wgchg_tm1_t, title("Distribution of nominal wage changes t-1,t (normal workers)") name(normtm1_t) xtitle(Percent wage change)
graph export ..\output\charts\wgchg_norm_tm1t.ps, replace
histogram wgchg_tm2_tm1, title("Distribution of nominal wage changes t-2,t-1 (normal workers)") name(normtm2_tm1) xtitle(Percent wage change)
graph export ..\output\charts\wgchg_norm_tm2tm1.ps, replace
histogram wgchg_tm1_tp1, title("Distribution of nominal wage changes t-1,t+1 (normal workers)") name(normtm1_tp1) xtitle(Percent wage change)
graph export ..\output\charts\wgchg_norm_tm1tp1.ps, replace
restore

foreach var of varlist wgchg* {
	preserve
	keep if f1.constr==1 & f1.headhourly==1
	sum `var' if `var'<0
	restore
}

/*underemployed wage workers*/
preserve
keep if f1.constr==1 & f1.headhourly==1
histogram wgchg_t_tp1, title("Distribution of nominal wage changes t,t+1 (underemployed workers)") name(undert_tp1) xtitle(Percent wage change)
graph export ..\output\charts\wgchg_under_ttp1.ps, replace
histogram wgchg_tm1_t, title("Distribution of nominal wage changes t-1,t (underemployed workers)") name(undertm1_t) xtitle(Percent wage change)
graph export ..\output\charts\wgchg_under_tm1t.ps, replace
histogram wgchg_tm2_tm1, title("Distribution of nominal wage changes t-2,t-1 (underemployed workers)") name(undertm2_tm1) xtitle(Percent wage change)
graph export ..\output\charts\wgchg_under_tm2tm1.ps, replace
histogram wgchg_tm1_tp1, title("Distribution of nominal wage changes t-1,t+1 (underemployed workers)") name(undertm1_tp1) xtitle(Percent wage change)
graph export ..\output\charts\wgchg_under_tm1tp1.ps, replace
restore

