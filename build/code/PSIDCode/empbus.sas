*********Employment history and business data                                                     *********;

data labor1968;
set psiddata.fam68; 
id1968                            =                  V3                 ; 
headstatus1968                    =                  V196               ;
headhour1968                      =                  V47                ;
wifehour1968                      =                  V53                ;
keep id1968 headstatus1968 headhour1968 wifehour1968;

*1 Working now 
2 Only temporarily laid off, sick leave or maternity leave 
3 Looking for work, unemployed 
4 Retired 
5 Permanently disabled temporarily disabled 
6 Keeping house 
7 Student 
8 Other;  

data labor1969;
set psiddata.fam69;
id1969                            =                  V442               ;                       ;  
headstatus1969                    =                  V639               ;
headhour1969                      =                  V465                ;
wifehour1969                      =                  V475                ;
keep id1969 headstatus1969 headhour1969 wifehour1969;

data labor1970;
set psiddata.fam70;
id1970                            =                  V1102              ;                       ; 
headstatus1970                    =                  V1278              ;
headextra1970                     =                  V1294              ;
headsalaried1970                  =                  V1296              ;
headhour1970                      =                  V1138              ;
wifehour1970                      =                  V1148              ;
keep id1970 headstatus1970 headhour1970 wifehour1970 headextra1970 headsalaried1970;

data labor1971;
set psiddata.fam71;
id1971                            =                  V1802              ;                       ; 
headstatus1971                    =                  V1983              ;
headextra1971                     =                  V2000              ;
headsalaried1971                  =                  V2002              ;
headhour1971                      =                  V1839              ;
wifehour1971                      =                  V1849              ;
keep id1971 headstatus1971 headhour1971 wifehour1971 headextra1971 headsalaried1971;

data labor1972;
set psiddata.fam72;
id1972                            =                  V2402              ;                       ; 
headstatus1972                    =                  V2581              ;
headextra1972                     =                  V2598              ;
headsalaried1972                  =                  V2600              ;
headhour1972                      =                  V2439              ;
wifehour1972                      =                  V2449              ;
keep id1972 headstatus1972 headhour1972 wifehour1972 headextra1972 headsalaried1972;

data labor1973;
set psiddata.fam73; 
id1973                            =                  V3002              ;                       ; 
headstatus1973                    =                  V3114              ;
headextra1973                     =                  V3131              ;
headsalaried1973                  =                  V3133              ;
headhour1973                      =                  V3027              ;
wifehour1973                      =                  V3035              ;
keep id1973 headstatus1973 headhour1973 wifehour1973 headextra1973 headsalaried1973;

data labor1974;
set psiddata.fam74;
id1974                            =                  V3402              ;                       ; 
headstatus1974                    =                  V3528              ;
headextra1974                     =                  V3546              ;
headsalaried1974                  =                  V3548              ;
headhour1974                      =                  V3423              ;
wifehour1974                      =                  V3431              ;
keep id1974 headstatus1974 headhour1974 wifehour1974 headextra1974 headsalaried1974;

data labor1975;
set psiddata.fam75;
id1975                            =                  V3802              ;                       ; 
headstatus1975                    =                  V3967              ;
headextra1975                     =                  V4000              ;
headsalaried1975                  =                  V4002              ;
headhour1975                      =                  V3823              ;
wifehour1975                      =                  V3831              ;
keep id1975 headstatus1975 headhour1975 wifehour1975 headextra1975 headsalaried1975;

data labor1976;
set psiddata.fam76;
id1976                            =                  V4302              ;                       ; 
headstatus1976                    =                  V4458              ;
headextra1976                     =                  V4511              ;
wifeextra1976                     =                  V4894              ;
headsalaried1976                  =                  V4509              ;
wifesalaried1976                  =                  V4892              ;
headhour1976                      =                  V4332              ;
wifehour1976                      =                  V4344              ;
keep id1976 headstatus1976 headhour1976 wifehour1976 headextra1976 wifeextra1976 headsalaried1976 wifesalaried1976;

data labor1977;
set psiddata.fam77;
id1977                            =                  V5202              ;                       ; 
headstatus1977                    =                  V5373              ;
headextra1977                     =                  V5422              ;
headsalaried1977                  =                  V5420              ;
headhour1977                      =                  V5232              ;
wifehour1977                      =                  V5244              ;
keep id1977 headstatus1977 headhour1977 wifehour1977 headextra1977 headsalaried1977;

