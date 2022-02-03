*********summary statistics of the PSID sample;

libname hp '/hpc/household_finance/BoardResearch/HP/WorkDir/Revision';

********share of constrained (household * year observations);
data u;
set hp.pooled;
if year ge 1968;   ******1968 - 1986, excluding 1967 constraint status;

proc freq data = u;
tables construp constrdown extrapay * construp extrapay * constrdown partime * construp partime * constrdown;
weight wgt;

******50+;
data u;
set hp.pooled;
if year ge 1968;   ******1968 - 1986, excluding 1967 constraint status;
if headage ge 50;

proc freq data = u;
tables construp constrdown extrapay * construp extrapay * constrdown;
weight wgt;

******share of experiencing constraints at least once;
proc sort data = u;
by pid;

proc means data = u noprint;
by pid;
var construp constrdown wgt;
output out = v max = construp constrdown wgt mean = up down mweight;

data v;
set v;
unconstrained = construp + constrdown = 0;

proc means data = v;
var construp constrdown unconstrained;
weight mweight; run;

******preliminary analysis of number of years each household head participating in the survey;
data all;
set hp.pooled_all;
if year ge 1968;

proc sort data = all;
by pid;

proc means data = all noprint;
by pid;
var year;
output out = v n = num;

proc freq data = v;
tables num;

******share of experiencing constraints at least once during 6+ years;
data v;
set v;
if num >= 6;

data u6;
merge u v(in = in1);
by pid;
if in1;

proc means data = u6 noprint;
by pid;
var construp constrdown wgt;
output out = v6 max = construp constrdown wgt mean = up down mweight;

proc means data = v6;
var construp constrdown;
weight mweight; run;

******number of constraints over the years;
proc means data = u6 noprint;
by pid;
var construp constrdown;
output out = count sum = construp_count constrdown_count n = time;

proc freq data = count;
tables construp_count constrdown_count time;

data hp.pooled_persistent;
merge hp.pooled v(in = in1) count(in = in2);
by pid;
if in1 and in2;
run;

******time series of constraints--total, among part time and full time workers, and among those who earn additional;
data u;
set hp.pooled; ******we include 1967 in this analysis;

proc sort data = u;
by year gender;

proc means data = u noprint;
output out = trend mean = share_up share_down;
by year;
weight wgt;
var construp constrdown;

proc export data = trend outfile = '/href/research2/m1gxl01/BoardResearch/HP/Output/Revision/trend.csv' dbms = csv replace;

proc means data = u noprint;
output out = trend_gender mean = share_up share_down;
by year gender;
weight wgt;
var construp constrdown;

proc sort data = trend_gender;
by gender year;

proc export data = trend_gender outfile = '/href/research2/m1gxl01/BoardResearch/HP/Output/Revision/trend_gender.csv' dbms = csv replace;

data partime;
set u;
construp = construp * partime;

proc means data = partime noprint;
output out = trend_partime mean = share_up_partime;
by year;
weight wgt;
var construp;

proc export data = trend_partime outfile = '/href/research2/m1gxl01/BoardResearch/HP/Output/Revision/trend_partime.csv' dbms = csv replace;

proc means data = partime noprint;
output out = trend_partime_gender mean = share_up_partime;
by year gender;
weight wgt;
var construp;

proc sort data = trend_partime_gender;
by gender year;

proc export data = trend_partime_gender outfile = '/href/research2/m1gxl01/BoardResearch/HP/Output/Revision/trend_partime_gender.csv' dbms = csv replace;

data extra;
set u;
construp = construp * extrapay;

proc sort data = extra;
by year;

proc means data = extra noprint;
output out = trend_extra mean = share_up_extra;
by year;
weight wgt;
var construp;

proc export data = trend_extra outfile = '/href/research2/m1gxl01/BoardResearch/HP/Output/Revision/trend_extra.csv' dbms = csv replace;

proc means data = extra noprint;
output out = trend_extra_gender mean = share_up_extra;
by year gender;
weight wgt;
var construp;

