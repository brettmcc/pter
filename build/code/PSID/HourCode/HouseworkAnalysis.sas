*********Housework Analysis -- we study the relationship between the estimated number of market hours constraints *********
*********and the estimated number of changes in housework                                                         *********;

***********************************************************************************************************************;
***********************************************************************************************************************;
***********************************************************************************************************************;
data housework;
set HomeProd.LAGHW;
HeadhourP = Headhour;    
DHeadhour = Headhour - lagHeadhour;
DWifehour = Wifehour - lagWifehour;
HWHeadP = HWHead;  
HWWifeP = HWWife;  
HWHWP = HWHW;  
if married = 1;
if abs(DHeadhour) < 2000; 
if abs(DWifehour) < 2000; 
if construp = 1 or constrdown = 1 then do; HeadhourP = .; HWHeadP = .; HWHWP = .; end;

proc reg data = housework;
model HeadHourP = lagHeadhour Wifehour lagWifehour Age2 Age6 Age12 Age18 Adults dis 
                  headage headage2 white highschool     somecollege     college     realheadwage 
                  wifeage wifeage2       wifehighschool wifesomecollege wifecollege realwifewage wifeparttime wifefulltime 
                  q2 - q5 year1970 - year1986 ;
output out = HourhatP p = predict;

data HourgapP;
set HourhatP;
if constraint > 0 then Net = Headhour - predict;
else Net = 0;

*********Housework Hours;
data HouseworkP;
set HourGapP;
if constraint > 0 then HeadHour = predict;

proc reg data = HouseworkP;
model HWHeadP = HWHeadLag headhour wifehour headage headage2 white highschool somecollege college children adults 
                wifeage wifeage2 wifehighschool wifesomecollege wifecollege wifeparttime wifefulltime 
                realheadwage realwifewage p2 - p10 year1969 - year1973 year1975 - year1980 year1982 - year1986; 
output out = HWHeadhat p = PredictHWHead;
run;

data HWHeadhat;
set HWHeadhat;
if constraint > 0;
HWHeadNet = HWHead - PredictHWHead;
 
proc sort data = HWHeadhat;
by constraint;

proc univariate data = HWHeadhat;
var Net HWHeadNet;
by constraint; 
run;

proc corr data = HWHeadhat;
var Net HWHeadNet;
by constraint;  

proc corr data = HWHeadhat;
var Net HWHeadNet;
run;

data housework;
set HomeProd.LAGHW;
HeadhourP = Headhour;    
DHeadhour = Headhour - lagHeadhour;
DWifehour = Wifehour - lagWifehour;
HWHeadP = HWHead;  
HWWifeP = HWWife;  
HWHWP = HWHW;  
if married = 0;
if abs(DHeadhour) < 2000; 
if abs(DWifehour) < 2000; 
if construp = 1 or constrdown = 1 then do; HeadhourP = .; HWHeadP = .; HWHWP = .; end;

proc reg data = housework;
model HeadHourP = lagHeadhour lagWifehour Age2 Age6 Age12 Age18 Adults dis 
                  headage headage2 white female highschool somecollege college realheadwage 
                  q2 - q5 year1970 - year1986 ;
output out = HourhatP p = predict;

data HourgapP;
set HourhatP;
if constraint > 0 then Net = Headhour - predict;
else Net = 0;

*********Housework Hours;
data HouseworkP;
set HourGapP;
if constraint > 0 then HeadHour = predict;

proc reg data = HouseworkP;
model HWHeadP = HWHeadLag headhour headage headage2 white female highschool somecollege college children adults 
                realheadwage p2 - p10 year1969 - year1973 year1975 - year1980 year1982 - year1986; 
output out = HWHeadhat p = PredictHWHead;
run;

data HWHeadhat;
set HWHeadhat;
if constraint > 0;
HWHeadNet = HWHead - PredictHWHead;
 
proc sort data = HWHeadhat;
by constraint;

proc univariate data = HWHeadhat;
var Net HWHeadNet;
by constraint; 
run;

proc corr data = HWHeadhat;
var Net HWHeadNet;
by constraint;  

proc corr data = HWHeadhat;
var Net HWHeadNet;
run;