data labor1978;
set psiddata.fam78; 
id1978                            =                  V5702              ;                       ; 
headstatus1978                    =                  V5872              ;
headextra1978                     =                  V5909              ;
headsalaried1978                  =                  V5907              ;
headhour1978                      =                  V5731              ;
wifehour1978                      =                  V5743              ;
keep id1978 headstatus1978 headhour1978 wifehour1978 headextra1978 headsalaried1978;

data labor1979;
set psiddata.fam79;
id1979                            =                  V6302              ;                       ; 
headstatus1979                    =                  V6492              ;
headextra1979                     =                  V6520              ;
headsalaried1979                  =                  V6518              ;
wifesalaried1979                  =                  V6614              ;
headhour1979                      =                  V6336              ;
wifehour1979                      =                  V6348              ;
keep id1979 headstatus1979 headhour1979 wifehour1979 headextra1979 headsalaried1979 wifesalaried1979;

data labor1980;
set psiddata.fam80;
id1980                            =                  V6902              ;                       ; 
headstatus1980                    =                  V7095              ;
headextra1980                     =                  V7123              ;
headsalaried1980                  =                  V7121              ;
wifesalaried1980                  =                  V7216              ;
headhour1980                      =                  V6934              ;
wifehour1980                      =                  V6946              ;
keep id1980 headstatus1980 headhour1980 wifehour1980 headextra1980 headsalaried1980 wifesalaried1980;

data labor1981;
set psiddata.fam81;
id1981                            =                  V7502              ;                       ; 
headstatus1981                    =                  V7706              ;
headextra1981                     =                  V7716              ;
headsalaried1981                  =                  V7714              ;
wifesalaried1981                  =                  V7887              ;
headhour1981                      =                  V7530              ;
wifehour1981                      =                  V7540              ;
keep id1981 headstatus1981 headhour1981 wifehour1981 headextra1981 headsalaried1981 wifesalaried1981;

data labor1982;
set psiddata.fam82;
id1982                            =                  V8202              ;                       ; 
headstatus1982                    =                  V8374              ;
headextra1982                     =                  V8384              ;
headsalaried1982                  =                  V8382              ;
wifesalaried1982                  =                  V8546              ;
headhour1982                      =                  V8228              ;
wifehour1982                      =                  V8238              ;
keep id1982 headstatus1982 headhour1982 wifehour1982 headextra1982 headsalaried1982 wifesalaried1982;

data labor1983;
set psiddata.fam83;
id1983                            =                  V8802              ;                       ; 
headstatus1983                    =                  V9005              ;
headextra1983                     =                  V9015              ;
headsalaried1983                  =                  V9013              ;
wifesalaried1983                  =                  V9196              ;
headhour1983                      =                  V8830              ;
wifehour1983                      =                  V8840              ;
keep id1983 headstatus1983 headhour1983 wifehour1983 headextra1983 headsalaried1983 wifesalaried1983;

data labor1984;
set psiddata.fam84;
id1984                            =                  V10002             ;                       ; 
headstatus1984                    =                  V10453             ;
headextra1984                     =                  V10464             ;
headsalaried1984                  =                  V10462             ;
wifesalaried1984                  =                  V10680             ;
headhour1984                      =                  V10037             ;
wifehour1984                      =                  V10131             ;
keep id1984 headstatus1984 headhour1984 wifehour1984 headextra1984 headsalaried1984 wifesalaried1984;

data labor1985;
set psiddata.fam85;
id1985                            =                  V11102             ;                       ; 
headstatus1985                    =                  V11637             ;
headextra1985                     =                  V11655             ;
wifeextra1985                     =                  V12018             ;
headsalaried1985                  =                  V11653             ;
wifesalaried1985                  =                  V12016             ;
headhour1985                      =                  V11146             ;
wifehour1985                      =                  V11258             ;
keep id1985 headstatus1985 headhour1985 wifehour1985 headextra1985 wifeextra1985 headsalaried1985 wifesalaried1985;

data labor1986;
set psiddata.fam86;
id1986                            =                  V12502             ;                       ; 
headstatus1986                    =                  V13046             ;
headextra1986                     =                  V13058             ;
wifeextra1986                     =                  V13237             ;
headsalaried1986                  =                  V13056             ;
wifesalaried1986                  =                  V13235             ;
headhour1986                      =                  V12545             ;
wifehour1986                      =                  V12657             ;
keep id1986 headstatus1986 headhour1986 wifehour1986 headextra1986 wifeextra1986 headsalaried1986 wifesalaried1986;

