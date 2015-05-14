data foodpct;
set HomeProd.LAGFood;

HeadhourP = Headhour;    
DHeadhour = Headhour - lagHeadhour;
DWifehour = Wifehour - lagWifehour;
FoodpctP = Foodpct;
lagfoodpct = foodoutlag / max(1, foodinlag + foodoutlag);
if abs(DHeadhour) < 2000; 
if abs(DWifehour) < 2000; 
if construp = 1 or constrdown = 1 then do; HeadhourP = .; FoodpctP = .; end;
if married = 1;

proc reg data = foodpct;
model HeadHourP = lagHeadhour Wifehour lagWifehour Age2 Age6 Age12 Age18 Adults dis 
                  headage headage2 white highschool     somecollege     college     realheadwage 
                  wifeage wifeage2       wifehighschool wifesomecollege wifecollege realwifewage wifeparttime wifefulltime 
                  q2 - q5 year1970 - year1986 ;
output out = HourhatP p = predict;

data HourgapP;
set HourhatP;
if constraint > 0 then Net = Headhour - predict;
else Net = 0;

*********Foodout Ratio;
data FoodpctP;
set HourhatP;
if constraint > 0 then Net = Headhour - predict;
else Net = 0;

proc reg data = FoodpctP;
model FoodpctP = lagfoodpct Age2 Age6 Age12 Age18 Adults dis 
                  headage headage2 white highschool     somecollege     college     realheadwage 
                  wifeage wifeage2       wifehighschool wifesomecollege wifecollege realwifewage wifeparttime wifefulltime 
                  q2 - q5 year1970 - year1986 ;
output out = foodpcthat p = Predictfoodpct;
run;

data foodpcthat;
set foodpcthat;
if constraint > 0;
foodpctNet = foodpct - Predictfoodpct;

proc sort data = foodpcthat;
by constraint;

proc univariate data = foodpcthat;
var Net foodpctNet; 
by constraint; 

proc reg data = foodpcthat;
model foodpctnet = Net Age2 Age6 Age12 Age18 Adults dis 
                   headage headage2 white highschool     somecollege     college     realheadwage 
                   wifeage wifeage2       wifehighschool wifesomecollege wifecollege realwifewage wifeparttime wifefulltime 
                   q2 - q5 year1970 - year1986 ;
output out = HourhatP p = predict;

proc corr data = foodpcthat;
var Net foodpctNet; 
by constraint;  

proc corr data = foodpcthat;
var Net foodpctNet; 
run;

data foodpct;
set HomeProd.LAGFood;

HeadhourP = Headhour;    
DHeadhour = Headhour - lagHeadhour;
DWifehour = Wifehour - lagWifehour;
FoodpctP = Foodpct;
lagfoodpct = foodoutlag / max(1, foodinlag + foodoutlag);
if abs(DHeadhour) < 2000; 
if abs(DWifehour) < 2000; 
if construp = 1 or constrdown = 1 then do; HeadhourP = .; FoodpctP = .; end;
if married = 0;

proc reg data = foodpct;
model HeadHourP = lagHeadhour Wifehour lagWifehour Age2 Age6 Age12 Age18 Adults dis 
                  headage headage2 white female highschool     somecollege     college     realheadwage 
                  q2 - q5 year1970 - year1986 ;
output out = HourhatP p = predict;

data HourgapP;
set HourhatP;
if constraint > 0 then Net = Headhour - predict;
else Net = 0;

*********Foodout Ratio;
data FoodpctP;
set HourhatP;
if constraint > 0 then Net = Headhour - predict;
else Net = 0;

proc reg data = FoodpctP;
model FoodpctP = lagfoodpct Age2 Age6 Age12 Age18 Adults dis 
                  headage headage2 white female highschool     somecollege     college     realheadwage 
                  q2 - q5 year1970 - year1986 ;
output out = foodpcthat p = Predictfoodpct;
run;

data foodpcthat;
set foodpcthat;
if constraint > 0;
foodpctNet = foodpct - Predictfoodpct;

proc sort data = foodpcthat;
by constraint;

proc univariate data = foodpcthat;
var Net foodpctNet; 
by constraint; 

proc reg data = foodpcthat;
model foodpctnet = Net Age2 Age6 Age12 Age18 Adults dis 
                   headage headage2 white highschool     somecollege     college     realheadwage 
                   wifeage wifeage2       wifehighschool wifesomecollege wifecollege realwifewage wifeparttime wifefulltime 
                   q2 - q5 year1970 - year1986 ;
output out = HourhatP p = predict;

proc corr data = foodpcthat;
var Net foodpctNet; 
by constraint;  

proc corr data = foodpcthat;
var Net foodpctNet; 
run;
