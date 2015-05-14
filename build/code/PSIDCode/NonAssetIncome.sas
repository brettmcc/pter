*********Construct family nonasset income as the sum of head labor income, wife labor income, head plus wife  *********
*********transfer income, other members' taxable income and other members' transfer income, head and wife     *********
*********nonasset income is the sum of head and wife labor and transfer income                                *********
*********We then merge them with the existing psiddata.income                                                 *********;

data inc1968;
set psiddata.income1968;
FamNAST1968 = Faminc1968 - HeadRDI1968;; 
HWNAST1968 = FamNAST1968 - OthTaxable1968; 
keep id1968 Faminc1968 HeadLabor1968 WifeLabor1968 HeadSalary1968 FamNAST1968 HWNAST1968 TotalFarm1968;
proc means data = inc1968;
proc sort data = inc1968;
by id1968;
run;

data inc1969;
set psiddata.income1969;
FamNAST1969 = Faminc1969 - HeadRDI1969;; 
HWNAST1969 = FamNAST1969 - OthTaxable1969 - OthTrans1969; 
keep id1969 Faminc1969 HeadLabor1969 WifeLabor1969 HeadSalary1969 FamNAST1969 HWNAST1969 TotalFarm1969;
proc means data = inc1969;
proc sort data = inc1969;
by id1969;
run;

%macro nasset(year);
data inc&year;
set psiddata.income&year.;
FamNAST&year. = HeadLabor&year. + WifeLabor&year. + HWTrans&year. + OthTaxable&year. + OthTrans&year.; 
HWNAST&year. = HeadLabor&year. + WifeLabor&year. + HWTrans&year.; 
keep id&year. Faminc&year. HeadLabor&year. WifeLabor&year. HeadSalary&year. HWTrans&year FamNAST&year. HWNAST&year. TotalFarm&year.;
proc sort data = inc&year.;
by id&year.;
proc means data = inc&year.;
proc univariate data = inc&year;
var TotalFarm&year.;
run;
%mend;
%nasset(1970) %nasset(1971) %nasset(1972) %nasset(1973) %nasset(1974) %nasset(1975) %nasset(1976) %nasset(1977)
%nasset(1978) %nasset(1979) %nasset(1980) %nasset(1981) %nasset(1982) %nasset(1983) %nasset(1984) %nasset(1985)
%nasset(1986) %nasset(1987) %nasset(1988) %nasset(1989) %nasset(1990) %nasset(1991) %nasset(1992) %nasset(1993)

%macro nasset(year);
data inc&year;
set psiddata.income&year.;
FamNAST&year. = HeadLabor&year. + WifeLabor&year. + HWTrans&year. + FamSSI&year + OthTaxable&year. + OthTrans&year.; 
HWNAST&year. = HeadLabor&year. + WifeLabor&year. + HWTrans&year. + FamSSI&year; 
keep id&year. Faminc&year. HeadLabor&year. WifeLabor&year. HeadSalary&year. HWTrans&year FamNAST&year. HWNAST&year. TotalFarm&year.;
proc sort data = inc&year.;
by id&year.;
proc means data = inc&year.;
run;
%mend;
%nasset(1994) %nasset(1995) %nasset(1996) %nasset(1997) %nasset(1999) %nasset(2001) %nasset(2003) 

%macro nasset(year);
data inc&year;
set psiddata.income&year.;
FamNAST&year. = HeadLabor&year. + WifeLabor&year. + HWTrans&year. + HeadSSI&year + WifeSSI&year + OthTaxable&year. + OthTrans&year.; 
HWNAST&year. = HeadLabor&year. + WifeLabor&year. + HWTrans&year. + HeadSSI&year + WifeSSI&year; 
keep id&year. Faminc&year. HeadLabor&year. WifeLabor&year. HeadSalary&year. HWTrans&year FamNAST&year. HWNAST&year. TotalFarm&year.;
proc sort data = inc&year.;
by id&year.;
proc means data = inc&year.;
run;
%mend;
%nasset(2005)

data psiddata.income;
merge inc1968 inc1969 inc1970 inc1971 inc1972 inc1973 inc1974 inc1975 inc1976 inc1977 inc1978 inc1979 
      inc1980 inc1981 inc1982 inc1983 inc1984 inc1985 inc1986 inc1987 inc1988 inc1989 inc1990 inc1991 
      inc1992 inc1993 inc1994 inc1995 inc1996 inc1997 inc1999 inc2001 inc2003 inc2005;
proc means data = psiddata.income;
run;
