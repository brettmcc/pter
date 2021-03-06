global analyisin "C:\Users\bmccully\Documents\pter-master\analysis\input"

clear all
set more off

use "$analyisin\pooled.dta",clear

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

/*Statistically different means?*/
*hourly workers
program statdiffmeans
args var
	preserve
	keep if f1.headhourly==1
	collapse (mean) `var' (count) N=`var' (sebinomial) sebinom=`var', by(f1_constr)
	drop if f1_constr==2 | f1_constr==.
	gen z`var' = ((`var'-`var'[_n+1])/sqrt(sebinom^2+sebinom[_n+1]^2))
	list f1_constr `var' N z`var', abbreviate(20)
	restore
end
foreach v of varlist /*wagechg*/ negwgchg* {
	statdiffmeans `v'
}







sort pid year
gen wgchg_t_tp1 = (f1.mainwage-mainwage)/mainwage if f1.tenure>1 & f1.tenure<9 & f1.mainwage!=. & mainwage!=.
gen wgchg_tm1_t = (mainwage-l1.mainwage)/l1.mainwage if tenure>1 & tenure<9 & mainwage!=. & l1.mainwage!=.
gen wgchg_tm2_tm1 = (l1.mainwage-l2.mainwage)/l2.mainwage if l1.tenure>1 & l1.tenure<9 & l1.mainwage!=. & l2.mainwage!=.
gen wgchg_tm1_tp1 = (f1.mainwage-l1.mainwage)/l1.mainwage if f1.tenure>2 & f1.tenure<9 & f1.mainwage!=. & l1.mainwage!=.

/*Magnitude of negative wage changes*/
*all
foreach var of varlist wgchg* {
	preserve
	keep if f1.headhourly==1
	sum `var' if `var'<-.01
	restore
}
*unconstrained
foreach var of varlist wgchg* {
	preserve
	keep if f1.constr==0 & f1.headhourly==1
	sum `var' if `var'<-.01
	restore
}
*underemployed
foreach var of varlist wgchg* {
	preserve
	keep if f1.constr==1 & f1.headhourly==1
	sum `var' if `var'<-.01
	restore
}

/*Wage changes after constrained*/
bysort constr: sum wgchg_t_tp1
reg wgchg_t_tp1 i.constr
bysort constr: sum wgchg_t_tp1 if headhourly==1
reg wgchg_t_tp1 i.constr if headhourly==1
replace wgchg_t_tp1 = .5 if wgchg_t_tp1>.5 & wgchg_t_tp1!=.
replace wgchg_t_tp1 = -.5 if wgchg_t_tp1<-.5 & wgchg_t_tp1!=.
histogram wgchg_t_tp1 if headhourly==1 & constr==0, title("Distribution of nominal wage changes t,t+1") name(allt_tp1) xtitle(Percent wage change) note("unconstrained")
histogram wgchg_t_tp1 if headhourly==1 & constr==1, title("Distribution of nominal wage changes t,t+1") name(hourlyt_tp1) xtitle(Percent wage change) note("underemployed)")



/*education and skillz*/
*compute a skill-index for each occupation for 1968, merge onto dataset
preserve
gen hsdropout = (headedu==1) if headedu!=.
gen hsgrad = (headedu==2) if headedu!=.
gen somepostsec = (headedu==3) if headedu!=.
gen collegeormore = (headedu==4) if headedu!=.
collapse (sum) hsdropout hsgrad somepostsec collegeormore, by(year headocc)
drop if headocc==0 | headocc==.
egen total = rsum(hsdropout hsgrad somepostsec collegeormore)
replace hsdropout = hsdropout/total
replace hsgrad = hsgrad/total
replace somepostsec = somepostsec/total
replace collegeormore = collegeormore/total
drop total
gen skillscore = 1*hsdropout + 2*hsgrad + 3*somepostsec + 4*collegeormore
keep year headocc skillscore
list
tempfile occs
save `occs'
restore

merge m:1 year headocc using `occs'
drop _merge

reg skillscore i.constr
sum skillscore
reg skillscore i.constr if headhourly==1
sum skillscore if headhourly==1
