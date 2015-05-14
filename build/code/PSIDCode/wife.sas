***********************************************************************************************************************
***********************************************************************************************************************
***********************************************PSID wife INFORMATION***************************************************
***********************************************************************************************************************
***********************************************************************************************************************
***********************************************************************************************************************
**********************************************************************************************************************;


***Include wife AGE, RACE, EDUCATION, Whether Self-Employed and Occupation;

data wifeinfor1968;
set psiddata.fam68; 
id1968                        =                  V3                 ; 
wifeage1968                   =                  V118               ;      
wifeedu1968                   =                  V246               ;      
wifeoccupation1968            =                  V243               ;        
keep id1968 wifeage1968 wifeedu1968;

data wifeinfor1969;
set psiddata.fam69;
id1969                        =                  V442               ;  
wifeage1969                   =                  V1011              ;      
wifeoccupation1969            =                  V609               ;        
keep id1969 wifeage1969;

data wifeinfor1970;
set psiddata.fam70;
id1970                        =                  V1102              ; 
wifeage1970                   =                  V1241              ;      
wifeoccupation1970            =                  V1367               ;        
keep id1970 wifeage1970;

data wifeinfor1971;
set psiddata.fam71;
id1971                        =                  V1802              ; 
wifeage1971                   =                  V1944              ;      
wifeoccupation1971            =                  V2074              ;        
keep id1971 wifeage1971;

data wifeinfor1972;
set psiddata.fam72;
id1972                        =                  V2402              ; 
wifeedu1972                   =                  V2687              ;      
wifeage1972                   =                  V2544              ;      
wifeoccupation1972            =                  V2672              ;        
keep id1972 wifeage1972 wifeedu1972;

data wifeinfor1973;
set psiddata.fam73;
id1973                        =                  V3002              ; 
wifeedu1973                   =                  V3216              ;      
wifeage1973                   =                  V3097              ;      
wifeoccupation1973            =                  V3183              ;        
keep id1973 wifeage1973 wifeedu1973;

data wifeinfor1974;
set psiddata.fam74;
id1974                        =                  V3402              ; 
wifeedu1974                   =                  V3638              ;      
wifeage1974                   =                  V3510              ;      
wifeoccupation1974            =                  V3601              ;        
keep id1974 wifeage1974 wifeedu1974;

data wifeinfor1975;
set psiddata.fam75;
id1975                        =                  V3802              ; 
wifeedu1975                   =                  V4199              ;      
wifeage1975                   =                  V3923              ;      
wifeoccupation1975            =                  V4055              ;        
keep id1975 wifeage1975 wifeedu1975;

data wifeinfor1976;
set psiddata.fam76;
id1976                        =                  V4302              ; 
wifeedu1976                   =                  V5075              ;      
wifeage1976                   =                  V4438              ;      
wifeoccupation1976            =                  V4962               ;        
keep id1976 wifeage1976 wifeedu1976;

data wifeinfor1977;
set psiddata.fam77;
id1977                        =                  V5202              ; 
wifeedu1977                   =                  V5648              ;      
wifeage1977                   =                  V5352              ;      
wifeoccupation1977            =                  V5507              ;        
keep id1977 wifeage1977 wifeedu1977;

data wifeinfor1978;
set psiddata.fam78;
id1978                        =                  V5702              ; 
wifeedu1978                   =                  V6195              ;      
wifeage1978                   =                  V5852              ;      
wifeoccupation1978            =                  V6039              ;        
keep id1978 wifeage1978 wifeedu1978;


data wifeinfor1979;
set psiddata.fam79;
id1979                        =                  V6302              ; 
wifeage1979                   =                  V6464              ;      
wifeedu1979                   =                  V6788              ;      
wifeselfemploy1979            =                  V6592              ;               
wifeoccupation1979            =                  V6596              ;        
keep id1979 wifeage1979 wifeedu1979 wifeselfemploy1979; 

data wifeinfor1980;
set psiddata.fam80;
id1980                        =                  V6902              ; 
wifeage1980                   =                  V7069              ;      
wifeedu1980                   =                  V7434              ;      
wifeselfemploy1980            =                  V7194              ;               
wifeoccupation1980            =                  V7198              ;        
keep id1980 wifeage1980 wifeedu1980 wifeselfemploy1980; 

%macro indocc(year);
proc sort data = wifeinfor&year;
by id&year;
data indocc&year;
set psiddata.indocc6880;
if id&year ne .;
wifeocc3digit&year = wifeocc&year;
wifeind3digit&year = wifeind&year;
keep id&year wifeind3digit&year wifeocc3digit&year;
proc sort;
by id&year;
data wifeinfor&year;
merge wifeinfor&year indocc&year;
by id&year; 
run;
%mend;
%indocc(1968) %indocc(1969) %indocc(1970) %indocc(1971) %indocc(1972) %indocc(1973) %indocc(1974) %indocc(1975)
%indocc(1976) %indocc(1977) %indocc(1978) %indocc(1979) %indocc(1980)

data wifeinfor1981;
set psiddata.fam81;
id1981                        =                  V7502              ; 
wifeage1981                   =                  V7660              ;      
wifeedu1981                   =                  V8086              ;      
wifeselfemploy1981            =                  V7880              ;               
wifeocc3digit1981             =                  V7885              ;        
wifeind3digit1981             =                  V7886              ;        
keep id1981 wifeage1981 wifeedu1981 wifeselfemploy1981 wifeocc3digit1981 wifeind3digit1981; 

data wifeinfor1982;
set psiddata.fam82;
id1982                        =                  V8202              ; 
wifeage1982                   =                  V8354              ;      
wifeedu1982                   =                  V8710              ;      
wifeselfemploy1982            =                  V8539              ;               
wifeocc3digit1982             =                  V8544              ;        
wifeind3digit1982             =                  V8545              ;        
keep id1982 wifeage1982 wifeedu1982 wifeselfemploy1982 wifeocc3digit1982 wifeind3digit1982; 

data wifeinfor1983;
set psiddata.fam83;
id1983                        =                  V8802              ; 
wifeage1983                   =                  V8963              ;      
wifeedu1983                   =                  V9396              ;      
wifeselfemploy1983            =                  V9189              ;               
wifeocc3digit1983             =                  V9194              ;        
wifeind3digit1983             =                  V9195              ;        
keep id1983 wifeage1983 wifeedu1983 wifeselfemploy1983 wifeocc3digit1983 wifeind3digit1983; 

data wifeinfor1984;
set psiddata.fam84;
id1984                        =                  V10002             ; 
wifeage1984                   =                  V10421             ;      
wifeedu1984                   =                  V11043             ;      
wifeselfemploy1984            =                  V10674             ;               
wifeocc3digit1984             =                  V10678             ;        
wifeind3digit1984             =                  V10679             ;        
keep id1984 wifeage1984 wifeedu1984 wifeselfemploy1984 wifeocc3digit1984 wifeind3digit1984; 

data wifeinfor1985;
set psiddata.fam85;
id1985                        =                  V11102             ; 
wifeage1985                   =                  V11608             ;
wiferace1985                  =                  V12293             ;      
wifeedu1985                   =                  V12401             ;      
wifeselfemploy1985            =                  V12003             ;               
wifeocc3digit1985             =                  V12014             ;        
wifeind3digit1985             =                  V12015             ;        
keep id1985 wifeage1985 wiferace1985 wifeedu1985 wifeselfemploy1985 wifeocc3digit1985 wifeind3digit1985; 

data wifeinfor1986;
set psiddata.fam86;
id1986                        =                  V12502             ; 
wifeage1986                   =                  V13013             ;
wiferace1986                  =                  V13500             ;      
wifeedu1986                   =                  V13641             ;      
wifeselfemploy1986            =                  V13228             ;               
wifeocc3digit1986             =                  V13233             ;        
wifeind3digit1986             =                  V13234             ;        
keep id1986 wifeage1986 wiferace1986 wifeedu1986 wifeselfemploy1986 wifeocc3digit1986 wifeind3digit1986; 

data wifeinfor1987;
set psiddata.fam87;
id1987                        =                  V13702             ; 
wifeage1987                   =                  V14116             ;
wiferace1987                  =                  V14547             ;      
wifeedu1987                   =                  V14688             ;      
wifeselfemploy1987            =                  V14324             ;               
wifeocc3digit1987             =                  V14329             ;        
wifeind3digit1987             =                  V14330             ;        
keep id1987 wifeage1987 wiferace1987 wifeedu1987 wifeselfemploy1987 wifeocc3digit1987 wifeind3digit1987; 

