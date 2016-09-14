*********Merge constraints, housework, demography, income and labor data together                              *********
*********In constraints and housework data the variable indices point to the reference year, while in other    *********
*********data, some indices point to survey year. We make all variable indexes point to the reference year     *********;

*before running this program, also run wantable, food, and housework. Also, should run empbus.sas rather than labor.sas;
libname psiddata '/href/scratch3/m1bam03/PSID/data/';
libname HomeProd '/href/scratch3/m1bam03/PSID/data/homeprod/';
libname temp '../../temp/';
libname out '../../output/';

options nomprint;

%macro var(year);
data income&year.;
set psiddata.income;
if id&year. ne .;
keep id&year. faminc&year. headlabor&year. wifelabor&year.;

data hour&year.;
set psiddata.labor;
if id&year. ne .;
keep id&year. headhour&year. wifehour&year. headextra&year. wifeextra&year. headsalaried&year. wifesalaried&year.;

data head&year.;
set psiddata.head;
if id&year. ne .;
keep id&year. headage&year. WGT&year. headedu&year. headrace&year. headstatus&year. selfemploy&year. 
     famsize&year. headocc&year.  headind&year.;

data marital&year.;
set psiddata.head;
if id&year. ne .;
keep id&year. headmarital&year.;

data wife&year.;
set psiddata.wife;
if id&year. ne .;
keep id&year. wifeage&year. wifeedu&year. wifeocc&year.  wifeind&year.;

data gender&year.;
set psiddata.headgender;
if id&year. ne .;
keep id&year. gender&year.;
run;

data housing&year.;
	set HomeProd.housing;
	if id&year. ne .;
	keep id&year. homeown&year.;
run;

data tenure&year.;
	set HomeProd.tenure;
	if id&year ne .;
	%if &year.=1968 %then tenure1968=.;
	;
	%if &year.<1970 %then mainwage&year=.;
	;
	keep id&year. tenure&year. secjob&year. mainwage&year sameemp_mths&year;
run;
%mend;
%var(1968) %var(1969) 
%var(1970) %var(1971) %var(1972) %var(1973) %var(1974) %var(1975) %var(1976) %var(1977) %var(1978) %var(1979) 
%var(1980) %var(1981) %var(1982) %var(1983) %var(1984) %var(1985) %var(1986) %var(1987)  

*********Data that are created not from regular datasets in PSIDDATA library;
%macro children(year);
data children&year.;
set HomeProd.ChildAge;
if Rel&year. in(3, 30, 33, 35, 37, 38);
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
run;
%mend;
%children(1968)  %children(1969)  %children(1970)  %children(1971)  %children(1972)  %children(1973)  %children(1974)  
%children(1975)  %children(1976)  %children(1977)  %children(1978)  %children(1979)  %children(1980)  %children(1981)  
%children(1982)  %children(1983)  %children(1984)  %children(1985)  %children(1986)  %children(1987)  

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
id1968 = V3;
dis1968 = (V215 = 1);
if dis1968 = 0 then dis1968 = 5;
keep id1968 dis1968;

proc sort data = dis1968;
by id1968; 
run;

*********1967 is not merged using the macro;
data pid;
set psiddata.person;
if id1968 ne . and rel1968 = 1; 
keep id1968 pid;

proc sort data = pid;
by id1968;

data homeprod1967;  ******1967 data will not be used for change-over-change analysis;
merge head1968 marital1968 wife1968 gender1968 temp.wantable1968 dis1968 temp.housework1968 income1968 hour1968 children1968 pid;
by id1968; run;

%macro m(year1, year2, year3);
proc sort data = head&year1.;
by id&year1.;

proc sort data = marital&year1.;
by id&year1.;

proc sort data = wife&year1.;
by id&year1.;

proc sort data = children&year1.;
by id&year1.;

proc sort data = temp.food&year1.;
by id&year1.;

proc sort data = dis&year1.;
by id&year1.;

proc sort data = gender&year1.;
by id&year1.;

proc sort data = temp.housework&year1.;
by id&year1.;

proc sort data = hour&year1.;
by id&year1.;

proc sort data=housing&year1.;
by id&year1.;

proc sort data = marital&year2.;
by id&year2.;

%if &year1.>1968 %then %do;
	proc sort data=tenure&year1.;
	by id&year1.;
%end;

%if &year1. < 1986 %then %do;
proc sort data = temp.housework&year2.;
by id&year2.;
%end;

