*********We predict the desired increase of market work hours of the constrained people using the coefficients of*********
*********a model estimated with unconstrained people.  We observe the unconstrained people hours changes when    *********
*********their preference changes, including number of kids, disability status and spouse work hours             *********;

*********We first construct a vector of number of children in various age categories                             *********;

%macro children(year);
data children&year.;
set HomeProd.ChildAge;
if Rel&year. in(3, 30, 33, 35);
if seqno&year. le 20;
if age&year. ge 1 and age&year. le 18;
if age&year. = 1 or age&year. = 2 then do; agegroup1 = 1; agegroup2 = 0; agegroup3 = 0; agegroup4 = 0; end;
else if age&year. in (3, 4, 5, 6) then do; agegroup1 = 0; agegroup2 = 1; agegroup3 = 0; agegroup4 = 0; end;
else if age&year. in (7,  8,  9,  10, 11, 12) then do; agegroup1 = 0; agegroup2 = 0; agegroup3 = 1; agegroup4 = 0; end;
else if age&year. in (13, 14, 15, 16, 17, 18) then do; agegroup1 = 0; agegroup2 = 0; agegroup3 = 0; agegroup4 = 1; end;
keep id&year. agegroup1 agegroup2 agegroup3 agegroup4;

proc sort data = children&year.;
by id&year.;

proc means data = children&year. noprint;
by id&year.;
var agegroup1 agegroup2 agegroup3 agegroup4;
output out = agegroup&year. sum = age2&year. age6&year. age12&year. age18&year.;

data agegroup&year.;
set agegroup&year.;
keep id&year. age2&year. age6&year. age12&year. age18&year.;

proc sort data = agegroup&year;
by id&year;

data num&year.;
set HomeProd.num;
if id&year. ne .;
keep id&year. num&year.;

proc sort data = num&year.;
by id&year.;

data children&year.;
merge agegroup&year.(in = in1) num&year.(in = in2);
by id&year.;
if num&year. = 0 then do; age2&year. = 0; age6&year. = 0; age12&year. = 0; age18&year. = 0; end;
if num&year. > 0 and (age2&year. = . or age6&year. = . or age12&year. = . or age18&year. = .) then delete;
run;
%mend;
%children(1968)  %children(1969)  %children(1970)  %children(1971)  %children(1972)  %children(1973)  %children(1974)  
%children(1975)  %children(1976)  %children(1977)  %children(1978)  %children(1979)  %children(1980)  %children(1981)  
%children(1982)  %children(1983)  %children(1984)  %children(1985)  %children(1986)  %children(1987)  

*********Second, we construct status and changes of head disability                                             *********;
%macro dis(year);
data dis&year.;
set HomeProd.disable;
if id&year. ne .;
keep id&year. dis&year.;

proc sort data = dis&year.;
by id&year.;
run;
%mend;
%dis(1969) %dis(1970) %dis(1971) %dis(1972) %dis(1973) %dis(1974) %dis(1975) %dis(1976) %dis(1977) %dis(1978) 
%dis(1979) %dis(1980) %dis(1981) %dis(1982) %dis(1983) %dis(1984) %dis(1985) %dis(1986) %dis(1987)

data dis1968;        ******Dis data in 1968 need unique treatment;
set psiddata.fam68;
id1968 = V2;
dis1968 = (V215 = 1);
if dis1968 = 0 then dis1968 = 5;
keep id1968 dis1968;

proc sort data = dis1968;
by id1968; 
run;

*********Third, marital status and pid                                                                          *********;
%macro pid(year1, year2);
data pid&year1.;
set psiddata.person;
%if &year1. = 1968 %then %do; if seqno&year2. = 1 and (rel&year1 = 1 or rel&year1 = 10) and (rel&year2 = 1 or rel&year2 = 10); %end;
%else %do; if seqno&year1 = 1 and seqno&year2 = 1 and (rel&year1 = 1 or rel&year1 = 10) and (rel&year2 = 1 or rel&year2 = 10); %end;
keep id&year1. id&year2. pid; 

proc sort data = pid&year1.;
by id&year1.;

data marital&year1.;
set psiddata.head;
if id&year1. ne .;
keep id&year1. headmarital&year1. famsize&year1.;
run;
%mend; 
%pid(1968, 1969) %pid(1969, 1970) %pid(1970, 1971) %pid(1971, 1972) %pid(1972, 1973) %pid(1973, 1974) %pid(1974, 1975) 
%pid(1975, 1976) %pid(1976, 1977) %pid(1977, 1978) %pid(1978, 1979) %pid(1979, 1980) %pid(1980, 1981) %pid(1981, 1982) 
%pid(1982, 1983) %pid(1983, 1984) %pid(1984, 1985) %pid(1985, 1986) %pid(1986, 1987)

*********Merge                                                                                                  *********;
%macro DH(year1, year2);
data hour&year1.;
set HomeProd.HomeProd&year1.;
keep id&year1. housework&year1. hrshd&year1. hrswf&year1. hourlywage&year1. foodpct&year1. faminc&year1.;

