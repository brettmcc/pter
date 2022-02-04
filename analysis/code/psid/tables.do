/*Brett McCully, Sept. 2017
  Fill out statistics laid out in email from LG on 10/1/16
  
  Table 1   -- Summary Statistics
  Table 1.a -- Industry and Occupation Effects on Hours Constraints
  Table 1.b -- Observed and Predicted Work Hour Gaps
  Table 1.c -- Persistence of Constraints
  Table 1.d -- Transition Matrix
  Table 1.e -- Characteristics of the long-time constrained
  Table 1.f -- Proportion of underemployed by hours bins and 
				share underemployed by hours bin.
  Table 2   -- Regression results for constraint transitions
  Table 3   -- Streamlined presentation of housework hours results
  Table 3.a -- Streamlined presentation of food-out ratio results
  
*/

clear all
set more off, permanently

global analysisout /*
	*/"C:\Users\bmccully\Documents\pter-master\analysis\output"
global build /*
	*/"C:\Users\bmccully\Documents\pter-master\build\output\"
global analysisin /*
	*/"C:\Users\bmccully\Documents\pter-master\analysis\input"


program calcstat 
args vari nn
	sum `vari' if construp==1 [aweight=wgt]
	replace UC = r(mean) if _n==`nn'
	sum `vari' if constrdown==1 [aweight=wgt]
	replace DC = r(mean) if _n==`nn'
	sum `vari' if construp==0 & constrdown==0 [aweight=wgt]
	replace NC = r(mean) if _n==`nn'
end


use "$analysisin\pooled.dta",clear

/* Table 1 -- Summary Statistics */
gen varname = ""
label variable varname "SUMMARY STATISTICS"
gen UC = .
gen DC = .
gen NC = .

replace varname = "Extensive Margin" if _n==1
replace varname = "Share of HH heads" if _n==2
sum construp [aweight=wgt]
replace UC = r(mean) if _n==2
sum constrdown [aweight=wgt]
replace DC = r(mean) if _n==2
replace NC = 1 - UC - DC if _n==2

//define a household as constrained if either husband or wife is constrained
//defined only for years in which observe wife's constraint status
replace varname = "Share of households" if _n==3
sum hhconstrup [aweight=wgt]
replace UC = r(mean) if _n==3

replace varname = "Demographics" if _n==5
replace varname = "Head age" if _n==6
calcstat headage 6
replace varname = "White (%)" if _n==7
calcstat headwhite 7
replace varname = "High school dropout (%)" if _n==8
calcstat headedu_ltHs 8
replace varname = "High school grad (%)" if _n==9
calcstat headedu_hsgrad 9
replace varname = "Some college (%)" if _n==10
calcstat headedu_someCol 10
replace varname = "College Grad.+ (%)" if _n==11
calcstat headedu_colPl 11
replace varname = "Married (%)" if _n==12
calcstat headmarried 12
replace varname = "Num. children in HH" if _n==13
calcstat children 13

replace varname = "Income and Employment" if _n==15
replace varname = "Total family income" if _n==16
calcstat faminc 16
replace varname = "Total head labor income" if _n==17
calcstat headlabor 17
replace varname = "Head avg. weekly hours" if _n==18
calcstat headhourweekly 18
replace varname = "Share can work extra for add'l pay" if _n==19
calcstat headext 19
replace varname = "Having additional jobs" if _n==20
calcstat headsecjob 20
replace varname = "Salaried" if _n==21
calcstat headsalary 21
replace varname = "Unionized" if _n==22
calcstat union_dummy 22

replace varname = "Housework and Leisure" if _n==24
replace varname = "Food-out ratio" if _n==25
calcstat foodoutratio 25
replace varname = "Head housework hours (weekly)" if _n==26
calcstat hwheadweekly 26
replace varname = "Wife housework hours (weekly)" if _n==27
calcstat hwwifeweekly 27
replace varname = "Vacation weeks taken" if _n==28
calcstat headvacationweek 28