data wifeinfor1988;
set psiddata.fam88;
id1988                        =                  V14802             ; 
wifeage1988                   =                  V15132             ;
wiferace1988                  =                  V16021             ;      
wifeedu1988                   =                  V16162             ;      
wifeselfemploy1988            =                  V15459             ;               
wifeocc3digit1988             =                  V15464             ;        
wifeind3digit1988             =                  V15465             ;        
keep id1988 wifeage1988 wiferace1988 wifeedu1988 wifeselfemploy1988 wifeocc3digit1988 wifeind3digit1988; 

data wifeinfor1989;
set psiddata.fam89;
id1989                        =                  V16302             ; 
wifeage1989                   =                  V16633             ;
wiferace1989                  =                  V17418             ;      
wifeedu1989                   =                  V17546             ;      
wifeselfemploy1989            =                  V16977             ;               
wifeocc3digit1989             =                  V16982             ;        
wifeind3digit1989             =                  V16983             ;        
keep id1989 wifeage1989 wiferace1989 wifeedu1989 wifeselfemploy1989 wifeocc3digit1989 wifeind3digit1989; 

data wifeinfor1990;
set psiddata.fam90;
id1990                        =                  V17702             ; 
wifeage1990                   =                  V18051             ;
wiferace1990                  =                  V18749             ;      
wifeedu1990                   =                  V18899             ;      
wifeselfemploy1990            =                  V18398             ;               
wifeocc3digit1990             =                  V18403             ;        
wifeind3digit1990             =                  V18404             ;        
keep id1990 wifeage1990 wiferace1990 wifeedu1990 wifeselfemploy1990 wifeocc3digit1990 wifeind3digit1990; 

data wifeinfor1991;
set psiddata.fam91;
id1991                        =                  V19002             ; 
wifeage1991                   =                  V19351             ;
wiferace1991                  =                  V20049             ;      
wifeedu1991                   =                  V20199             ;      
wifeselfemploy1991            =                  V19698             ;               
wifeocc3digit1991             =                  V19703             ;        
wifeind3digit1991             =                  V19704             ;        
keep id1991 wifeage1991 wiferace1991 wifeedu1991 wifeselfemploy1991 wifeocc3digit1991 wifeind3digit1991; 

data wifeinfor1992;
set psiddata.fam92;
id1992                        =                  V20302             ; 
wifeage1992                   =                  V20653             ;
wiferace1992                  =                  V21355             ;      
wifeedu1992                   =                  V21505             ;      
wifeselfemploy1992            =                  V20998             ;               
wifeocc3digit1992             =                  V21003             ;        
wifeind3digit1992             =                  V21004             ;        
keep id1992 wifeage1992 wiferace1992 wifeedu1992 wifeselfemploy1992 wifeocc3digit1992 wifeind3digit1992; 

data wifeinfor1993;
set psiddata.fam93;
id1993                        =                  V21602             ; 
wifeage1993                   =                  V22408             ;
wiferace1993                  =                  V23212             ;      
wifeedu1993                   =                  V23334             ;      
wifeselfemploy1993            =                  V22804             ;               
wifeocc3digit1993             =                  V22809             ;        
wifeind3digit1993             =                  V22810             ;        
keep id1993 wifeage1993 wiferace1993 wifeedu1993 wifeselfemploy1993 wifeocc3digit1993 wifeind3digit1993; 

data income9401;
set psiddata.income9401;
id1994                        =                  ER2002             ;  
id1995                        =                  ER5002             ;  
id1996                        =                  ER7002             ;  
id1997                        =                  ER10002            ;  
id1999                        =                  ER13002            ;  
id2001                        =                  ER17002            ;  
run;


data wifeinfor1994;
set psiddata.fam94;
id1994                        =                  ER2002             ;  
wifeage1994                   =                  ER2009             ;      
wifeselfemploy1994            =                  ER2639             ;               
keep id1994 wifeage1994 wifeselfemploy1994; 
proc sort data = psiddata.racedu9401;
by id1994;
proc sort data = income9401;
by id1994;
by id1994;data wifeinfor1994;
merge wifeinfor1994(in = in1) psiddata.racedu9401 income9401;
by id1994;
if in1;
wifeedu1994 = UPEDU94W;
wiferace1994 = UPR94WM1;
wifeocc3digit1994 = wfocc94;
wifeind3digit1994 = wfind94;
keep id1994 wifeage1994 wiferace1994 wifeedu1994 wifeselfemploy1994 wifeocc3digit1994 wifeind3digit1994; 

data wifeinfor1995;
set psiddata.fam95;
id1995                        =                  ER5002             ;  
wifeage1995                   =                  ER5008             ;      
wifeselfemploy1995            =                  ER5638             ;               
keep id1995 wifeage1995 wifeselfemploy1995; 
proc sort data = psiddata.racedu9401;
by id1995;
proc sort data = income9401;
by id1995;
data wifeinfor1995;
merge wifeinfor1995(in = in1) psiddata.racedu9401 income9401;
by id1995;
if in1;
wifeedu1995 = UPEDU95W;
wiferace1995 = UPR95WM1;
wifeocc3digit1995 = wfocc95;
wifeind3digit1995 = wfind95;
keep id1995 wifeage1995 wiferace1995 wifeedu1995 wifeselfemploy1995 wifeocc3digit1995 wifeind3digit1995; 

data wifeinfor1996;
set psiddata.fam96;
id1996                        =                  ER7002             ;  
wifeage1996                   =                  ER7008             ;      
wifeselfemploy1996            =                  ER7663             ;               
keep id1996 wifeage1996 wifeselfemploy1996; 
proc sort data = psiddata.racedu9401;
by id1996;
proc sort data = income9401;
by id1996;
data wifeinfor1996;
merge wifeinfor1996(in = in1) psiddata.racedu9401 income9401;
by id1996;
if in1;
wifeedu1996 = UPEDU96W;
wiferace1996 = UPR96WM1;
wifeocc3digit1996 = wfocc96;
wifeind3digit1996 = wfind96;
keep id1996 wifeage1996 wiferace1996 wifeedu1996 wifeselfemploy1996 wifeocc3digit1996 wifeind3digit1996; 

data wifeinfor1997;
set psiddata.fam97;
id1997                        =                  ER10002             ;  
wifeage1997                   =                  ER10011             ;      
wiferace1997                  =                  ER11760             ;      
wifeselfemploy1997            =                  ER10568             ;               
keep id1997 wifeage1997 wiferace1997 wifeselfemploy1997; 
proc sort data = psiddata.racedu9401;
by id1997;
proc sort data = income9401;
by id1997;
data wifeinfor1997;
merge wifeinfor1997(in = in1) psiddata.racedu9401 income9401;
by id1997;
if in1;
wifeedu1997 = UPEDU97W;
wifeocc3digit1997 = wfocc97;
wifeind3digit1997 = wfocc97;
keep id1997 wifeage1997 wiferace1997 wifeedu1997 wifeselfemploy1997 wifeocc3digit1997 wifeind3digit1997; 

data wifeinfor1999;
set psiddata.fam99;
id1999                        =                  ER13002            ;  
wifeage1999                   =                  ER13012             ;      
wiferace1999                  =                  ER15836             ;      
wifeselfemploy1999            =                  ER13722             ;               
keep id1999 wifeage1999 wiferace1999 wifeselfemploy1999; 
proc sort data = psiddata.racedu9401;
by id1999;
proc sort data = income9401;
by id1999;
data wifeinfor1999;
merge wifeinfor1999(in = in1) psiddata.racedu9401 income9401;
by id1999;
if in1;
wifeedu1999 = UPEDU99W;
wifeocc3digit1999 = wfocc99;
wifeind3digit1999 = wfind99;
keep id1999 wifeage1999 wiferace1999 wifeedu1999 wifeselfemploy1999 wifeocc3digit1999 wifeind3digit1999; 

data wifeinfor2001;
set psiddata.fam01;
id2001                        =                  ER17002             ;  
wifeage2001                   =                  ER17015             ;      
wiferace2001                  =                  ER19897             ;
wifeselfemploy2001            =                  ER17791             ;               
keep id2001 wifeage2001 wiferace2001 wifeselfemploy2001; 
proc sort data = psiddata.racedu9401;
by id2001;
proc sort data = income9401;
by id2001;
data wifeinfor2001;
merge wifeinfor2001(in = in1) psiddata.racedu9401 income9401;
by id2001;
if in1;
wifeedu2001 = UPEDU01W;
wifeocc3digit2001 = wfocc01;
wifeind3digit2001 = wfind01;
keep id2001 wifeage2001 wiferace2001 wifeedu2001 wifeselfemploy2001 wifeocc3digit2001 wifeind3digit2001; 

