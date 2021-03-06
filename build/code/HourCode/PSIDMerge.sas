*********Merge constraints, housework, demography, income and labor data together                              *********
*********In constraints and housework data the variable indices point to the reference year, while in other    *********
*********data, some indices point to survey year. We make all variable indexes point to the reference year     *********;

*before running this program, also run wantable, food, and housework. Also, should run empbus.sas rather than labor.sas;
%include 'setlibraries_psid.sas';
options mprint;

%macro var(year);
data income&year.;
set temp.income;
if id&year. ne .;
keep id&year. faminc&year. headlabor&year. wifelabor&year.;

data hour&year.;
set temp.labor;
if id&year. ne .;
keep id&year. headhour&year. wifehour&year. headextra&year. wifeextra&year. headsalaried&year. wifesalaried&year.;

data head&year.;
set temp.head;
if id&year. ne .;
keep id&year. headage&year. WGT&year. headedu&year. headrace&year. headstatus&year. selfemploy&year. 
     famsize&year. headocc&year.  headind&year.;

data marital&year.;
set temp.head;
if id&year. ne .;
keep id&year. headmarital&year.;

data wife&year.;
set temp.wife;
if id&year. ne .;
keep id&year. wifeage&year. wifeedu&year. wifeocc&year.  wifeind&year.;

data gender&year.;
set temp.headgender;
if id&year. ne .;
keep id&year. gender&year.;
run;

data housing&year.;
	set temp.housing;
	if id&year. ne .;
	keep id&year. homeown&year.;
run;

data tenure&year.;
	set temp.tenure;
	if id&year ne .;
	*for questions not asked in given years, fill in values as missing;
	%if &year.=1968 %then %do;
		tenure1968=.;
		relocated1968=.;
	%end;
	%if &year.=1973 %then union&year.=.;
	;
	%if &year.>1981 %then union&year.=.;
	;
	keep id&year. tenure&year. sameemp_mths&year. union&year. relocated&year. ;
run;

data tenure_retro&year.;
	set temp.tenure;
	if id&year ne .;
	*for questions not asked in given years, fill in values as missing;
	%if &year.<1970 %then mainwage&year.=.;
	;
	keep id&year. secjob&year. mainwage&year. num_addljobs&year.;
run;
%mend;
%var(1968) %var(1969) 
%var(1970) %var(1971) %var(1972) %var(1973) %var(1974) %var(1975) %var(1976) %var(1977) %var(1978) %var(1979) 
%var(1980) %var(1981) %var(1982) %var(1983) %var(1984) %var(1985) %var(1986) %var(1987)  

*********Data that are created not from regular datasets in PSIDDATA library;
%macro children(year);
data children&year.;
set temp.ChildAge;
if Rel&year. in(3, 30, 33, 35, 37, 38); *keep biological, step-, and foster children;
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
set temp.Children;
if id&year. ne .;
keep id&year. number&year.;

proc sort data = num&year.;
by id&year.;

data children&year.;
merge agegroup&year.(in = in1) num&year.(in = in2);
by id&year.;
if number&year. = 0 then do; age2&year. = 0; age6&year. = 0; age12&year. = 0; age18&year. = 0; end;
run;
%mend;
%children(1968)  %children(1969)  %children(1970)  %children(1971)  %children(1972)  %children(1973)  %children(1974)  
%children(1975)  %children(1976)  %children(1977)  %children(1978)  %children(1979)  %children(1980)  %children(1981)  
%children(1982)  %children(1983)  %children(1984)  %children(1985)  %children(1986)  %children(1987)  

%macro dis(year);
data dis&year.;
set temp.disable;
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
set temp.person;
if id1968 ne . and rel1968 = 1; 
keep id1968 pid;

proc sort data = pid;
by id1968;

data homeprod1967;  ******1967 data will not be used for change-over-change analysis;
merge head1968 marital1968 wife1968 gender1968 temp.wantable1968 dis1968 temp.housework1968 
	income1968 hour1968 children1968 pid tenure_retro1968;
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

%if &year1.>1968 %then %do;
	proc sort data=tenure&year1.;
	by id&year1.;
%end;

proc sort data=tenure_retro&year1.;
by id&year1.;

