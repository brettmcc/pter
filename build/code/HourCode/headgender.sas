*headgender;

%macro headgender(year, varnum,idvar);
	%let yy = %substr(&year,3);
	data headgender&year.;
		set psiddata.Fam&yy.;
		gender&year. = &varnum.;
		id&year. = v&idvar.;
		keep gender&year. id&year.;
	run;
%mend;
%headgender(1968,v119,3) %headgender(1969,v1010,442) %headgender(1970,v1240,1102) 
%headgender(1971,v1943,1802) %headgender(1972,v2543,2402) %headgender(1973,v3096,3002)
%headgender(1974,v3509,3402) %headgender(1975,v3922,3802) %headgender(1976,v4437,4302)
%headgender(1977,v5351,5202) %headgender(1978,v5851,5702) %headgender(1979,v6463,6302)
%headgender(1980,v7068,6902) %headgender(1981,v7659,7502) %headgender(1982,v8353,8202)
%headgender(1983,v8962,8802) %headgender(1984,v10420,10002) %headgender(1985,v11607,11102)
%headgender(1986,v13012,12502) %headgender(1987,v14115,13702);

data psiddata.headgender;
	set headgender1968 headgender1969 headgender1970 headgender1971 headgender1972 headgender1973 headgender1974 headgender1975 headgender1976 headgender1977 headgender1978
		headgender1979 headgender1980 headgender1981 headgender1982 headgender1983 headgender1984 headgender1985 headgender1986 headgender1987;
	run;