data wifeinfor2003;
set psiddata.fam03;
id2003                        =                  ER21002            ; 
wifeage2003                   =                  ER21019            ;      
wiferace2003                  =                  ER23334            ;       
wifeselfemploy2003            =                  ER21397            ;               
wifeedu2003                   =                  ER24149            ;
wifeocc3digit2003             =                  ER21395            ;
wifeind3digit2003             =                  ER21396            ;
keep id2003 wifeage2003 wiferace2003 wifeedu2003 wifeselfemploy2003 wifeocc3digit2003 wifeind3digit2003; 

data wifeinfor2005;
set psiddata.fam05;
id2005                        =                  ER25002            ; 
wifeage2005                   =                  ER25019            ;      
wiferace2005                  =                  ER27297            ;       
wifeselfemploy2005            =                  ER25387            ;               
wifeedu2005                   =                  ER28048            ;
wifeocc3digit2005             =                  ER25385            ;
wifeind3digit2005             =                  ER25386            ;
keep id2005 wifeage2005 wiferace2005 wifeedu2005 wifeselfemploy2005 wifeocc3digit2005 wifeind3digit2005; 

data wifeinfor2007;
set psiddata.fam07;
id2007                        =                  ER36002            ; 
wifeage2007                   =                  ER36019            ;      
wiferace2007                  =                  ER40472            ;       
wifeselfemploy2007            =                  ER36392            ;               
wifeedu2007                   =                  ER41038            ;
wifeocc3digit2007             =                  ER36390            ;
wifeind3digit2007             =                  ER36391            ;
keep id2007 wifeage2007 wiferace2007 wifeedu2007 wifeselfemploy2007 wifeocc3digit2007 wifeind3digit2007; 

data wifeinfor2009;
set psiddata.fam09;
id2009                        =                  ER42002            ; 
wifeage2009                   =                  ER42019            ;      
wiferace2009                  =                  ER46449            ;       
wifeselfemploy2009            =                  ER42421            ;               
wifeedu2009                   =                  ER46982            ;
wifeocc3digit2009             =                  ER42419            ;
wifeind3digit2009             =                  ER42420            ;
keep id2009 wifeage2009 wiferace2009 wifeedu2009 wifeselfemploy2009 wifeocc3digit2009 wifeind3digit2009; 

run;
                                                             

data PSIDDATA.wife;
merge wifeinfor1968 wifeinfor1969 wifeinfor1970 wifeinfor1971 wifeinfor1972 wifeinfor1973 wifeinfor1974 wifeinfor1975 
      wifeinfor1976 wifeinfor1977 wifeinfor1978 wifeinfor1979 wifeinfor1980 wifeinfor1981 wifeinfor1982 wifeinfor1983 
      wifeinfor1984 wifeinfor1985 wifeinfor1986 wifeinfor1987 wifeinfor1988 wifeinfor1989 wifeinfor1990 wifeinfor1991 
      wifeinfor1992 wifeinfor1993 wifeinfor1994 wifeinfor1995 wifeinfor1996 wifeinfor1997 wifeinfor1999 wifeinfor2001 
      wifeinfor2003 wifeinfor2005 wifeinfor2007 wifeinfor2009; 
if     wifeage1968      > 96 then wifeage1968    =.   ;
if     wifeage1969      > 96 then wifeage1969    =.   ;
if     wifeage1970      > 96 then wifeage1970    =.   ;
if     wifeage1971      > 96 then wifeage1971    =.   ;
if     wifeage1972      > 96 then wifeage1972    =.   ;
if     wifeage1973      > 96 then wifeage1973    =.   ;
if     wifeage1974      > 96 then wifeage1974    =.   ;
if     wifeage1975      > 96 then wifeage1975    =.   ;
if     wifeage1976      > 96 then wifeage1976    =.   ;
if     wifeage1977      > 96 then wifeage1977    =.   ;
if     wifeage1978      > 96 then wifeage1978    =.   ;
if     wifeage1979      > 96 then wifeage1979    =.   ;
if     wifeage1980      > 96 then wifeage1980    =.   ;
if     wifeage1981      > 96 then wifeage1981    =.   ;
if     wifeage1982      > 96 then wifeage1982    =.   ;
if     wifeage1983      > 96 then wifeage1983    =.   ;
if     wifeage1984      > 96 then wifeage1984    =.   ;
if     wifeage1985      > 96 then wifeage1985    =.   ;
if     wifeage1986      > 96 then wifeage1986    =.   ;
if     wifeage1987      > 96 then wifeage1987    =.   ;
if     wifeage1988      > 96 then wifeage1988    =.   ;
if     wifeage1989      > 96 then wifeage1989    =.   ;
if     wifeage1990      > 96 then wifeage1990    =.   ;
if     wifeage1991      > 96 then wifeage1991    =.   ;
if     wifeage1992      > 96 then wifeage1992    =.   ;
if     wifeage1993      > 96 then wifeage1993    =.   ;
if     wifeage1994      > 96 then wifeage1994    =.   ;
if     wifeage1995      > 96 then wifeage1995    =.   ;
if     wifeage1996      > 96 then wifeage1996    =.   ;
if     wifeage1997      > 120 then wifeage1997    =.   ;
if     wifeage1999      > 120 then wifeage1999    =.   ;
if     wifeage2001      > 120 then wifeage2001    =.   ;
if     wifeage2003      > 120 then wifeage2003    =.   ;
if     wifeage2005      > 120 then wifeage2005    =.   ;
if     wifeage2007      > 120 then wifeage2007    =.   ;
if     wifeage2009      > 120 then wifeage2009    =.   ;

if    wiferace1994     >     7       then     wiferace1994         =     .;
if    wiferace1995     >     7       then     wiferace1995         =     .;
if    wiferace1996     >     7       then     wiferace1996         =     .;
if    wiferace1997     >     7       then     wiferace1997         =     .;
if    wiferace1999     >     7       then     wiferace1999         =     .;
if    wiferace2001     >     7       then     wiferace2001         =     .;
if    wiferace2003     >     7       then     wiferace2003         =     .;
if    wiferace2005     >     7       then     wiferace2005         =     .;
if    wiferace2007     >     7       then     wiferace2007         =     .;
if    wiferace2009     >     7       then     wiferace2009         =     .;


if   wifeselfemploy1994     > 7   then wifeselfemploy1994   =   .           ; 
if   wifeselfemploy1995     > 7   then wifeselfemploy1995   =   .           ; 
if   wifeselfemploy1996     > 7   then wifeselfemploy1996   =   .           ; 
if   wifeselfemploy1997     > 7   then wifeselfemploy1997   =   .           ; 
if   wifeselfemploy1999     > 7   then wifeselfemploy1999   =   .           ; 
if   wifeselfemploy2001     > 7   then wifeselfemploy2001   =   .           ; 
if   wifeselfemploy2003     > 7   then wifeselfemploy2003   =   .           ; 
if   wifeselfemploy2005     > 7   then wifeselfemploy2005   =   .           ; 
if   wifeselfemploy2007     > 7   then wifeselfemploy2007   =   .           ; 
if   wifeselfemploy2009     > 7   then wifeselfemploy2009   =   .           ; 

 if wifeedu1968    <    4  and wifeedu1968 > 0  then      school1968  =  1;  
 if wifeedu1969    <    4  and wifeedu1969 > 0  then      school1969  =  1;  
 if wifeedu1970    <    4  and wifeedu1970 > 0  then      school1970  =  1;  
 if wifeedu1971    <    4  and wifeedu1971 > 0  then      school1971  =  1;  
 if wifeedu1972    <    4  and wifeedu1972 > 0  then      school1972  =  1;  
 if wifeedu1973    <    4  and wifeedu1973 > 0  then      school1973  =  1;  
 if wifeedu1974    <    4  and wifeedu1974 > 0  then      school1974  =  1;  
 if wifeedu1976    <    4  and wifeedu1976 > 0  then      school1976  =  1;  
 if wifeedu1979    <    4  and wifeedu1979 > 0  then      school1979  =  1;  
 if wifeedu1980    <    4  and wifeedu1980 > 0  then      school1980  =  1;  
 if wifeedu1981    <    4  and wifeedu1981 > 0  then      school1981  =  1;  
 if wifeedu1982    <    4  and wifeedu1982 > 0  then      school1982  =  1;  
 if wifeedu1983    <    4  and wifeedu1983 > 0  then      school1983  =  1;  
 if wifeedu1984    <    4  and wifeedu1984 > 0  then      school1984  =  1;  
 if wifeedu1985    <    4  and wifeedu1985 > 0  then      school1985  =  1;  
 if wifeedu1986    <    4  and wifeedu1986 > 0  then      school1986  =  1;  
 if wifeedu1987    <    4  and wifeedu1987 > 0  then      school1987  =  1;  
 if wifeedu1988    <    4  and wifeedu1988 > 0  then      school1988  =  1;  
 if wifeedu1989    <    4  and wifeedu1989 > 0  then      school1989  =  1;  
 if wifeedu1990    <    4  and wifeedu1990 > 0  then      school1990  =  1;  

