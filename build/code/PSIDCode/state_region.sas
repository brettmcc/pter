data state1968;
set psiddata.fam68;
id1968      =      V3       ;
state1968   =      V93      ;
region1968  =      V361     ;
keep id1968 state1968 region1968;

data state1969;
set psiddata.fam69;
id1969      =      V442     ;
state1969   =      V537     ;
region1969  =      V876     ;
keep id1969 state1969 region1969;

data state1970;
set psiddata.fam70;
id1970      =      V1102    ;
state1970   =      V1103    ;
region1970  =      V1572    ;
keep id1970 state1970 region1970;

data state1971;
set psiddata.fam71;
id1971      =      V1802    ;
state1971   =      V1803    ;
region1971  =      V2284    ;
keep id1971 state1971 region1971;

data state1972;
set psiddata.fam72;
id1972      =      V2402    ;
state1972   =      V2403    ;
region1972  =      V2911    ;
keep id1972 state1972 region1972;

data state1973;
set psiddata.fam73;
id1973      =      V3002    ;
state1973   =      V3003    ;
region1973  =      V3279    ;
keep id1973 state1973 region1973;

data state1974;
set psiddata.fam74;
id1974      =      V3402    ;
state1974   =      V3403    ;
region1974  =      V3699    ;
keep id1974 state1974 region1974;

data state1975;
set psiddata.fam75;
id1975      =      V3802    ;
state1975   =      V3803    ;
region1975  =      V4178    ;
keep id1975 state1975 region1975;

data state1976;
set psiddata.fam76;
id1976      =      V4302    ;
state1976   =      V4303    ;
region1976  =      V5054    ;
mtrate1976  =      V4391    ;
keep id1976 state1976 region1976 mtrate1976;

data state1977;
set psiddata.fam77;
id1977      =      V5202    ;
state1977   =      V5203    ;
region1977  =      V5633    ;
mtrate1977  =      V5302    ;
keep id1977 state1977 region1977 mtrate1977;

data state1978;
set psiddata.fam78;
id1978      =      V5702    ;
state1978   =      V5703    ;
region1978  =      V6180    ;
mtrate1978  =      V5801    ;
keep id1978 state1978 region1978 mtrate1978;

data state1979;
set psiddata.fam79;
id1979      =      V6302    ;
state1979   =      V6303    ;
region1979  =      V6773    ;
mtrate1979  =      V6412    ;
keep id1979 state1979 region1979 mtrate1979;

data state1980;
set psiddata.fam80;
id1980      =      V6902    ;
state1980   =      V6903    ;
region1980  =      V7419    ;
mtrate1980  =      V7400    ;
keep id1980 state1980 region1980 mtrate1980;

data state1981;
set psiddata.fam81;
id1981      =      V7502    ;
state1981   =      V7503    ;
region1981  =      V8071    ;
mtrate1981  =      V8053    ;
keep id1981 state1981 region1981 mtrate1981;

data state1982;
set psiddata.fam82;
id1982      =      V8202    ;
state1982   =      V8203    ;
region1982  =      V8695    ;
mtrate1982  =      V8677    ;
keep id1982 state1982 region1982 mtrate1982;

data state1983;
set psiddata.fam83;
id1983      =      V8802    ;
state1983   =      V8803    ;
region1983  =      V9381    ;
mtrate1983  =      V9363    ;
keep id1983 state1983 region1983 mtrate1983;

data state1984;
set psiddata.fam84;
id1984      =      V10002   ;
state1984   =      V10003   ;
region1984  =      V11028   ;
mtrate1984  =      V11010    ;
keep id1984 state1984 region1984 mtrate1984;
proc freq;
tables state1984;
run;

data state1985;
set psiddata.fam85;
id1985      =      V11102   ;
state1985   =      V12380   ;
region1985  =      V12379   ;
mtrate1985  =      V12539    ;
keep id1985 state1985 region1985 mtrate1985;
proc freq;
tables state1985;
run;

data state1986;
set psiddata.fam86;
id1986      =      V12502   ;
state1986   =      V13632   ;
region1986  =      V13631   ;
mtrate1986  =      V13611    ;
keep id1986 state1986 region1986 mtrate1986;

