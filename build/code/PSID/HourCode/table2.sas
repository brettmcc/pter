/* Recreate table 2 of descriptive statistics
 * Brett McCully, January 2014
*/

ods html file="R:/m1bam03/homeProdHourConstraints/build/output/table2.html";

data pooled;
	set homeprod.pooled;
	restr = "none";
	if construp=1 then restr="up";
	else if constrdown=1 then restr="down";
	marrHead = (headmarital=1 | headmarital=5);
	foodRatio = foodout/sum(foodin,foodout);
run;

*percentage sample observations;
proc means data=pooled mean;
	var construp constrdown;
	weight wgt;
run;

proc sort data=pooled;
	by restr;
run;
/*Demographic characteristics*/
proc freq data=pooled;
	by restr;
	tables headrace headedu marrHead;
	weight wgt;
run;
proc means data=pooled mean stddev;
	by restr;
	var headage famsize faminc headhour wifehour;
	weight wgt;
run;
proc sort data=pooled;
	by restr marrHead;
run;
proc means data=pooled mean stddev;
	by restr marrHead;
	var foodRatio HWHead HWWife HeadVacationWeek;
	weight wgt;
run;

ods html close;
