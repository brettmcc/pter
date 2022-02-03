*********Merge constraints, housework, demography, income and labor data together                              *********
*********In constraints and housework data the variable indices point to the reference year, while in other    *********
*********data, some indices point to survey year. We make all variable indexes point to the reference year     *********;

libname macrodat '/hpc/household_finance/BoardResearch/MacroData';
libname psiddata '/hpc/household_finance/SurveyData/PSIDDATA';
libname hp '/hpc/household_finance/BoardResearch/HP/WorkDir/Revision';

*options mprint;

******First create a dummy indicating whether working extra hours will lead to additional pay;
%macro var(year);
data extrapay&year.;
set psiddata.labor;
if id&year. ne .;
extrapay&year. = headextra&year. = 1;
keep id&year. extrapay&year.;

proc sort data = extrapay&year.;
by id&year.;
run;
%mend;
%var(1968) %var(1969) %var(1970) %var(1971) %var(1972) %var(1973) %var(1974) %var(1975) 

%macro var(year);
data extrapay&year.;
set psiddata.labor;
if id&year. ne .;
%if &year. < 1978 %then %do; extrapay&year. = (headsalariedextra&year. = 1 or (0 < headhourlyextrarate&year. < 9.99) or (0 < headotherpaidextrarate&year. < 9.99)); %end;
%if &year. ge 1978 %then %do; extrapay&year. = (headsalariedextra&year. = 1 or (0 < headhourlyextrarate&year. < 99.99) or (0 < headotherpaidextrarate&year. < 99.99)); %end;
keep id&year. extrapay&year.;

proc sort data = extrapay&year.;
by id&year.;
run;
%mend;
%var(1976) %var(1977) %var(1978) %var(1979) %var(1980) %var(1981) %var(1982) %var(1983) %var(1984) %var(1985) %var(1986) %var(1987)  

******labor hour constraints;
%macro more(year1, year2);
data wantable&year1.;
set psiddata.wantable;
if id&year1. ne .;
keep id&year1. construp&year2. constrdown&year2. marwage&year2.;

proc sort data = wantable&year1.;
by id&year1.;
run;
%mend;
%more(1968, 1967) %more(1969, 1968) %more(1970, 1969)   
%more(1971, 1970) %more(1972, 1971) %more(1973, 1972) %more(1974, 1973) %more(1975, 1974) %more(1976, 1975) %more(1977, 1976) %more(1978, 1977) %more(1979, 1978) %more(1980, 1979) 
%more(1981, 1980) %more(1982, 1981) %more(1983, 1982) %more(1984, 1983) %more(1985, 1984) %more(1986, 1985) %more(1987, 1986);

******housework data time reference changed around 1976;
data housework1968;
set psiddata.housework;
if id1968 ne .;
keep id1968 HWHW1967;

proc sort data = housework1968;
by id1968;
run;

%macro hw1(year1, year2);
data housework&year1.;
set psiddata.housework;
if id&year1. ne .;

HWWifeWeekly&year2. = HWWife&year2. / 52;
HWHeadWeekly&year2. = HWHead&year2. / 52;
keep id&year1. HWWifeWeekly&year2. HWHeadWeekly&year2. HWHead&year2. HWWife&year2.;

proc sort data = housework&year1.;
by id&year1.;
run;
%mend;
%hw1(1969, 1968) %hw1(1970, 1969) %hw1(1971, 1970) %hw1(1972, 1971) %hw1(1973, 1972) %hw1(1974, 1973);  

******house work was not collected in 1975;
data housework1975;
set psiddata.head;
if id1975 ne .;
HWWifeWeekly1975 = .;
HWHeadWeekly1975 = .;
keep id1975 HWWifeWeekly1975 HWHeadWeekly1975 HWHead1975 HWWife1975;

%macro hw2(year);
data housework&year.;
set psiddata.housework;
if id&year. ne .;
keep id&year. HWWifeWeekly&year. HWHeadWeekly&year. HWHead&year. HWWife&year.;

proc sort data = housework&year.;
by id&year.;
run;
%mend;
%hw2(1976) %hw2(1977) %hw2(1978) %hw2(1979) %hw2(1980) %hw2(1981) %hw2(1982) %hw2(1983) %hw2(1984) %hw2(1985) %hw2(1986);

******income, work hours, demographics;
%macro var(year);
data income&year.;
set psiddata.income&year.;
if id&year. ne .;
keep id&year. faminc&year. headlabor&year. wifelabor&year.;