proc sort data = hour&year2.;
by id&year2.;

proc sort data = temp.wantable&year2.;
by id&year2.;

proc sort data = income&year2.;
by id&year2.;

data pid;
set PSIDDATA.person;
%if &year1 = 1968 %then %do; if seqno&year2. = 1 and (rel&year1. = 1 or rel&year1. = 10) and (rel&year2. = 1 or rel&year2. = 10); %end;
%else %do; if seqno&year1. = 1 and seqno&year2. = 1 and (rel&year1. = 1 or rel&year1. = 10) and (rel&year2. = 1 or rel&year2. = 10); %end;
keep pid id&year1. id&year2.;

proc sort data = pid;
by id&year1.;

%if &year1. le 1973 %then %do;
    data hp&year1.;
    merge head&year1.(in = in1) marital&year1. wife&year1. gender&year1. temp.food&year1. children&year1. 
          hour&year1. dis&year1. housing&year1. tenure&year1. pid(in = in2);
    by id&year1.;
    if in1 and in2;

    proc sort data = hp&year1.;
    by id&year2;

    data homeprod&year1.;
    merge hp&year1.(in = in1) marital&year2. temp.wantable&year2. temp.housework&year2.(in = in2) hour&year2. income&year2.(in = in3);
    by id&year2.;
    if in1 and in2 and in3;
	%end;

%else %if &year1. = 1974 %then %do;
    data hp&year1.;
    merge head&year1.(in = in1) marital&year1. wife&year1. gender&year1. temp.food&year1. children&year1. 
          temp.housework&year1. hour&year1. dis&year1. housing&year1. tenure&year1. pid(in = in2);
    by id&year1.;
    if in1 and in2;

    proc sort data = hp&year1.;
    by id&year2;

    data homeprod&year1.;
    merge hp&year1.(in = in1) marital&year2. temp.wantable&year2. hour&year2. income&year2.(in = in2);
    by id&year2.;
    if in1 and in2;
	%end;

%else %do;
    data hp&year1.;
    merge head&year1.(in = in1) marital&year1. wife&year1. gender&year1. temp.food&year1. children&year1. 
          temp.housework&year1. hour&year1. dis&year1. housing&year1. tenure&year1. pid(in = in2);
    by id&year1.;
    if in1 and in2;

    proc sort data = hp&year1.;
    by id&year2;

    data homeprod&year1.;
    merge hp&year1.(in = in1) marital&year2. temp.wantable&year2. hour&year2. income&year2.(in = in2);
    by id&year2.;
    if in1 and in2;
	%end;
run;
%mend;
%m(1968, 1969); %m(1969, 1970); %m(1970, 1971); %m(1971, 1972); %m(1972, 1973); %m(1973, 1974); 
%m(1974, 1975); %m(1975, 1976); %m(1976, 1977); %m(1977, 1978); %m(1978, 1979); %m(1979, 1980);
%m(1980, 1981); %m(1981, 1982); %m(1982, 1983); %m(1983, 1984); %m(1984, 1985); %m(1985, 1986); 
%m(1986, 1987);

%macro variable(year1, year2);
data HomeProd.homeprod&year1.;
set homeprod&year1.;

construp      = construp&year1.;
wifeconstrup  = wifeconstrup&year1.;
constrdown    = constrdown&year1.;
marwage       = marwage&year1.;

%if &year1. ge 1968 %then %do;
gender        = gender&year1.;
headage       = headage&year1.;
headmarital   = headmarital&year1.;
headedu       = headedu&year1.;
headrace      = headrace&year1.; 
headstatus    = headstatus&year1.;
dis           = dis&year1.;
selfemploy    = selfemploy&year1.; 
famsize       = famsize&year1.;
children      = num&year1.;
age2          = age2&year1.;
age6          = age6&year1.;
age12         = age12&year1.;
age18         = age18&year1.;
headocc       = headocc&year1.;
headind       = headind&year1.;
wifeage       = wifeage&year1.;
wifeedu       = wifeedu&year1.;
wifeocc       = wifeocc&year1.;
wifeind       = wifeind&year1.;
WGT           = WGT&year1.;
homeown		  = homeown&year1.;
tenure		  = tenure&year1.;
secjob    	  = secjob&year1.;
mainwage	  = mainwage&year1.;
sameemp_mths  = sameemp_mths&year1.;
%end;
%else %do;
gender        = gender&year2.;
headage       = headage&year2.;
headmarital   = headmarital&year2.;
headedu       = headedu&year2.;
headrace      = headrace&year2.; 
headstatus    = headstatus&year2.;
dis           = dis&year2.;
selfemploy    = selfemploy&year2.; 
famsize       = famsize&year2.;
children      = num&year2.;
age2          = age2&year2.;
age6          = age6&year2.;
age12         = age12&year2.;
age18         = age18&year2.;
headocc       = headocc&year2.;
headind       = headind&year2.;
wifeage       = wifeage&year2.;
wifeedu       = wifeedu&year2.;
wifeocc       = wifeocc&year2.;
wifeind       = wifeind&year2.;
WGT           = WGT&year2.;
secjob    	  = secjob&year1.;
%end;