data labor1987;
set psiddata.fam87;
id1987                            =                  V13702             ;                       ; 
headstatus1987                    =                  V14146             ;
headextra1987                     =                  V14158             ;
wifeextra1987                     =                  V14333             ;
headsalaried1987                  =                  V14156             ;
wifesalaried1987                  =                  V14331             ;
headhour1987                      =                  V13745             ;
wifehour1987                      =                  V13809             ;
keep id1987 headstatus1987 headhour1987 wifehour1987 headextra1987 wifeextra1987 headsalaried1987 wifesalaried1987;

data labor1988;
set psiddata.fam88;
id1988                            =                  V14802             ;                       ; 
headstatus1988                    =                  V15154             ;
headextra1988                     =                  V15166             ;
wifeextra1988                     =                  V15468             ;
headsalaried1988                  =                  V15164             ;
wifesalaried1988                  =                  V15466             ;
headhour1988                      =                  V14835             ;
wifehour1988                      =                  V14865             ;
keep id1988 headstatus1988 headhour1988 wifehour1988 headextra1988 wifeextra1988 headsalaried1988 wifesalaried1988;

data labor1989;
set psiddata.fam89;
id1989                            =                  V16302             ;                       ; 
headstatus1989                    =                  V16655             ;
headextra1989                     =                  V16667             ;
wifeextra1989                     =                  V16986             ;
headsalaried1989                  =                  V16665             ;
wifesalaried1989                  =                  V16984             ;
headhour1989                      =                  V16335             ;
wifehour1989                      =                  V16365             ;
keep id1989 headstatus1989 headhour1989 wifehour1989 headextra1989 wifeextra1989 headsalaried1989 wifesalaried1989;

data labor1990;
set psiddata.fam90;
id1990                            =                  V17702             ;                       ; 
headstatus1990                    =                  V18093             ;
headextra1990                     =                  V18105             ;
wifeextra1990                     =                  V18407             ;
headsalaried1990                  =                  V18103             ;
wifesalaried1990                  =                  V18405             ;
headhour1990                      =                  V17744             ;
wifehour1990                      =                  V17774             ;
keep id1990 headstatus1990 headhour1990 wifehour1990 headextra1990 wifeextra1990 headsalaried1990 wifesalaried1990;

data labor1991;
set psiddata.fam91;
id1991                            =                  V19002             ;                       ; 
headstatus1991                    =                  V19393             ;
headextra1991                     =                  V19405             ;
wifeextra1991                     =                  V19707              ;
headsalaried1991                  =                  V19403             ;
wifesalaried1991                  =                  V19705             ;
headhour1991                      =                  V19044             ;
wifehour1991                      =                  V19074             ;
keep id1991 headstatus1991 headhour1991 wifehour1991 headextra1991 wifeextra1991 headsalaried1991 wifesalaried1991;

data labor1992;
set psiddata.fam92;
id1992                            =                  V20302             ;                       ; 
headstatus1992                    =                  V20693             ;
headextra1992                     =                  V20705             ;
wifeextra1992                     =                  V21007             ;
headsalaried1992                  =                  V20703             ;
wifesalaried1992                  =                  V21005             ;
headhour1992                      =                  V20344             ;
wifehour1992                      =                  V20374             ;
keep id1992 headstatus1992 headhour1992 wifehour1992 headextra1992 wifeextra1992 headsalaried1992 wifesalaried1992;

data labor1993;
set psiddata.fam93;
id1993                            =                  V21602             ;                       ; 
headstatus1993                    =                  V22448             ;
headextra1993                     =                  V22466             ;
wifeextra1993                     =                  V22819              ;
headsalaried1993                  =                  V22463             ;
wifesalaried1993                  =                  V22816             ;
headhour1993                      =                  V21634             ;
wifehour1993                      =                  V21670             ;
keep id1993 headstatus1993 headhour1993 wifehour1993 headextra1993 wifeextra1993 headsalaried1993 wifesalaried1993;

data labor1994;
set psiddata.HourWage9401;
id1994                            =                  ER2002             ;
if id1994 ne .                                                          ;  
headhour1994                      =                  HDTOT94            ;
wifehour1994                      =                  WFTOT94            ;
keep id1994 headhour1994 wifehour1994;
proc sort;
by id1994;
data status1994;
set psiddata.fam94;
id1994                            =                  ER2002             ;
headstatus1994                    =                  ER2069             ;
headextra1994                     =                  ER2084              ;
wifeextra1994                     =                  ER2578              ;
headsalaried1994                  =                  ER2081             ;
wifesalaried1994                  =                  ER2575             ;
if headstatus1994 > 10 then headstatus1994 = .;
keep id1994 headstatus1994 headextra1994 wifeextra1994 headsalaried1994 wifesalaried1994;
proc sort;
by id1994;
data labor1994;
merge labor1994 status1994;
by id1994;