proc sort data = income&year.;
by id&year.;

data hour&year.;
set psiddata.labor;
if id&year. ne .;
/*%if &year. < 1970 %then %do; partime&year. = (headweeklyhour&year. > 0 and headweeklyhour&year. < 3); %end;
%else %do; partime&year. = (headweeklyhour&year. > 0 and headweeklyhour&year. < 35); %end;*/
partime&year. = (headhour&year. > 0 and headhour&year. / 52 < 35);
keep id&year. headhour&year. wifehour&year. partime&year.;

proc sort data = hour&year.;
by id&year.;

data children&year.;
set psiddata.children;
if id&year. ne .;
keep id&year. number&year.;

proc sort data = children&year.;
by id&year.;

data head&year.;
set psiddata.head;
if id&year. ne .;
keep id&year. headage&year. WGT&year. headedu&year. headrace&year. headstatus&year. selfemploy&year. 
     famsize&year. headocc&year.  headind&year.;

proc sort data = head&year.;
by id&year.;

data marital&year.;
set psiddata.head;
if id&year. ne .;
keep id&year. headmarital&year.;

proc sort data = marital&year.;
by id&year.;

data wife&year.;
set psiddata.wife;
if id&year. ne .;
keep id&year. wifeage&year. wifeedu&year. wifeocc&year.  wifeind&year.;

proc sort data = wife&year.;
by id&year.;

data gender&year.;
set psiddata.headgender;
if id&year. ne .;
keep id&year. gender&year.;

proc sort data = gender&year.;
by id&year.;

data housing&year.;
set psiddata.housing;
if id&year. ne .;
keep id&year. own&year.;

proc sort data = housing&year.;
by id&year.;

data tenure&year.;
	set psiddata.tenure;
	if id&year ne .;
	*for questions not asked in given years, fill in values as blank;
	%if &year.=1968 %then %do;
		tenure1968=.;
		relocated1968=.;
	%end;
	%if &year.=1973 %then union&year.=.;
	;
	%if &year.>1981 %then union&year.=.;
	;
	keep id&year. tenure&year. sameemp_mths&year. union&year. relocated&year. ;

proc sort data = tenure&year.;
by id&year.;

data food&year.;
set psiddata.psidfood19682015;
if id&year. ne .;
keep id&year. foodhome&year. foodout&year.;

proc sort data = food&year.;
by id&year.;
run;

data tenure_retro&year.;
	set psiddata.tenure;
	if id&year ne .;
	*for questions not asked in given years, fill in values as blank;
	%if &year.<1970 %then mainwage&year.=.;
	;
	keep id&year. secjob&year. mainwage&year. num_addljobs&year.;

proc sort data = tenure_retro&year.;
by id&year.;
run;
%mend;
%var(1968) %var(1969) 
%var(1970) %var(1971) %var(1972) %var(1973) %var(1974) %var(1975) %var(1976) %var(1977) %var(1978) %var(1979) 
%var(1980) %var(1981) %var(1982) %var(1983) %var(1984) %var(1985) %var(1986) %var(1987)  

******food data were not collected 1973;
data food1973;
set psiddata.head;
if id1973 ne .;
foodhome1973 = .;
foodout1973 = .;
keep id1973 foodhome1973 foodout1973;

proc sort data = food1973;
by id1973;

******Merge******;

*********1967 is not merged using the macro;
data pid;
set psiddata.person;
if id1968 ne . and rel1968 = 1; 
keep id1968 pid;

proc sort data = pid;
by id1968;

data hp.homeprod1967;  ******1967 data will not be used for change-over-change analysis;
merge head1968(in = in1) marital1968 wife1968 gender1968 wantable1968 housework1968 income1968 hour1968 children1968 tenure_retro1968 pid(in = in2);
by id1968; 
if in1 and in2;
construp      = construp1967;
constrdown    = constrdown1967;
gender        = gender1968;
headage       = headage1968;
headmarital   = headmarital1968;
headedu       = headedu1968;
headrace      = headrace1968; 
headstatus    = headstatus1968;
selfemploy    = selfemploy1968; 
famsize       = famsize1968;
children      = number1968;
headocc       = headocc1968;
headind       = headind1968;
wifeage       = wifeage1968;
wifeedu       = wifeedu1968;
wifeocc       = wifeocc1968;
wifeind       = wifeind1968;
WGT           = WGT1968;
homeown		  = own1968;
secjob    	  = secjob1968; *changed in tenure.sas to be contemporaneous;