if wifeedu1968    =    4    then      school1968  =  2;                        
if wifeedu1969    =    4    then      school1969  =  2;                        
if wifeedu1970    =    4    then      school1970  =  2;                        
if wifeedu1971    =    4    then      school1971  =  2;                        
if wifeedu1972    =    4    then      school1972  =  2;                        
if wifeedu1973    =    4    then      school1973  =  2;                        
if wifeedu1974    =    4    then      school1974  =  2;                        
if wifeedu1976    =    4    then      school1976  =  2;                        
if wifeedu1979    =    4    then      school1979  =  2;                        
if wifeedu1980    =    4    then      school1980  =  2;                        
if wifeedu1981    =    4    then      school1981  =  2;                        
if wifeedu1982    =    4    then      school1982  =  2;                        
if wifeedu1983    =    4    then      school1983  =  2;                        
if wifeedu1984    =    4    then      school1984  =  2;                        
if wifeedu1985    =    4    then      school1985  =  2;                        
if wifeedu1986    =    4    then      school1986  =  2;                        
if wifeedu1987    =    4    then      school1987  =  2;                        
if wifeedu1988    =    4    then      school1988  =  2;                        
if wifeedu1989    =    4    then      school1989  =  2;                        
if wifeedu1990    =    4    then      school1990  =  2;                        

if wifeedu1968    = 5 or  wifeedu1968    = 6 then      school1968  =  3;       
if wifeedu1969    = 5 or  wifeedu1969    = 6 then      school1969  =  3;       
if wifeedu1970    = 5 or  wifeedu1970    = 6 then      school1970  =  3;       
if wifeedu1971    = 5 or  wifeedu1971    = 6 then      school1971  =  3;       
if wifeedu1972    = 5 or  wifeedu1972    = 6 then      school1972  =  3;       
if wifeedu1973    = 5 or  wifeedu1973    = 6 then      school1973  =  3;       
if wifeedu1974    = 5 or  wifeedu1974    = 6 then      school1974  =  3;       
if wifeedu1976    = 5 or  wifeedu1976    = 6 then      school1976  =  3;       
if wifeedu1979    = 5 or  wifeedu1979    = 6 then      school1979  =  3;       
if wifeedu1980    = 5 or  wifeedu1980    = 6 then      school1980  =  3;       
if wifeedu1981    = 5 or  wifeedu1981    = 6 then      school1981  =  3;       
if wifeedu1982    = 5 or  wifeedu1982    = 6 then      school1982  =  3;       
if wifeedu1983    = 5 or  wifeedu1983    = 6 then      school1983  =  3;       
if wifeedu1984    = 5 or  wifeedu1984    = 6 then      school1984  =  3;       
if wifeedu1985    = 5 or  wifeedu1985    = 6 then      school1985  =  3;       
if wifeedu1986    = 5 or  wifeedu1986    = 6 then      school1986  =  3;       
if wifeedu1987    = 5 or  wifeedu1987    = 6 then      school1987  =  3;       
if wifeedu1988    = 5 or  wifeedu1988    = 6 then      school1988  =  3;       
if wifeedu1989    = 5 or  wifeedu1989    = 6 then      school1989  =  3;       
if wifeedu1990    = 5 or  wifeedu1990    = 6 then      school1990  =  3;       

if wifeedu1968    = 7 or  wifeedu1968    = 8 then      school1968  =  4;       
if wifeedu1969    = 7 or  wifeedu1969    = 8 then      school1969  =  4;       
if wifeedu1970    = 7 or  wifeedu1970    = 8 then      school1970  =  4;       
if wifeedu1971    = 7 or  wifeedu1971    = 8 then      school1971  =  4;       
if wifeedu1972    = 7 or  wifeedu1972    = 8 then      school1972  =  4;       
if wifeedu1973    = 7 or  wifeedu1973    = 8 then      school1973  =  4;       
if wifeedu1974    = 7 or  wifeedu1974    = 8 then      school1974  =  4;       
if wifeedu1976    = 7 or  wifeedu1976    = 8 then      school1976  =  4;       
if wifeedu1979    = 7 or  wifeedu1979    = 8 then      school1979  =  4;       
if wifeedu1980    = 7 or  wifeedu1980    = 8 then      school1980  =  4;       
if wifeedu1981    = 7 or  wifeedu1981    = 8 then      school1981  =  4;       
if wifeedu1982    = 7 or  wifeedu1982    = 8 then      school1982  =  4;       
if wifeedu1983    = 7 or  wifeedu1983    = 8 then      school1983  =  4;       
if wifeedu1984    = 7 or  wifeedu1984    = 8 then      school1984  =  4;       
if wifeedu1985    = 7 or  wifeedu1985    = 8 then      school1985  =  4;       
if wifeedu1986    = 7 or  wifeedu1986    = 8 then      school1986  =  4;       
if wifeedu1987    = 7 or  wifeedu1987    = 8 then      school1987  =  4;       
if wifeedu1988    = 7 or  wifeedu1988    = 8 then      school1988  =  4;       
if wifeedu1989    = 7 or  wifeedu1989    = 8 then      school1989  =  4;       
if wifeedu1990    = 7 or  wifeedu1990    = 8 then      school1990  =  4;       

if wifeedu1968    = 9   then    school1968    =   .;                           
if wifeedu1969    = 9   then    school1969    =   .;                           
if wifeedu1970    = 9   then    school1970    =   .;                           
if wifeedu1971    = 9   then    school1971    =   .;                           
if wifeedu1972    = 9   then    school1972    =   .;                           
if wifeedu1973    = 9   then    school1973    =   .;                           
if wifeedu1974    = 9   then    school1974    =   .;                           
if wifeedu1976    = 9   then    school1976    =   .;                           
if wifeedu1979    = 9   then    school1979    =   .;                           
if wifeedu1980    = 9   then    school1980    =   .;                           
if wifeedu1981    = 9   then    school1981    =   .;                           
if wifeedu1982    = 9   then    school1982    =   .;                           
if wifeedu1983    = 9   then    school1983    =   .;                           
if wifeedu1984    = 9   then    school1984    =   .;                           
if wifeedu1985    = 9   then    school1985    =   .;                           
if wifeedu1986    = 9   then    school1986    =   .;                           
if wifeedu1987    = 9   then    school1987    =   .;                           
if wifeedu1988    = 9   then    school1988    =   .;                           
if wifeedu1989    = 9   then    school1989    =   .;                           
if wifeedu1990    = 9   then    school1990    =   .;                           
                                                                               
                                                                               
if  wifeedu1975   = 99  then wifeedu1975   = .;                                 
if  wifeedu1977   = 99  then wifeedu1977   = .;                                 
if  wifeedu1978   = 99  then wifeedu1978   = .;                                 
if  wifeedu1991   = 99  then wifeedu1991   = .;                                 
if  wifeedu1992   = 99  then wifeedu1992   = .;                                 
if  wifeedu1993   = 99  then wifeedu1993   = .;                                 
if  wifeedu1994   = 99  then wifeedu1994   = .;                                 
if  wifeedu1995   = 99  then wifeedu1995   = .;                                 
if  wifeedu1996   = 99  then wifeedu1996   = .;                                 
if  wifeedu1997   = 99  then wifeedu1997   = .;                                 
if  wifeedu1999   = 99  then wifeedu1999   = .;                                 
if  wifeedu2001   = 99  then wifeedu2001   = .;                                 
if  wifeedu2003   = 99  then wifeedu2003   = .;                                 
if  wifeedu2005   = 99  then wifeedu2005   = .;                                 
if  wifeedu2007   = 99  then wifeedu2007   = .;                                 
if  wifeedu2009   = 99  then wifeedu2009   = .;                                 

