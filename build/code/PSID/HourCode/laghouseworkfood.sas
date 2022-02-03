*********Merge the baseline data with lagged housework hours and food expenditure data                        *********;
%macro LAGHW(year1, year2);
data u;
set homeprod.homeprod&year1.;
HWHeadLag = HWHead;
HWWifeLag = HWWife;
HWHWLag = HWHW;
keep pid HWHeadLag HWHWLag HWWifeLag;

proc sort data = u;
by pid;

proc sort data = homeprod.homeprod&year2.;
by pid;

data laghw&year2.;
merge u(in = in1) homeprod.homeprod&year2.(in = in2);
by pid;
if in1 and in2;
run;
%mend;
%LAGHW(1967, 1968); %LAGHW(1968, 1969); %LAGHW(1969, 1970); %LAGHW(1970, 1971); %LAGHW(1971, 1972); %LAGHW(1972, 1973); 
%LAGHW(1976, 1977); %LAGHW(1977, 1978); %LAGHW(1978, 1979); %LAGHW(1979, 1980); %LAGHW(1980, 1981); %LAGHW(1983, 1984); 
%LAGHW(1984, 1985); %LAGHW(1985, 1986); 

data HomeProd.LAGHW;
set LAGHW1968 LAGHW1969 LAGHW1970 LAGHW1971 LAGHW1972 LAGHW1973 LAGHW1977 LAGHW1978 LAGHW1979 LAGHW1980 LAGHW1981
    LAGHW1984 LAGHW1985 LAGHW1986; 

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
if year ne 1967 and HWHW - HWHead - HWWife > 0 then delete;
if year = 1967 and headmarital ne 1 then do; 
   if HWHW > 3000 then delete; 
   HWHead = HWHW;
   end;

headage2 = headage ** 2 / 100;
highschool = (headedu = 2);
somecollege = (headedu = 3);
college = (headedu = 4);
belowhighschool = (headedu < 3);
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

proc sort data = HomeProd.LAGHW;
by year; 
run;

data HomeProd.LAGHW;
merge HomeProd.LAGHW HomeProd.IncomeDecile HomeProd.OtherIncomeQuintile;
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
run;


%macro LAGFood(year1, year2);
data u;
set homeprod.homeprod&year1.;
FoodinLag = Foodin;
FoodoutLag = Foodout;
keep pid FoodinLag FoodoutLag;

proc sort data = u;
by pid;

proc sort data = homeprod.homeprod&year2.;
by pid;

data lagfood&year2.;
merge u(in = in1) homeprod.homeprod&year2.(in = in2);
by pid;
if in1 and in2;
run;
%mend;
%LAGFood(1969, 1970); %LAGFood(1970, 1971); %LAGFood(1971, 1972); %LAGFood(1974, 1975); %LAGFood(1975, 1976); 
%LAGFood(1976, 1977); %LAGFood(1977, 1978); %LAGFood(1978, 1979); %LAGFood(1979, 1980); %LAGFood(1980, 1981); 
%LAGFood(1981, 1982); %LAGFood(1982, 1983); %LAGFood(1983, 1984); %LAGFood(1984, 1985); %LAGFood(1985, 1986); 

data HomeProd.LAGFood;
set LAGFood1970 LAGFood1971 LAGFood1972 LAGFood1975 LAGFood1976 LAGFood1977 LAGFood1978 LAGFood1979 LAGFood1980 LAGFood1981
    LAGFood1982 LAGFood1983 LAGFood1984 LAGFood1985 LAGFood1986; 

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
if year ne 1967 and HWHW - HWHead - HWWife > 0 then delete;
if year = 1967 and headmarital ne 1 then do; 
   if HWHW > 3000 then delete; 
   HWHead = HWHW;
   end;

headage2 = headage ** 2 / 100;
highschool = (headedu = 2);
somecollege = (headedu = 3);
college = (headedu = 4);
belowhighschool = (headedu < 3);
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

proc sort data = HomeProd.LAGFood;
by year; 
run;

data HomeProd.LAGFood;
merge HomeProd.LAGFood HomeProd.IncomeDecile HomeProd.OtherIncomeQuintile;
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
run;