foodin        = foodin&year1.;
foodout       = foodout&year1.;
HWHW          = HWHW&year1.;
HWHead        = HWHead&year1.;
HWWife        = HWWife&year1.;
HWHeadWeekly  = HWHeadWeekly&year1.;
HWWifeWeekly  = HWWifeWeekly&year1.;
HomeProd      = HomeProd&year1.;
Repair        = Repair&year1.;
HeadTakeVacation  = Vacation&year1.;
HeadVacationWeek  = VacationWks&year1.;
if HeadVacationWeek = 0 then HeadVacationWeek=.;
WifeTakeVacation  = WifeVacation&year1.;
WifeVacationWeek  = WifeVacationWks&year1.;
if WifeVacationWeek = 0 then WifeVacationWeek=.;

leadmarital   = headmarital&year2.;
faminc        = faminc&year2.;
headlabor     = headlabor&year2.;
wifelabor     = wifelabor&year2.;
headhour      = headhour&year2.;
wifehour      = wifehour&year2.;
headextra     = headextra&year2.; 
wifeextra     = wifeextra&year2.; 
headsalaried  = headsalaried&year2.; 
wifesalaried  = wifesalaried&year2.;

lagheadhour   = headhour&year1.;
lagwifehour   = wifehour&year1.;

year = &year1.;

*bottom coding;
if faminc<1 then faminc = 1;


/*get lagged variables*
%let year0 = %eval(&year1-1);
%let year_1 = %eval(&year1-2);
%let year_2 = %eval(&year1-3);
construp_lag1 = construp&year0.;
constrdown_lag1 = constrdown&year0.;
wifeconstrup_lag1  = wifeconstrup&year0.;

faminc_lag1 = faminc&*/


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

keep pid year WGT construp constrdown wifeconstrup homeprod repair marwage leadmarital wifeage wifeedu wifeocc wifeind dis 
     gender headage headmarital headedu headrace headstatus selfemploy age2 age6 age12 age18 children famsize headocc 
     headind foodin foodout HWHW HWHead HWWife HWHeadWeekly HWWifeWeekly HeadTakeVacation HeadVacationWeek WifeTakeVacation 
     WifeVacationWeek faminc headlabor wifelabor headhour wifehour lagheadhour lagwifehour headextra wifeextra headsalaried wifesalaried 
	 food laborInc estHW totHW homeown tenure secjob mainwage sameemp_mths;  
run;
%mend;
%variable(1967, 1968); %variable(1968, 1969); %variable(1969, 1970); %variable(1970, 1971);
%variable(1971, 1972); %variable(1972, 1973); %variable(1973, 1974); %variable(1974, 1975);
%variable(1975, 1976); %variable(1976, 1977); %variable(1977, 1978); %variable(1978, 1979);
%variable(1979, 1980); %variable(1980, 1981); %variable(1981, 1982); %variable(1982, 1983);
%variable(1983, 1984); %variable(1984, 1985); %variable(1985, 1986); %variable(1986, 1987);

*********Pooling home production data from 1967 to 1986, variable availabilities vary across years            *********;

data HomeProd.pooled;
set HomeProd.HomeProd1967 HomeProd.HomeProd1968 HomeProd.HomeProd1969 HomeProd.HomeProd1970 HomeProd.HomeProd1971           
    HomeProd.HomeProd1972 HomeProd.HomeProd1973 HomeProd.HomeProd1974 HomeProd.HomeProd1975 HomeProd.HomeProd1976 
    HomeProd.HomeProd1977 HomeProd.HomeProd1978 HomeProd.HomeProd1979 HomeProd.HomeProd1980 HomeProd.HomeProd1981 
    HomeProd.HomeProd1982 HomeProd.HomeProd1983 HomeProd.HomeProd1984 HomeProd.HomeProd1985 HomeProd.HomeProd1986;