HWHW          = HWHW1967;

faminc        = faminc1968;
headlabor     = HeadLabor1968;
wifelabor     = WifeLabor1968;
headhour      = headhour1968;
partime       = partime1968;
wifehour      = wifehour1968;

*bottom coding;
if faminc<1 then faminc = 1;

year = 1967;
run;

%macro m(year1, year2, year3);

data pid;
set psiddata.person;
%if &year1 = 1968 %then %do; if seqno&year2. = 1 and (rel&year1. = 1 or rel&year1. = 10) and (rel&year2. = 1 or rel&year2. = 10); %end;
%else %do; if seqno&year1. = 1 and seqno&year2. = 1 and (rel&year1. = 1 or rel&year1. = 10) and (rel&year2. = 1 or rel&year2. = 10); %end;
keep pid id&year1. id&year2.;

proc sort data = pid;
by id&year1.;

%if &year1. le 1974 %then %do;
    data hp&year1.;
    merge head&year1.(in = in1) marital&year1. wife&year1. gender&year1.  children&year1. 
          hour&year1. income&year1. housing&year1. tenure&year1. food&year1. extrapay&year1. pid(in = in2);
    by id&year1.;
    if in1 and in2;

    proc sort data = hp&year1.;
    by id&year2;

	*merge with retrospective variables;
    data homeprod&year1.;
    merge hp&year1.(in = in1) marital&year2. wantable&year2. housework&year2.(in = in2) 
			hour&year2. income&year2.(in = in3) tenure_retro&year2.;
    by id&year2.;
    if in1 and in2 and in3;
	%end;

/*%else %if &year1. = 1974 %then %do;
    data hp&year1.;
    merge head&year1.(in = in1) marital&year1. wife&year1. gender&year1.  children&year1. 
          psiddata.housework&year1. hour&year1. dis&year1. housing&year1. tenure&year1. pid(in = in2);
    by id&year1.;
    if in1 and in2;

    proc sort data = hp&year1.;
    by id&year2;

    data homeprod&year1.;
    merge hp&year1.(in = in1) marital&year2. psiddata.wantable&year2. hour&year2. income&year2.(in = in2)
			tenure_retro&year2. psiddata.food&year2.;
    by id&year2.;
    if in1 and in2;
	%end;*/

%else %do;
    data hp&year1.;
    merge head&year1.(in = in1) marital&year1. wife&year1. gender&year1.  children&year1. 
          housework&year1. hour&year1. income&year1. housing&year1. tenure&year1. food&year1. extrapay&year1. pid(in = in2);
    by id&year1.;
    if in1 and in2;

    proc sort data = hp&year1.;
    by id&year2;

    data homeprod&year1.;
    merge hp&year1.(in = in1) marital&year2. wantable&year2. hour&year2. income&year2.(in = in2)
			tenure_retro&year2.;
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
data psiddata.homeprod&tminus1.;
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
data hp.homeprod&year1.;
set homeprod&year1.;

construp      = construp&year1.;
wifeconstrup  = wifeconstrup&year1.;
constrdown    = constrdown&year1.;
marwage       = marwage&year1.;
extrapay      = extrapay&year1.;

gender        = gender&year1.;
headage       = headage&year1.;
headmarital   = headmarital&year1.;
headedu       = headedu&year1.;
headrace      = headrace&year1.; 
headstatus    = headstatus&year1.;
selfemploy    = selfemploy&year1.; 
famsize       = famsize&year1.;
children      = number&year1.;
headocc       = headocc&year1.;
headind       = headind&year1.;
wifeage       = wifeage&year1.;
wifeedu       = wifeedu&year1.;
wifeocc       = wifeocc&year1.;
wifeind       = wifeind&year1.;
WGT           = WGT&year1.;
homeown		  = own&year1.;
tenure		  = tenure&year1.;
secjob    	  = secjob&year2.; *changed in tenure.sas to be contemporaneous;
mainwage	  = mainwage&year2.; *changed in tenure.sas to be contemporaneous;
sameemp_mths  = sameemp_mths&year1.;
union		  = union&year1.;
relocated	  = relocated&year1.;
num_addljobs  = num_addljobs&year2.; *changed in tenure.sas to be contemporaneous;

