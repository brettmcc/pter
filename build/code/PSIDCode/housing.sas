/**this macro produces the HomeProd.housing dataset
	Brett McCully, July 2014
**/
***homeowner (consistent coding across years)
1 owner
5 renter
8 other
;

* data for 1968 through 1986;
%let idvars  = V3 V442 V1102 V1802 V2402 V3002 V3402 V3802 V4302 V5202 V5702 V6302 V6902 V7502 V8202 V8802 V10002 V11102 V12502 V13702;
%let homeownvars = V103 V593 V1264 V1967 V2566 V3108 V3522 V3939 V4450 V5364 V5864 V6479 V7084 V7675 V8364 V8974 V10437 V11618 V13023;

%macro housing(yr,idvar,homeownvar);
	%let endyr = %substr(&yr,3);
	data housing&endyr;
		set psiddata.fam&endyr;
		id&yr = &idvar;
		homeown&yr = &homeownvar;
		keep id&yr. homeown&yr;
	run;
%mend;
%macro allyrs;
	%do i=1 %to 19;
		%let y = %eval(&i + 1967);
		%let id = %scan(&idvars,&i);
		%let hmvar = %scan(&homeownvars,&i);
		%housing(&y,&id,&hmvar);
	%end;
%mend;

%allyrs;

data HomeProd.housing;
	merge housing68 housing69 housing70 housing71 housing72 housing73 housing74 housing75 housing76 
	housing77 housing78 housing79 housing80 housing81 housing82 housing83 housing84 housing85 housing86;
run;
