*********Input housework hours data from the PSID family data.  Head and wife combined hours were asked in 1968 *********
*********from 1969 to 1974, head and wife hours were collected separately.  These questions refer to the year   *********
*********prior to the survey.  From 1976, weekly hours data were collected for head and wife separately.  Annual*********
*********hours were imputed for the survey year.  The data were not collected in 1982.  We compare the weekly   *********
*********hours and imputed annual hours.  If weekly number multiplied by 52 is different from annual hours by   *********
*********more than 26 then we treat the data as blank.                                                          *********
*********From 1968 to 1972, miscellaneous questions were asked about home production and car repairment         *********; 
libname psiddata '/href/scratch3/m1bam03/PSID/data/';
libname temp '../../temp/';

data temp.housework1968;
set psiddata.fam68;
id1968 = V3;
HWHW1967 = V59; 
HWHead1967 = .; 
HWWife1967 = .; 
HomeProd1967 = V61;
Repair1967 = V26;
keep id1968 HWHW1967 HWHead1967 HWWife1967 HomeProd1967 Repair1967;

data temp.housework1969;
set psiddata.fam69;
id1969 = V442;
HWWife1968 = V481;
HWHusband1968 = V483;
HWHW1968 = V895;
HomeProd1968 = V464;
Repair1968 = V447;
keep id1969 HWWife1968 HWHusband1968 HWHW1968 HomeProd1968 Repair1968;

data temp.housework1970;
set psiddata.fam70;
id1970 = V1102;
HWWife1969 = V1154;
HWHusband1969 = V1156;
HWHW1969 = V1592;
HomeProd1969 = V1507;
Repair1969 = V1120;
keep id1970 HWWife1969 HWHusband1969 HWHW1969 HomeProd1969 Repair1969;

data temp.housework1971;
set psiddata.fam71;
id1971 = V1802;
HWWife1970 = V1855;
HWHusband1970 = V1857;
HWHW1970 = V2304;
HomeProd1970 = V2219;
Repair1970 = V1821;
keep id1971 HWWife1970 HWHusband1970 HWHW1970 HomeProd1970 Repair1970;

data temp.housework1972;
set psiddata.fam72;
id1972 = V2402;
HWWife1971 = V2455;
HWHusband1971 = V2457;
HWHW1971 = V2931;
HomeProd1971 = V2936;
Repair1971 = V2421;
keep id1972 HWWife1971 HWHusband1971 HWHW1971 HomeProd1971 Repair1971;

data temp.housework1973;
set psiddata.fam73;
id1973 = V3002;
HWWife1972 = V3037;
HWHusband1972 = V3039;
HWHW1972 = V3296;
keep id1973 HWWife1972 HWHusband1972 HWHW1972;

data temp.housework1974;
set psiddata.fam74;
id1974 = V3402;
HWWife1973 = V3449;
HWHusband1973 = V3451;
HWHW1973 = V3716;
keep id1974 HWWife1973 HWHusband1973 HWHW1973;

%macro hw(year1, year2);
data marital&year1.;
set psiddata.head;
if id&year1. ne .;
keep id&year1. headmarital&year1.;

proc sort data = marital&year1.;
by id&year1.;

data temp.housework&year1.;
merge temp.housework&year1.(in = in1) marital&year1.(in = in2);
by id&year1.;
if in1 and in2;
if headmarital&year1 = 1 then HWHead&year2. = HWHusband&year2.;
else do;
   HWHead&year2. = HWWife&year2.;
   HWWife&year2. = 0;
   end;
keep id&year1 HWHead&year2. HWWife&year2. HWHW&year2. HomeProd&year2. Repair&year2.;
run;
%mend; 
%hw(1969, 1968) %hw(1970, 1969) %hw(1971, 1970) %hw(1972, 1971) %hw(1973, 1972) %hw(1974, 1973);  

data houseworka1974;
set psiddata.fam74;
id1974 = V3402;
HWWife1974 = .;
HWHead1974 = .;
keep id1974 HWHead1974 HWWife1974;

data temp.housework1975;
set psiddata.fam75;
id1975 = V3802;
HWWife1975 = .;
HWHead1975 = .;
keep id1975 HWHead1975 HWWife1975;