data state1987;
set psiddata.fam87;
id1987      =      V13702   ;
state1987   =      V14679   ;
region1987  =      V14678   ;
mtrate1987  =      V14658    ;
keep id1987 state1987 region1987 mtrate1987;

data state1988;
set psiddata.fam88;
id1988      =      V14802   ;
state1988   =      V16153   ;
region1988  =      V16152   ;
mtrate1988  =      V16132    ;
keep id1988 state1988 region1988 mtrate1988;

data state1989;
set psiddata.fam89;
id1989      =      V16302   ;
state1989   =      V17539   ;
region1989  =      V17538   ;
mtrate1989  =      V17529    ;
keep id1989 state1989 region1989 mtrate1989;

data state1990;
set psiddata.fam90;
id1990      =      V17702   ;
state1990   =      V18890   ;
region1990  =      V18889   ;
mtrate1990  =      V18863    ;
keep id1990 state1990 region1990 mtrate1990;

data state1991;
set psiddata.fam91;
id1991      =      V19002   ;
state1991   =      V20190   ;
region1991  =      V20189   ;
mtrate1991  =      V20163    ;
keep id1991 state1991 region1991 mtrate1991;

data state1992;
set psiddata.fam92;
id1992      =      V20302   ;
state1992   =      V21496   ;
region1992  =      V21495   ;
keep id1992 state1992 region1992;

data state1993;
set psiddata.fam93;
id1993      =      V21602   ;
state1993   =      V23328   ;
region1993  =      V23327   ;
keep id1993 state1993 region1993;
proc freq;
tables state1993;
run;

data state1994;
set psiddata.income9401;
id1994      =      ER2002   ;
state1994   =      FIPS94ST ;
if id1994 ne .;
if state1994 in(9, 23, 25, 33, 34, 36, 42, 44, 50) then region1994 = 1;
else if state1994 in(17, 18, 19, 20, 26, 27, 29, 31, 38, 39, 46, 55) then region1994 = 2;
else if state1994 in(1, 5, 10, 12, 13, 21, 22, 24, 28, 37, 40, 45, 47, 48, 51, 53, 54) then region1994 = 3;
else region1994 = 4;
keep id1994 state1994 region1994;
proc freq;
tables state1994;
run;

data state1995;
set psiddata.income9401;
id1995      =      ER5002   ;
state1995   =      FIPS95ST ;
if id1995 ne .;
if state1995 in(9, 23, 25, 33, 34, 36, 42, 44, 50) then region1995 = 1;
else if state1995 in(17, 18, 19, 20, 26, 27, 29, 31, 38, 39, 46, 55) then region1995 = 2;
else if state1995 in(1, 5, 10, 12, 13, 21, 22, 24, 28, 37, 40, 45, 47, 48, 51, 53, 54) then region1995 = 3;
else region1995 = 4;
keep id1995 state1995 region1995;
run;
data state1996;
set psiddata.income9401;
id1996      =      ER7002   ;
state1996   =      FIPS96ST ;
if id1996 ne .;
if state1996 in(9, 23, 25, 33, 34, 36, 42, 44, 50) then region1996 = 1;
else if state1996 in(17, 18, 19, 20, 26, 27, 29, 31, 38, 39, 46, 55) then region1996 = 2;
else if state1996 in(1, 5, 10, 12, 13, 21, 22, 24, 28, 37, 40, 45, 47, 48, 51, 53, 54) then region1996 = 3;
else region1996 = 4;
keep id1996 state1996 region1996; 

data state1997;
set psiddata.fam97;
id1997      =      ER10002  ;
state1997   =      ER10004  ;
if state1997 in(9, 23, 25, 33, 34, 36, 42, 44, 50) then region1997 = 1;
else if state1997 in(17, 18, 19, 20, 26, 27, 29, 31, 38, 39, 46, 55) then region1997 = 2;
else if state1997 in(1, 5, 10, 12, 13, 21, 22, 24, 28, 37, 40, 45, 47, 48, 51, 53, 54) then region1997 = 3;
else region1997 = 4;
keep id1997 state1997 region1997 ;

data state1999;
set psiddata.fam99;
id1999      =      ER13002  ;
state1999   =      ER13005  ;
region1999  =      ER16430  ;
keep id1999 state1999 region1999;

data state2001;
set psiddata.fam01;
id2001      =      ER17002  ;
state2001   =      ER17005  ;
region2001  =      ER20376  ;
keep id2001 state2001 region2001;