replace varname = "N (person-years)" if _n==30
count if construp==1 
replace UC = `r(N)' if _n==30
count if constrdown==1
replace DC = `r(N)' if _n==30
count
replace NC = `r(N)'-UC-DC if _n==30

replace UC = round(UC,0.01)
replace DC = round(DC,0.01)
replace NC = round(NC,0.01)

replace varname = "Source: PSID; weighted." if _n==32

export excel varname UC DC NC using /*
	*/"C:\Users\bmccully\Documents\pter-master\analysis\output\tables_sep17.xlsx"/*
	*/in 1/32, sheet("Summary Stats") sheetreplace firstrow(varlabels)


/*   Table 1.a -- Industry and Occupation Effects on Hours Constraints */
use "$analysisin\pooled.dta",clear

sum wgt,d
gen totwgt=r(sum)
gen wgt_normalized = wgt/totwgt*_N

//generate percentages by industry
preserve 
collapse (mean) UC=construp DC=constrdown (count) N=construp/*
	*/[iweight=wgt_normalized],by(headind)
gen NC = 1-UC-DC
//drop students, unemp., etc.
replace UC = . if headind==0
replace DC = . if headind==0
replace NC = . if headind==0
replace N = . if headind==0
gen vari = ""
label variable vari "Occupation and Industry by Constrained Status"
replace vari = "Industry" if headind==0
replace vari = "Agriculture" if headind==1
replace vari = "Mining" if headind==2
replace vari = "Construction" if headind==3
replace vari = "Manufacturing" if headind==4
replace vari = "Transportation, Communications, Utilities" if headind==5
replace vari = "Wholesale and Retail Trade" if headind==6
replace vari = "Finance, Insurance, and Real Estate" if headind==7
replace vari = "Business and Repair Services" if headind==8
replace vari = "Personal Services" if headind==9
replace vari = "Entertainment and Recreation Services" if headind==10
replace vari = "Professional and Related Services" if headind==11
replace vari = "Public Administration" if headind==12
order vari UC DC NC N
tempfile tmp
keep vari UC NC DC N
keep if _n<=13
drop if vari==""
tempfile tmp
save "`tmp'"
restore

collapse (mean) UC=construp DC=constrdown (count) N=construp /*
	*/[iweight=wgt_normalized],by(headocc)
gen NC = 1-UC-DC

/*bysort headocc: egen UC = mean(construp) 
by headocc: egen DC = mean(constrdown)
by headocc: gen NC = 1 - UC - DC
contract headocc UC DC NC*/

//drop students, unemp., etc.
replace UC = . if headocc==0
replace DC = . if headocc==0
replace NC = . if headocc==0
replace N = . if headocc==0
gen vari = ""
label variable vari "Occupation and Industry by Constrained Status"
replace vari = "Occupation" if headocc==0
replace vari = "Professional" if headocc==1
replace vari = "Manager" if headocc==2
replace vari = "Sales" if headocc==3
replace vari = "Clerical" if headocc==4
replace vari = "Craftsman" if headocc==5
replace vari = "Operatives" if headocc==6
replace vari = "Transport operators" if headocc==7
replace vari = "Laborers" if headocc==8
replace vari = "Farmers" if headocc==9
replace vari = "Farm laborers" if headocc==10
replace vari = "Service workers" if headocc==11
replace vari = "Priv. household workers" if headocc==12
order vari UC DC NC N
drop if vari==""
set obs `=_N+1'
append using "`tmp'"
replace UC = round(UC,0.01)
replace DC = round(DC,0.01)
replace NC = round(NC,0.01)
replace N = round(N,1)

set obs `=_N+2'
replace vari = "Source: PSID; weighted." if _n==_N

export excel vari UC NC DC N using /*
	*/"C:\Users\bmccully\Documents\pter-master\analysis\output\tables_sep17.xlsx"/*
	*/, sheet("Ind. & Occ.") sheetreplace firstrow(varlabels)



 /*
graph bar (mean) construp if headind!=0, over(headind, /*
	*/label(angle(70)) sort((mean) construp)) name(construp_ind,replace)
graph save construp_ind "$analysisout\construp_ind.gph",replace 
putexcel B14 = picture("$analysisout\construp_ind.gph")
*/

/*  Table 1.b -- Observed and Predicted Work Hour Gaps  */

	* need HRS data on gaps to predict PSID gaps
	
/*  Table 1.c -- Persistence of Constraints  */
use "$analysisin\pooled.dta",clear

sum wgt,d
local sumwgt = r(sum)

sum wgt if headfulltime==1,d
local sumwgtft = r(sum)

gen numYrs = ""
gen shrHhs = .
gen shrHhsFulltime = .
label variable numYrs "Number of consecutive constrained years"
label variable shrHhs "Share of heads"
label variable shrHhsFulltime "Share of heads (working FT)"
replace numYrs = "Upside Constrained" if _n==1
replace numYrs = "1" if _n==2
sum wgt if construp==1
replace shrHhs = r(sum)/`sumwgt' if _n==2
sum wgt if construp==1 & headfulltime==1
replace shrHhsFulltime = r(sum)/`sumwgtft' if _n==2
replace numYrs = "2" if _n==3
sum wgt if construp==1 & l1.construp==1
replace shrHhs = r(sum)/`sumwgt' if _n==3
sum wgt if construp==1 & l1.construp==1 & headfulltime==1
replace shrHhsFulltime = r(sum)/`sumwgtft' if _n==3
replace numYrs = "3" if _n==4
sum wgt if construp==1 & l1.construp==1 & l2.construp==1
replace shrHhs = r(sum)/`sumwgt' if _n==4
sum wgt if construp==1 & l1.construp==1 & l2.construp==1 /*
	*/ & headfulltime==1
replace shrHhsFulltime = r(sum)/`sumwgtft' if _n==4
replace numYrs = "4" if _n==5
sum wgt if construp==1 & l1.construp==1 & l2.construp==1 /*
	*/& l3.construp==1
replace shrHhs = r(sum)/`sumwgt' if _n==5
sum wgt if construp==1 & l1.construp==1 & l2.construp==1 /*
	*/& l3.construp==1 & headfulltime==1
