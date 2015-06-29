/*Program Li Geng wrote to read in RAND-processed Health and Retirement Survey data in for home production/hours constraints project*/
/* Brett McCully, May 2015*/

/*Can get waged/salaried position variable at J031*/

libname HRS "/href/scratch2/HRS/Rawdata";
libname HomeProd "../output";
libname randhrs "../input/randhrs";

proc format library=randhrs cntlin=randhrs.sasfmts;
run;

options FMTSEARCH=(randhrs);

*list of variables to keep for each wave of survey;
%macro keeplist;
    %do w=1 %to 11;
     H&w.HHID
     INW&w.
     S&w.HHIDPN       
     R&w.WTHH        
     H&w.HHRESP       
     R&w.AGEY_E      
     S&w.AGEY_E       
     S&w.GENDER       
     S&w.RACEM        
     S&w.HISPAN     
     S&w.EDYRS         
     R&w.MSTAT        
     H&w.ITOT           
     H&w.HHRES       
     R&w.SAYRET      
     S&w.SAYRET      
     R&w.RETEMP     
     S&w.RETEMP     
     R&w.WORK          
     S&w.WORK         
     R&w.SLFEMP    
     S&w.SLFEMP       
     R&w.LBRF           
     S&w.LBRF         
     R&w.JHOURS       
     S&w.JHOURS
     R&w.JWEEKS    
     S&w.JWEEKS       
     R&w.WGIHR         
     S&w.WGIHR
    %end; 
%mend;

data RandVariable;                                                                    
set HRS.rndhrs_n
(                                                                             
keep=HHIDPN     RAGENDER   RARACEM    RAHISPAN   RAEDYRS                                      
     %keeplist );    
run;


*endsas;

%macro rand(wave);
data RandHead&wave.;
set RandVariable;
wave = 1990 + 2 * &wave.;
if RAGender = 1 or (RAGender = 2 and R&wave.MSTAT ge 4);
if H&wave.HHID ne .;
hhid         = int(H&wave.HHID / 10);
subhh        = H&wave.HHID - hhid * 10;
pn           = hhidpn - int(hhidpn / 1000) * 1000;
famsize      = H&wave.HHRES;
WGT          = R&wave.WTHH;
headgender   = RAGENDER;
headrace     = RARACEM;
headhispanic = RAHISPAN;
headedu      = RAEDYRS;
headage      = R&wave.AGEY_E;
married      = (R&wave.MSTAT = 1);
Faminc       = H&wave.ITOT;
headretire1  = R&wave.SAYRET; 
headretire2  = R&wave.RETEMP; 
wiferetire1  = S&wave.SAYRET; 
wiferetire2  = S&wave.RETEMP;
headwork     = R&wave.WORK;
wifework     = S&wave.WORK;
headselfemp  = R&wave.SLFEMP; 
wifeselfemp  = S&wave.SLFEMP; 
headstatus   = R&wave.LBRF;
wifestatus   = S&wave.LBRF;
headhour     = R&wave.JHOURS;
wifehour     = S&wave.JHOURS;
headweek     = R&wave.JWEEKS;
wifeweek     = S&wave.JWEEKS;
headwage     = R&wave.WGIHR;
wifewage     = S&wave.WGIHR;

if subhh = 0;
 
keep hhidpn       hhid         pn           wave         WGT       headage     headgender   headrace     headedu  married    
     headretire1  headretire2  wiferetire1  wiferetire2  headwork  wifework    headselfemp  wifeselfemp  faminc         
     headstatus   wifestatus   headhour     wifehour     headweek  wifeweek    headwage     wifewage     famsize;

proc sort data = RandHead&wave. nodupkey; 
by hhid;
run;
%mend;
%rand(1) %rand(2) %rand(3) %rand(4) %rand(5) %rand(6) 
%rand(7) %rand(8) %rand(9) %rand(10) %rand(11)  


************************************Number of kids, food consumption and labor market frictions*************************;
data food1992;
INFILE '/href/scratch2/HRS/Rawdata/HOUSEHLD.DA'  LRECL=2749;     
input HHID 1-6 ASUBHH 7 foodstamp 1590 foodhm1 1595-1597 foodhmper1 1598 foodout1 1605 - 1608 foodoutper1 1609
                                       foodhm2 1610-1613 foodhmper2 1614 foodout2 1621 - 1624 foodoutper2 1625;
if foodhm1 = 9996 then foodhm1 = .;
if foodhm2 = 9996 then foodhm2 = .;
if foodout1 = 9996 then foodout1 = .;
if foodout2 = 9996 then foodout2 = .;