data labor1995;
set psiddata.HourWage9401;
id1995                            =                  ER5002             ;                      ;  
if id1995 ne .                                                          ;  
headhour1995                      =                  HDTOT95            ;
wifehour1995                      =                  WFTOT95            ;
keep id1995 headhour1995 wifehour1995;
proc sort;
by id1995;
data status1995;
set psiddata.fam95;
id1995                            =                  ER5002             ;
headstatus1995                    =                  ER5068             ;
headextra1995                     =                  ER5083             ;
wifeextra1995                     =                  ER5577             ;
headsalaried1995                  =                  ER5080             ;
wifesalaried1995                  =                  ER5574             ;
if headstatus1995 > 10 then headstatus1995 = .;
keep id1995 headstatus1995 headextra1995 wifeextra1995 headsalaried1995 wifesalaried1995;
proc sort;
by id1995;
data labor1995;
merge labor1995 status1995;
by id1995;

data labor1996;
set psiddata.HourWage9401;
id1996                            =                  ER7002             ;                      ;  
if id1996 ne .                                                          ;  
headhour1996                      =                  HDTOT96            ;
wifehour1996                      =                  WFTOT96            ;
keep id1996 headhour1996 wifehour1996;
proc sort;
by id1996;
data status1996;
set psiddata.fam96;
id1996                            =                  ER7002             ;
headstatus1996                    =                  ER7164             ;
headextra1996                     =                  ER7179             ;
wifeextra1996                     =                  ER7673             ;
headsalaried1996                  =                  ER7176             ;
wifesalaried1996                  =                  ER7670             ;
if headstatus1996> 10 then headstatus1996 = .;
keep id1996 headstatus1996 headextra1996 wifeextra1996 headsalaried1996 wifesalaried1996;
proc sort;
by id1996;
data labor1996;
merge labor1996 status1996;
by id1996;

data labor1997;
set psiddata.HourWage9401;
id1997                            =                  ER10002            ;                       ; 
if id1997 ne .                                                          ;  
headhour1997                      =                  HDTOT97            ;
wifehour1997                      =                  WFTOT97            ;
keep id1997 headhour1997 wifehour1997;
proc sort;
by id1997;
data status1997;
set psiddata.fam97;
id1997                            =                  ER10002            ;
headstatus1997                    =                  ER10081            ;
headextra1997                     =                  ER10094            ;
wifeextra1997                     =                  ER10576            ;
headsalaried1997                  =                  ER10091            ;
wifesalaried1997                  =                  ER10573            ;
if headstatus1997 > 10 then headstatus1997 = .;
keep id1997 headstatus1997 headextra1997 wifeextra1997 headsalaried1997 wifesalaried1997;
proc sort;
by id1997;
data labor1997;
merge labor1997 status1997;
by id1997;

data labor1999;
set psiddata.HourWage9401;
id1999                            =                  ER13002            ;                       ; 
if id1999 ne .                                                          ;  
headhour1999                      =                  HDTOT99            ;
wifehour1999                      =                  WFTOT99            ;
keep id1999 headhour1999 wifehour1999;
proc sort;
by id1999;
data status1999;
set psiddata.fam99;
id1999                            =                  ER13002            ;
headstatus1999                    =                  ER13205            ;
headextra1999                     =                  ER13220            ;
wifeextra1999                     =                  ER13732            ;
headsalaried1999                  =                  ER13217            ;
wifesalaried1999                  =                  ER13729            ;
if headstatus1999 > 10 then headstatus1999 = .;
keep id1999 headstatus1999 headextra1999 wifeextra1999 headsalaried1999 wifesalaried1999;
proc sort;
by id1999;
data labor1999;
merge labor1999 status1999;
by id1999;