replace shrHhsFulltime = r(sum)/`sumwgtft' if _n==5
replace numYrs = "5" if _n==6
sum wgt if construp==1 & l1.construp==1 & l2.construp==1 /*
	*/& l3.construp==1 & l4.construp==1
replace shrHhs = r(sum)/`sumwgt' if _n==6
sum wgt if construp==1 & l1.construp==1 & l2.construp==1 /*
	*/& l3.construp==1 & l4.construp==1 & headfulltime==1
replace shrHhsFulltime = r(sum)/`sumwgtft' if _n==6
replace numYrs = "6" if _n==7
sum wgt if construp==1 & l1.construp==1 & l2.construp==1 /*
	*/& l3.construp==1 & l4.construp ==1 & l5.construp
replace shrHhs = r(sum)/`sumwgt' if _n==7
sum wgt if construp==1 & l1.construp==1 & l2.construp==1 & /*
	*/l3.construp==1 & l4.construp==1 /*
	*/ & l5.construp==1 & headfulltime==1
replace shrHhsFulltime = r(sum)/`sumwgtft' if _n==7

replace numYrs = "Downside Constrained" if _n==9
replace numYrs = "1" if _n==10
sum wgt if constrdown==1
replace shrHhs = r(sum)/`sumwgt' if _n==10
sum wgt if constrdown==1 & headfulltime==1
replace shrHhsFulltime = r(sum)/`sumwgtft' if _n==10
replace numYrs = "2" if _n==11
sum wgt if constrdown==1 & l1.constrdown==1 
replace shrHhs = r(sum)/`sumwgt' if _n==11
sum wgt if constrdown==1 & l1.constrdown==1  & headfulltime==1
replace shrHhsFulltime = r(sum)/`sumwgtft' if _n==11
replace numYrs = "3" if _n==12
sum wgt if constrdown==1 & l1.constrdown==1 & l2.constrdown==1
replace shrHhs = r(sum)/`sumwgt' if _n==12
sum wgt if constrdown==1 & l1.constrdown==1 & l2.constrdown==1 /*
	*/& headfulltime==1
replace shrHhsFulltime = r(sum)/`sumwgtft' if _n==12
replace numYrs = "4" if _n==13
sum wgt if constrdown==1 & l1.constrdown==1 & l2.constrdown==1 /*
	*/& l3.constrdown==1
replace shrHhs = r(sum)/`sumwgt' if _n==13
sum wgt if constrdown==1 & l1.constrdown==1 & l2.constrdown==1 /*
	*/& l3.constrdown==1 & headfulltime==1
replace shrHhsFulltime = r(sum)/`sumwgtft' if _n==13
replace numYrs = "5" if _n==14
sum wgt if constrdown==1 & l1.constrdown==1 & l2.constrdown==1 /*
	*/& l3.constrdown==1 & l4.constrdown==1
replace shrHhs = r(sum)/`sumwgt' if _n==14
sum wgt if constrdown==1 & l1.constrdown==1 & l2.constrdown==1 /*
	*/& l3.constrdown==1 & l4.constrdown==1 & headfulltime==1
replace shrHhsFulltime = r(sum)/`sumwgtft' if _n==14
replace numYrs = "6" if _n==15
sum wgt if constrdown==1 & l1.constrdown==1 & l2.constrdown==1 /*
	*/& l3.constrdown==1 & l4.constrdown==1 /*
	*/ & l5.constrdown==1
replace shrHhs = r(sum)/`sumwgt' if _n==15
sum wgt if constrdown==1 & l1.constrdown==1 & l2.constrdown==1 /*
	*/& l3.constrdown==1 & l4.constrdown==1 /*
	*/ & l5.constrdown==1 & headfulltime==1
