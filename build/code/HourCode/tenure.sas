**** Get job tenure variables
**** Brett McCully, December 2014

;

option mprint;

* data for 1969 through 1986;
%let idvars  = V3 V442 V1102 V1802 V2402 V3002 V3402 V3802 V4302 V5202 V5702 V6302 V6902 V7502 V8202 V8802 V10002 V11102 V12502 V13702;
*1969-75;
%let tenyrbins = V642 V1281 V1987 V2585 V3118 V3533 V3984;
*1976-86;
%let tenmonths = V4488 V5397 V5888 V6499 V7102 V7722 V8390 V9021 V10520 V11669 V13069;
*second job, 68-87;
%let secjob = V227 V660 V1298 V2004 V2602 V3135 V3550 V4005 V4518 V5428 V5915 V6526 V7129 V7744 V8406 V9037 V10564 V11708 V13108 V14206;
*main job wage, 70-86;
%let mainwage = V1297 V2003 V2601 V3134 V3549 V4003 V4513 V5424 V5911 V6522 V7125 V7718 V8386 V9017 V10466 V11657 V13060;
*same employer, 68, 76-78,81-86;
%let sameemp = V200 V4480 V5384 V5941 V7711 V8379 V9010 V10519 V11668 V13068;

*second job question asks about previous year;
%macro tenure(yr,idvar,tenvar,secvar,wage,samemp);
	%let endyr = %substr(&yr,3);
	%let yr_1 = %eval(&yr-1);
	data tenure&endyr;
		set psiddata.fam&endyr;
		id&yr = &idvar;
		%if &yr>1968 %then tenure&yr = &tenvar;
		%else %if &yr=1968 %then sameemp_mths&yr = &samemp;
		;
		%if &yr>=1976 & &yr<=1978 %then sameemp_mths&yr = &samemp;
		%else %if &yr>=1981 %then sameemp_mths&yr = &samemp;
		;
		%if &yr>=1970 %then mainwage&yr = &wage;
		;
		secjob&yr_1 = &secvar;
		%if &yr=1968 %then keep id&yr. secjob&yr_1 sameemp_mths&yr;
		%else %if &yr=1969 %then keep id&yr. tenure&yr. secjob&yr_1;
		%else %if &yr>1969 & &yr<1976 %then keep id&yr. tenure&yr. secjob&yr_1. mainwage&yr.;
		%else %if &yr>=1976 & &yr<=1978 %then keep id&yr. tenure&yr. secjob&yr_1. mainwage&yr. sameemp_mths&yr;
		%else %if &yr>1978 & &yr<1981 %then keep id&yr. tenure&yr. secjob&yr_1. mainwage&yr.;
		%else keep id&yr. tenure&yr. secjob&yr_1. mainwage&yr. sameemp_mths&yr;
		;
	run;
%mend;
%macro allyrs;
	%do i=1 %to 8;
		%let y = %eval(&i+1967);
		%let id = %scan(&idvars,&i);
		%if &i>1 %then %let tnvar = %scan(&tenyrbins,%eval(&i-1));
		%if &i>2 %then %let wgvar = %scan(&mainwage,%eval(&i-2));
		%if &y=1968 %then %let smemp = %scan(&sameemp,1);
		%let scvar = %scan(&secjob,&i);
		%tenure(&y,&id,&tnvar,&scvar,&wgvar,&smemp);
	%end;
	%do i=9 %to 19;
		%let y = %eval(&i+1967);
		%let id = %scan(&idvars,&i);
		%let tnvar = %scan(&tenmonths,%eval(&i-8));
		%let wgvar = %scan(&mainwage,%eval(&i-2));
		%let scvar = %scan(&secjob,&i);
		%if &y>=1976 & &y<=1978 %then %let smemp = %scan(&sameemp,%eval(&i-7));
		%else %if &y>1980 %then %let smemp = %scan(&sameemp,%eval(&i-9));
		%tenure(&y,&id,&tnvar,&scvar,&wgvar,&smemp);
	%end;
%mend;
%allyrs;

data HomeProd.tenure;
	merge tenure69 tenure70 tenure71 tenure71 tenure72 tenure73 tenure74 tenure75 tenure76 
	tenure77 tenure78 tenure79 tenure80 tenure81 tenure82 tenure83 tenure84 tenure85 tenure86;
run;