if  wifeedu1975    < 12  and  wifeedu1975 > 0 then school1975   = 1;
if  wifeedu1977    < 12  and  wifeedu1977 > 0 then school1977   = 1;
if  wifeedu1978    < 12  and  wifeedu1978 > 0 then school1978   = 1;
if  wifeedu1991    < 12  and  wifeedu1991 > 0 then school1991   = 1;
if  wifeedu1992    < 12  and  wifeedu1992 > 0 then school1992   = 1;
if  wifeedu1993    < 12  and  wifeedu1993 > 0 then school1993   = 1;
if  wifeedu1994    < 12  and  wifeedu1994 > 0 then school1994   = 1;
if  wifeedu1995    < 12  and  wifeedu1995 > 0 then school1995   = 1;
if  wifeedu1996    < 12  and  wifeedu1996 > 0 then school1996   = 1;
if  wifeedu1997    < 12  and  wifeedu1997 > 0 then school1997   = 1;
if  wifeedu1999    < 12  and  wifeedu1999 > 0 then school1999   = 1;
if  wifeedu2001    < 12  and  wifeedu2001 > 0 then school2001   = 1;
if  wifeedu2003    < 12  and  wifeedu2003 > 0 then school2003   = 1;
if  wifeedu2005    < 12  and  wifeedu2005 > 0 then school2005   = 1;
if  wifeedu2007    < 12  and  wifeedu2007 > 0 then school2007   = 1;
if  wifeedu2009    < 12  and  wifeedu2009 > 0 then school2009   = 1;

if  wifeedu1975    = 12 then school1975   = 2;                                 
if  wifeedu1977    = 12 then school1977   = 2;                                 
if  wifeedu1978    = 12 then school1978   = 2;                                 
if  wifeedu1991    = 12 then school1991   = 2;                                 
if  wifeedu1992    = 12 then school1992   = 2;                                 
if  wifeedu1993    = 12 then school1993   = 2;                                 
if  wifeedu1994    = 12 then school1994   = 2;                                 
if  wifeedu1995    = 12 then school1995   = 2;                                 
if  wifeedu1996    = 12 then school1996   = 2;                                 
if  wifeedu1997    = 12 then school1997   = 2;                                 
if  wifeedu1999    = 12 then school1999   = 2;                                 
if  wifeedu2001    = 12 then school2001   = 2;                                 
if  wifeedu2003    = 12 then school2003   = 2;                                 
if  wifeedu2005    = 12 then school2005   = 2;                                 
if  wifeedu2007    = 12 then school2007   = 2;                                 
if  wifeedu2009    = 12 then school2009   = 2;                                 
                                                                               
if  wifeedu1975    > 12 and wifeedu1975  < 16  then school1975   = 3;          
if  wifeedu1977    > 12 and wifeedu1977  < 16  then school1977   = 3;          
if  wifeedu1978    > 12 and wifeedu1978  < 16  then school1978   = 3;          
if  wifeedu1991    > 12 and wifeedu1991  < 16  then school1991   = 3;          
if  wifeedu1992    > 12 and wifeedu1992  < 16  then school1992   = 3;          
if  wifeedu1993    > 12 and wifeedu1993  < 16  then school1993   = 3;          
if  wifeedu1994    > 12 and wifeedu1994  < 16  then school1994   = 3;          
if  wifeedu1995    > 12 and wifeedu1995  < 16  then school1995   = 3;          
if  wifeedu1996    > 12 and wifeedu1996  < 16  then school1996   = 3;          
if  wifeedu1997    > 12 and wifeedu1997  < 16  then school1997   = 3;          
if  wifeedu1999    > 12 and wifeedu1999  < 16  then school1999   = 3;          
if  wifeedu2001    > 12 and wifeedu2001  < 16  then school2001   = 3;          
if  wifeedu2003    > 12 and wifeedu2003  < 16  then school2003   = 3;          
if  wifeedu2005    > 12 and wifeedu2005  < 16  then school2005   = 3;          
if  wifeedu2007    > 12 and wifeedu2007  < 16  then school2007   = 3;          
if  wifeedu2009    > 12 and wifeedu2009  < 16  then school2009   = 3;          
                                                                         
if  wifeedu1975    >= 16  then school1975   = 4  ;                              
if  wifeedu1977    >= 16  then school1977   = 4  ;                              
if  wifeedu1978    >= 16  then school1978   = 4  ;                              
if  wifeedu1991    >= 16  then school1991   = 4  ;                              
if  wifeedu1992    >= 16  then school1992   = 4  ;                              
if  wifeedu1993    >= 16  then school1993   = 4  ;                              
if  wifeedu1994    >= 16  then school1994   = 4  ;                              
if  wifeedu1995    >= 16  then school1995   = 4  ;                              
if  wifeedu1996    >= 16  then school1996   = 4  ;                              
if  wifeedu1997    >= 16  then school1997   = 4  ;                              
if  wifeedu1999    >= 16  then school1999   = 4  ;                              
if  wifeedu2001    >= 16  then school2001   = 4  ;                              
if  wifeedu2003    >= 16  then school2003   = 4  ;                              
if  wifeedu2005    >= 16  then school2005   = 4  ;                              
if  wifeedu2007    >= 16  then school2007   = 4  ;                              
if  wifeedu2009    >= 16  then school2009   = 4  ;                              

wifeedu1968   =   school1968; 
wifeedu1969   =   school1969; 
wifeedu1970   =   school1970; 
wifeedu1971   =   school1971; 
wifeedu1972   =   school1972; 
wifeedu1973   =   school1973; 
wifeedu1974   =   school1974; 
wifeedu1975   =   school1975; 
wifeedu1976   =   school1976; 
wifeedu1977   =   school1977; 
wifeedu1978   =   school1978; 
wifeedu1979   =   school1979; 
wifeedu1980   =   school1980; 
wifeedu1981   =   school1981; 
wifeedu1982   =   school1982; 
wifeedu1983   =   school1983; 
wifeedu1984   =   school1984; 
wifeedu1985   =   school1985; 
wifeedu1986   =   school1986; 
wifeedu1987   =   school1987; 
wifeedu1988   =   school1988; 
wifeedu1989   =   school1989; 
wifeedu1990   =   school1990; 
wifeedu1994   =   school1994; 
wifeedu1995   =   school1995; 
wifeedu1996   =   school1996; 
wifeedu1997   =   school1997; 
wifeedu1999   =   school1999; 
wifeedu2001   =   school2001; 
wifeedu2003   =   school2003; 
wifeedu2005   =   school2005; 
wifeedu2007   =   school2007; 
wifeedu2009   =   school2009; 

wifeocc1968 = wifeocc3digit1968;
wifeocc1969 = wifeocc3digit1969;
wifeocc1970 = wifeocc3digit1970;
wifeocc1971 = wifeocc3digit1971;
wifeocc1972 = wifeocc3digit1972;
wifeocc1973 = wifeocc3digit1973;
wifeocc1974 = wifeocc3digit1974;
wifeocc1975 = wifeocc3digit1975;

%macro occind(year);
        if wifeocc3digit&year =  .   then do; wifeocc&year = .; end;        
   else if wifeocc3digit&year =  999 then do; wifeocc&year = .; end;        
   else if wifeocc3digit&year =  0   then do; wifeocc&year = 0; end;
   else if wifeocc3digit&year le 195 then do; wifeocc&year = 1; end;
   else if wifeocc3digit&year le 245 then do; wifeocc&year = 2; end;
   else if wifeocc3digit&year le 285 then do; wifeocc&year = 3; end;
   else if wifeocc3digit&year le 395 then do; wifeocc&year = 4; end;
   else if wifeocc3digit&year le 600 then do; wifeocc&year = 5; end;
   else if wifeocc3digit&year le 695 then do; wifeocc&year = 6; end;
   else if wifeocc3digit&year le 715 then do; wifeocc&year = 7; end;
   else if wifeocc3digit&year le 785 then do; wifeocc&year = 8; end;
   else if wifeocc3digit&year le 802 then do; wifeocc&year = 9; end;
   else if wifeocc3digit&year le 824 then do; wifeocc&year = 10; end;
   else if wifeocc3digit&year le 965 then do; wifeocc&year = 11; end;
   else if wifeocc3digit&year le 984 then do; wifeocc&year = 12; end;

        if wifeind3digit&year =  .   then do; wifeind&year = .; end;        
   else if wifeind3digit&year =  999 then do; wifeind&year = .; end;        
   else if wifeind3digit&year =  0   then do; wifeind&year = 0; end;
   else if wifeind3digit&year le 28  then do; wifeind&year = 1; end;
   else if wifeind3digit&year le 57  then do; wifeind&year = 2; end;
   else if wifeind3digit&year le 77  then do; wifeind&year = 3; end;
   else if wifeind3digit&year le 398 then do; wifeind&year = 4; end;
   else if wifeind3digit&year le 479 then do; wifeind&year = 5; end;
   else if wifeind3digit&year le 698 then do; wifeind&year = 6; end;
   else if wifeind3digit&year le 718 then do; wifeind&year = 7; end;
   else if wifeind3digit&year le 759 then do; wifeind&year = 8; end;
   else if wifeind3digit&year le 798 then do; wifeind&year = 9; end;
   else if wifeind3digit&year le 809 then do; wifeind&year = 10; end;
   else if wifeind3digit&year le 897 then do; wifeind&year = 11; end;
   else if wifeind3digit&year le 937 then do; wifeind&year = 12; end;
