libname rand "/href/scratch3/m1haf01/HRS/RawData/randpsas";
libname psiddata '/hpc/household_finance/SurveyData/PSIDDATA';
libname macrodat '/hpc/household_finance/BoardResearch/MacroData';
libname hrs "/href/scratch3/m1haf01/HRS/RawData";
libname hp '/hpc/household_finance/BoardResearch/HP/WorkDir/Revision';

data ua;
set hp.pooled;
construp1 = construp;
constrdown1 = constrdown;
type1 = (construp = 1) + (constrdown = 1) * 2 + (construp + constrdown = 0) * 3;
pter1 = (construp = 1) * partime;
fter1 = (construp = 1) * (1 - partime);
extrapter1 = (construp = 1) * extrapay * partime;
extrafter1 = (construp = 1) * extrapay * (1 - partime);
partime1 = partime;
extra1 = extrapay;
keep pid year type1 construp1 constrdown1 pter1 extrapter1 fter1 extrafter1 partime1 extra1;

proc sort data = ua;
by pid year;

data ub;
set hp.pooled;
construp2 = construp;
constrdown2 = constrdown;
type2 = (construp = 1) + (constrdown = 1) * 2 + (construp + constrdown = 0) * 3;
pter2 = (construp = 1) * partime;
fter2 = (construp = 1) * (1 - partime);
extrapter2 = (construp = 1) * extrapay * partime;
extrafter2 = (construp = 1) * extrapay * (1 - partime);
partime2 = partime;
extra2 = extrapay;
year = year - 1;
keep pid year type2 construp2 constrdown2 pter2 extrapter2 fter2 extrafter2 partime2 wgt extra2;

proc sort data = ub;
by pid year;

******overall transitions;
data u;
merge ua(in = in1) ub(in = in2);
by pid year;
if in1 and in2;

proc freq data = u;
tables type1 * type2 construp1 * construp2 constrdown1 * constrdown2;
weight wgt; 

proc freq data = u;
tables partime1 * partime2 extra1 * extra2 partime1 * extra1 partime2 * extra2;
weight wgt; 

******partime worker transitions;
data p;
set u;
if partime1 = 1 and partime2 = 1;

proc freq data = p;
tables pter1 * pter2;
weight wgt;

data extrap;
set u;
if partime1 = 1 and partime2 = 1 and extra1 = 1 and extra2 = 1;

proc freq data = extrap;
tables extrapter1 * extrapter2;
weight wgt;

******fulltime worker transitions;
data q;
set u;
if partime1 = 0 and partime2 = 0;

proc freq data = q;
tables fter1 * fter2;
weight wgt; 

data extraq;
set u;
if partime1 = 0 and partime2 = 0 and extra1 = 1 and extra2 = 1;

proc freq data = extraq;
tables extrafter1 * extrafter2;
weight wgt; 

******partime-fulltime worker transitions;
data pq;
set u;
if partime1 = 1 and partime2 = 0;

proc freq data = pq;
tables construp1 * construp2;
weight wgt;

******fulltime-partime worker transitions;
data qp;
set u;
if partime1 = 0 and partime2 = 1;

proc freq data = qp;
tables construp1 * construp2;
weight wgt; 

******fulltime constrained transitions;
data up1;
set u;
if partime1 = 0 and construp1 = 1;
if partime2 = 0 and construp2 = 1 then type = 1;
else if partime2 = 0 and construp2 = 0 then type = 2;
else if partime2 = 1 and construp2 = 1 then type = 3;
else if partime2 = 1 and construp2 = 0 then type = 4;
else type = 0;

proc freq data = up1;
tables type;
weight wgt; 

******partime constrained transitions;
data up1;
set u;
if partime1 = 1 and construp1 = 1;
if partime2 = 0 and construp2 = 1 then type = 1;
else if partime2 = 0 and construp2 = 0 then type = 2;
else if partime2 = 1 and construp2 = 1 then type = 3;
else if partime2 = 1 and construp2 = 0 then type = 4;
else type = 0;
 
proc freq data = up1;
tables type;
weight wgt; 


run;

******household participating at least 6 years;

data u;
set hp.pooled;

proc sort data = u;
by pid;

proc means data = u noprint;
by pid;
var year;
output out = v n = num;

proc freq data = v;
tables num;

data v;
set v;
if num >= 6;

data u6a u6b;
merge u v(in = in1);
by pid;
if in1;

data u6a;
set u6a;
construp1 = construp;
constrdown1 = constrdown;
type1 = (construp = 1) + (constrdown = 1) * 2 + (construp + constrdown = 0) * 3;
keep pid year type1 construp1 constrdown1;

proc sort data = u6a;
by pid year;

data u6b;
set u6b;
construp2 = construp;
constrdown2 = constrdown;
type2 = (construp = 1) + (constrdown = 1) * 2 + (construp + constrdown = 0) * 3;
year = year - 1;
keep pid year type2 construp2 constrdown2 wgt;

proc sort data = u6b;
by pid year;

data u6;
merge u6a(in = in1) u6b(in = in2);
by pid year;
if in1 and in2;

proc freq data = u6;
tables type2 * type1 construp1 * construp2 constrdown1 * constrdown2;
weight wgt; run;
