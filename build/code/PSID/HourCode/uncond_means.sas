


/* table of unconditional summary statistics */
*ods html file="R:/m1bam03/homeProdHourConstraints/uncond_means.html"; 
ods html file="R:\m1bam03\homeProdHourConstraints\build\output\uncond_means.html"; 

proc means data=HomeProd.pooled;
	var construp wifeconstrup constrdown marwage gender headage famsize
		children age2 age6 age12 age18 headocc headind HWHW HWHead 
		HWHeadWeekly HomeProd Repair HeadTakeVacation HeadVacationWeek faminc
		headlabor headhour headext headsalary headhourly lagheadhour year 
		headwhite headblack disLimitHswrk selfEmployed headmarried leadmarried
		homeowner homeown headstatus sameemp_mths;
run;
*if married or separated;
proc  means data=HomeProd.pooled(where=(headmarital=1 OR headmarital=5));
	var wifeage wifeedu wifeocc wifeind HWWife HWWifeWeekly wifeext WifeVacationWeek WifeTakeVacation wifelabor wifehour wifesalary wifehourly;
run;
ods html close;

/*by constrained status;
data pooled;	
	set HomeProd.pooled;
	if constrdown=1 then constr="downward constrained";
	else if construp=1 then constr="upward constrained";
	else constr = "unconstrained";
	headhsgrad = (headedu=2);
	headsomecol = (headedu=3);
	headcolplus = (headedu=4);

	headsalot = (headext=1 & headsalary=1);

	lnfaminc = log(faminc);
	lnlaborinc = log(headlabor);
	lnwage = log(headlabor/headhour);
run;
proc means data=pooled n mean;
	class constr;
	var headage headwhite headhsgrad headsomecol headcolplus headmarried children headhour
	headsalary headsalot headhourly
	lnwage lnlaborinc lnfaminc;
run;
ods html close;
