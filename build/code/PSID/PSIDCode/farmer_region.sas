data farmer1979;
set psiddata.fam79;
id1979      =      V6302    ;
farmer1979   =      V6678    ;
region1979  =      V6773    ;
mtrate1979  =      V6412    ;
keep id1979 farmer1979 region1979 mtrate1979;

data farmer1980;
set psiddata.fam80;
id1980      =      V6902    ;
farmer1980   =      V7275    ;
region1980  =      V7419    ;
mtrate1980  =      V7400    ;
keep id1980 farmer1980 region1980 mtrate1980;

data farmer1981;
set psiddata.fam81;
id1981      =      V7502    ;
farmer1981   =      V7967    ;
region1981  =      V8071    ;
mtrate1981  =      V8053    ;
keep id1981 farmer1981 region1981 mtrate1981;

data farmer1982;
set psiddata.fam82;
id1982      =      V8202    ;
farmer1982   =      V8606    ;
region1982  =      V8695    ;
mtrate1982  =      V8677    ;
keep id1982 farmer1982 region1982 mtrate1982;

data farmer1983;
set psiddata.fam83;
id1983      =      V8802    ;
farmer1983   =      V9286    ;
region1983  =      V9381    ;
mtrate1983  =      V9363    ;
keep id1983 farmer1983 region1983 mtrate1983;

data farmer1984;
set psiddata.fam84;
id1984      =      V10002   ;
farmer1984   =      V10870   ;
region1984  =      V11028   ;
mtrate1984  =      V11010    ;
keep id1984 farmer1984 region1984 mtrate1984;
proc freq;
tables farmer1984;
run;

data farmer1985;
set psiddata.fam85;
id1985      =      V11102   ;
farmer1985   =      V11886   ;
region1985  =      V12379   ;
mtrate1985  =      V12539    ;
keep id1985 farmer1985 region1985 mtrate1985;
proc freq;
tables farmer1985;
run;

data farmer1986;
set psiddata.fam86;
id1986      =      V12502   ;
farmer1986   =      V13397   ;
region1986  =      V13631   ;
mtrate1986  =      V13611    ;
keep id1986 farmer1986 region1986 mtrate1986;

data farmer1987;
set psiddata.fam87;
id1987      =      V13702   ;
farmer1987   =      V14494   ;
region1987  =      V14678   ;
mtrate1987  =      V14658    ;
keep id1987 farmer1987 region1987 mtrate1987;

data farmer1988;
set psiddata.fam88;
id1988      =      V14802   ;
farmer1988   =      V15762   ;
region1988  =      V16152   ;
mtrate1988  =      V16132    ;
keep id1988 farmer1988 region1988 mtrate1988;

data farmer1989;
set psiddata.fam89;
id1989      =      V16302   ;
farmer1989   =      V17297   ;
region1989  =      V17538   ;
mtrate1989  =      V17529    ;
keep id1989 farmer1989 region1989 mtrate1989;

data farmer1990;
set psiddata.fam90;
id1990      =      V17702   ;
farmer1990   =      V18701   ;
region1990  =      V18889   ;
mtrate1990  =      V18863    ;
keep id1990 farmer1990 region1990 mtrate1990;

data farmer1991;
set psiddata.fam91;
id1991      =      V19002   ;
farmer1991   =      V20001   ;
region1991  =      V20189   ;
mtrate1991  =      V20163    ;
keep id1991 farmer1991 region1991 mtrate1991;

data farmer1992;
set psiddata.fam92;
id1992      =      V20302   ;
farmer1992   =      V21301   ;
region1992  =      V21495   ;
keep id1992 farmer1992 region1992;

data farmer1993;
set psiddata.fam93;
id1993      =      V21602   ;
farmer1993   =      V23160   ;
region1993  =      V23327   ;
keep id1993 farmer1993 region1993;
proc freq;
tables farmer1993;
run;

data farmer1994;
set psiddata.fam94;
id1994      =      ER2002   ;
farmer1994   =      ER3092 ;
if id1994 ne .;
keep id1994 farmer1994 region1994;
proc freq;
tables farmer1994;
run;

data farmer1995;
set psiddata.fam95;
id1995      =      ER5002   ;
farmer1995   =    ER6092;
if id1995 ne .;
keep id1995 farmer1995 region1995;
run;
data farmer1996;
set psiddata.fam96;
id1996      =      ER7002   ;
farmer1996   =     ER8189 ;
if id1996 ne .;
keep id1996 farmer1996 region1996; 

data farmer1997;
set psiddata.fam97;
id1997      =      ER10002  ;
farmer1997   =      ER11084  ;
keep id1997 farmer1997 region1997 ;

data farmer1999;
set psiddata.fam99;
id1999      =      ER13002  ;
farmer1999   =      ER14345  ;
region1999  =      ER16430  ;
keep id1999 farmer1999 region1999;

data farmer2001;
set psiddata.fam01;
id2001      =      ER17002  ;
farmer2001   =      ER18484  ;
region2001  =      ER20376  ;
keep id2001 farmer2001 region2001;

data farmer2003;
set psiddata.fam03;
id2003      =      ER21002  ;
farmer2003   =      ER21852  ;
region2003  =      ER24143  ;
keep id2003 farmer2003 region2003;

data farmer2005;
set psiddata.fam05;
id2005      =      ER25002  ;
farmer2005   =      ER25833  ;
region2005  =      ER28042  ;
keep id2005 farmer2005 region2005;

data farmer2007;
set psiddata.fam07;
id2007      =      ER36002  ;
farmer2007   =      ER36851  ;
region2007  =      ER41032  ;
keep id2007 farmer2007 region2007;

data farmer2009;
set psiddata.fam09;
id2009      =      ER42002  ;
farmer2009   =      ER42842  ;
region2009  =      ER46974  ;
keep id2009 farmer2009 region2009;

data psiddata.farmer;
merge farmer1979 farmer1980 farmer1981 farmer1982 farmer1983 farmer1984 farmer1985 farmer1986 farmer1987 
      farmer1988 farmer1989 farmer1990 farmer1991 farmer1992 farmer1993 farmer1994 farmer1995 farmer1996 farmer1997 
      farmer1999 farmer2001 farmer2003 farmer2005 farmer2007 farmer2009;

proc freq data = psiddata.farmer;
tables farmer1979-farmer1997 farmer1999 farmer2001 farmer2003 farmer2005 farmer2007 farmer2009;
run;