%mend;

%occind(1968) %occind(1969) %occind(1970) %occind(1971) %occind(1972) %occind(1973) %occind(1974) %occind(1975)
%occind(1976) %occind(1977) %occind(1978) %occind(1979) %occind(1980) %occind(1981) %occind(1982) %occind(1983)
%occind(1984) %occind(1985) %occind(1986) %occind(1987) %occind(1988) %occind(1989) %occind(1990) %occind(1991)
%occind(1992) %occind(1993) %occind(1994) %occind(1995) %occind(1996) %occind(1997) %occind(1999) %occind(2001) 

if wifeind3digit2003  =  .                                  then wifeind2003 = .; 
if wifeind3digit2003  =  999                                then wifeind2003 = .; 
if wifeind3digit2003  =  0                                  then wifeind2003 = 0; 
if wifeind3digit2003  > 0     and wifeind3digit2003 le 29   then wifeind2003 = 1; 
if wifeind3digit2003  ge 37   and wifeind3digit2003 le 49   then wifeind2003 = 2; 
if wifeind3digit2003  =  77                                 then wifeind2003 = 3; 
if wifeind3digit2003  ge 107  and wifeind3digit2003 le 399  then wifeind2003 = 4; 
if (wifeind3digit2003 ge 57   and wifeind3digit2003 le 69)                        
or (wifeind3digit2003 ge 647  and wifeind3digit2003 le 679) then wifeind2003 = 5; 
if wifeind3digit2003  ge 407  and wifeind3digit2003 le 579  then wifeind2003 = 6; 
if wifeind3digit2003  ge 687  and wifeind3digit2003 le 719  then wifeind2003 = 7; 
if wifeind3digit2003  ge 757  and wifeind3digit2003 le 779  then wifeind2003 = 8; 
if wifeind3digit2003  ge 866  and wifeind3digit2003 le 869  then wifeind2003 = 9; 
if wifeind3digit2003  ge 856  and wifeind3digit2003 le 859  then wifeind2003 = 10;
if (wifeind3digit2003 ge 727  and wifeind3digit2003 le 749)                       
or (wifeind3digit2003 ge 786  and wifeind3digit2003 le 847)                       
or (wifeind3digit2003 ge 877  and wifeind3digit2003 le 929) then wifeind2003 = 11;
if wifeind3digit2003  ge 937  and wifeind3digit2003 le 987  then wifeind2003 = 12;

if wifeind3digit2005  =  .                                  then wifeind2005 = .; 
if wifeind3digit2005  =  999                                then wifeind2005 = .; 
if wifeind3digit2005  =  0                                  then wifeind2005 = 0; 
if wifeind3digit2005  > 0     and wifeind3digit2005 le 29   then wifeind2005 = 1; 
if wifeind3digit2005  ge 37   and wifeind3digit2005 le 49   then wifeind2005 = 2; 
if wifeind3digit2005  =  77                                 then wifeind2005 = 3; 
if wifeind3digit2005  ge 107  and wifeind3digit2005 le 399  then wifeind2005 = 4; 
if (wifeind3digit2005 ge 57   and wifeind3digit2005 le 69)                        
or (wifeind3digit2005 ge 647  and wifeind3digit2005 le 679) then wifeind2005 = 5; 
if wifeind3digit2005  ge 407  and wifeind3digit2005 le 579  then wifeind2005 = 6; 
if wifeind3digit2005  ge 687  and wifeind3digit2005 le 719  then wifeind2005 = 7; 
if wifeind3digit2005  ge 757  and wifeind3digit2005 le 779  then wifeind2005 = 8; 
if wifeind3digit2005  ge 866  and wifeind3digit2005 le 869  then wifeind2005 = 9; 
if wifeind3digit2005  ge 856  and wifeind3digit2005 le 859  then wifeind2005 = 10;
if (wifeind3digit2005 ge 727  and wifeind3digit2005 le 749)                       
or (wifeind3digit2005 ge 786  and wifeind3digit2005 le 847)                       
or (wifeind3digit2005 ge 877  and wifeind3digit2005 le 929) then wifeind2005 = 11;
if wifeind3digit2005  ge 937  and wifeind3digit2005 le 987  then wifeind2005 = 12;

if wifeind3digit2007  =  .                                  then wifeind2007 = .; 
if wifeind3digit2007  =  999                                then wifeind2007 = .; 
if wifeind3digit2007  =  0                                  then wifeind2007 = 0; 
if wifeind3digit2007  > 0     and wifeind3digit2007 le 29   then wifeind2007 = 1; 
if wifeind3digit2007  ge 37   and wifeind3digit2007 le 49   then wifeind2007 = 2; 
if wifeind3digit2007  =  77                                 then wifeind2007 = 3; 
if wifeind3digit2007  ge 107  and wifeind3digit2007 le 399  then wifeind2007 = 4; 
if (wifeind3digit2007 ge 57   and wifeind3digit2007 le 69)                        
or (wifeind3digit2007 ge 647  and wifeind3digit2007 le 679) then wifeind2007 = 5; 
if wifeind3digit2007  ge 407  and wifeind3digit2007 le 579  then wifeind2007 = 6; 
if wifeind3digit2007  ge 687  and wifeind3digit2007 le 719  then wifeind2007 = 7; 
if wifeind3digit2007  ge 757  and wifeind3digit2007 le 779  then wifeind2007 = 8; 
if wifeind3digit2007  ge 866  and wifeind3digit2007 le 869  then wifeind2007 = 9; 
if wifeind3digit2007  ge 856  and wifeind3digit2007 le 859  then wifeind2007 = 10;
if (wifeind3digit2007 ge 727  and wifeind3digit2007 le 749)                       
or (wifeind3digit2007 ge 786  and wifeind3digit2007 le 847)                       
or (wifeind3digit2007 ge 877  and wifeind3digit2007 le 929) then wifeind2007 = 11;
if wifeind3digit2007  ge 937  and wifeind3digit2007 le 987  then wifeind2007 = 12;

if wifeind3digit2009  =  .                                  then wifeind2009 = .; 
if wifeind3digit2009  =  999                                then wifeind2009 = .; 
if wifeind3digit2009  =  0                                  then wifeind2009 = 0; 
if wifeind3digit2009  > 0     and wifeind3digit2009 le 29   then wifeind2009 = 1; 
if wifeind3digit2009  ge 37   and wifeind3digit2009 le 49   then wifeind2009 = 2; 
if wifeind3digit2009  =  77                                 then wifeind2009 = 3; 
if wifeind3digit2009  ge 107  and wifeind3digit2009 le 399  then wifeind2009 = 4; 
if (wifeind3digit2009 ge 57   and wifeind3digit2009 le 69)                        
or (wifeind3digit2009 ge 647  and wifeind3digit2009 le 679) then wifeind2009 = 5; 
if wifeind3digit2009  ge 407  and wifeind3digit2009 le 579  then wifeind2009 = 6; 
if wifeind3digit2009  ge 687  and wifeind3digit2009 le 719  then wifeind2009 = 7; 
if wifeind3digit2009  ge 757  and wifeind3digit2009 le 779  then wifeind2009 = 8; 
if wifeind3digit2009  ge 866  and wifeind3digit2009 le 869  then wifeind2009 = 9; 
if wifeind3digit2009  ge 856  and wifeind3digit2009 le 859  then wifeind2009 = 10;
if (wifeind3digit2009 ge 727  and wifeind3digit2009 le 749)                       
or (wifeind3digit2009 ge 786  and wifeind3digit2009 le 847)                       
or (wifeind3digit2009 ge 877  and wifeind3digit2009 le 929) then wifeind2009 = 11;
if wifeind3digit2009  ge 937  and wifeind3digit2009 le 987  then wifeind2009 = 12;