proc sort data = trend_extra_gender;
by gender year;

proc export data = trend_extra_gender outfile = '/href/research2/m1gxl01/BoardResearch/HP/Output/Revision/trend_extra_gender.csv' dbms = csv replace;

data prime;
set u;
construp = construp * partime;
if 25 le headage < 55;

proc means data = prime noprint;
output out = trend_prime mean = share_up_prime;
by year;
weight wgt;
var construp;

proc export data = trend_prime outfile = '/href/research2/m1gxl01/BoardResearch/HP/Output/Revision/trend_prime.csv' dbms = csv replace;

proc means data = prime noprint;
output out = trend_prime_gender mean = share_up_prime;
by year gender;
weight wgt;
var construp;

proc sort data = trend_prime_gender;
by gender year;

proc export data = trend_prime_gender outfile = '/href/research2/m1gxl01/BoardResearch/HP/Output/Revision/trend_prime_gender.csv' dbms = csv replace;

data trend_male;
set trend_gender;
if gender = 1;
share_up_male = share_up;
keep year share_up_male;

data trend_female;
set trend_gender;
if gender = 2;
share_up_female = share_up;
keep year share_up_female;

data trend_partime_male;
set trend_partime_gender;
if gender = 1;
share_up_partime_male = share_up_partime;
keep year share_up_partime_male;

data trend_partime_female;
set trend_partime_gender;
if gender = 2;
share_up_partime_female = share_up_partime;
keep year share_up_partime_female;

data trend_extra_male;
set trend_extra_gender;
if gender = 1;
share_up_extra_male = share_up_extra;
keep year share_up_extra_male;

data trend_extra_female;
set trend_extra_gender;
if gender = 2;
share_up_extra_female = share_up_extra;
keep year share_up_extra_female;

data trend_prime_male;
set trend_prime_gender;
if gender = 1;
share_up_prime_male = share_up_prime;
keep year share_up_prime_male;

data trend_prime_female;
set trend_prime_gender;
if gender = 2;
share_up_prime_female = share_up_prime;
keep year share_up_prime_female;

data trend;
set trend;
keep year share_up;

data trend_all;
merge trend trend_male trend_female trend_partime trend_partime_male trend_partime_female trend_extra trend_extra_male trend_extra_female trend_prime trend_prime_male trend_prime_female;
by year;

proc export data = trend_all outfile = '/href/research2/m1gxl01/BoardResearch/HP/Output/Revision/trend_all.csv' dbms = csv replace;
run;
run;

******demographics--age, education, race, marital status, working part-time;
data u;
set hp.pooled;
if year ge 1968;
type = (construp = 1) + (constrdown = 1) * 2 + (construp + constrdown = 0) * 3;

proc freq data = u;
tables type headedu;

proc freq data = u;
tables type type * partime type * headedu type * headwhite type * headmarried;
weight wgt;

proc sort data = u;
by type;

proc means data = u vardef = wgt;
var headage;
by type; weight wgt;

******income and hours;
proc means data = u vardef = wgt;
var faminc headhour;
by type; weight wgt;

******home production--foodout ratio, housework hours;

proc sort data = u;
by headmarried type;

proc means data = u vardef = wgt;;
var foodin foodout hwhead hwwife;
by headmarried type;
weight wgt;
run;

******Occupation and industry;
data u;
set hp.pooled;
if year ge 1968;   ******1968 - 1986, excluding 1967 constraint status;

proc sort data = u;
by headocc;

proc means data = u noprint;
by headocc; 
var construp constrdown;
weight wgt; 
output out = v mean = construp constrdown;

proc print data = v;
var headocc construp constrdown; 

proc corr data = v;
var construp constrdown; 

proc sort data = u;
by headind;

proc means data = u noprint;
by headind; 
var construp constrdown;
weight wgt; 
output out = v mean = construp constrdown;

proc print data = v;
var headind construp constrdown; 

proc corr data = v;
var construp constrdown; run;
