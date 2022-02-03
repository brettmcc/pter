/* Create variable for entering/exiting constrained status, evaluate what causes these transitions. *
 * Brett McCully, May 2014								   */

options linesize=120;

proc sort data=HomeProd.pooled;
	by pid year;
run;

*keep only observations for which we can observe a transition;
data homeprod.pooled_transitions;
	set homeprod.pooled;
	constrained = construp;
	if constrdown=1 then constrained = 2;

	pid_lag1 = lag(pid);
	constrained_lag1 = lag(constrained);
	year_lag1 = lag(year);
	if pid_lag1^=pid OR year^=year_lag1+1 then constrained_lag1=.;
	constrained_lag1 = lag(constrained);
	faminc_lag1 = lag(faminc);
	headlabor_lag1 = lag(headlabor);
	wifelabor_lag1 = lag(wifelabor);
	headsalaried_lag1 = lag(headsalaried);
	wifesalaried_lag1 = lag(wifesalaried);
	headind_lag1 = lag(headind);
	wifeind_lag1 = lag(wifeind);
	headocc_lag1 = lag(headocc);
	wifeocc_lag1 = lag(wifeocc);
	laborInc_lag1 = lag(laborInc);

	if constrained^=constrained_lag1 & constrained in (0,1,2) & constrained_lag1 in (0,1,2) & year=year_lag1+1 & pid=pid_lag1 then do;
		if constrained=1 & constrained_lag1=0 then constr_trans=1;
		else if constrained=2 & constrained_lag1=0 then constr_trans=2;
		else if constrained=0 & constrained_lag1=1 then constr_trans=3;
		else if constrained=2 & constrained_lag1=1 then constr_trans=4;
		else if constrained=0 & constrained_lag1=2 then constr_trans=5;
		else if constrained=1 & constrained_lag1=2 then constr_trans=6;
	end;
	if constrained=constrained_lag1 & constrained in (0,1,2) & constrained_lag1 in (0,1,2) & year=year_lag1+1 & pid=pid_lag1 then do;
		if constrained=0 & constrained_lag1=0 then constr_trans=7;
		else if constrained=1 & constrained_lag1=1 then constr_trans=8;
		else if constrained=2 & constrained_lag1=2 then constr_trans=9;
	end;
	array constr_tr(9) constr_trans1-constr_trans9;
	do i = 1 to 9;
		constr_tr(i) = (constr_trans=i);
	end;
	drop i;

	*this label statement is incorrect--fix sometime later;
	*label constr_trans1 = "Up to Not"
		  constr_trans2 = "Down to Not"
		  constr_trans3 = "Not to Up"
		  constr_trans4 = "Down to Up"
		  constr_trans5 = "Not to Down"
		  constr_trans6 = "Up to Down"
		  constr_trans7 = "Not to Not"
		  constr_trans8 = "Up to Up"
		  constr_trans9 = "Down to Down";

	if year=year_lag1+1 & pid=pid_lag1 then diff_faminc = faminc - faminc_lag1;
	if year=year_lag1+1 & pid=pid_lag1 then diff_headlabor = headlabor - headlabor_lag1;
	if year=year_lag1+1 & pid=pid_lag1 then diff_wifelabor = wifelabor - wifelabor_lag1;
	if year=year_lag1+1 then diff_headsalaried = (headsalaried^=headsalaried_lag1);
	if year=year_lag1+1 then diff_wifesalaried = (wifesalaried^=wifesalaried_lag1);
	if year=year_lag1+1 then diff_headind = (headind^=headind_lag1);
	if year=year_lag1+1 then diff_wifeind = (wifeind^=wifeind_lag1);
	if year=year_lag1+1 then diff_headocc = (headocc^=headocc_lag1);
	if year=year_lag1+1 then diff_wifeocc = (wifeocc^=wifeocc_lag1);

	if year=year_lag1+1 & pid=pid_lag1 then diff_nonLaborInc = sum(sum(faminc,-laborInc),sum(faminc_lag1,-laborInc_lag1));
	diff_headhour = headhour - lagheadhour;
	
run;
/*
proc format;
	value cstr_tr 	0="No transition"
				  	1="up to none"
					2="down to none"
					3="none to up"
					4="down to up"
					5="none to down"
					6="up to down";
run;

title3 "Number obs. in each constrained status category";
proc freq data=homeprod.pooled_transitions;
	format constr_trans cstr_tr.;
	tables constr_trans / missing;
run;

%let regressors = diff_nonLaborInc diff_headlabor diff_wifelabor diff_headsalaried diff_wifesalaried diff_headind diff_wifeind diff_headocc diff_wifeocc;
%let indep_var = diff_faminc diff_headsalaried diff_wifesalaried diff_headind diff_wifeind diff_headocc diff_wifeocc ;

%macro regress;
  %do i=1 %to 8;
	%let indep_var = %scan(&regressors,&i);
	title "regression &i";
	proc reg data=homeprod.pooled_transitions;
		model constr_trans = &regressors;
		weight wgt;
	run;
  %end;
%mend;

*%regress;
/*
proc reg data=homeprod.pooled_transitions;
	model constr_trans = diff_faminc diff_headsalaried diff_wifesalaried diff_headind diff_wifeind diff_headocc diff_wifeocc;
	weight wgt;
run;*/

%macro regress2;
	%do i=0 %to 6;
		proc reg data=homeprod.pooled_transitions;
			model constr_trans&i. = &indep_var;
			weight wgt;
		run;
	%end;
%mend;
*%regress2;

/*INCOME*/
*see what average income change is for constrained-status-changers vs. non-changers;
title3 "Income changes for constrained-trans. categories";
proc means data=homeprod.pooled_transitions mean std p50;
	format constr_trans cstr_tr.;
	class constr_trans;
	var diff_faminc diff_headlabor diff_wifelabor;
	weight wgt;
run;

data buildout.pooled_transitions;
	set homeprod.pooled_transitions;
run;