run; 

proc import datafile="/href/research3/m1bam03/homeProdHourConstraints/build/input/cpi.csv"
			out=cpi
			dbms=csv
			replace;
	GETNAMES=YES;
run;
proc sort data=cpi; by year; run;
proc sort data=HomeProd.pooled; by year; run;
/*recode some variables*/
data out.pooled;
	merge HomeProd.pooled cpi;
	by year;
	*set Head and Wife take vacation variable to a dummy;
	if HeadTakeVacation in (0,9) then HeadTakeVacation=.;
	else if HeadTakeVacation = 5 then HeadTakeVacation=0;
	if WifeTakeVacation in (0,9) then WifeTakeVacation=.;
	else if WifeTakeVacation = 5 then WifeTakeVacation=0;
	*make dummies for white/black;
	headwhite = 0;
	if headrace = 1 then headwhite=1;
	headblack = 0;
	if headrace = 2 then headblack=1;
	*dummy for disabled limiting the amount of housework one can do;
	disLimitHswrk = 0;
	if dis in (1,3) then disLimitHswrk = 1;
	else if dis = 9 then disLimitHswrk =.;
	*dummy for self-employment status -- if partially or totally self employed, set to one. For NA/DK, set to missing;
	*here I leave 0, "Inap.: not working for money now" as a 0;
	selfEmployed = 0;
	if selfemploy in (2,3) then selfEmployed=1;
	else if selfemploy in (0,9) then selfEmployed = .;
	*recode marital statuses: if married or separted, count as married. Single, widowed, or divorced, count as not married;
	headmarried = 0;
	if headmarital in (1,5) then headmarried = 1;
	leadmarried = 0;
	if leadmarital in (1,5) then leadmarried = 1;
	*recode whether one is salaried or hourly. Coding irregularities before and after 1976;
	if year<1975 AND headextra^=0 then headsalary = (headsalaried=5 & headextra=5);
	if year<1975 AND headextra^=0 then headhourly = ((headsalaried=1 & headextra=5) OR
	   	     	 	      	   	         (headsalaried=0 & headextra=1));
	if year>=1975 AND headsalaried^=0 then headsalary = (headsalaried=1 AND headextra!=1);
	if year>=1975 AND headsalaried^=0 then headhourly = (headsalaried=3 OR 
	   	      	  		       		    (headsalaried=1 & headextra=1));
	if headmarried=1 & wifesalaried^=0 then wifesalary = (wifesalaried=1);
	if headmarried=1 & wifesalaried^=0 then wifehourly = (wifesalaried=3 & wifeextra=1);
	*recode whether one receives extra income from working more hours than usual in a week;
	if headsalary=1 then headext = (headextra=1);
	if headmarried=1 & wifesalary=1 then wifeext = (wifeextra=1);
	*homeowner dummy;
	homeowner = (homeown=1);
	*make tenure variable consistent;
	if year<1976 then jobchglastyr = (tenure=1);
	else if year>=1976 then jobchglastyr = (tenure<12 & tenure^=.);
	if year>=1976 & tenure^=. then do;
		if tenure=99 & year=1976 then tenure=9;
		else if tenure>0 & tenure<12 then tenure=1;
		else if tenure>=12 & tenure<=19 then tenure=2;
		else if tenure>19 & tenure<=42 then tenure=3;
		else if tenure>42 & tenure<=114 then tenure=4;
		else if tenure>114 & tenure<=234 then tenure=5;
		else if tenure>234 & tenure<999 then tenure=6;
		else if tenure=999 then tenure=9;
	end;
	*make second job variable consistent;
	if year=1968 & jobchglastyr = 3 then jobchglastyr=1;

	*main wage variable adjustments;
	if year<1978 & mainwage in (9.99,0) then mainwage=.;
	else if year>=1978 & mainwage in (99.99,0) then mainwage=.;

	*adjust same employer, #months;
	if sameemp_mths=999 then sameemp_mths=.;

	/*adjust income for inflation*/
	lnheadlabor = log(headlabor*cpi);
	lnwifelabor = log(wifelabor*cpi);
	lnfaminc = log(faminc*cpi);
run;