data year1;            
merge children&year1. hour&year1. dis&year1. marital&year1. pid&year1.;
by id&year1.;
if id&year2. ne .;

proc sort data = year1;
by id&year2.;

proc sort data = HomeProd.HomeProd&year2.;
by id&year2.;

data DH&year2;
merge year1(in = in1) children&year2.(in = in2) dis&year2.(in = in3) HomeProd.HomeProd&year2.(in = in4) marital&year2.;
by id&year2.;
if in1 and in2 and in3 and in4;


%if &year1 le 1972 %then %do; 
    housework1 = housework&year1.;  housework2 = housework&year2.;  
    DHousework = housework&year2. - housework&year1.; 
    %end;
%else %do;
    housework1 = .; housework2 = .; 
    DHousework = .; 
    %end;

%if &year1 > 1968 %then %do; 
    foodpct1 = foodpct&year1.;  foodpct2 = foodpct&year2.;  DFoodpct = foodpct&year2. - foodpct&year1.; 
    %end;
%else %do; foodpct1 = .; foodpct2 = foodpct&year2.; DFoodpct = .; %end;

headhour1 = hrshd&year1.; headhour2 = hrshd&year2.;
wifehour1 = hrswf&year1.; wifehour2 = hrswf&year2.;
DHeadhour = hrshd&year2. - hrshd&year1.;
DWifehour = hrswf&year2. - hrswf&year1.;

if hourlywage&year1. > 0 then wage1 = log(hourlywage&year1.);
else wage1 = .;

if hourlywage&year2. > 0 then wage2 = log(hourlywage&year2.);
else wage2 = .;

if hourlywage&year2. > 0 and hourlywage&year1. > 0 then DWage = (log(hourlywage&year2.) - log(hourlywage&year1.));
else DWage = .;

year = &year2.;
construp = construp&year2.;
constrdown = constrdown&year2.;
Age2 = Age2&year2;
Age6 = Age6&year2;
Age12 = Age12&year2;
Age18 = Age18&year2;
AgeAll = Age2 + Age6 + Age12 + Age18;
Children = Num&year2.;
Adult = famsize&year2. - Children;
Disability = dis&year2.;
headage = agehd&year2.;
headage2 = headage ** 2 / 100;
highschool = (educationhd&year2. = 4 or educationhd&year2. = 5);
somecollege = (educationhd&year2. = 6);
college = (educationhd&year2. = 7 or educationhd&year2. = 8);
marital = headmarital&year2.;
white = (racehd&year2. = 1);
faminc = faminc&year2.;
food = foodin&year2. + foodout&year2.;

DAge2 = (age2&year2. - age2&year1.);
DAge6 = (age6&year2. - age6&year1.);
DAge12 = (age12&year2. - age12&year1.);
DAge18 = (age18&year2. - age18&year1.);
DAgeAll = DAge2 + DAge6 + DAge12 + DAge18;
DChildren = (Num&year2. - Num&year1.);
DAdult = (famsize&year2. - famsize&year1.) - (Num&year2. - Num&year1.);
DIncome = log(faminc&year2.) - log(faminc&year1.);
Marry  = (headmarital&year1. ne 1 and headmarital&year2. = 1);
Divorce = (headmarital&year1. = 1 and headmarital&year2. ne 1);
Positive = (dis&year2. = 5 and dis&year1. = 1);
Negative = (dis&year2. = 1 and dis&year1. = 5);
 
keep pid year construp constrdown headage headage2 highschool somecollege college white 
     Age2  Age6  Age12  Age18  AgeAll  Children  Adult  marital       Disability 
     DAge2 DAge6 DAge12 DAge18 DAgeAll DChildren DAdult Marry Divorce Positive Negative 
     housework1 housework2 foodpct1 foodpct2 headhour1 headhour2 wifehour1 wifehour2 wage1 wage2 faminc food 
     DHousework            DFoodpct          DHeadhour           DWifehour           DWage       DIncome;
run;

proc means data = DH&year2;
var DHousework DFoodpct DHeadhour DWifehour DWage DIncome headage;

proc freq data = DH&year2;
tables year construp constrdown highschool somecollege college white 
       Age2  Age6  Age12  Age18  AgeAll  Children  Adult  marital       Disability 
       DAge2 DAge6 DAge12 DAge18 DAgeAll DChildren DAdult Marry Divorce Positive Negative;
run;
%mend;
%DH(1968, 1969) %DH(1969, 1970) %DH(1970, 1971) %DH(1971, 1972) %DH(1972, 1973) %DH(1973, 1974) %DH(1974, 1975) 
%DH(1975, 1976) %DH(1976, 1977) %DH(1977, 1978) %DH(1978, 1979) %DH(1979, 1980) %DH(1980, 1981) %DH(1981, 1982) 
%DH(1982, 1983) %DH(1983, 1984) %DH(1984, 1985) %DH(1985, 1986) 