if wifeocc3digit2003 =  .                                  then wifeocc2003 = .;  
if wifeocc3digit2003 =  999                                then wifeocc2003 = .;  
if wifeocc3digit2003 =  0                                  then wifeocc2003 = 0;  
if (wifeocc3digit2003 ge 80  and wifeocc3digit2003 le 196)                        
or (wifeocc3digit2003 ge 210 and wifeocc3digit2003 le 365) then wifeocc2003 = 1;  
if (wifeocc3digit2003 ge 1   and wifeocc3digit2003 le 73)  then wifeocc2003 = 2;  
if (wifeocc3digit2003 ge 200 and wifeocc3digit2003 le 206)                        
or (wifeocc3digit2003 ge 470 and wifeocc3digit2003 le 496) then wifeocc2003 = 3;  
if wifeocc3digit2003 ge 500  and wifeocc3digit2003 le 593  then wifeocc2003 = 4;  
if wifeocc3digit2003 ge 700  and wifeocc3digit2003 le 896  then wifeocc2003 = 5;  
if wifeocc3digit2003 ge 900  and wifeocc3digit2003 le 975  then wifeocc2003 = 7;  
if wifeocc3digit2003 ge 620  and wifeocc3digit2003 le 694  then wifeocc2003 = 8;  
if wifeocc3digit2003 ge 600  and wifeocc3digit2003 le 613  then wifeocc2003 = 10; 
if (wifeocc3digit2003 ge 370 and wifeocc3digit2003 le 465)                        
or (wifeocc3digit2003 ge 980 and wifeocc3digit2003 le 983) then wifeocc2003 = 11; 

if wifeocc3digit2005 =  .                                  then wifeocc2005 = .;  
if wifeocc3digit2005 =  999                                then wifeocc2005 = .;  
if wifeocc3digit2005 =  0                                  then wifeocc2005 = 0;  
if (wifeocc3digit2005 ge 80  and wifeocc3digit2005 le 196)                        
or (wifeocc3digit2005 ge 210 and wifeocc3digit2005 le 365) then wifeocc2005 = 1;  
if (wifeocc3digit2005 ge 1   and wifeocc3digit2005 le 73)  then wifeocc2005 = 2;  
if (wifeocc3digit2005 ge 200 and wifeocc3digit2005 le 206)                        
or (wifeocc3digit2005 ge 470 and wifeocc3digit2005 le 496) then wifeocc2005 = 3;  
if wifeocc3digit2005 ge 500  and wifeocc3digit2005 le 593  then wifeocc2005 = 4;  
if wifeocc3digit2005 ge 700  and wifeocc3digit2005 le 896  then wifeocc2005 = 5;  
if wifeocc3digit2005 ge 900  and wifeocc3digit2005 le 975  then wifeocc2005 = 7;  
if wifeocc3digit2005 ge 620  and wifeocc3digit2005 le 694  then wifeocc2005 = 8;  
if wifeocc3digit2005 ge 600  and wifeocc3digit2005 le 613  then wifeocc2005 = 10; 
if (wifeocc3digit2005 ge 370 and wifeocc3digit2005 le 465)                        
or (wifeocc3digit2005 ge 980 and wifeocc3digit2005 le 983) then wifeocc2005 = 11; 

if wifeocc3digit2007 =  .                                  then wifeocc2007 = .;  
if wifeocc3digit2007 =  999                                then wifeocc2007 = .;  
if wifeocc3digit2007 =  0                                  then wifeocc2007 = 0;  
if (wifeocc3digit2007 ge 80  and wifeocc3digit2007 le 196)                        
or (wifeocc3digit2007 ge 210 and wifeocc3digit2007 le 365) then wifeocc2007 = 1;  
if (wifeocc3digit2007 ge 1   and wifeocc3digit2007 le 73)  then wifeocc2007 = 2;  
if (wifeocc3digit2007 ge 200 and wifeocc3digit2007 le 206)                        
or (wifeocc3digit2007 ge 470 and wifeocc3digit2007 le 496) then wifeocc2007 = 3;  
if wifeocc3digit2007 ge 500  and wifeocc3digit2007 le 593  then wifeocc2007 = 4;  
if wifeocc3digit2007 ge 700  and wifeocc3digit2007 le 896  then wifeocc2007 = 5;  
if wifeocc3digit2007 ge 900  and wifeocc3digit2007 le 975  then wifeocc2007 = 7;  
if wifeocc3digit2007 ge 620  and wifeocc3digit2007 le 694  then wifeocc2007 = 8;  
if wifeocc3digit2007 ge 600  and wifeocc3digit2007 le 613  then wifeocc2007 = 10; 
if (wifeocc3digit2007 ge 370 and wifeocc3digit2007 le 465)                        
or (wifeocc3digit2007 ge 980 and wifeocc3digit2007 le 983) then wifeocc2007 = 11; 

if wifeocc3digit2009 =  .                                  then wifeocc2009 = .;  
if wifeocc3digit2009 =  999                                then wifeocc2009 = .;  
if wifeocc3digit2009 =  0                                  then wifeocc2009 = 0;  
if (wifeocc3digit2009 ge 80  and wifeocc3digit2009 le 196)                        
or (wifeocc3digit2009 ge 210 and wifeocc3digit2009 le 365) then wifeocc2009 = 1;  
if (wifeocc3digit2009 ge 1   and wifeocc3digit2009 le 73)  then wifeocc2009 = 2;  
if (wifeocc3digit2009 ge 200 and wifeocc3digit2009 le 206)                        
or (wifeocc3digit2009 ge 470 and wifeocc3digit2009 le 496) then wifeocc2009 = 3;  
if wifeocc3digit2009 ge 500  and wifeocc3digit2009 le 593  then wifeocc2009 = 4;  
if wifeocc3digit2009 ge 700  and wifeocc3digit2009 le 896  then wifeocc2009 = 5;  
if wifeocc3digit2009 ge 900  and wifeocc3digit2009 le 975  then wifeocc2009 = 7;  
if wifeocc3digit2009 ge 620  and wifeocc3digit2009 le 694  then wifeocc2009 = 8;  
if wifeocc3digit2009 ge 600  and wifeocc3digit2009 le 613  then wifeocc2009 = 10; 
if (wifeocc3digit2009 ge 370 and wifeocc3digit2009 le 465)                        
or (wifeocc3digit2009 ge 980 and wifeocc3digit2009 le 983) then wifeocc2009 = 11; 

keep

