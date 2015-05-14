/*Analyze transitions into and out of constrained-status
  Brett McCully, November 2014
  */
  
  set more off
  
  !st ../../build/output/pooled.sas7bdat ../../build/output/pooled.dta -y
  
  use "../../build/output/pooled.dta",clear

sort pid year
order pid year *


//label vars
label define empstatus 1 "Working/Temp. laid off" 2 "looking for work, unemployed" 3 "retired/permanently disabled" 4 "housewife" 5 "student" 6 "other"
label values headstatus empstatus
label define educ 1 "Dropped out before completing high school" 2 "High school grad" 3 "Some post-secondary education" 4 "College or higher degree"
label values headedu educ
label define occ 0 "Inap.: unemployed, retired, permanently disabled, housewife, or student" 1 "Professional, technical or kindred workers" 2 "Managers and Administrators, except Farm" 3 "Sales Workers" 4 "Clerical and kindred workers" 5 "craftsman and kindred workers" 6 "operatives, except transport" 7 "Transport equipment operatives" 8 "laborers, except farm" 9 "farmers and farm managers" 10 "farm laborers and farm foremen" 11 "services workers, except private household" 12 "private household workers"
label values headocc occ
label define ind 0 "Inap.: unemployed, retired, permanently disabled, housewife, or student" 1 "Agriculture, forestry, and fisheries" 2"mining" 3 "construction" 4 "manufacturing" 5 "transportation communication and other public utilities" 6 "wholesale and retail trade" 7 "finance, insurance, and real estate" 8 "business and repair services" 9 "personal services" 10 "entertainment and recreation services" 11 "Professional and related services" 12 "public administration" 
label values headind ind

  
  //make a timeseries
  tsset pid year
  tsfill, full
  
  /*establish various transition dummies
  CU==constrained up, CD==constrained down, NC==no constraint*/
  gen nc_to_nc = ((l1.construp==0 & l1.constrdown==0) & (construp==0 & constrdown==0))
  gen nc_to_uc = ((l1.construp==0 & l1.constrdown==0) & (construp==1))
  gen nc_to_dc = ((l1.construp==0 & l1.constrdown==0) & (constrdown==1))
  
  gen uc_to_nc = (l1.construp==1 & (construp==0 & constrdown==0))
  gen uc_to_dc = (l1.construp==1 & constrdown==1)
  gen uc_to_uc = (l1.construp==1 & construp==1)
  
  gen dc_to_nc = (l1.constrdown==1 & (construp==0 & constrdown==0))
  gen dc_to_uc = (l1.constrdown==1 & construp==1)
  gen dc_to_dc = (l1.constrdown==1 & constrdown==1)
  
  //generate income growth variables
  gen famincchg_1yr = (faminc - l1.faminc)/l1.faminc if faminc!=. & l1.faminc!=.
  
  //generate change vars
  g dislmtHw_chg = (disLimitHswrk!=l1.disLimitHswrk) if l1.disLimitHswrk!=. & disLimitHswrk!=.
  g selfEmp_chg = (selfEmployed!=l1.selfEmployed) if l1.selfEmployed!=. & selfEmployed!=.
  g headmarried_chg = (headmarried!=l1.headmarried) if l1.headmarried!=. & headmarried!=.
  g famsize_chg = famsize-l1.famsize
  g headedu_chg = (headedu!=l1.headedu) if headedu!=. & l1.headedu!=.
  g headocc_chg = (headocc!=l1.headocc) if headocc!=. & l1.headocc!=.
  g headind_chg = (headind!=l1.headind) if headind!=. & l1.headind!=.
  g homeown_chg = (homeowner!=l1.homeowner) if homeowner!=. & l1.homeowner!=.
  g hstatus_chg = (headstatus!=l1.headstatus) if headstatus!=. & l1.headstatus!=.
  g employed = (inlist(headstatus,1,2)) if headstatus!=.
  g lnwage = ln(headlabor/headhour) if headhour!=0 & headhour!=. & headlabor!=.
  g lnwage_chg = lnwage-l1.lnwage if l1.lnwage!=. & lnwage!=.
  g headage2 = headage^2 if headage!=.
  
  
  //before I get all fancy with regressions, calculate summary statistics for subsamples

 
 /*regress indep. vars on transition dummies
 foreach t of varlist nc_to_uc nc_to_dc {
	*male hourly workers
	reg `t' `indvars' if headhourly==1 & l1.headhourly==1 & gender==1
	*all hourly workers
	reg `t' gender `indvars' if headhourly==1 & l1.headhourly==1
	*male hourly + extra OT wage workers
	reg `t' `indvars' if (headhourly+headext)>=1 & (l1.headhourly+l1.headext)>=1 & gender==1
	*all hourly + extra OT wage workers
	reg `t' gender `indvars' if (headhourly+headext)>=1 & (l1.headhourly+l1.headext)>=1 
	*all workers
	reg `t' gender `indvars'
}
*/
 
 
//do above but with ordinal logit
gen constr_trans = 0 if nc_to_dc==1
replace constr_trans = 1 if nc_to_nc==1
replace constr_trans = 2 if nc_to_uc==1
label define ct 0 "NCtoDC" 1 "NCtoNC" 2 "NCtoUC"
label values constr_trans ct

  
*sum `ivars' if headhourly==1 & l1.headhourly==1 & gender==1 & constr_trans!=.
 *sum `ivars' if headhourly==1 & l1.headhourly==1 & constr_trans!=.
 *sum `ivars' if (headhourly+headext)>=1 & (l1.headhourly+l1.headext)>=1 & gender==1 & constr_trans!=.
 *sum `ivars' if (headhourly+headext)>=1 & (l1.headhourly+l1.headext)>=1 & constr_trans!=.
 