data state2003;
set psiddata.fam03;
id2003      =      ER21002  ;
state2003   =      ER21004  ;
region2003  =      ER24143  ;
keep id2003 state2003 region2003;

data state2005;
set psiddata.fam05;
id2005      =      ER25002  ;
state2005   =      ER25004  ;
region2005  =      ER28042  ;
keep id2005 state2005 region2005;

data state2007;
set psiddata.fam07;
id2007      =      ER36002  ;
state2007   =      ER36004  ;
region2007  =      ER41032  ;
keep id2007 state2007 region2007;

data state2009;
set psiddata.fam09;
id2009      =      ER42002  ;
state2009   =      ER42004  ;
region2009  =      ER46974  ;
keep id2009 state2009 region2009;

data psiddata.state;
merge state1968 state1969 state1970 state1971 state1972 state1973 state1974 state1975 state1976 state1977 
      state1978 state1979 state1980 state1981 state1982 state1983 state1984 state1985 state1986 state1987 
      state1988 state1989 state1990 state1991 state1992 state1993 state1994 state1995 state1996 state1997 
      state1999 state2001 state2003 state2005 state2007 state2009;
array state[17] state1968 - state1984;
do i = 1 to 17;
    if state[i] = 1           then state[i] =     1      ;
    else if state[i] = 50          then state[i] =     2      ;
    else if state[i] = 2           then state[i] =     4      ;
    else if state[i] = 3           then state[i] =     5      ;
    else if state[i] = 4           then state[i] =     6      ;
    else if state[i] = 5           then state[i] =     8      ;
    else if state[i] = 6           then state[i] =     9      ;
    else if state[i] = 7           then state[i] =     10     ;
    else if state[i] = 8           then state[i] =     11     ;
    else if state[i] = 9           then state[i] =     12     ;
    else if state[i] = 10          then state[i] =     13     ;
    else if state[i] = 51          then state[i] =     15     ;
    else if state[i] = 11          then state[i] =     16     ;
    else if state[i] = 12          then state[i] =     17     ;
    else if state[i] = 13          then state[i] =     18     ;
    else if state[i] = 14          then state[i] =     19     ;
    else if state[i] = 15          then state[i] =     20     ;
    else if state[i] = 16          then state[i] =     21     ;
    else if state[i] = 17          then state[i] =     22     ;
    else if state[i] = 18          then state[i] =     23     ;
    else if state[i] = 19          then state[i] =     24     ;
    else if state[i] = 20          then state[i] =     25     ;
    else if state[i] = 21          then state[i] =     26     ;
    else if state[i] = 22          then state[i] =     27     ;
    else if state[i] = 23          then state[i] =     28     ;
    else if state[i] = 24          then state[i] =     29     ;
    else if state[i] = 25          then state[i] =     30     ;
    else if state[i] = 26          then state[i] =     31     ;
    else if state[i] = 27          then state[i] =     32     ;
    else if state[i] = 28          then state[i] =     33     ;
    else if state[i] = 29          then state[i] =     34     ;
    else if state[i] = 30          then state[i] =     35     ;
    else if state[i] = 31          then state[i] =     36     ;
    else if state[i] = 32          then state[i] =     37     ;
    else if state[i] = 33          then state[i] =     38     ;
    else if state[i] = 34          then state[i] =     39     ;
    else if state[i] = 35          then state[i] =     40     ;
    else if state[i] = 36          then state[i] =     41     ;
    else if state[i] = 37          then state[i] =     42     ;
    else if state[i] = 38          then state[i] =     44     ;
    else if state[i] = 39          then state[i] =     45     ;
    else if state[i] = 40          then state[i] =     46     ;
    else if state[i] = 41          then state[i] =     47     ;
    else if state[i] = 42          then state[i] =     48     ;
    else if state[i] = 43          then state[i] =     49     ;
    else if state[i] = 44          then state[i] =     50     ;
    else if state[i] = 45          then state[i] =     51     ;
    else if state[i] = 46          then state[i] =     53     ;
    else if state[i] = 47          then state[i] =     54     ;
    else if state[i] = 48          then state[i] =     55     ;
    else if state[i] = 49          then state[i] =     56     ;
end;

run;
