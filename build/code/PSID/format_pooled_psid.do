global sample = 1 //==1 if Brett's preferred sample, ==4 if LG's 2009 sample restrictions

clear all
set more off

use "${dir}\build\output\pooled.dta",clear

drop if year==1987 //for some reason have one observation in 1987

tsset pid year

label define empstat 1 "Employed" 2 "Temporarily laid off" 3 "Looking for work, unemployed"
label values headstatus empstat

gen headhourweekly = headhour/52
gen headfulltime = (headhourweekly>35 & headhourweekly!=.)
gen headparttime = (headhourweekly<=35 & headhourweekly>0 & headstatus==1)
label variable headparttime "Head part-time dummy"
gen headage_squared = headage^2
label variable headhour "Head hours (annual)"
label variable headhourweekly "Head hours (weekly)"

gen lt35hrs = (headhourweekly<35)
gen construp35 = (lt35hrs == 1 & construp==1)
gen constr = "NC"
replace constr = "UC" if construp==1
replace constr = "DC" if constrdown==1

*these are necessary since dropping some observations in sample selection
gen lag_construp = l1.construp
gen lag_constrdown = l1.constrdown
gen lag_headmarried = l1.headmarried
gen lag_headstatus = l1.headstatus
gen lag_headparttime = l1.headparttime
gen lag_headfulltime = l1.headfulltime
label variable headmarried "Head married"

label variable construp "Upside constrained"
label variable constrdown "Downside constrained"

gen headsecjob = (secjob==1 | secjob==3)
label variable headsecjob "Head has 2+ jobs"

*demographic variables
gen headedu_ltHs = headedu==1
gen headedu_hsgrad = headedu==2
gen headedu_someCol = headedu==3
gen headedu_colPl = headedu==4

gen headfemale = gender==2
label variable headfemale "Head female"

label variable headage "Head age"
label variable headage_squared "$ Head age^2$"
label variable headblack "Head black"
label variable dislimithswrk "Disability limits house work"
label variable wifeage "Wife age"

label variable children "# children in HH"

*long term upward constrained
gen longterm_upconstr = (construp==1 & l1.construp==1 & l2.construp==1) if year>1969

*constraint transition dummies
gen became_uc = (l1.construp==0 & construp==1)
label variable became_uc "Became UC" 
gen escaped_uc = (l1.construp==1 & construp==0)
label variable escaped_uc "Escaped UC"

*other transition variables;
gen stay_married = (l1.headmarital==1 & headmarital==1)
label variable stay_married "Stay married"
gen became_div_sep = (l1.headmarital==1 & inlist(headmarital,2,3,4,5))
label variable became_div_sep "Became divorced/separated"
gen became_married = (l1.headmarital!=1 & headmarital==1)
label variable became_married "Became married"
gen chg_num_children = (children-l1.children)
label variable chg_num_children "Chg. in num. of children"

gen chglog_faminc = log(faminc)-log(l1.faminc)
label variable chglog_faminc "Chg. ln of family income"
gen nonlabor_inc = faminc - headlabor
replace nonlabor_inc = nonlabor_inc - wifelabor if wifelabor!=.
label variable nonlabor_inc "Family non-labor income"
gen chg_nonlabor_inc = nonlabor_inc-l1.nonlabor_inc
label variable chg_nonlabor_inc "Chg. family's non-labor income"
gen chg_log_nonlabor_inc = log(nonlabor_inc+1)-log(l1.nonlabor_inc+1)
label variable chg_log_nonlabor_inc "Chg. ln family's non-labor income"
gen chg_log_headwage = log((1+headlabor)/(1+headhour))/*
	*/-log((1+l1.headlabor)/(1+l1.headhour))
label variable chg_log_headwage "Chg. ln head wage"
gen chg_log_wifewage = log(wifelabor/wifehour)/*
	*/-log(l1.wifelabor/l1.wifehour)
label variable chg_log_wifewage "Chg. ln wife wage"
gen log_headwage = log((1+headlabor)/(1+headhour))
label variable log_headwage "Ln head wage"
gen headwage = headlabor/headhour if headhour>0
label variable headwage "Avg. head wage"

replace mainwage = . if mainwage==9.99 & year<=1977
replace mainwage = . if mainwage==99.99 & year>1977
label variable mainwage "Hourly wage (if paid hourly)"
	
gen chglog_headhour = log(headhour+1)-log(l1.headhour+1)
label variable chglog_headhour "Chg. ln head annual hours"
gen chglog_wifehour = log((1+wifehour)/(l1.wifehour+1))
label variable chglog_wifehour "Chg. ln wife annual hours"
gen chg_headhour = headhour-l1.headhour
label variable chg_headhour "Chg. head annual hours"
gen became_hmowner = (homeowner==1 & l1.homeowner==0)
label variable became_hmowner "Became homeowner"
label variable homeowner "Homeowner"