replace shrHhsFulltime = r(sum)/`sumwgtft' if _n==15

replace shrHhs = round(shrHhs,0.001)
replace shrHhsFulltime = round(shrHhsFulltime,0.001)

replace numYrs = "Source: PSID; weighted." if _n==17

export excel numYrs shrHhs shrHhsFulltime using /*
	*/"C:\Users\bmccully\Documents\pter-master\analysis\output\tables_sep17.xlsx"/*
	*/in 1/17, sheet("Persistence") sheetreplace firstrow(varlabels)


/*  Table 1.d -- Transition Matrix  */
use "$analysisin\pooled.dta",clear

/*Upward constrained*/
gen rowlab = ""
label variable rowlab "Transition Matrix"
replace rowlab = "Upside constrained" if _n==1
replace rowlab = "year t-1" if _n==2
replace rowlab = "Constrained" if _n==3
replace rowlab = "Unconstrained" if _n==4
gen year_t = .
label variable year_t "year t"
gen constrained = .
label variable constrained "constrained"
gen unconstrained = . 
label variable unconstrained "unconstrained"

sum wgt if construp==1 & l1.construp==1
local n1 = r(sum)
sum wgt if l1.construp==1
replace constrained = `n1'/r(sum) if _n==3
sum wgt if construp==1 & l1.construp==0
local n1 = r(sum)
sum wgt if l1.construp==0
replace constrained = `n1'/r(sum) if _n==4

sum wgt if construp==0 & l1.construp==1
local n1 = r(sum)
sum wgt if l1.construp==1
replace unconstrained = `n1'/r(sum) if _n==3
sum wgt if construp==0 & l1.construp==0
local n1 = r(sum)
sum wgt if l1.construp==0
replace unconstrained = `n1'/r(sum) if _n==4

/*downward constrained*/
gen blank = ""
gen rowlab2 = ""
label variable rowlab2 "Transition Matrix"
replace rowlab2 = "Downside constrained" if _n==1
replace rowlab2 = "year t-1" if _n==2
replace rowlab2 = "Constrained" if _n==3
replace rowlab2 = "Unconstrained" if _n==4 
gen year_t2 = .
label variable year_t2 "year t"
gen constrained2 = .
label variable constrained2 "constrained"
gen unconstrained2 = . 
label variable unconstrained2 "unconstrained"

sum wgt if constrdown==1 & l1.constrdown==1
local n1 = r(sum)
sum wgt if l1.constrdown==1
replace constrained2 = `n1'/r(sum) if _n==3
sum wgt if constrdown==1 & l1.constrdown==0
local n1 = r(sum)
sum wgt if l1.constrdown==0
replace constrained2 = `n1'/r(sum) if _n==4

sum wgt if constrdown==0 & l1.constrdown==1
local n1 = r(sum)
sum wgt if l1.constrdown==1
replace unconstrained2 = `n1'/r(sum) if _n==3
sum wgt if constrdown==0 & l1.constrdown==0
local n1 = r(sum)
sum wgt if l1.constrdown==0
replace unconstrained2 = `n1'/r(sum) if _n==4

replace rowlab = "Source: PSID; weighted." if _n==6

replace rowlab = "Chg. in weekly hours if escaping UC status:" if _n==8
sum chg_headhour if escaped_uc==1
replace year_t = `r(mean)'/52 if _n==8
replace rowlab = "Chg. in weekly hours if entering UC status:" if _n==9
sum chg_headhour if became_uc==1
replace year_t = `r(mean)'/52 if _n==9

replace constrained = round(constrained,0.001)
replace unconstrained = round(unconstrained,0.001)
replace constrained2 = round(constrained2,0.001)
replace unconstrained2 = round(unconstrained2,0.001)

export excel rowlab year_t constrained unconstrained blank rowlab2 /*
	*/year_t2 constrained2 unconstrained2 using /*
	*/"C:\Users\bmccully\Documents\pter-master\analysis\output\tables_sep17.xlsx"/*
	*/in 1/9, sheet("Transition Matrix") sheetreplace firstrow(varlabels)

drop rowlab year_t constrained unconstrained blank rowlab2 year_t2 constrained2/*
	*/ unconstrained2
	
//3x3 transition matrix
gen rowlab = ""
label variable rowlab "3x3 Transition Matrix"
replace rowlab = "Year t-1" if _n==2
replace rowlab = "Unconstrained" if _n==3
replace rowlab = "Upside constrained" if _n==4
replace rowlab = "Downside constrained" if _n==5
replace rowlab = "Source: PSID; weighted." if _n==7
gen year_t = . 
label variable year_t "year t"
gen Unconstrained = .
gen upside_constr = .
label variable upside_constr "Upside constr."
gen downside_constr = . 
label variable downside_constr "Downside constr."

//calculate unconstrained row
sum wgt if constrdown==0 & construp==0 & l1.constrdown==0 & l1.construp==0
local n1 = r(sum)
sum wgt if l1.constrdown==0 & l1.construp==0
replace Unconstrained = `n1'/r(sum) if _n==3

sum wgt if constrdown==0 & construp==1 & l1.constrdown==0 & l1.construp==0
local n1 = r(sum)
sum wgt if l1.constrdown==0 & l1.construp==0
replace upside_constr = `n1'/r(sum) if _n==3
	
sum wgt if constrdown==1 & construp==0 & l1.constrdown==0 & l1.construp==0
local n1 = r(sum)
sum wgt if l1.constrdown==0 & l1.construp==0
replace downside_constr = `n1'/r(sum) if _n==3	
	
//upside constrained row
sum wgt if constrdown==0 & construp==0 & l1.constrdown==0 & l1.construp==1
local n1 = r(sum)
sum wgt if l1.constrdown==0 & l1.construp==1
replace Unconstrained = `n1'/r(sum) if _n==4

sum wgt if constrdown==0 & construp==1 & l1.constrdown==0 & l1.construp==1
local n1 = r(sum)
sum wgt if l1.constrdown==0 & l1.construp==1
replace upside_constr = `n1'/r(sum) if _n==4