proc sort data = marital&year2.;
by id&year2.;

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
set temp.person;
%if &year1 = 1968 %then %do; if seqno&year2. = 1 and (rel&year1. = 1 or rel&year1. = 10) and (rel&year2. = 1 or rel&year2. = 10); %end;
%else %do; if seqno&year1. = 1 and seqno&year2. = 1 and (rel&year1. = 1 or rel&year1. = 10) and (rel&year2. = 1 or rel&year2. = 10); %end;
keep pid id&year1. id&year2.;

proc sort data = pid;
by id&year1.;

%if &year1. le 1973 %then %do;
    data hp&year1.;
    merge head&year1.(in = in1) marital&year1. wife&year1. gender&year1.  children&year1. 
          hour&year1. dis&year1. housing&year1. tenure&year1. pid(in = in2);
    by id&year1.;
    if in1 and in2;

    proc sort data = hp&year1.;
    by id&year2;

	*merge with retrospective variables;
    data homeprod&year1.;
    merge hp&year1.(in = in1) marital&year2. temp.wantable&year2. temp.housework&year2.(in = in2) 
			hour&year2. income&year2.(in = in3) temp.food&year2. tenure_retro&year2.;
    by id&year2.;
    if in1 and in2 and in3;
	%end;

%else %if &year1. = 1974 %then %do;
    data hp&year1.;
    merge head&year1.(in = in1) marital&year1. wife&year1. gender&year1.  children&year1. 
          temp.housework&year1. hour&year1. dis&year1. housing&year1. tenure&year1. pid(in = in2);
    by id&year1.;
    if in1 and in2;

    proc sort data = hp&year1.;
    by id&year2;

    data homeprod&year1.;
    merge hp&year1.(in = in1) marital&year2. temp.wantable&year2. hour&year2. income&year2.(in = in2)
			tenure_retro&year2. temp.food&year2.;
    by id&year2.;
    if in1 and in2;
	%end;

%else %do;
    data hp&year1.;
    merge head&year1.(in = in1) marital&year1. wife&year1. gender&year1.  children&year1. 
          temp.housework&year1. hour&year1. dis&year1. housing&year1. tenure&year1. pid(in = in2);
    by id&year1.;
    if in1 and in2;

    proc sort data = hp&year1.;
    by id&year2;

    data homeprod&year1.;
    merge hp&year1.(in = in1) marital&year2. temp.wantable&year2. hour&year2. income&year2.(in = in2)
			tenure_retro&year2. temp.food&year2.;
    by id&year2.;
    if in1 and in2;
	%end;
run;
%mend;
%m(1968, 1969); %m(1969, 1970); %m(1970, 1971); %m(1971, 1972); %m(1972, 1973); %m(1973, 1974); 
%m(1974, 1975); %m(1975, 1976); %m(1976, 1977); %m(1977, 1978); %m(1978, 1979); %m(1979, 1980);
%m(1980, 1981); %m(1981, 1982); %m(1982, 1983); %m(1983, 1984); %m(1984, 1985); %m(1985, 1986); 
%m(1986, 1987);

/*some variables refer to the survey year (t), e.g. demographics, while others, e.g. wages, refer to 
 the previous year. This macro aligns each observation to refer to the correct year.;
%macro yearalignment(tminus1,t);
data temp.homeprod&tminus1.;
set homeprod&tminus1.;

construp      = construp&tminus1.;
wifeconstrup  = wifeconstrup&tminus1.;
constrdown    = constrdown&tminus1.;
marwage       = marwage&tminus1.;

gender        = gender&tminus1.;
headage       = headage&tminus1.;
headmarital   = headmarital&tminus1.;
headedu       = headedu&tminus1.;
headrace      = headrace&tminus1.; 
headstatus    = headstatus&tminus1.;
dis           = dis&tminus1.;
selfemploy    = selfemploy&tminus1.; 
famsize       = famsize&tminus1.;
children      = number&tminus1.;
age2          = age2&tminus1.;
age6          = age6&tminus1.;
age12         = age12&tminus1.;
age18         = age18&tminus1.;
headocc       = headocc&tminus1.;
headind       = headind&minus1t.;
wifeage       = wifeage&tminus1.;
wifeedu       = wifeedu&tminus1.;
wifeocc       = wifeocc&tminus1.;
wifeind       = wifeind&tminus1.;
WGT           = WGT&tminus1.;
homeown		  = homeown&tminus1.;
tenure		  = tenure&tminus1.;
*already moved second job variable back a year in tenure.sas;
secjob    	  = secjob&tminus1.;
mainwage	  = mainwage&tminus1.;
sameemp_mths  = sameemp_mths&tminus1.;

*No interview in 1967, but can impute time-invariant characteristics from 1968 data.;
%if &tminus1.=1967 %then %do;
gender        = gender&t.;
headage       = headage&t.-1;
headrace      = headrace&t.;
%end;

year = &tminus1.;

%mend;
*/