gen unemp_to_ft = (l1.headstatus==2 & headstatus==1 & headfulltime==1)
label variable unemp_to_ft "Unemp. to FT"
gen unemp_to_pt = (l1.headstatus==2 & headstatus==1 & headparttime==1)
label variable unemp_to_pt "Unemp. to PT"
gen ft_to_unemp = (l1.headstatus==1 & l1.headfulltime==1 & headstatus==2)
label variable ft_to_unemp "FT to Unemp."
gen pt_to_unemp = (l1.headparttime==1 & l1.headstatus==1 & headstatus==2)
label variable pt_to_unemp "PT to Unemp."

gen ft_to_pt	= (l1.headfulltime==1 & l1.headstatus==1 & /*
					*/headstatus==1 & headparttime==1)
label variable ft_to_pt "FT to PT"
gen pt_to_ft	= (l1.headstatus==1 & l1.headparttime==1 &/*
					*/ headfulltime==1 & headstatus==1)
label variable pt_to_ft "PT to FT"
gen pt_to_pt	= (l1.headstatus==1 & l1.headparttime==1 & /*
					*/headstatus==1 & headparttime==1)
label variable pt_to_pt "PT to PT"

gen became_hourlywaged = (l1.headhourly==0 & headhourly==1)
label variable became_hourlywaged "Became hourly wage worker"

replace num_addljobs=0 if headstatus==1 & num_addljobs==.

//changed jobs
gen chgd_jobs = (tenure==1)
label variable chgd_jobs "Chg'd job"

//acquired additional job
gen got_addl_job = (num_addljobs-l1.num_addljobs>0 & headstatus==1 & /*
	*/l1.headstatus==1) if num_addljobs!=. & l1.num_addljobs!=.
label variable got_addl_job "Got add'l job"
	
//changed union status
gen chgd_union_status = (union_dummy!=l1.union_dummy) if union_dummy!=. /*
	*/ & l1.union_dummy!=.
label variable chgd_union_status "Chg'd union status"
label variable union_dummy "Union dummy"

//wife changes labor force participation 
*first format wife hours variable to account for not having a wife
replace wifehour = . if headmarried==0
gen wife_enters_workforce = (wifehour>0 & wifehour!=. & l1.wifehour==0)
label variable wife_enters_workforce "Wife starts working"

//change in food-out ratio and housework hours
gen chg_foodout = foodout-l1.foodout
label variable chg_foodout "Chg. food-out ratio"
gen chg_housework_hours = hwhead-l1.hwhead
label variable chg_housework_hours "Chg. HW hours"

*home production variables
gen foodoutratio = foodout/(foodout+foodin)*100
label variable foodoutratio "Food-out ratio"
gen loghwhead = log(hwhead+1)
label variable loghwhead "Ln housework hours (head)"
gen loghwwife = log(hwwife+1)
label variable loghwwife "Ln housework hours (wife)"
gen loghwhw = log(hwhw+1)
label variable loghwhw "Ln head+wife housework hours"

*hours bin variable
gen headhours_bin = ""
replace headhours_bin = "0-35" if headhourweekly>0 & headhourweekly<35
replace headhours_bin = "35-40" if headhourweekly>=35 & headhourweekly<40
replace headhours_bin = "40-45" if headhourweekly>=40 & headhourweekly<45
replace headhours_bin = "45-50" if headhourweekly>=45 & headhourweekly<50
replace headhours_bin = "50-55" if headhourweekly>=50 & headhourweekly<55
replace headhours_bin = "55-60" if headhourweekly>=55 & headhourweekly<60
replace headhours_bin = "60-65" if headhourweekly>=60 & headhourweekly<65
replace headhours_bin = "65-70" if headhourweekly>=65 & headhourweekly<70
replace headhours_bin = "70-75" if headhourweekly>=70 & headhourweekly<75
replace headhours_bin = "75-80" if headhourweekly>=75 & headhourweekly<=80


//label vars
label define empstatus 1 "Working/Temp. laid off" 2 "looking for work, unemployed" 3 "retired/permanently disabled" 4 "housewife" 5 "student" 6 "other"
label values headstatus empstatus
label define educ 1 "Dropped out before completing high school" 2 "High school grad" 3 "Some post-secondary education" 4 "College or higher degree"
label values headedu educ
label values wifeedu educ
label define occ 0 "Inap.: unemployed, retired, permanently disabled, housewife, or student" 1 "Professional, technical or kindred workers" 2 "Managers and Administrators, except Farm" 3 "Sales Workers" 4 "Clerical and kindred workers" 5 "craftsman and kindred workers" 6 "operatives, except transport" 7 "Transport equipment operatives" 8 "laborers, except farm" 9 "farmers and farm managers" 10 "farm laborers and farm foremen" 11 "services workers, except private household" 12 "private household workers"
label values headocc occ
label define ind 0 "Inap.: unemployed, retired, permanently disabled, housewife, or student" 1 "Agriculture, forestry, and fisheries" 2"mining" 3 "construction" 4 "manufacturing" 5 "transportation communication and other public utilities" 6 "wholesale and retail trade" 7 "finance, insurance, and real estate" 8 "business and repair services" 9 "personal services" 10 "entertainment and recreation services" 11 "Professional and related services" 12 "public administration" 
label values headind ind
label variable marwage "head marginal wage"