sum wgt if constrdown==1 & construp==0 & l1.constrdown==0 & l1.construp==1
local n1 = r(sum)
sum wgt if l1.constrdown==0 & l1.construp==1
replace downside_constr = `n1'/r(sum) if _n==4

//downside constrained row
sum wgt if constrdown==0 & construp==0 & l1.constrdown==1 & l1.construp==0
local n1 = r(sum)
sum wgt if l1.constrdown==1 & l1.construp==0
replace Unconstrained = `n1'/r(sum) if _n==5

sum wgt if constrdown==0 & construp==1 & l1.constrdown==1 & l1.construp==0
local n1 = r(sum)
sum wgt if l1.constrdown==1 & l1.construp==0
replace upside_constr = `n1'/r(sum) if _n==5

sum wgt if constrdown==1 & construp==0 & l1.constrdown==1 & l1.construp==0
local n1 = r(sum)
sum wgt if l1.constrdown==1 & l1.construp==0
replace downside_constr = `n1'/r(sum) if _n==5

replace Unconstrained = round(Unconstrained,0.001)
replace upside_constr = round(upside_constr,0.001)
replace downside_constr = round(downside_constr,0.001)

export excel rowlab year_t Unconstrained upside_constr downside_constr/*
	*/ using /*
	*/"C:\Users\bmccully\Documents\pter-master\analysis\output\tables_sep17.xlsx"/*
	*/in 1/6, sheet("3x3 Transition Matrix") sheetreplace /*
	*/firstrow(varlabels)

drop rowlab year_t Unconstrained upside_constr downside_constr
	
/*  Table 1.e -- Characteristics of the long-time constrained  */
use "$analysisin\pooled.dta",clear

gen rowlab = ""
label variable rowlab "Char. of Long-term Constr."
gen uc_3wvs = .
label variable uc_3wvs "Upward constrained 3+ waves"
replace rowlab = "Extensive margin" if _n==1

replace rowlab = "Share of observations" if _n==2
sum longterm_upconstr [aweight=wgt]
replace uc_3wvs = `r(mean)' if _n==2

replace rowlab = "Share of individuals ever LT UC" if _n==3
preserve
collapse (max) longterm_upconstr, by(pid)
sum longterm_upconstr //should this be weighted?
local uc3hh = `r(mean)'
restore
replace uc_3wvs = `uc3hh' if _n==3


replace rowlab = "Demographics" if _n==4
replace rowlab = "Head age" if _n==5
sum headage if longterm_upconstr==1 [aweight=wgt]
replace uc_3wvs = `r(mean)' if _n==5
replace rowlab = "White (%)" if _n==6
sum headwhite if longterm_upconstr==1 [aweight=wgt]
replace uc_3wvs = `r(mean)' if _n==6
replace rowlab = "Below high school (%)" if _n==7
sum headedu_ltHs if longterm_upconstr==1 [aweight=wgt]
replace uc_3wvs = `r(mean)' if _n==7
replace rowlab = "High school (%)" if _n==8
sum headedu_hsgrad if longterm_upconstr==1 [aweight=wgt]
replace uc_3wvs = `r(mean)' if _n==8
replace rowlab = "Some college (%)" if _n==9
sum headedu_someCol if longterm_upconstr==1 [aweight=wgt]
replace uc_3wvs = `r(mean)' if _n==9
replace rowlab = "College Grad.+ (%)" if _n==10
sum headedu_colPl if longterm_upconstr==1 [aweight=wgt]
replace uc_3wvs = `r(mean)' if _n==10
replace rowlab = "Married (%)" if _n==11
sum headmarried if longterm_upconstr==1 [aweight=wgt]
replace uc_3wvs = `r(mean)' if _n==11
replace rowlab = "Num. Children" if _n==12
sum children if longterm_upconstr==1 [aweight=wgt]
replace uc_3wvs = `r(mean)' if _n==12


replace rowlab = "Income and Employment" if _n==14
replace rowlab = "Total family income" if _n==15
sum faminc if longterm_upconstr==1 [aweight=wgt]
replace uc_3wvs = `r(mean)' if _n==15
replace rowlab = "Head labor income" if _n==16
sum headlabor if longterm_upconstr==1 [aweight=wgt]
replace uc_3wvs = `r(mean)' if _n==16
replace rowlab = "Head hours" if _n==17
sum headhour if longterm_upconstr==1 [aweight=wgt]
replace uc_3wvs = `r(mean)' if _n==17
replace rowlab = "Earn add'l wages for add'l hours" if _n==18
sum headext if longterm_upconstr==1 [aweight=wgt]
replace uc_3wvs = `r(mean)' if _n==18
replace rowlab = "Hold more than one job" if _n==19
sum headsecjob if longterm_upconstr==1 [aweight=wgt]
replace uc_3wvs = `r(mean)' if _n==19
replace rowlab = "Head salaried" if _n==20
sum headsalary if longterm_upconstr==1 [aweight=wgt]
replace uc_3wvs = `r(mean)' if _n==20
replace rowlab = "Head Unionized" if _n==21
sum union_dummy if longterm_upconstr==1 [aweight=wgt]
replace uc_3wvs = `r(mean)' if _n==21