data temp.housework1976;
set psiddata.fam76;
id1976 = V4302;
HWWife1976 = V4711;
HWHead1976 = V4350;
HWWifeWeekly1976 = V4768;
HWHeadWeekly1976 = V4609;
keep id1976 HWWife1976 HWHead1976 HWWifeWeekly1976 HWHeadWeekly1976;

data temp.housework1977;
set psiddata.fam77;
id1977 = V5202;
HWWife1977 = V5260;
HWHead1977 = V5262;
HWWifeWeekly1977 = V5534;
HWHeadWeekly1977 = V5535;
keep id1977 HWWife1977 HWHead1977 HWWifeWeekly1977 HWHeadWeekly1977;

data temp.housework1978;
set psiddata.fam78;
id1978 = V5702;
HWWife1978 = V5759;
HWHead1978 = V5761;
HWWifeWeekly1978 = V6072;
HWHeadWeekly1978 = V6073;
Repair1978 = V6317;
keep id1978 HWWife1978 HWHead1978 HWWifeWeekly1978 HWHeadWeekly1978;

data temp.housework1979;
set psiddata.fam79;
id1979 = V6302;
HWWife1979 = V6365;
HWHead1979 = V6367;
HWWifeWeekly1979 = V6663;
HWHeadWeekly1979 = V6664;
keep id1979 HWWife1979 HWHead1979 HWWifeWeekly1979 HWHeadWeekly1979;

data temp.housework1980;
set psiddata.fam80;
id1980 = V6902;
HWWife1980 = V6963;
HWHead1980 = V6965;
HWWifeWeekly1980 = V7265;
HWHeadWeekly1980 = V7266;
keep id1980 HWWife1980 HWHead1980 HWWifeWeekly1980 HWHeadWeekly1980;

data temp.housework1981;
set psiddata.fam81;
id1981 = V7502;
HWWife1981 = V7555;
HWHead1981 = V7557;
HWWifeWeekly1981 = V7956;
HWHeadWeekly1981 = V7957;
keep id1981 HWWife1981 HWHead1981 HWWifeWeekly1981 HWHeadWeekly1981;

data temp.housework1982;
set psiddata.fam82;
id1982 = V8202;
HWWife1982 = .;
HWHead1982 = .;
keep id1982 HWWife1982 HWHead1982;

data temp.housework1983;
set psiddata.fam83;
id1983 = V8802;
HWWife1983 = V8855;
HWHead1983 = V8857;
HWWifeWeekly1983 = V9280;
HWHeadWeekly1983 = V9281;
keep id1983 HWWife1983 HWHead1983 HWWifeWeekly1983 HWHeadWeekly1983;

data temp.housework1984;
set psiddata.fam84;
id1984 = V10002;
HWWife1984 = V10226;
HWHead1984 = V10228;
HWWifeWeekly1984 = V10866;
HWHeadWeekly1984 = V10867;
keep id1984 HWWife1984 HWHead1984 HWWifeWeekly1984 HWHeadWeekly1984;

data temp.housework1985;
set psiddata.fam85;
id1985 = V11102;
HWWife1985 = V11366;
HWHead1985 = V11368;
HWWifeWeekly1985 = V12337;
HWHeadWeekly1985 = V11982;
keep id1985 HWWife1985 HWHead1985 HWWifeWeekly1985 HWHeadWeekly1985;

data temp.housework1986;
set psiddata.fam86;
id1986 = V12502;
HWWife1986 = V12765;
HWHead1986 = V12767;
HWWifeWeekly1986 = V13393;
HWHeadWeekly1986 = V13394;
keep id1986 HWWife1986 HWHead1986 HWWifeWeekly1986 HWHeadWeekly1986;
run;

%macro adjustmts;
	%do y=1976 %to 1986;
		%if &y. NE 1981 %then %do;
			data temp.housework&y.;
				set temp.housework&y.;
				if HWWifeWeekly&y. in (0,99) then HWWifeWeekly&y.=.;
				if HWHeadWeekly&y. in (0,99) then HWHeadWeekly&y.=.;
			run;
		%end;
	%end;
%mend;

%adjustmts;