id1968  wifeage1968  wifeedu1968                                    wifeocc3digit1968  wifeind3digit1968  wifeocc1968  wifeind1968 
id1969  wifeage1969  wifeedu1969                                    wifeocc3digit1969  wifeind3digit1969  wifeocc1969  wifeind1969 
id1970  wifeage1970  wifeedu1970                                    wifeocc3digit1970  wifeind3digit1970  wifeocc1970  wifeind1970 
id1971  wifeage1971  wifeedu1971                                    wifeocc3digit1971  wifeind3digit1971  wifeocc1971  wifeind1971 
id1972  wifeage1972  wifeedu1972                                    wifeocc3digit1972  wifeind3digit1972  wifeocc1972  wifeind1972 
id1973  wifeage1973  wifeedu1973                                    wifeocc3digit1973  wifeind3digit1973  wifeocc1973  wifeind1973 
id1974  wifeage1974  wifeedu1974                                    wifeocc3digit1974  wifeind3digit1974  wifeocc1974  wifeind1974 
id1975  wifeage1975  wifeedu1975                                    wifeocc3digit1975  wifeind3digit1975  wifeocc1975  wifeind1975 
id1976  wifeage1976  wifeedu1976                                    wifeocc3digit1976  wifeind3digit1976  wifeocc1976  wifeind1976 
id1977  wifeage1977  wifeedu1977                                    wifeocc3digit1977  wifeind3digit1977  wifeocc1977  wifeind1977 
id1978  wifeage1978  wifeedu1978                                    wifeocc3digit1978  wifeind3digit1978  wifeocc1978  wifeind1978 
id1979  wifeage1979  wifeedu1979                wifeselfemploy1979  wifeocc3digit1979  wifeind3digit1979  wifeocc1979  wifeind1979 
id1980  wifeage1980  wifeedu1980                wifeselfemploy1980  wifeocc3digit1980  wifeind3digit1980  wifeocc1980  wifeind1980 
id1981  wifeage1981  wifeedu1981                wifeselfemploy1981  wifeocc3digit1981  wifeind3digit1981  wifeocc1981  wifeind1981 
id1982  wifeage1982  wifeedu1982                wifeselfemploy1982  wifeocc3digit1982  wifeind3digit1982  wifeocc1982  wifeind1982 
id1983  wifeage1983  wifeedu1983                wifeselfemploy1983  wifeocc3digit1983  wifeind3digit1983  wifeocc1983  wifeind1983 
id1984  wifeage1984  wifeedu1984                wifeselfemploy1984  wifeocc3digit1984  wifeind3digit1984  wifeocc1984  wifeind1984 
id1985  wifeage1985  wifeedu1985  wiferace1985  wifeselfemploy1985  wifeocc3digit1985  wifeind3digit1985  wifeocc1985  wifeind1985 
id1986  wifeage1986  wifeedu1986  wiferace1986  wifeselfemploy1986  wifeocc3digit1986  wifeind3digit1986  wifeocc1986  wifeind1986 
id1987  wifeage1987  wifeedu1987  wiferace1987  wifeselfemploy1987  wifeocc3digit1987  wifeind3digit1987  wifeocc1987  wifeind1987 
id1988  wifeage1988  wifeedu1988  wiferace1988  wifeselfemploy1988  wifeocc3digit1988  wifeind3digit1988  wifeocc1988  wifeind1988 
id1989  wifeage1989  wifeedu1989  wiferace1989  wifeselfemploy1989  wifeocc3digit1989  wifeind3digit1989  wifeocc1989  wifeind1989 
id1990  wifeage1990  wifeedu1990  wiferace1990  wifeselfemploy1990  wifeocc3digit1990  wifeind3digit1990  wifeocc1990  wifeind1990 
id1991  wifeage1991  wifeedu1991  wiferace1991  wifeselfemploy1991  wifeocc3digit1991  wifeind3digit1991  wifeocc1991  wifeind1991 
id1992  wifeage1992  wifeedu1992  wiferace1992  wifeselfemploy1992  wifeocc3digit1992  wifeind3digit1992  wifeocc1992  wifeind1992 
id1993  wifeage1993  wifeedu1993  wiferace1993  wifeselfemploy1993  wifeocc3digit1993  wifeind3digit1993  wifeocc1993  wifeind1993 
id1994  wifeage1994  wifeedu1994  wiferace1994  wifeselfemploy1994  wifeocc3digit1994  wifeind3digit1994  wifeocc1994  wifeind1994 
id1995  wifeage1995  wifeedu1995  wiferace1995  wifeselfemploy1995  wifeocc3digit1995  wifeind3digit1995  wifeocc1995  wifeind1995 
id1996  wifeage1996  wifeedu1996  wiferace1996  wifeselfemploy1996  wifeocc3digit1996  wifeind3digit1996  wifeocc1996  wifeind1996 
id1997  wifeage1997  wifeedu1997  wiferace1997  wifeselfemploy1997  wifeocc3digit1997  wifeind3digit1997  wifeocc1997  wifeind1997 
id1999  wifeage1999  wifeedu1999  wiferace1999  wifeselfemploy1999  wifeocc3digit1999  wifeind3digit1999  wifeocc1999  wifeind1999 
id2001  wifeage2001  wifeedu2001  wiferace2001  wifeselfemploy2001  wifeocc3digit2001  wifeind3digit2001  wifeocc2001  wifeind2001 
id2003  wifeage2003  wifeedu2003  wiferace2003  wifeselfemploy2003  wifeocc3digit2003  wifeind3digit2003  wifeocc2003  wifeind2003                         
id2005  wifeage2005  wifeedu2005  wiferace2005  wifeselfemploy2005  wifeocc3digit2005  wifeind3digit2005  wifeocc2005  wifeind2005                        
id2007  wifeage2007  wifeedu2007  wiferace2007  wifeselfemploy2007  wifeocc3digit2007  wifeind3digit2007  wifeocc2007  wifeind2007                          
id2009  wifeage2009  wifeedu2009  wiferace2009  wifeselfemploy2009  wifeocc3digit2009  wifeind3digit2009  wifeocc2009  wifeind2009;                          


run;

proc freq data = PSIDDATA.wife;
tables 
wifeedu1968                                    wifeocc1968  wifeind1968 
wifeedu1969                                    wifeocc1969  wifeind1969 
wifeedu1970                                    wifeocc1970  wifeind1970 
wifeedu1971                                    wifeocc1971  wifeind1971 
wifeedu1972                                    wifeocc1972  wifeind1972 
wifeedu1973                                    wifeocc1973  wifeind1973 
wifeedu1974                                    wifeocc1974  wifeind1974 
wifeedu1975                                    wifeocc1975  wifeind1975 
wifeedu1976                                    wifeocc1976  wifeind1976 
wifeedu1977                                    wifeocc1977  wifeind1977 
wifeedu1978                                    wifeocc1978  wifeind1978 
wifeedu1979                wifeselfemploy1979  wifeocc1979  wifeind1979 
wifeedu1980                wifeselfemploy1980  wifeocc1980  wifeind1980 
wifeedu1981                wifeselfemploy1981  wifeocc1981  wifeind1981 
wifeedu1982                wifeselfemploy1982  wifeocc1982  wifeind1982 
wifeedu1983                wifeselfemploy1983  wifeocc1983  wifeind1983 
wifeedu1984                wifeselfemploy1984  wifeocc1984  wifeind1984 
wifeedu1985  wiferace1985  wifeselfemploy1985  wifeocc1985  wifeind1985 
wifeedu1986  wiferace1986  wifeselfemploy1986  wifeocc1986  wifeind1986 
wifeedu1987  wiferace1987  wifeselfemploy1987  wifeocc1987  wifeind1987 
wifeedu1988  wiferace1988  wifeselfemploy1988  wifeocc1988  wifeind1988 
wifeedu1989  wiferace1989  wifeselfemploy1989  wifeocc1989  wifeind1989 
wifeedu1990  wiferace1990  wifeselfemploy1990  wifeocc1990  wifeind1990 
wifeedu1991  wiferace1991  wifeselfemploy1991  wifeocc1991  wifeind1991 
wifeedu1992  wiferace1992  wifeselfemploy1992  wifeocc1992  wifeind1992 
wifeedu1993  wiferace1993  wifeselfemploy1993  wifeocc1993  wifeind1993 
wifeedu1994  wiferace1994  wifeselfemploy1994  wifeocc1994  wifeind1994 
wifeedu1995  wiferace1995  wifeselfemploy1995  wifeocc1995  wifeind1995 
wifeedu1996  wiferace1996  wifeselfemploy1996  wifeocc1996  wifeind1996 
wifeedu1997  wiferace1997  wifeselfemploy1997  wifeocc1997  wifeind1997 
wifeedu1999  wiferace1999  wifeselfemploy1999  wifeocc1999  wifeind1999 
wifeedu2001  wiferace2001  wifeselfemploy2001  wifeocc2001  wifeind2001 
wifeedu2003  wiferace2003  wifeselfemploy2003  wifeocc2003  wifeind2003                         
wifeedu2005  wiferace2005  wifeselfemploy2005  wifeocc2005  wifeind2005
wifeedu2007  wiferace2007  wifeselfemploy2007  wifeocc2007  wifeind2007
wifeedu2009  wiferace2009  wifeselfemploy2009  wifeocc2009  wifeind2009;                          
run;

%macro freq(year);
data u;
set psiddata.wife;
if id&year ne .;
proc freq data = u;
tables wifeedu&year wifeocc&year wifeind&year;
run;
%mend;
%freq(1968); %freq(1969); %freq(1970); %freq(1971); %freq(1972); %freq(1973); %freq(1974); %freq(1975);
%freq(1976); %freq(1977); %freq(1978); 

%macro freq(year);
data u;
set psiddata.wife;
if id&year ne .;
proc freq data = u;
tables wifeedu&year wifeselfemploy&year wifeocc&year wifeind&year;
run;
%mend;
%freq(1979); %freq(1980); %freq(1981); %freq(1982); %freq(1983); %freq(1984); 

%macro freq(year);
data u;
set psiddata.wife;
if id&year ne .;
proc freq data = u;
tables wifeedu&year wiferace&year wifeselfemploy&year wifeocc&year wifeind&year;
run;
%mend;
%freq(1985); %freq(1986); %freq(1987); %freq(1988); %freq(1989); %freq(1990); %freq(1991);
%freq(1992); %freq(1993); %freq(1994); %freq(1995); %freq(1996); %freq(1997); %freq(1999); 
%freq(2001); %freq(2003); %freq(2005)  %freq(2007)  %freq(2009);