if foodstamp = 1 then do;
   foodhm = foodhm1;
   foodhmper = foodhmper1;
   foodout = foodout1;
   foodoutper = foodoutper1;
   end;
else do;
   foodhm = foodhm2;
   foodhmper = foodhmper2;
   foodout = foodout2;
   foodoutper = foodoutper2;
   end;

if foodhmper in (2, 3, 4, 6);
if foodoutper in (2, 3, 4, 6);
foodhm = (foodhm * 52 * (foodhmper = 2) + foodhm * 26 * (foodhmper = 3) + foodhm * 12 * (foodhmper = 4) + foodhm * (foodhmper = 6)); 
foodout = (foodout * 52 * (foodoutper = 2) + foodout * 26 * (foodoutper = 3) + foodout * 12 * (foodoutper = 4) + foodout * (foodoutper = 6)); 

keep HHID ASUBHH foodhm foodout;

proc sort data = food1992;
by HHID ASUBHH;

data labor1992;
INFILE '/href/scratch2/HRS/Rawdata/EMPLOYER.DA'  LRECL=3131;     
input HHID 1-6 PN 7-9 ASUBHH 10 ableless 222 - 223 wantless 224 - 225 lessideal 226 - 228 propcut 232 - 233 
                                ablemore 238 - 239 wantmore 240 - 241 moreideal 242 - 244; 
if lessideal ge 96 then lessideal = .;
if moreideal ge 96 then moreideal = .;

proc sort data = labor1992;
by HHID ASUBHH;

data laborfood1;
merge food1992 labor1992;
by HHID ASUBHH;
if ASUBHH = 0;

proc univariate data = laborfood1;
var lessideal moreideal foodhm foodout;
run;



**************************;
data food1994;
INFILE '/href/scratch2/HRS/Rawdata/W2N.DA'  LRECL=1466;     
input HHID 1-6  CSUBHH 7 foodstamp 974-975 foodhm1 1043-1048 foodhmper1 1049-1051 foodout1 1061- 1066 foodoutper1 1067-1069
                                           foodhm2 1070-1075 foodhmper2 1076-1078 foodout2 1090- 1095 foodoutper2 1096-1098;

if foodhm1 > 99993 then foodhm1 = .;
if foodhm2 > 99993 then foodhm2 = .;
if foodout1 > 99993 then foodout1 = .;
if foodout2 > 99993 then foodout2 = .;

if foodstamp = 1 then do;
   foodhm = foodhm1;
   foodhmper = foodhmper1;
   foodout = foodout1;
   foodoutper = foodoutper1;
   end;
else do;
   foodhm = foodhm2;
   foodhmper = foodhmper2;
   foodout = foodout2;
   foodoutper = foodoutper2;
   end;

if foodhmper in (2, 3, 4, 6);
if foodoutper in (2, 3, 4, 6);
foodhm = (foodhm * 52 * (foodhmper = 2) + foodhm * 26 * (foodhmper = 3) + foodhm * 12 * (foodhmper = 4) + foodhm * (foodhmper = 6)); 
foodout = (foodout * 52 * (foodoutper = 2) + foodout * 26 * (foodoutper = 3) + foodout * 12 * (foodoutper = 4) + foodout * (foodoutper = 6)); 

keep HHID CSUBHH foodhm foodout;

proc sort data = food1994;
by HHID CSUBHH;

data labor1994;
INFILE '/href/scratch2/HRS/Rawdata/W2FA.DA'  LRECL=3131;     
input HHID 1-6 PN 7-9 CSUBHH 10 ableless 501-502 wantless 503-504 lessideal 505-508 propcut 511-512 
                                ablemore 517-518 wantmore 519-520 moreideal 521-524; 
if lessideal ge 96 then lessideal = .;
if moreideal ge 96 then moreideal = .;

proc sort data = labor1994;
by HHID CSUBHH;

data laborfood2;
merge food1994 labor1994;
by HHID CSUBHH;
if CSUBHH = 0;

proc univariate data = laborfood2;
var lessideal moreideal foodhm foodout;
run;


**************************1996 is merged by HHID and PN;
data food1996;
INFILE '/href/scratch2/HRS/Rawdata/H96M_R.DA'  LRECL=965;              
input HHID 1-6 PN 7-9 ESUBHH 10 foodhm 24-32 foodout 43-51; *** per week;
if foodhm > 999996 then foodhm = .;
if foodout > 999996 then foodout = .;
foodhm = foodhm * 52;
foodout = foodout * 52;

proc sort data = food1996;
by HHID PN;