/*Adjust timing of variables to be consistent, since some in PSID refer to survey year while others
refer to year before survey.*/
%macro variable(year1, year2);
data temp.homeprod&year1.;
set homeprod&year1.;

construp      = construp&year1.;
wifeconstrup  = wifeconstrup&year1.;
constrdown    = constrdown&year1.;
marwage       = marwage&year1.;

gender        = gender&year1.;
headage       = headage&year1.;
headmarital   = headmarital&year1.;
headedu       = headedu&year1.;
headrace      = headrace&year1.; 
headstatus    = headstatus&year1.;
dis           = dis&year1.;
selfemploy    = selfemploy&year1.; 
famsize       = famsize&year1.;
children      = number&year1.;
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
secjob    	  = secjob&year2.; *changed in tenure.sas to be contemporaneous;
mainwage	  = mainwage&year2.; *changed in tenure.sas to be contemporaneous;
sameemp_mths  = sameemp_mths&year1.;
union		  = union&year1.;
relocated	  = relocated&year1.;
num_addljobs  = num_addljobs&year2.; *changed in tenure.sas to be contemporaneous;

foodin        = Foodin&year2.;
foodout       = Foodout&year2.;
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

faminc        = faminc&year2.;
headlabor     = HeadLabor&year2.;
wifelabor     = WifeLabor&year2.;
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


/*
if headage ge 22 and headage < 68;   ******Head age restriction;
*if wifeage ge 66 then delete;
*if headstatus in (1, 2, 3);          *****Head is working, unemployed or temporarily laid off;
if year = 1967 or year = 1968 or year = 1973 or (foodin + foodout > 100 and foodin + foodout < 10000);  ******Food expenditure restriction;
if faminc > 1200 and faminc < 1000000;   ******Family income restriction;
if (headlabor + wifelabor > 1200) and (headlabor + wifelabor) < 1000000;   ******labor income restriction;
*if headmarital = 1 and gender = 2 then delete;
*if headmarital ne 1 and (HWWife > 0 or Wifehour > 0 or wifelabor > 0) then delete;
if year ge 1968 and headtakevacation ne 1 and headvacationweek > 0 then delete; 
if year ge 1975 and wifetakevacation ne 1 and wifevacationweek > 0 then delete; 
if headvacationweek > 27 then delete;                       ******Vacation time restriction;
if wifevacationweek > 27 then delete;                       ******Vacation time restriction;
if headhour > 4160 then delete;                             ******Market work hours restriction;
if wifehour > 4160 then delete; 
if headhour > 500;
if HWHead > 4160 then delete;                               ******Housework hours restriction;
if HWWife > 4160 then delete;  
if abs(HWHeadWeekly * 52 - HWHead) > 26 then delete;
if abs(HWWifeWeekly * 52 - HWWife) > 26 then delete;
if year ne 1967 and abs(HWHW - HWHead - HWWife) > 0 then delete;
if year = 1967 and headmarital ne 1 then do; 
   if HWHW > 8320 then delete; 
   HWHead = HWHW;
   end;
*/

keep pid year WGT construp constrdown wifeconstrup homeprod repair marwage headmarital wifeage wifeedu 
	 wifeocc wifeind dis gender headage headmarital headedu headrace headstatus selfemploy age2 age6 
	 age12 age18 children famsize headocc headind foodin foodout HWHW HWHead HWWife HWHeadWeekly 
	 HWWifeWeekly HeadTakeVacation HeadVacationWeek WifeTakeVacation WifeVacationWeek faminc headlabor
	 wifelabor headhour wifehour lagheadhour lagwifehour headextra wifeextra headsalaried wifesalaried 
	 homeown tenure secjob mainwage sameemp_mths union relocated num_addljobs;  
