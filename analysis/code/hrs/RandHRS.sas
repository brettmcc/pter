libname HomeProd "../../../build/output";
proc print printto="../../temp/RandHRS.lst";run;

ods html file = "../../output/RandHRS.html";

proc freq data = HomeProd.HRSData;
tables constraint;
weight wgt; run;

proc sort data = HomeProd.HRSData;
by constraint;
run;

proc freq data = HomeProd.HRSData;
weight WGT;
by constraint;
tables white belowhighschool highschool abovehighschool married;

proc means data = HomeProd.HRSData vardef = weight;
weight WGT;
by constraint;
var headage famsize realincome faminc food realfood realfoodout realwage headhour wifehour lessgap moregap;
run;
run;

data v;
set HomeProd.HRSData;
if construp = 1 then constraint = 1;
else if constrdown = 1 then constraint = 2;
else constraint = 0;

proc sort data = v;
by married constraint;

proc means data = v;
by married constraint;
var foodout food; 
weight wgt;
output out = u mean = foodout food;

data u;
set u;
foodpct = foodout / food;
run;
***********************************Econometric Analysis****************************************************;
**************OLS;
data married;
set HomeProd.HRSData;
if married = 1;

proc reg data = married;
model foodpct = construp constrdown headage headage2 white highschool somecollege college famsize 
                headwage p2 - p10 logfood wave2 wave3 wave5-wave11;  
run;
**************Tobit;
proc qlim data = married;
model foodpct = construp constrdown headage headage2 white highschool somecollege college famsize 
                headwage p2 - p10 logfood wave2 wave3 wave5-wave11; 
endogenous foodpct ~ censored(lb = 0 ub = 100);
run;

data predict;
set HomeProd.HRSData;
foodpctP = foodpct;
if constraint > 0 then foodpctP = .;

proc reg data = predict;
model foodpctP = /*construp constrdown*/ headage  headage2 white highschool somecollege college famsize 
                 headwage p2 - p10 logfood wave2 wave3 wave5-wave11;  
output out = foodpctP p = predict;

data foodpctP;
set foodpctP;
gap = predict - foodpct;
if moregap < 1500 and lessgap < 1500;
if constraint > 0;

proc univariate data = foodpctP;
var gap moregap lessgap;
run;

proc reg data = foodpctP;
model gap = lessgap moregap headage  headage2 white malehead highschool somecollege college famsize 
            p2 - p10 headhour wifehour headwage logfood wave2 wave3 wave5-wave11;  run;  

data unmarried;
set HomeProd.HRSData;
if married = 0;

proc reg data = unmarried;
model foodpct = construp constrdown headage  headage2 white malehead highschool somecollege college 
      	      	famsize p2 - p10 headwage wave2 wave3 wave5-wave11; run;

ods html close;