replace rowlab = "Housework and Leisure" if _n==23
replace rowlab = "Food-out ratio" if _n==24
sum foodoutratio if longterm_upconstr==1 [aweight=wgt]
replace uc_3wvs = `r(mean)' if _n==24
replace rowlab = "Head housework hours (weekly)" if _n==25
sum hwheadweekly if longterm_upconstr==1 [aweight=wgt]
replace uc_3wvs = `r(mean)' if _n==25
replace rowlab = "Wife housework hours (weekly)" if _n==26
sum hwwifeweekly if longterm_upconstr==1 [aweight=wgt]
replace uc_3wvs = `r(mean)' if _n==26
replace rowlab = "Head weeks of vacation" if _n==27
sum headvacationweek if longterm_upconstr==1 [aweight=wgt]
replace uc_3wvs = `r(mean)' if _n==27

replace rowlab = "Source: PSID; weighted." if _n==29

replace uc_3wvs = round(uc_3wvs,0.01)

export excel rowlab uc_3wvs using /*
	*/"C:\Users\bmccully\Documents\pter-master\analysis\output\tables_sep17.xlsx"/*
	*/in 1/29, sheet("Char. of Long-term Constr.") sheetreplace firstrow(varlabels)

drop rowlab uc_3wvs


/*Table 1.f -- Proportion of underemployed by hours bins and 
	share underemployed by hours bin. */
//--moved to charts.do

/*   Table 2   -- Regression results for constraint transitions   */
use "$analysisin\pooled.dta",clear

//the change variables exclude observations that don't have an 
//immediate predecessor in the period before.
//The Sameemp_months variable is only available 68, 76-78,81-86
//so it excludes observations in a number of years.

local indep_vars_all = /*
	*/"headage headage_squared headblack i.headedu became_married stay_married became_div_sep chg_num_children chg_nonlabor_inc chg_log_headwage chg_headhour became_hmowner dislimithswrk headsecjob unemp_to_ft unemp_to_pt ft_to_pt pt_to_ft pt_to_pt became_hourlywaged"
local addl_vars = "chgd_jobs relocated got_addl_job chgd_union_status chg_foodout chg_housework_hours"
areg became_uc `indep_vars_all' if headstatus==1 & lag_construp!=1 /*
	*/[aweight=wgt], vce(cluster pid) absorb(year)
sum became_uc if headstatus==1 & lag_construp!=1 [aweight=wgt]	
outreg2 using $analysisout\table2_sep17.tex, label replace /*
	*/addtext(Year FE, Yes, Sample, All Employed) addstat(Dep. var. mean, r(mean)) /*
	*/ctitle(Became UC) title(Baseline Spec.)
	
areg became_uc `indep_vars_all' `addl_vars' [aweight=wgt] /*
	*/if headstatus==1 & lag_construp!=1 ,vce(cluster pid) absorb(year)
sum became_uc if headstatus==1 & lag_construp!=1 
outreg2 using $analysisout\table2_sep17, label append tex(frag) /*
	*/addtext(Year FE, Yes, Sample, All Employed) addstat(Dep. var. mean, r(mean)) /*
	*/ctitle(Became UC) 
	
local indep_vars_married = /*
	*/"headage headage_squared headblack i.headedu chg_num_children chg_nonlabor_inc chg_log_headwage chg_headhour chglog_wifehour became_hmowner dislimithswrk headsecjob unemp_to_ft unemp_to_pt ft_to_pt pt_to_ft pt_to_pt became_hourlywaged wifeage i.wifeedu"
local addl_vars_marr = "chgd_jobs relocated got_addl_job chgd_union_status wife_enters_workforce chg_foodout chg_housework_hours"
areg became_uc `indep_vars_married' [aweight=wgt] /*
	*/if headmarried==1 & lag_headmarried==1 & headstatus==1 /*
	*/& lag_construp!=1 ,vce(cluster pid) absorb(year)
sum became_uc if headmarried==1 & lag_headmarried==1 & headstatus==1 /*
	*/& lag_construp!=1
 outreg2 using $analysisout\table2_sep17, tex(frag) label append /*
	*/addtext(Year FE, Yes, Sample,Married Employed) addstat(Dep. var. mean, r(mean)) /*
	*/ctitle(Became UC)
		
areg became_uc `indep_vars_married' `addl_vars_marr' [aweight=wgt] /*
	*/if headmarried==1 & lag_headmarried==1 & headstatus==1 /*
	*/& lag_construp!=1 ,vce(cluster pid) absorb(year)
sum became_uc if headmarried==1 & lag_headmarried==1 & headstatus==1 /*
	*/& lag_construp!=1 
outreg2 using $analysisout\table2_sep17, tex(frag) label append /*
	*/addtext(Year FE, Yes, Sample,Married Employed) addstat(Dep. var. mean, r(mean)) /*
	*/ctitle(Became UC)		