data DH;
set DH1969 DH1970 DH1971 DH1972 DH1973 DH1974 DH1975 DH1976 DH1977 DH1978 DH1979 DH1980 DH1981 DH1982 DH1983 DH1984 DH1985 DH1986 ;

proc sort data = DH;
by year;

data HomeProd.DH;
merge DH(in = in1) HomeProd.IncomeDecile(in = in2);
by year;
if in1 and in2;
******Some sample selection procedures on age, food expenditure, income, market and house work hours and wage changes;
if construp ne .;
if headage ge 25 and headage < 66; 
if abs(DChildren) le 3;
if abs(DAdult) le 3;
if year = 1973 or (food > 100 and food < 10000); 
if faminc > 1200 and faminc < 100000;
if DIncome > -1.5 and DIncome < 1.5; 
if headhour1 < 3000 and headhour2 < 3000; 
if wifehour1 < 3000 and wifehour2 < 3000;
if headhour1 > 500 and headhour2 > 500; 
if wage1 > 0 and wage2 > 0;
if DWage < 0.75 and DWage > -0.62;
if abs(DHeadhour) < 2000; 
if abs(DWifehour) < 2000; 
if (Housework1 > 0 and Housework1 < 3200) or Housework1 = .;
if (Housework2 > 0 and Housework2 < 3200) or Housework2 = .;

HeadhourP = Headhour2;    DHeadhourP = DHeadhour; 
FoodpctP = Foodpct2; 
HouseworkP = Housework2;  DHouseworkP = DHousework; 
if construp = 1 or constrdown = 1 then do; HeadhourP = .; FoodpctP = .; DHeadhourP = .; HouseworkP = .; end;
if construp = 1 then constraint = 1;
else if constrdown = 1 then constraint = 2;
else constraint = 0;

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

year1969 = (year = 1969); year1970 = (year = 1970); year1971 = (year = 1971); year1972 = (year = 1972); 
year1973 = (year = 1973); year1974 = (year = 1974); year1975 = (year = 1975); year1976 = (year = 1976); 
year1977 = (year = 1977); year1978 = (year = 1978); year1979 = (year = 1979); year1980 = (year = 1980); 
year1981 = (year = 1981); year1982 = (year = 1982); year1983 = (year = 1983); year1984 = (year = 1984); 
year1985 = (year = 1985); year1986 = (year = 1986); 
run;

proc sort data = HomeProd.DH;
by constraint;

proc univariate data = HomeProd.DH;
var Headhour2 DHousework DFoodpct DHeadhour DWifehour DWage;
run;

proc freq data = HomeProd.DH;
tables year construp highschool somecollege college white 
       Age2  Age6  Age12  Age18  AgeAll  Children  Adult  marital       Disability 
       DAge2 DAge6 DAge12 DAge18 DAgeAll DChildren DAdult Marry Divorce Positive Negative;
run;
run;

*********Hour levels regressions *********;
proc reg data = HomeProd.DH;
model HeadHourP = Headhour1 Wifehour1 Wifehour2 wage2 Age2 Age6 Age12 Age18 Adult marital Disability
                  headage headage2 white highschool somecollege college year1970 - year1986;
output out = HourhatP p = predict;

data HourgapP;
set HourhatP;
if constraint > 0 then Net = Headhour2 - predict;
else Net = 0;
if year le 1973;

*********Housework Hours;
data HouseworkP;
set HourGapP;
if constraint > 0 then HeadHour2 = predict;
if year le 1973;

proc reg data = HouseworkP;
model HouseworkP = Housework1 Headhour2 Wifehour2 wage2 Age2 Age6 Age12 Age18 Adult marital Disability
                   headage headage2 white highschool somecollege college p2 - p10 year1970 - year1973;
output out = Houseworkhat p = PredictHousework;
run;

data Houseworkhat;
set Houseworkhat;
if constraint > 0;
HouseworkNet = Housework2 - PredictHousework;
 
proc univariate data = Houseworkhat;
var Net HouseworkNet;
by constraint; 
run;

*********Foodout Ratio;
data FoodpctP;
set HourhatP;
if constraint > 0 then Net = Headhour2 - predict;
else Net = 0;
if constraint > 0 then HeadHour2 = predict;
if year ge 1970;

proc reg data = FoodpctP;
model FoodpctP = foodpct1 Headhour2 Wifehour2 wage2 Age2 Age6 Age12 Age18 Adult marital Disability
                 headage headage2 white highschool somecollege college p2 - p10 year1971 - year1973;
output out = foodpcthat p = Predictfoodpct;
run;

data foodpcthat;
set foodpcthat;
if constraint > 0;
foodpctNet = foodpct2 - Predictfoodpct;
 
proc univariate data = foodpcthat;
var Net foodpctNet; 
by constraint; 

proc corr data = foodpcthat;
var Net foodpctNet; 
by constraint;  run;