run;
%mend;
%variable(1967, 1968); %variable(1968, 1969); %variable(1969, 1970); %variable(1970, 1971);
%variable(1971, 1972); %variable(1972, 1973); %variable(1973, 1974); %variable(1974, 1975);
%variable(1975, 1976); %variable(1976, 1977); %variable(1977, 1978); %variable(1978, 1979);
%variable(1979, 1980); %variable(1980, 1981); %variable(1981, 1982); %variable(1982, 1983);
%variable(1983, 1984); %variable(1984, 1985); %variable(1985, 1986); %variable(1986, 1987);

*********Pooling home production data from 1967 to 1986, variable availabilities vary across years            *********;

data temp.pooled;
set temp.HomeProd1967 temp.HomeProd1968 temp.HomeProd1969 temp.HomeProd1970 temp.HomeProd1971           
    temp.HomeProd1972 temp.HomeProd1973 temp.HomeProd1974 temp.HomeProd1975 temp.HomeProd1976 
    temp.HomeProd1977 temp.HomeProd1978 temp.HomeProd1979 temp.HomeProd1980 temp.HomeProd1981 
    temp.HomeProd1982 temp.HomeProd1983 temp.HomeProd1984 temp.HomeProd1985 temp.HomeProd1986;
run; 

*Series Id:    CUUR0000SA0
Not Seasonally Adjusted
Area:         U.S. city average
Item:         All items
Base Period:  1982-84=100;
proc import datafile="C:\Users\bmccully\Documents\pter-master\build\input\cpi.csv"
			out=cpi
			dbms=csv
			replace;
	GETNAMES=YES;
run;
proc sort data=cpi; by year; run;
proc sort data=temp.pooled; by year; run;
/*recode some variables*/
data out.pooled;
	merge temp.pooled cpi;
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
	if headmarital in (1,5) then leadmarried = 1;
	*recode whether one is salaried or hourly. Coding irregularities before and after 1976.
	 	Prior to 1975, if paid hourly then headsalary=1. 
		1975 and later if paid hourly then headsalary=3;
	*assume that if respondent doesn�t earn income from more-than-usual hours per week (headextra=1),
		he is salaried.;
	if year<1975 AND headextra^=0 then headsalary = (headsalaried=5 & headextra=5);
	if year<1975 AND headextra^=0 then headhourly = ((headsalaried=1 & headextra=5) OR
	   	     	 	      	   	         (headsalaried=0 & headextra=1));
	if year>=1975 AND headsalaried^=0 then headsalary = (headsalaried=1);
	if year>=1975 AND headsalaried^=0 then headhourly = (headsalaried=3);
	if headmarried=1 & wifesalaried^=0 then wifesalary = (wifesalaried=1);
	if headmarried=1 & wifesalaried^=0 then wifehourly = (wifesalaried=3);
	*recode whether one receives extra income from working more hours than usual in a week;
	if year<1975 then headext = ((headsalaried=0 & headextra=1) OR (headsalary=1 & headextra=1));
	if year>=1975 then headext = ((headsalary=1 & headextra=1) OR (headhourly=1));
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

	*union membership variable is different only in 1968;
	if year=1968 & union in (1,2,3,4,5,8) then union_dummy=1;
	if year = 1968 & (union=0 OR union=9) then union_dummy=0;
	if union^=. & year^=1968 then union_dummy = (union=1);

	*dummies for whether household is constrained, i.e. if either husband or wife is constrained;
	if year>=1971 AND year<=1976 then hhconstrup = (construp=1 OR wifeconstrup=1);

	*adjust same employer, #months;
	if sameemp_mths=999 then sameemp_mths=.;

	/*adjust income for inflation*/
	headlabor = headlabor/cpi*100;
	wifelabor = wifelabor/cpi*100;
	faminc = faminc/cpi*100;
	mainwage = mainwage/cpi*100;
	marwage = marwage/cpi*100;

	lnheadlabor = log(headlabor);
	lnwifelabor = log(wifelabor);
	lnfaminc = log(faminc);

	*number of additional jobs;
	if num_addljobs=0 OR num_addljobs=9 then num_addljobs = .;
	if year=1968 then do;
		if secjob=1 AND num_addljobs=5 then num_addljobs=1;
		else if secjob=1 & num_addljobs=1 then num_addljobs=2;
		else if secjob=5 then num_addljobs=0;
	end;

	
run;