!rm ../output/constraint_analysis/trans_to_DC.*
!rm ../output/constraint_analysis/trans_to_UC.*
program drop ologit_trans
 program ologit_trans
 args cond title
	 local demographics1 = "gender headwhite headblack headage headmarried"
	 local other = "selfEmployed famsize homeowner employed headlabor headhour lnwage"
	 local demographics = "headwhite headblack headage headage2"
	 local indepvars_chg = "famincchg_1yr dislmtHw_chg selfEmp_chg famsize_chg headedu_chg headocc_chg headind_chg homeown_chg headmarried_chg hstatus_chg lnwage_chg i.year"
	 local indvars = "`demographics' `indepvars_chg'"
	 local noyears = "`demographics' famincchg_1yr dislmtHw_chg selfEmp_chg famsize_chg headedu_chg headocc_chg headind_chg homeown_chg headmarried_chg hstatus_chg lnwage_chg"
	 local ivars = "`demographics1' `other' famincchg_1yr dislmtHw_chg selfEmp_chg famsize_chg headedu_chg headocc_chg headind_chg homeown_chg headmarried_chg hstatus_chg lnwage_chg"
	*`title'
	quietly ologit constr_trans `indvars' `cond', nolog
	margins, dydx(`noyears') atmeans predict(pr outcome(0)) post
	outreg2 using ../output/constraint_analysis/trans_to_DC.doc, excel append ctitle(`title' NCtoDC) addnote(Marginal effects at means) 
	quietly ologit constr_trans `indvars' `cond', nolog
	margins, dydx(`noyears') atmeans predict(pr outcome(2)) post
	outreg2 using ../output/constraint_analysis/trans_to_UC.doc, excel append ctitle(`title' NCtoUC) addnote(Marginal effects at means) 
 end
 
 ologit_trans "if headhourly==1 & l1.headhourly==1 & gender==1" "Male hourly workers"
ologit_trans "if headhourly==1 & l1.headhourly==1" "all hourly workers"
ologit_trans "if (headhourly+headext)>=1 & (l1.headhourly+l1.headext)>=1 & gender==1" "male hourly + extra OT wage workers"
ologit_trans "if (headhourly+headext)>=1 & (l1.headhourly+l1.headext)>=1" "all hourly + extra OT wage workers"
ologit_trans "" "all workers"


 
 //now just regress on probability of having constraint, rather than transitioning into one
  

set lstretch off

gen constr = 0 if constrdown==1
replace constr = 1 if constr==. & headstatus==1
replace constr = 2 if construp==1
label define cstr 0 "DC" 1 "NC" 2 "UC" 
label values constr cstr

//since using i.headind and i.headocc is yielding "not estimable" marginal output, I make these dummies instead.
gen pros_and_managers = 0
replace pros_and_managers = 1 if inlist(headocc,1,2)
gen farm_or_service = 0
replace farm_or_service =1 if inlist(headocc,8,9,10,11,12)

gen services = 0 
replace services =1  if inlist(headind,8,9,10,11)
gen bluecol = 0 
replace bluecol = 1 if inlist(headind,1,2,3,4,5)
gen finance = 0 
replace finance = 1 if headind==7
gen govt = 0 
replace govt = 1 if headind==12

!rm ../output/constraint_analysis/constrdown.*
!rm ../output/constraint_analysis/construp.*
program drop ologit_constr
program ologit_constr
args cond title
	local demographics = "headwhite headblack headage headage2"
	local indvars = "`demographics' faminc selfEmployed headmarried famsize i.headedu pros_and_managers farm_or_service services bluecol finance govt homeowner lnwage i.year"		
	local indvars = "`demographics' faminc selfEmployed headmarried famsize i.headedu pros_and_managers farm_or_service services bluecol finance govt homeowner lnwage i.year"
	local noyears = "`demographics' faminc selfEmployed headmarried famsize i.headedu pros_and_managers farm_or_service services bluecol finance govt homeowner lnwage"

	*DC
	quietly ologit constr `indvars' `cond', nolog
	margins, dydx(`noyears') atmeans predict(pr outcome(0)) post
	outreg2 using ../output/constraint_analysis/constrdown.doc, excel append ctitle(`title') addnote(Marginal effects at means) 
	*UC
	quietly ologit constr `indvars' `cond', nolog
	margins, dydx(`noyears') atmeans predict(pr outcome(2)) post
	outreg2 using ../output/constraint_analysis/construp.doc, excel append ctitle(`title') addnote(Marginal effects at means) 
 end
ologit_constr "if headhourly==1 & l1.headhourly==1 & gender==1" "Male hourly workers"
ologit_constr "if headhourly==1 & l1.headhourly==1" "all hourly workers"
ologit_constr "if (headhourly+headext)>=1 & (l1.headhourly+l1.headext)>=1 & gender==1" "male hourly + extra OT wage workers"
ologit_constr "if (headhourly+headext)>=1 & (l1.headhourly+l1.headext)>=1" "all hourly + extra OT wage workers"
ologit_constr "" "all workers"

 