label variable age2 "Num. children age 0-2"
label variable age6 "Num. children age 3-6"
label variable age12 "Num. children age 7-12"
label variable age18 "Num. children age 13-18"

label define marital 1 "Married" 2 "Single" 3 "Widowed" 4 "Divorced" /*
	*/5 "Separated" 9 "NA"
label values headmarital marital

label variable wifehour "Wife work hours"


save "${dir}\analysis\input\pooled_all.dta",replace


/*output time series datasets*/
*underemployed and part time
preserve
collapse (sum) construp35 headstatus if headstatus==1 [iweight=wgt], by(year)
gen prop_underemp_lt35_psid = construp35/headstatus
label var prop_underemp_lt35_psid "PSID, all"
save "${dir}\build\output\psid_construp35_yrly.dta",replace
restore

*underemployed full time
preserve
collapse construp headstatus if headstatus==1 & headfulltime==1 /*
	*/[iweight=wgt], by(year)
gen prop_underemp_ft_psid = construp/headstatus
label var prop_underemp_ft_psid "Underemp., FT"
save "${dir}\build\output\psid_construp_ft_yrly.dta",replace
restore


*underemployed, part time, age 50-70 
preserve
collapse (sum) construp35 headstatus if headstatus==1 & headage>=50 & headage<=70 [iweight=wgt], by(year)
gen prop_underemp_50to70_psid = construp35/headstatus 
label var prop_underemp_50to70_psid "PSID, ages 50-70"
save "${dir}\build\output\psid_construp35_age50to70_yrly.dta",replace
restore

*underemployed, full and part time
preserve
collapse (sum) construp headstatus if headstatus==1 [iweight=wgt], by(year)
gen prop_underemp_psid = construp/headstatus
label var prop_underemp_psid "PSID, all"
save "${dir}\build\output\psid_construp_yrly.dta",replace
restore

/*Sample restrictions*/
*Brett's preferred restrictions
if $sample==1 {
	keep if headage>=25 & headage<=65
	keep if headhour>=520 & headhour<=4160 //10-80 hours a week
	drop if selfemployed==1
	keep if headext==1
}

*LG's 2009 restrictions
if $sample==4 {
	keep if headage>=22 & headage<68
	drop if wifeage>66 & wifeage!=.
	keep if headstatus==1 | headstatus==2 | headstatus==3
	keep if year ==1967 | year==1968 | year==1973 | /*
		*/(foodin+foodout>100 & foodin+foodout<10000)
	keep if faminc>1200 & faminc<1000000
	keep if (headlabor + wifelabor > 1200) & (headlabor + wifelabor) < 1000000
	drop if headmarital== 1 & gender == 2
	drop if headmarital != 1 & ((hwwife > 0 & hwwife!=.) | /*
		*/(wifehour > 0 & wifehour!=.) | (wifelabor > 0 & wifelabor!=.))
	drop if year >= 1968 & headtakevacation != 1 & headvacationweek > 0 & headvacationweek!=.
	drop if year >= 1975 & wifetakevacation != 1 & wifevacationweek > 0 & wifevacationweek!=.
	drop if headvacationweek > 27 & headvacationweek!=.
	drop if wifevacationweek > 27 & wifevacationweek!=.
	drop if headhour > 4160 & headhour!=.
	drop if wifehour > 4160 & wifehour!=.
	keep if headhour > 500 
	drop if hwhead > 4160 & hwhead!=.                              
	drop if hwwife > 4160 & hwwife!=.
	drop if abs(hwheadweekly * 52 - hwhead) > 26 & abs(hwheadweekly * 52 - hwhead)!=.
	drop if abs(hwwifeweekly * 52 - hwwife) > 26 & abs(hwwifeweekly * 52 - hwwife)!=.
	drop if year != 1967 & abs(hwhw - hwhead - hwwife) > 0 & abs(hwhw - hwhead - hwwife)!=.
	if year == 1967 & headmarital != 1 { 
	   drop if hwhw > 8320 & hwhw!=.
	   replace hwhead = hwhw
	 }
}

save "${dir}\analysis\input\pooled.dta",replace
