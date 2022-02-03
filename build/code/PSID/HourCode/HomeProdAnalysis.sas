*********Construct a sample that we will use to study the market work hours constraints on housework and vacation*********
*********There are two sets of sample selection rules. 1. apply to both head and wife, 2. apply to head or wife  *********
*********only.  For the second set of selection rules, we apply them to the datasets that we will use to run     *********
*********head or wife specific analysis                                                                          *********;

data u;
set HomeProd.Pooled;
mc = (headmarital ne leadmarital);

proc sort data = u;
by pid;

proc means data = u noprint;
var mc;
output out = mc sum = mc;
by pid; run;

data mc;
set mc;
keep pid mc;

proc freq data = mc;
tables mc;
run;

data u;
merge u(in = in1) mc(in = in2);
by pid;
if in1 and in2;

if headage ge 25 and headage < 66;   ******Head age restriction;
if wifeage ge 66 then delete;
if headstatus in (1, 2, 3);          *****Head is working, unemployed or temporarily laid off;
if year = 1967 or year = 1968 or year = 1973 or (foodin + foodout > 100 and foodin + foodout < 10000);  ******Food expenditure restriction;
if faminc > 1200 and faminc < 100000;   ******Family income restriction;
if (headlabor + wifelabor > 1200) and (headlabor + wifelabor) < 100000;   ******labor income restriction;
if headmarital = 1 and gender = 2 then delete;
if headmarital ne 1 and (HWWife > 0 or Wifehour > 0 or wifelabor > 0) then delete;
if year ge 1968 and headtakevacation ne 1 and headvacationweek > 0 then delete; 
if year ge 1975 and wifetakevacation ne 1 and wifevacationweek > 0 then delete; 
if headvacationweek > 27 then delete;                       ******Vacation time restriction;
if wifevacationweek > 27 then delete;                       ******Vacation time restriction;
if headhour > 3000 then delete;                             ******Market work hours restriction;
if wifehour > 3000 then delete; 
if headhour > 1000;
if HWHead > 3000 then delete;                               ******Housework hours restriction;
if HWWife > 3000 then delete;  
if abs(HWHeadWeekly * 52 - HWHead) > 26 then delete;
if abs(HWWifeWeekly * 52 - HWWife) > 26 then delete;
if year ne 1967 and abs(HWHW - HWHead - HWWife) > 0 then delete;
if year = 1967 and headmarital ne 1 then do; 
   if HWHW > 3000 then delete; 
   HWHead = HWHW;
   end;

headage2 = headage ** 2 / 100;
highschool = (headedu = 2);
somecollege = (headedu = 3);
college = (headedu = 4);
belowhighschool = (headedu = 1);
abovehighschool = (headedu ge 3);
white = (headrace = 1);
salaried = (headextra = 1 or (year le 1975 and headsalaried = 1) or (year ge 1976 and headsalaried = 3));

wifeage2 = wifeage ** 2 / 100;
wifehighschool = (wifeedu = 2);
wifesomecollege = (wifeedu = 3);
wifecollege = (wifeedu = 4);

adults = famsize - children; 
married = (headmarital = 1);
female = (gender = 2);
headwage = headlabor / headhour;
food = foodin + foodout;
foodpct = foodout / food * 100;
totalhour = headhour + wifehour;
mup = married * construp;
mdown = married * constrdown;

wifewage = wifelabor / max(wifehour, 1);
wifefulltime = wifehour > 1000;
wifeparttime = (wifehour > 0 and wifehour le 1000);

labor = headlabor + wifelabor;
otherincome = faminc - labor;

if year ne 1967 then HWHW = HWHead + HWWife;
MarketHome = totalhour + HWHW;
if year le 1971 and repair < 999 then homeprod = homeprod + repair;
HWHP = HWHW + Homeprod;

if construp = 1 then constraint = 1;
else if constrdown = 1 then constraint = 2;
else constraint = 0;

logincome = log(faminc);
logfood = log(food);