data labor1996;
INFILE '/href/scratch2/HRS/Rawdata/H96G_R.DA'  LRECL=2668;     
input HHID 1-6 PN 7-9 ESUBHH 10 ableless 503 wantless 504 lessideal 505-507 propcut 509 
                                ablemore 512 wantmore 513 moreideal 514-516; 
if lessideal ge 96 then lessideal = .;
if moreideal ge 96 then moreideal = .;

proc sort data = labor1996;
by HHID PN;

data laborfood3;
merge food1996 labor1996;
by HHID PN;
if ESUBHH = 0;

proc univariate data = laborfood3;
var lessideal moreideal foodhm foodout;
run;
*********We do not use the 1998 data because it does not have the composition of food home and food out*********;
**************************;
data food2000;
INFILE '/href/scratch2/HRS/Rawdata/H00J_H.DA'  LRECL=1297;              
input HHID 1-6 GSUBHH 7 foodhm 1115-1120 foodout 1128-1133; *** per week;
if foodhm > 999996 then foodhm = .;
if foodout > 999996 then foodout = .;
foodhm = foodhm * 52;
foodout = foodout * 52;

proc sort data = food2000;
by HHID GSUBHH;

data labor2000;
INFILE '/href/scratch2/HRS/Rawdata/H00G_R.DA'  LRECL=5074;     
input HHID 1-6 PN 7-9 GSUBHH 10 ableless 956 wantless 957 lessideal 958-960 propcut 961 
                                ablemore 965 wantmore 966 moreideal 967-969; 
if lessideal ge 96 then lessideal = .;
if moreideal ge 96 then moreideal = .;

proc sort data = labor2000;
by HHID GSUBHH;

data laborfood5;
merge food2000 labor2000;
by HHID GSUBHH;
if GSUBHH = 0;

proc univariate data = laborfood5;
var lessideal moreideal foodhm foodout;
run;

**************************;
data food2002;
INFILE '/href/scratch2/HRS/Rawdata/H02Q_H.da'  LRECL=2244;
input HHID 1-6 HSUBHH 7 foodhm 1604-1608 foodout 1629-1632; *** per week;
if foodhm > 99997 then foodhm = .;
if foodout > 9997 then foodout = .;
foodhm = foodhm * 52;
foodout = foodout * 52;

proc sort data = food2002;
by HHID HSUBHH;

data labor2002;
INFILE '/href/scratch2/HRS/Rawdata/H02J_R.da'  LRECL=3539;
input HHID 1-6 PN 7-9 HSUBHH 10 ableless 1133 wantless 1134 lessideal 1135-1137 propcut 1138 
                                ablemore 1142 wantmore 1143 moreideal 1144-1146; 
if lessideal ge 96 then lessideal = .;
if moreideal ge 96 then moreideal = .;

proc sort data = labor2002;
by HHID HSUBHH;

data laborfood6;
merge food2002 labor2002;
by HHID HSUBHH;
if HSUBHH = 0;

proc univariate data = laborfood6;
var lessideal moreideal foodhm foodout;
run;

**************************;
data food2004;
INFILE '/href/scratch2/HRS/Rawdata/H04Q_H.da'  LRECL=2335;              
input HHID 1-6 JSUBHH 7 foodhm 1746-1750 foodout 1781-1784; *** per week;
if foodhm > 99997 then foodhm = .;
if foodout > 9997 then foodout = .;
foodhm = foodhm * 52;
foodout = foodout * 52;

proc sort data = food2004;
by HHID JSUBHH;

data labor2004;
INFILE '/href/scratch2/HRS/Rawdata/H04J_R.da'  LRECL=3843;
input HHID 1-6 PN 7-9 JSUBHH 10 ableless 1281 wantless 1282 lessideal 1283-1285 propcut 1286
                             ablemore 1289 wantmore 1292 moreideal 1293-1295; 
if lessideal ge 98 then lessideal = .;
if moreideal ge 998 then moreideal = .;

proc sort data = labor2004;
by HHID JSUBHH;

data laborfood7;
merge food2004 labor2004;
by HHID JSUBHH;
if JSUBHH = 0;

proc univariate data = laborfood7;
var lessideal moreideal foodhm foodout;
run;

**************************; 
data food2006;
INFILE '/href/scratch2/HRS/Rawdata/H06Q_H.da'  LRECL=3108;
input HHID 1-6 KSUBHH 7 foodhm 2289-2294 foodout 2338-2343; *** per week;
if foodhm > 999997 then foodhm = .;
if foodout > 999997 then foodout = .;
foodhm = foodhm * 52;
foodout = foodout * 52;

proc sort data = food2006;
by HHID KSUBHH;

