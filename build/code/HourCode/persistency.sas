proc sort data = HomeProd.Baseline;
by pid;

**************************************************************************************************************************
**************************************************************************************************************************
**************************************************************************************************************************;
data countup;
set HomeProd.construpcount;
longup = longest_str;
numup = num_str;
if pid ne .;
keep pid longup numup;

proc sort data = countup;
by pid;

data countdown;
set HomeProd.constrdowncount;
longdown = longest_str;
numdown = num_str;
if pid ne .;
keep pid longdown numdown;

proc sort data = countdown;
by pid;

proc sort data = HomeProd.Baseline;
by pid;

data sub;
merge HomeProd.Baseline(in = in1) countup(in = in2) countdown(in = in3);
by pid;
if in1 and in2 and in3;

longup1 = (longup = 1);
longup2 = (longup = 2);
longup3 = (longup = 3);
longup4 = (longup = 4);
longup5 = (longup = 5);
longup6 = (longup ge 6);
longup2p = (longup ge 2);
longup23 = (longup = 2 or longup = 3);
longup4p = (longup ge 4);

construp1 = construp * (longup = 1);
construp2 = construp * (longup = 2);
construp3 = construp * (longup = 3);
construp4 = construp * (longup = 4);
construp5 = construp * (longup = 5);
construp6 = construp * (longup = 6);
construp2p = construp * (longup ge 2);
construp23 = construp * (longup = 2 or longup = 3);
construp4p = construp * (longup ge 4);

constrdown1 = constrdown * (longdown = 1);
constrdown2 = constrdown * (longdown = 2);
constrdown3 = constrdown * (longdown = 3);
constrdown4 = constrdown * (longdown = 4);
constrdown5 = constrdown * (longdown = 5);
constrdown6 = constrdown * (longdown = 6);
constrdown2p = constrdown * (longdown ge 2);
constrdown23 = constrdown * (longdown = 2 or longdown = 3);
constrdown4p = constrdown * (longdown ge 4);

data sub1;
set  sub;
if married = 1;

proc reg data = sub1;
model HWHead = construp1 construp2p
               headage headage2 white highschool somecollege college age2 age6 age12 age18 adults dis
               wifeage wifeage2 wifehighschool wifesomecollege wifecollege wifeparttime wifefulltime 
               realheadwage realwifewage p2 - p10 year1969 - year1973 year1976 - year1981 year1983 - year1986;
test construp1 = construp2p;
run;

proc reg data = sub1;
model Foodpct =  construp1 construp2p 
                 headage headage2 white highschool somecollege college age2 age6 age12 age18 adults dis
                 wifeage wifeage2 wifehighschool wifesomecollege wifecollege wifeparttime wifefulltime 
                 realheadwage realwifewage p2 - p10 year1970 - year1972 year1975 - year1986;
test construp1 = construp2p;
run;

data sub2;
set  sub;
if married = 0;

proc reg data = sub2;
model HWHead = construp1 construp2p female
               headage headage2 white highschool somecollege college age2 age6 age12 age18 adults dis
               realheadwage p2 - p10 year1969 - year1973 year1976 - year1981 year1983 - year1986;
test construp1 = construp2p;
proc reg data = sub2;
model Foodpct =  construp1 construp2p female
                 headage headage2 white highschool somecollege college age2 age6 age12 age18 adults dis
                 realheadwage p2 - p10 year1970 - year1972 year1975 - year1986;
test construp1 = construp2p;
run;

data sub3;
set  sub;
if married = 1;

proc reg data = sub3;
model HWHead = constrdown1 constrdown2p
               headage headage2 white highschool somecollege college age2 age6 age12 age18 adults dis
               realheadwage p2 - p10 year1969 - year1973 year1976 - year1981 year1983 - year1986;
test constrdown1 = constrdown2p;
run;

proc reg data = sub3;
model Foodpct =  constrdown1 constrdown2p 
                 headage headage2 white highschool somecollege college age2 age6 age12 age18 adults dis
                 wifeage wifeage2 wifehighschool wifesomecollege wifecollege wifeparttime wifefulltime 
                 realheadwage realwifewage p2 - p10 year1970 - year1972 year1975 - year1986;
test constrdown1 = constrdown2p;
run;

data sub4;
set  sub;
if married = 0;

proc reg data = sub4;
model HWHead = constrdown1 constrdown2p female
               headage headage2 white highschool somecollege college age2 age6 age12 age18 adults dis
               realheadwage p2 - p10 year1969 - year1973 year1976 - year1981 year1983 - year1986;
test constrdown1 = constrdown2p;
run;

proc reg data = sub4;
model Foodpct =  constrdown1 constrdown2p female
                 headage headage2 white highschool somecollege college age2 age6 age12 age18 adults dis
                 realheadwage p2 - p10 year1970 - year1972 year1975 - year1986;
test constrdown1 = constrdown2p;
run;

