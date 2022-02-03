*proc logistic data = HomeProd.Baseline;
*class leisure;
*model leisure = construp constrdown headage headage2 white highschool somecollege college children adults 
                p2 - p10 headhour wifehour hourlywage year1969 - year1971;

**************Tobit;
*proc qlim data = HomeProd.Baseline;
*model foodpct = construp constrdown headage headage2 white married highschool somecollege college 
                children adults p2 - p10 headhour wifehour year1970 - year1972 year1974 - year1986;
*endogenous foodpct ~ censored(lb = 0 ub = 100);
*run;
*run;
*run;
*keep pid year wgt foodin foodout food foodpct logfood realfood otherincome realotherincome salaried
     faminc logincome realfaminc headlabor wifelabor labor realheadlabor realwifelabor reallabor HWHP
     headwage wifewage realheadwage realwifewage headhour wifehour wifeparttime wifefulltime totalhour markethome homeprod
     children adults famsize gender headage headage2 white married male gender highschool somecollege college 
     belowhighschool abovehighschool headocc headind wifeage wifeedu wifeocc wifeind headextra wifeextra headsalaried wifesalaried
     wifeage wifeage2 wifehighschool wifesomecollege wifecollege 
	 construp wifeconstrup constrdown constraint HWHW HWHead HWWife HeadVacationWeek WifeVacationWeek 
     headocc1 - headocc12 headind1 - headind12 p1 - p10 q1 - q5 year1968 - year1986
     lagHWHW lagHWHead lagHWWife lagheadhour lagwifehour age2 age6 age12 age18;  

*proc reg data = married;
*model Headhour = construp constrdown headage headage2 white highschool somecollege college children adults realheadwage  
                 headind2 - headind12 q2 - q5 headocc2 - headocc12 year1968 - year1986; run; 

*proc reg data = married;
*model Wifehour = construp constrdown headage headage2 white highschool somecollege college children adults 
                 wifeage wifeage2 wifehighschool wifesomecollege wifecollege wifeparttime wifefulltime 
                 realheadwage realwifewage q2 - q5 year1968 - year1986; 
*run;
*run;