data labor2006;
INFILE '/href/scratch2/HRS/Rawdata/H06J_R.da'  LRECL=8719;
input HHID 1-6 PN 7-9 KSUBHH 10 ableless 1922 wantless 1923 lessideal 1924-1926 propcut 1927 
                                ablemore 1931 wantmore 1934 moreideal 1935-1937; 
if lessideal > 168 then lessideal = .;
if moreideal > 168 then moreideal = .;

proc sort data = labor2006;
by HHID KSUBHH;

data laborfood8;
merge food2006 labor2006;
by HHID KSUBHH;
if KSUBHH = 0;

title "2006";
proc univariate data = laborfood8;
var lessideal moreideal foodhm foodout;
run;

**************************; 
data food2008;
INFILE '/href/scratch2/HRS/hrs08raw/h08da/H08Q_H.da' LRECL = 3130;
input HHID 1 - 6 LSUBHH 7 LQ417 2249 - 2254 LQ426  2298 - 2303; *** per week;
if LQ417 > 999997 then LQ417 = .;
if LQ426 > 999997 then LQ426 = .;
foodhm = LQ417 * 52;
foodout = LQ426 * 52;

proc sort data=food2008; by HHID LSUBHH;

data labor2008;
INFILE '/href/scratch2/HRS/hrs08raw/h08da/H08J_R.da' LRECL = 6198;
input HHID 1 - 6 PN 7 - 9 LSUBHH 10 LJ234 1607 LJ235 1608 LJ236 1609-1611 LJ940 1612
      	       	      	  	    LJ241 1616 LJ242 1617 LJ243 1618-1620;
rename LJ234=ableless LJ235=wantless LJ236=lessideal LJ940=propcut
       LJ241=ablemore LJ242=wantmore LJ243=moreideal;

data labor2008;
set labor2008;
if lessideal > 168 then lessideal=.;
if moreideal > 168 then moreideal=.;

proc sort data=labor2008; by HHID LSUBHH;

data laborfood9;
merge food2008 labor2008;
by HHID LSUBHH;
if LSUBHH = 0;

title "2008";
proc univariate data = laborfood9;
var lessideal moreideal foodhm foodout;
run;

**************************; 
data food2010;
INFILE '/href/scratch2/HRS/hrs10raw/h10da/H10Q_H.da' LRECL = 2537;
input HHID 1 - 6 MSUBHH 7 MQ417 1944 - 1949 MQ426  1982 - 1987; *** per week;
if MQ417 > 999997 then MQ417 = .;
if MQ426 > 999997 then MQ426 = .;
foodhm  = MQ417 * 52;
foodout = MQ426 * 52;

proc sort data=food2010; by HHID MSUBHH;

data labor2010;
INFILE '/href/scratch2/HRS/hrs10raw/h10da/H10J_R.da' LRECL = 2537;
input HHID 1 - 6 PN 7 - 9 MSUBHH 10 MJ234 1278 MJ235 1279 MJ236 1280-1282 MJ940 1283
      	       	      	  	    MJ241 1287 MJ242 1288 MJ243 1289-1291;
rename MJ234=ableless MJ235=wantless MJ236=lessideal MJ940=propcut
       MJ241=ablemore MJ242=wantmore MJ243=moreideal;

data labor2010;
set labor2010;
if lessideal > 168 then lessideal=.;
if moreideal > 168 then moreideal=.;

proc sort data=labor2010; by HHID MSUBHH;

data laborfood10;
merge food2010 labor2010;
by HHID MSUBHH;
if MSUBHH = 0;

title "2010";
proc univariate data = laborfood10;
var lessideal moreideal foodhm foodout;
run;

**************************; 
data food2012;
INFILE '/href/scratch2/HRS/hrs12raw/h12da/H12Q_H.da' LRECL = 2610;
input HHID 1 - 6 NSUBHH 7 NQ417 1974 - 1979 NQ426 1974 - 1979; *** per week;
if NQ417 > 999997 then NQ417 = .;
if NQ426 > 999997 then NQ426 = .;
foodhm  = NQ417 * 52;
foodout = NQ426 * 52;

proc sort data=food2012; by HHID NSUBHH;

data labor2012;
INFILE '/href/scratch2/HRS/hrs12raw/h12da/H12J_R.da' LRECL = 1512;
input HHID 1 - 6 PN 7 - 9 NSUBHH 10 NJ234 681 NJ235 682 NJ236 683 - 685 NJ940 686
      	       	      	  	    NJ241 690 NJ242 691 NJ243 692 - 694;
rename NJ234=ableless NJ235=wantless NJ236=lessideal NJ940=propcut
       NJ241=ablemore NJ242=wantmore NJ243=moreideal;