if year = 1967 then CPI =    33.4;  
if year = 1968 then CPI =    34.7833333333333;    
if year = 1969 then CPI =    36.6833333333333;    
if year = 1970 then CPI =              38.825;    
if year = 1971 then CPI =    40.4916666666667;    
if year = 1972 then CPI =    41.8166666666667;    
if year = 1973 then CPI =                44.4;    
if year = 1974 then CPI =    49.3083333333333;    
if year = 1975 then CPI =    53.8166666666667;    
if year = 1976 then CPI =    56.9083333333333;    
if year = 1977 then CPI =    60.6083333333333;    
if year = 1978 then CPI =    65.2333333333333;    
if year = 1979 then CPI =              72.575;    
if year = 1980 then CPI =    82.4083333333333;    
if year = 1981 then CPI =              90.925;    
if year = 1982 then CPI =                96.5;    
if year = 1983 then CPI =                99.6;    
if year = 1984 then CPI =    103.883333333333;    
if year = 1985 then CPI =    107.566666666667;    
if year = 1986 then CPI =    109.608333333333;    

realfaminc    = faminc * 100 / CPI;
realheadlabor = headlabor * 100 / CPI;
realwifelabor = wifelabor * 100 / CPI;
reallabor     = labor * 100 / CPI;
realotherincome = otherincome * 100 / CPI;
realheadwage  = headwage * 100 / CPI;
realwifewage  = wifewage * 100 / CPI;
realfood      = food * 100 / CPI;


array headoccupation[12] headocc1 - headocc12;
do i = 1 to 12;
   headoccupation[i] = (headocc = i);
end;

array headindustry[12] headind1 - headind12;
do i = 1 to 12;
   headindustry[i] = (headind = i);
end;
run;

proc sort data = u;
by year; 
run;

proc freq data = u;
tables mc;
run;

proc univariate data = u noprint;
by year;
var faminc;
output out = HomeProd.IncomeDecile
pctlpre = faminc_ 
pctlpts = 10 20 30 40 50 60 70 80 90; run;

proc univariate data = u noprint;
by year;
var otherincome;
output out = HomeProd.OtherIncomeQuintile
pctlpre = otherincome_
pctlpts = 20 40 60 80; run;


data HomeProd.Baseline;
merge u HomeProd.IncomeDecile HomeProd.OtherIncomeQuintile;
by year;
p1 = (faminc < faminc_10);
p2 = (faminc ge faminc_10 and faminc < faminc_20);
p3 = (faminc ge faminc_20 and faminc < faminc_30);
p4 = (faminc ge faminc_30 and faminc < faminc_40);
p5 = (faminc ge faminc_40 and faminc < faminc_50);
p6 = (faminc ge faminc_50 and faminc < faminc_60);
p7 = (faminc ge faminc_60 and faminc < faminc_70);
p8 = (faminc ge faminc_70 and faminc < faminc_80);
p9 = (faminc ge faminc_80 and faminc < faminc_90);
p10 = (faminc ge faminc_90);

q1 = (otherincome < otherincome_20);
q2 = (otherincome ge otherincome_20 and otherincome < otherincome_40);
q3 = (otherincome ge otherincome_40 and otherincome < otherincome_60);
q4 = (otherincome ge otherincome_60 and otherincome < otherincome_80);
q5 = (otherincome ge otherincome_80);

year1968 = (year = 1968); year1969 = (year = 1969); year1970 = (year = 1970); year1971 = (year = 1971); 
year1972 = (year = 1972); year1973 = (year = 1973); year1974 = (year = 1974); year1975 = (year = 1975); 
year1976 = (year = 1976); year1977 = (year = 1977); year1978 = (year = 1978); year1979 = (year = 1979); 
year1980 = (year = 1980); year1981 = (year = 1981); year1982 = (year = 1982); year1983 = (year = 1983); 
year1984 = (year = 1984); year1985 = (year = 1985); year1986 = (year = 1986); 

proc sort data = HomeProd.Baseline;
by married constraint;

proc freq data = HomeProd.Baseline;
tables constraint wifeconstrup;
by married;
weight wgt; run;

proc univariate data = HomeProd.Baseline;
var HWHead HWWife HWHW foodpct;
run;

proc means data = HomeProd.Baseline vardef = weight;
var HWHead HWWife HWHW Headvacationweek foodpct;
by married constraint; 
weight WGT;
run;
run; 
********************************Summary statistics by constraint status************************************;
data v;
set HomeProd.Baseline;
if construp = 1;