data labor2001;
set psiddata.HourWage9401;
id2001                            =                  ER17002            ;                       ; 
if id2001 ne .                                                          ;  
headhour2001                      =                  HDTOT01            ;
wifehour2001                      =                  WFTOT01            ;
keep id2001 headhour2001 wifehour2001;
proc sort;
by id2001;
data status2001;
set psiddata.fam01;
id2001                            =                  ER17002             ;
headstatus2001                    =                  ER17216             ;
headextra2001                     =                  ER17231             ;
wifeextra2001                     =                  ER17801             ;
headsalaried2001                  =                  ER17228             ;
wifesalaried2001                  =                  ER17798             ;
if headstatus2001 > 10 then headstatus2001 = .;
keep id2001 headstatus2001 headextra2001 wifeextra2001 headsalaried2001 wifesalaried2001;
proc sort;
by id2001;
data labor2001;
merge labor2001 status2001;
by id2001;

data labor2003;
set psiddata.fam03;
id2003                            =                  ER21002            ;                       ; 
headstatus2003                    =                  ER21123            ;
headextra2003                     =                  ER21155            ;
wifeextra2003                     =                  ER21405            ;
headsalaried2003                  =                  ER21152            ;
wifesalaried2003                  =                  ER21402            ;
headhour2003                      =                  ER24080            ;
wifehour2003                      =                  ER24091            ;
if headstatus2003 > 10 then headstatus2003 = .;
keep id2003 headstatus2003 headhour2003 wifehour2003 headextra2003 wifeextra2003 headsalaried2003 wifesalaried2003;

data labor2005;
set psiddata.fam05;
id2005                            =                  ER25002            ;                       ; 
headstatus2005                    =                  ER25104            ;
headextra2005                     =                  ER25144            ;
wifeextra2005                     =                  ER25402            ;
headsalaried2005                  =                  ER25141            ;
wifesalaried2005                  =                  ER25399            ;
headhour2005                      =                  ER27886            ;
wifehour2005                      =                  ER27897            ;
if headstatus2005 > 10 then headstatus2005 = .;
keep id2005 headstatus2005 headhour2005 wifehour2005 headextra2005 wifeextra2005 headsalaried2005 wifesalaried2005;
run;

data PSIDDATA.labor;
merge labor1968 labor1969 labor1970 labor1971 labor1972 labor1973 labor1974 labor1975 
      labor1976 labor1977 labor1978 labor1979 labor1980 labor1981 labor1982 labor1983 
      labor1984 labor1985 labor1986 labor1987 labor1988 labor1989 labor1990 labor1991 
      labor1992 labor1993 labor1994 labor1995 labor1996 labor1997 labor1999 labor2001 
      labor2003 labor2005 ; 
run;
%macro hour(year);
proc freq data = labor&year;
tables headstatus&year;
run;
%mend;
%hour(1968)  %hour(1969)  %hour(1970)  %hour(1971)  %hour(1972)  %hour(1973)  %hour(1974)  %hour(1975) 
%hour(1976)  %hour(1977)  %hour(1978)  %hour(1979)  %hour(1980)  %hour(1981)  %hour(1982)  %hour(1983) 
%hour(1984)  %hour(1985)  %hour(1986)  %hour(1987)  %hour(1988)  %hour(1989)  %hour(1990)  %hour(1991) 
%hour(1992)  %hour(1993)  %hour(1994)  %hour(1995)  %hour(1996)  %hour(1997)  %hour(1999)  %hour(2001)
%hour(2003)  %hour(2005)

%macro hour(year);
proc freq data = labor&year;
tables headextra&year headsalaried&year;
run;
%mend;
%hour(1970)  %hour(1971)  %hour(1972)  %hour(1973)  %hour(1974)  %hour(1975) 
%hour(1976)  %hour(1977)  %hour(1978)  %hour(1979)  %hour(1980)  %hour(1981)  %hour(1982)  %hour(1983) 
%hour(1984)  %hour(1985)  %hour(1986)  %hour(1987)  %hour(1988)  %hour(1989)  %hour(1990)  %hour(1991) 
%hour(1992)  %hour(1993)  %hour(1994)  %hour(1995)  %hour(1996)  %hour(1997)  %hour(1999)  %hour(2001)
%hour(2003)  %hour(2005)

%macro hour(year);
proc freq data = labor&year;
tables wifeextra&year. wifesalaried&year;
run;
%mend;
%hour(1976)  %hour(1985)  %hour(1986)  %hour(1987)  %hour(1988)  %hour(1989)  %hour(1990)  %hour(1991) 
%hour(1992)  %hour(1993)  %hour(1994)  %hour(1995)  %hour(1996)  %hour(1997)  %hour(1999)  %hour(2001)
%hour(2003)  %hour(2005)