data labor2012;
set labor2012;
if lessideal > 168 then lessideal=.;
if moreideal > 168 then moreideal=.;

proc sort data=labor2012; by HHID NSUBHH;

data laborfood11;
merge food2012 labor2012;
by HHID NSUBHH;
if NSUBHH = 0;

title "2012";
proc univariate data = laborfood11;
var lessideal moreideal foodhm foodout;
run;
proc sort data=laborfood11; by HHID PN;run;

*merge macro;
%macro mer(wave);
title "&wave";
data u;
merge RandHead&wave.(in = in1) laborfood&wave.(in = in2);
by HHID PN;
if in1 and in2;
if wifehour > 80 then delete;
if wifeweek > 52 then delete;
if wifewage > 100 then delete;
if headhour > 0 and headhour < 80;
if headweek > 0 and headweek < 53;
if headwage > 1 and headwage < 1000;
if faminc > 1200 and faminc < 500000;
if foodhm > 520 and foodhm < 52000;
if foodout ge 0 and foodout < 52000;
if headage < 70;

headage2    = headage * headage;
malehead    = (headgender = 1);
white       = (headrace = 1);
headhour    = headhour * headweek; 
wifehour    = max(0, wifehour * wifeweek);
if headhour < 3000 and wifehour < 3000;
if headhour > 500;
food        = foodhm + foodout;
logincome   = log(faminc);
logfood     = log(food);
foodpct     = foodout / food * 100;
highschool  = (headedu = 12);
somecollege = (headedu > 12 and headedu < 16);
college     = (headedu ge 16);
belowhighschool = (headedu < 12);
abovehighschool = (headedu > 12);

construp = 0;
constrdown = 0;
if ableless = 5 and wantless = 1 then constrdown = 1;
if ablemore = 5 and wantmore = 1 then construp = 1;
if construp = 1 then constraint = 1;
else if constrdown = 1 then constraint = 2;
else constraint = 0;
if constrdown = 1 and construp = 1 then delete;

if constrdown = 1 then lessgap = headhour - lessideal * headweek; 
else lessgap = 0;
if construp = 1 then moregap = moreideal * headweek - headhour; 
else moregap = 0;

if moregap < 0 or lessgap < 0 then delete;
if construp = 1 and lessgap > 0 then delete;
if constrdown = 1 and moregap > 0 then delete;

*using CPI with base years 1982-84;
if wave = 1992 then cpi = 140.300;
else if wave = 1994 then cpi = 148.200;
else if wave = 1996 then cpi = 156.900;
else if wave = 1998 then cpi = 163.000;
else if wave = 2000 then cpi = 172.200;
else if wave = 2002 then cpi = 179.900;
else if wave = 2004 then cpi = 188.900;
else if wave = 2006 then cpi = 201.600;
else if wave = 2008 then cpi = 215.303;
else if wave = 2010 then cpi = 218.056;
else if wave = 2012 then cpi = 229.594;

realincome = faminc * 100 / cpi;
realfood = food * 100 / cpi;
realfoodout = foodout * 100 / cpi;
realwage = headwage * 100 / cpi;

if construp = 1 then constraint = 1;
else if constrdown = 1 then constraint = 2;
else constraint = 0;
 
m = 1;
run;
 
proc univariate data = u noprint;
var faminc;
output out = p
pctlpre = faminc_ 
pctlpts = 10 20 30 40 50 60 70 80 90;
data p ;
set p;
m = 1;

data HRSData&wave.;
merge u p;
by m;
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

wave2 = (&wave. = 2);
wave3 = (&wave. = 3);
wave5 = (&wave. = 5);
wave6 = (&wave. = 6);
wave7 = (&wave. = 7);
wave8 = (&wave. = 8);
wave9 = (&wave. = 9);
wave10= (&wave. = 10);
wave11= (&wave. = 11);


proc freq data = HRSData&wave. noprint;
tables constrdown construp constrdown * headselfemp construp * headselfemp white highschool somecollege college married famsize malehead;

proc univariate data = HRSData&wave. noprint;
var foodhm foodout foodpct headwage logincome logfood headage headhour wifehour famsize lessgap moregap;
run;
%mend;
%mer(1) %mer(2) %mer(3) %mer(5) %mer(6) %mer(7) %mer(8) %mer(9) %mer(10) %mer(11)

data HomeProd.HRSData;
set HRSData1 HRSData2 HRSData3 HRSData5 HRSData6 HRSData7 HRSData8 HRSData9 HRSData10 HRSData11;

X 'st ../output/hrsdata.sas7bdat ../../analysis/input/hrsdata.dta -y';