proc freq data = v;
tables white belowhighschool highschool abovehighschool married;
weight wgt; 

proc means data = v vardef = weight;
var headage children adults famsize realfaminc realfood reallabor headhour wifehour foodin foodout food foodpct
    HWHead HWWife HWHW headvacationweek wifevacationweek;
weight wgt; run;

data v;
set HomeProd.Baseline;
if constrdown = 1;

proc freq data = v;
tables white belowhighschool highschool abovehighschool married;
weight wgt; 

proc means data = v vardef = weight;
var headage children adults famsize realfaminc realfood reallabor headhour wifehour foodin foodout food foodpct
    HWHead HWWife HWHW headvacationweek wifevacationweek;
weight wgt; run;

data v;
set HomeProd.Baseline;
if construp = 0 and constrdown = 0;

proc freq data = v;
tables white belowhighschool highschool abovehighschool married;
weight wgt; 

proc means data = v vardef = weight;
var headage children adults famsize realfaminc realfood reallabor headhour wifehour foodin foodout food foodpct
    HWHead HWWife HWHW headvacationweek wifevacationweek;
weight wgt; run;

data v;
set HomeProd.Baseline;
if wifeconstrup = 1;

proc freq data = v;
tables white belowhighschool highschool abovehighschool married married * male;
weight wgt; 

proc means data = v vardef = weight;
var headage children adults famsize realfaminc realfood reallabor headhour wifehour foodin foodout food foodpct
    HWHead HWWife HWHW headvacationweek wifevacationweek;
weight wgt; 

proc corr data = HomeProd.Baseline;
var construp wifeconstrup;

data v;
set HomeProd.Baseline;

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

***********************************Preliminary Econometric Analysis******************************************************
*********We conduct a series of OLS analysis using SAS and will do more concrete econometric studies using STATA*********   
*********In addition to the constraint variables, we include family and head and wife (if married) specific     *********
*********demographic variable, head and wife real wages, wife full/part time dummies, income and year dummies   *********
*********We do not include head and wife market work hours because home and market work hours are jointed chosen*********;

proc reg data = HomeProd.Baseline;
model HWHead = construp mup constrdown mdown headage headage2 white female highschool somecollege college married
               age2 age6 age12 age18 adults dis realheadwage 
               p2 - p10 year1969 - year1973 year1975 - year1980 year1982 - year1986; run;


*****************;
data marriedhousework;
set HomeProd.Baseline;
if married = 1;
if year ne 1967 and year ne 1974 and year ne 1975 and year ne 1982;

proc freq data = marriedhousework;
tables construp constrdown year;
run;

proc reg data = marriedhousework;
model HWHead = construp constrdown headage headage2 white highschool somecollege college age2 age6 age12 age18 adults dis
               wifeage wifeage2 wifehighschool wifesomecollege wifecollege wifeparttime wifefulltime 
               realheadwage realwifewage p2 - p10 year1969 - year1973 year1976 - year1981 year1983 - year1986; 

proc reg data = marriedhousework;
model HWWife = construp constrdown headage headage2 white highschool somecollege college age2 age6 age12 age18 adults dis
               wifeage wifeage2 wifehighschool wifesomecollege wifecollege wifeparttime wifefulltime 
               realheadwage realwifewage p2 - p10 year1969 - year1973 year1976 - year1981 year1983 - year1986; 

proc reg data = marriedhousework;
model HWHW =   construp constrdown headage headage2 white highschool somecollege college  age2 age6 age12 age18 adults dis 
               wifeage wifeage2 wifehighschool wifesomecollege wifecollege wifeparttime wifefulltime 
               realheadwage realwifewage p2 - p10 year1969 - year1973 year1976 - year1981 year1983 - year1986; 
run;

data marriedfoodpct;
set HomeProd.Baseline;
if married = 1;
if year ne 1967 and year ne 1968 and year ne 1973;

proc reg data = marriedfoodpct;
model foodpct = construp constrdown headage headage2 white highschool somecollege college age2 age6 age12 age18 adults dis
                wifeage wifeage2 wifehighschool wifesomecollege wifecollege wifeparttime wifefulltime 
                realheadwage realwifewage p2 - p10 year1970 - year1972 year1974 - year1986; 
run;

data marriedvacation;
set HomeProd.Baseline;
if married = 1;