foodin        = foodhome&year1.;
foodout       = foodout&year1.;
foodoutratio  = foodin / (foodin + foodout);
*HWHead        = HWHeadWeekly&year1. * 52;
*HWWife        = HWWifeWeekly&year1. * 52;
HWHead        = HWHead&year1.;
HWWife        = HWWife&year1.;
HWHeadweekly  = HWHeadWeekly&year1.;
HWWifeweekly  = HWWifeWeekly&year1.;

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
partime       = partime&year2.;
wifehour      = wifehour&year2.;

lagfaminc     = faminc&year1.;
lagheadlabor  = headlabor&year1.;
lagwifelabor  = wifelabor&year1.;
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

keep pid year WGT construp constrdown extrapay wifeconstrup marwage headmarital wifeage wifeedu 
	 wifeocc wifeind gender headage headmarital headedu headrace headstatus selfemploy children 
	 famsize headocc headind foodin foodout HWHW HWHead HWWife HWHeadWeekly HWWifeWeekly HeadTakeVacation HeadVacationWeek 
     WifeTakeVacation WifeVacationWeek faminc headlabor
	 wifelabor headhour partime wifehour lagfaminc lagheadlabor lagwifelabor lagheadhour lagwifehour 
	 homeown tenure secjob mainwage sameemp_mths union relocated num_addljobs;  

proc means data = hp.homeprod&year1.;
var HWHead HWWife;
run;
%mend;
*%variable(1967, 1968); %variable(1968, 1969); %variable(1969, 1970); %variable(1970, 1971);
%variable(1971, 1972); %variable(1972, 1973); %variable(1973, 1974); %variable(1974, 1975);
%variable(1975, 1976); %variable(1976, 1977); %variable(1977, 1978); %variable(1978, 1979);
%variable(1979, 1980); %variable(1980, 1981); %variable(1981, 1982); %variable(1982, 1983);
%variable(1983, 1984); %variable(1984, 1985); %variable(1985, 1986); %variable(1986, 1987);

*********Pooling home production data from 1967 to 1986, variable availabilities vary across years            *********;

data hp.pooled;
set hp.HomeProd1967 hp.HomeProd1968 hp.HomeProd1969 hp.HomeProd1970 hp.HomeProd1971           
    hp.HomeProd1972 hp.HomeProd1973 hp.HomeProd1974 hp.HomeProd1975 hp.HomeProd1976 
    hp.HomeProd1977 hp.HomeProd1978 hp.HomeProd1979 hp.HomeProd1980 hp.HomeProd1981 
    hp.HomeProd1982 hp.HomeProd1983 hp.HomeProd1984 hp.HomeProd1985 hp.HomeProd1986;

proc sort data = hp.pooled;
by year;

data hp.pooled;
	merge hp.pooled(in = in1) macrodat.annualcpi;
	by year;
	if in1;
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

	/*recode whether one is salaried or hourly. Coding irregularities before and after 1976.
	 	Prior to 1975, if paid hourly then headsalary=1. 
		1975 and later if paid hourly then headsalary=3;
	*assume that if respondent doesn’t earn income from more-than-usual hours per week (headextra=1),
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
	if headmarried=1 & wifesalary=1 then wifeext = (wifeextra=1);*/
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

	/*adjust income and food expenditure for inflation using 1986 dollars*/
	headlabor = headlabor/cpi*109.6;
	wifelabor = wifelabor/cpi*109.6;
	faminc = faminc/cpi*109.6;
	mainwage = mainwage/cpi*109.6;
	marwage = marwage/cpi*109.6;

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

data hp.pooled_all; ******keep unselected dataset for future analysis;
set hp.pooled; 

data hp.pooled; ******sample selection criteria;
set hp.pooled; 
if headage ge 22 and headage < 68;   ******Head age restriction;
if headstatus = 1;          *****Head is working or temporarily laid off;
if year = 1967 or year = 1968 or year = 1973 or (foodin + foodout > 100 and foodin + foodout < 10000);  ******Food expenditure restriction;
if faminc > 1200 and faminc < 1000000;   ******Family income restriction;
if headmarital = 1 and gender = 2 then delete;
if headhour > 4160 then delete;                             ******Market work hours restriction;
if wifehour > 4160 then delete; 
if headhour > 0;
if HWHead > 4160 then delete;                               ******Housework hours restriction;
if HWWife > 4160 then delete; 

proc sort data = hp.pooled;
by pid;

proc means data = hp.pooled noprint;
by pid;
var wgt;
output out = wgt mean = wgtmean;

data hp.pooled;
merge hp.pooled wgt;
by pid; run;