local indep_vars_esc = /*
	*/"headage headage_squared headblack i.headedu became_married stay_married became_div_sep chg_num_children chg_nonlabor_inc chg_log_headwage chg_headhour became_hmowner dislimithswrk headsecjob ft_to_unemp pt_to_unemp ft_to_pt pt_to_ft pt_to_pt became_hourlywaged"
areg escaped_uc `indep_vars_esc' if lag_headstatus==1 & lag_construp==1 /*
	*/[aweight=wgt], vce(cluster pid) absorb(year)
sum escaped_uc if lag_headstatus==1 & lag_construp==1 [aweight=wgt]
outreg2 using $analysisout\table2_sep17, tex(frag) label append /*
	*/addtext(Year FE, Yes, Sample,All Employed ) addstat(Dep. var. mean, r(mean)) /*
	*/ctitle(Escaped UC)
	
areg escaped_uc `indep_vars_esc' `addl_vars' [aweight=wgt] /*
	*/if lag_headstatus==1 & lag_construp==1, vce(cluster pid) absorb(year)
sum escaped_uc if lag_headstatus==1 & lag_construp==1 [aweight=wgt]
outreg2 using $analysisout\table2_sep17, tex(frag) label append /*
	*/addtext(Year FE, Yes, Sample,All Employed ) addstat(Dep. var. mean, r(mean)) /*
	*/ctitle(Escaped UC)
	
local indep_vars_marriedesc = /*
	*/"headage headage_squared headblack i.headedu chg_num_children chg_nonlabor_inc chg_log_headwage chg_headhour chglog_wifehour became_hmowner dislimithswrk headsecjob ft_to_unemp pt_to_unemp ft_to_pt pt_to_ft pt_to_pt became_hourlywaged wifeage i.wifeedu"
areg escaped_uc `indep_vars_marriedesc' [aweight=wgt] /*
	*/if headmarried==1 & lag_headmarried==1 & lag_headstatus==1 & /*
	*/lag_construp==1, vce(cluster pid) absorb(year)
sum escaped_uc if headmarried==1 & lag_headmarried==1 & lag_headstatus==1 & /*
	*/lag_construp==1 [aweight=wgt]
outreg2 using $analysisout\table2_sep17, tex(frag) label append /*
	*/addtext(Year FE, Yes, Sample,Married Employed) addstat(Dep. var. mean, r(mean)) /*
	*/ctitle(Escaped UC)
	
areg escaped_uc `indep_vars_marriedesc' `addl_vars_marr' [aweight=wgt] /*
	*/if headmarried==1 & lag_headmarried==1 & lag_headstatus==1 & /*
	*/lag_construp==1, vce(cluster pid) absorb(year)
sum escaped_uc if headmarried==1 & lag_headmarried==1 & lag_headstatus==1 & /*
	*/lag_construp==1 [aweight=wgt]
outreg2 using $analysisout\table2_sep17, tex(frag) label append /*
	*/addtext(Year FE, Yes, Sample,Married Employed) ///
	addstat(Dep. var. mean, r(mean)) /*
	*/ctitle(Escaped UC)

/* Table 3 -- Streamlined presentation of housework hours results */
use "$analysisin\pooled.dta",clear

local indep_vars_unmar = /*
	*/"construp constrdown headfemale headage headage_squared headblack i.headedu dislimithswrk headsecjob age2 age6 age12 age18 nonlabor_inc"
local indep_vars_married = /*
	*/"construp constrdown headage headage_squared headblack i.headedu dislimithswrk headsecjob age2 age6 age12 age18 nonlabor_inc wifeage i.wifeedu wifehour"
areg hwheadweekly `indep_vars_unmar' [aweight=wgt] if headmarried==0 /*
	*/& headstatus==1 , vce(cluster pid) absorb(year)  
sum hwheadweekly if headmarried==0 & headstatus==1 [aweight=wgt] 
outreg2 using /*
	*/C:\Users\bmccully\Documents\pter-master\analysis\output\table3_sep17.tex /*
	*/,label replace ctitle("Head--unmarried, (all)") /*
	*/cttop(House work hours) addtext(Year FE, Yes) /*
	*/addstat(Dep. var. mean, r(mean))
	
areg hwheadweekly `indep_vars_unmar' [aweight=wgt] if headmarried==0 /*
	*/& headstatus==1 & headext==1, vce(cluster pid) absorb(year)  
sum hwheadweekly if headmarried==0 & headstatus==1 & headext==1 /*
	*/[aweight=wgt]
outreg2 using /*
	*/"C:\Users\bmccully\Documents\pter-master\analysis\output\table3_sep17.xml" /*
	*/,tex(frag) label append /*
	*/ctitle("Head--unmarried, (Earn ext. from add'l hours)") /*
	*/cttop(House work hours) addtext(Year FE, Yes) /*
	*/addstat(Dep. var. mean, r(mean))
	