proc reg data = marriedvacation;
model headvacationweek = construp constrdown headage headage2 white highschool somecollege college age2 age6 age12 age18 adults dis
                         wifeage wifeage2 wifehighschool wifesomecollege wifecollege wifeparttime wifefulltime 
                         realheadwage realwifewage p2 - p10 year1968 - year1986; 

data wifevacation;
set HomeProd.Baseline;
if married = 1;
if year ge 1975;

proc reg data = wifevacation;
model wifevacationweek = construp constrdown headage headage2 white highschool somecollege college  age2 age6 age12 age18 adults dis 
                         wifeage wifeage2 wifehighschool wifesomecollege wifecollege wifeparttime wifefulltime 
                         realheadwage realwifewage p2 - p10 year1976 - year1986; 
run;

*********;
data unmarriedhousework;
set HomeProd.Baseline;
if married = 0;
if year ne 1967 and year ne 1974 and year ne 1975 and year ne 1982;

proc freq data = unmarriedhousework;
tables construp constrdown;
run;

proc reg data = unmarriedhousework;
model HWHead = construp constrdown headage headage2 white female highschool somecollege college age2 age6 age12 age18 
               adults dis realheadwage p2 - p10 year1969 - year1973 year1976 - year1981 year1983 - year1986; run;

data unmarriedfoodpct;
set HomeProd.Baseline;
if married = 0;
if year ne 1967 and year ne 1968 and year ne 1973;

proc reg data = unmarriedfoodpct;
model foodpct = construp constrdown headage headage2 white female highschool somecollege college age2 age6 age12 age18 
                adults dis realheadwage p2 - p10 year1970 - year1972 year1974 - year1986; 
run;

data unmarriedvacation;
set HomeProd.Baseline;
if married = 0;

proc reg data = unmarriedvacation;
model headvacationweek = construp constrdown headage headage2 white highschool somecollege college age2 age6 age12 age18 
                         adults dis realheadwage p2 - p10 year1968 - year1986; 
run;

**************************************************************************************************************************;
**************************************************************************************************************************;
**************************************************************************************************************************;

data wifeup;
set HomeProd.Baseline;
if year ge 1970 and year le 1973;
if married = 1;

proc reg data = wifeup;
model HWHead = wifeconstrup headage headage2 white highschool somecollege college children adults 
               wifeage wifeage2 wifehighschool wifesomecollege wifecollege wifeparttime wifefulltime 
               realheadwage realwifewage p2 - p10 year1971 year1972 year1973; 
run;

proc reg data = wifeup;
model HWWife = wifeconstrup headage headage2 white highschool somecollege college children adults 
               wifeage wifeage2 wifehighschool wifesomecollege wifecollege wifeparttime wifefulltime 
               realheadwage realwifewage p2 - p10 year1971 year1972 year1973; 
run;

proc reg data = wifeup;
model HWHW =   wifeconstrup headage headage2 white highschool somecollege college children adults 
               wifeage wifeage2 wifehighschool wifesomecollege wifecollege wifeparttime wifefulltime 
               realheadwage realwifewage p2 - p10 year1971 year1972 year1973; 
run;


data wifeup;
set HomeProd.Baseline;
if year ge 1970 and year le 1975 and year ne 1973;
if married = 1;

proc reg data = wifeup;
model foodpct = wifeconstrup headage headage2 white highschool somecollege college children adults 
                wifeage wifeage2 wifehighschool wifesomecollege wifecollege wifeparttime wifefulltime 
                realheadwage realwifewage p2 - p10 year1971 year1972 year1974 year1975; 
run;

data wifeup;
set HomeProd.Baseline;
if year ge 1970 and year le 1975;
if married = 1;

proc reg data = wifeup;
model headvacationweek = wifeconstrup headage headage2 white highschool somecollege college children adults 
                         wifeage wifeage2 wifehighschool wifesomecollege wifecollege wifeparttime wifefulltime 
                         realheadwage realwifewage p2 - p10 year1971 - year1975; 
run;

*********Linking food-out ratio with housework hours;
proc reg data = HomeProd.Baseline;
model HWHW   =  foodpct headage headage2 white highschool somecollege college children adults 
                married p2 - p10 year1971 year1972 year1974 year1975; run;
