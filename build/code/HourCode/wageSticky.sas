/* Using the pooled dataset, determine the probability of the wage remaining unchanged for constrained and *
 * unconstrained groups.																				   *
 * Brett McCully, April 2014																			   */
/*
proc sort data=Homeprod.Pooled;
	by pid year;
run;

proc expand data=homeprod.pooled out=homeprod.wageSticky method=none;
	by pid;
	id year;
	convert headlabor = headlabor_lag1 / transformout = (lag 1);
	convert headhour = headhour_lag1 / transformout = (lag 1);
run;
data homeprod.wageSticky;
	set homeprod.wageSticky;
	headwage = headlabor/headhour;
	headwage_lag1 = headlabor_lag1/headhour_lag1;
run;

proc sql;
	create table wageSticky as
	select ws.*, aw.meanWage, aw.meanWage_lag1
	from homeprod.wageSticky as ws, 
		(select year, mean(headlabor/headhour) as meanWage, mean(headlabor_lag1/headhour_lag1) as meanWage_lag1
		 from homeprod.wageSticky 
		 group by year) as aw
	where ws.year=aw.year
	order by pid, year
	;
quit;
proc copy in=work out=homeprod;
	select wageSticky;
run;*/
*compute probability of wage stickiness;
data homeprod.wageSticky;
	set homeprod.wageSticky(where=(headlabor^=. & headlabor_lag1^=.));
	sameWage = 0;
	sameWage_interval1=0;
	sameWage_interval5=0;
	if headwage=headwage_lag1 then sameWage=1;
	*wage changed less than 5 percent of last year wage;
	if abs(headwage-headwage_lag1)<headwage_lag1*.05 then sameWage_interval1=1;
	*wage changed less than 10 percent of last year wage;
	if abs(headwage-headwage_lag1)<headwage_lag1*.1 then sameWage_interval5=1;
	constrained = construp;
	if constrdown=1 then constrained = 2;
run;
proc format;
	value cstr 0="Unconstrained"
			   1="Upward"
			   2="Downward";
run;

proc means data=homeprod.wageSticky n mean;
	title "Overall";
	var sameWage:;
run;
proc means data=homeprod.wageSticky n mean;
	title "by constrained status";
	format constrained cstr;
	class constrained;
	var sameWage:;
run;

*by salaried;
proc means data=homeprod.wageSticky n mean;
	title "All, by salaried";
	class headsalaried;
	var sameWage:;
run;


*for only salaried workers;
proc means data=homeprod.wageSticky(where=(headsalaried=1)) n mean;
	title "All salaried workers";
	var sameWage:;
run;
proc means data=homeprod.wageSticky(where=(headsalaried=1)) n mean;
	title "Salaried workers, by constrained status";
	format contstrained cstr;
	class constrained;
	var sameWage:;
run;


proc freq data=homeprod.wageSticky(where=(headsalaried in (1,3)));
	Title "Salaried and Hourly workers only, by constrained and salary status";
	format constrained cstr;
	tables headsalaried*(constrained)*sameWage_interval1;
run;


proc freq data=homeprod.wageSticky;
	*by year;
	/*title "All obs, by year (1% interval)";
	format constrained cstr;*/
	tables year*sameWage_interval1;
run;