areg hwheadweekly `indep_vars_married' if headmarried==1 & /*
	*/headstatus==1 [aweight=wgt],vce(cluster pid) absorb(year)
sum hwheadweekly if headmarried==1 & headstatus==1 [aweight=wgt]
outreg2 using /*
	*/C:\Users\bmccully\Documents\pter-master\analysis\output\table3_sep17/*
	*/,tex(frag) label append ctitle("Head--married (all)") /*\
	*/addtext(Year FE, Yes) addstat(Dep. var. mean, r(mean))
	
areg hwheadweekly `indep_vars_married' [aweight=wgt] if headmarried==1 /*
	*/& headstatus==1 & headext==1, vce(cluster pid) absorb(year)
sum hwheadweekly if headmarried==1 & headstatus==1 & headext==1 /*
	*/[aweight=wgt]
outreg2 using /*
	*/C:\Users\bmccully\Documents\pter-master\analysis\output\table3_sep17/*
	*/,tex(frag) label append /*
	*/ctitle("Head--married, (Earn ext. from add'l hours)") /*
	*/cttop(House work hours) addtext(Year FE, Yes) /*
	*/addstat(Dep. var. mean, r(mean))
	
areg hwwifeweekly `indep_vars_married' if headmarried==1 & /*
	*/headstatus==1 [aweight=wgt],vce(cluster pid) absorb(year)
sum hwwifeweekly if headmarried==1 & headstatus==1 [aweight=wgt]
outreg2 using /*
	*/C:\Users\bmccully\Documents\pter-master\analysis\output\table3_sep17/*
	*/,tex(frag) label append ctitle("Wife (all)") addtext(Year FE, Yes) /*
	*/addstat(Dep. var. mean, r(mean))
	
areg hwwifeweekly `indep_vars_married' [aweight=wgt] if headmarried==1 /*
	*/& headstatus==1 & headext==1, vce(cluster pid) absorb(year)
sum hwwifeweekly if headmarried==1 & headstatus==1 & headext==1 /*
	*/[aweight=wgt]
outreg2 using /*
	*/C:\Users\bmccully\Documents\pter-master\analysis\output\table3_sep17/*
	*/,tex(frag) label append ctitle("Wife, (Earn ext. from add'l hours)") /*
	*/cttop(House work hours) addtext(Year FE, Yes) /*
	*/addstat(Dep. var. mean, r(mean)) title(Determinants of Homework Hours)
	
/* Table 3.a -- Streamlined presentation of food-out ratio results */
use "$analysisin\pooled.dta",clear

local indep_vars_unmar = /*
	*/"construp constrdown headfemale headage headage_squared headblack i.headedu dislimithswrk headsecjob age2 age6 age12 age18 nonlabor_inc"
local indep_vars_married = /*
	*/"construp constrdown headage headage_squared headblack i.headedu dislimithswrk headsecjob age2 age6 age12 age18 nonlabor_inc wifeage i.wifeedu wifehour"
areg foodoutratio `indep_vars_unmar' if headmarried==0 [aweight=wgt],/*
	*/vce(cluster pid) absorb(year)
sum foodoutratio if headmarried==0 [aweight=wgt]
outreg2 using /*
	*/"C:\Users\bmccully\Documents\pter-master\analysis\output\table3a_sep17.tex" /*
	*/,replace label ctitle("Unmarried, (all)") /*
	*/addtext(Year FE, Yes) addstat(Dep. var. mean, r(mean))
	
areg foodoutratio `indep_vars_unmar' [aweight=wgt] if headmarried==0 /*
	*/& headstatus==1 & headext==1, vce(cluster pid) absorb(year)
sum foodoutratio if headmarried==0 & headstatus==1 & headext==1 /*
	*/[aweight=wgt]
outreg2 using /*
	*/C:\Users\bmccully\Documents\pter-master\analysis\output\table3a_sep17 /*
	*/,tex(frag) label append ctitle("Unmarried, (Earn ext. from add'l hours)") /*
	*/cttop(House work hours) addtext(Year FE, Yes) /*
	*/addstat(Dep. var. mean, r(mean))	
	
areg foodoutratio `indep_vars_married' if headmarried==1 & /*
	*/headstatus==1 [aweight=wgt],vce(cluster pid) absorb(year) 
sum foodoutratio if headmarried==1 & headstatus==1 [aweight=wgt]
outreg2 using /*
	*/C:\Users\bmccully\Documents\pter-master\analysis\output\table3a_sep17/*
	*/,tex(frag) label append ctitle("Married, (all)") addtext(Year FE, Yes)/*
	*/ addstat(Dep. var. mean, r(mean))
	
areg foodoutratio `indep_vars_married' [aweight=wgt] /*
	*/if headmarried==1 & headstatus==1 & headext==1,vce(cluster pid)/*
	*/ absorb(year)
sum foodoutratio if headmarried==1 & headstatus==1 & headext==1 /*
	*/[aweight=wgt]
outreg2 using /*
	*/C:\Users\bmccully\Documents\pter-master\analysis\output\table3a_sep17/*
	*/,tex(frag) label append ctitle("Married, (Earn ext. from add'l hours)") /*
	*/cttop(House work hours) addtext(Year FE, Yes) /*
	*/addstat(Dep. var. mean, r(mean)) ///
	title(Determinants of Food-out Ratio)

