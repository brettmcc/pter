**** Get job tenure variables
**** Brett McCully, December 2014;
%include 'setlibraries_psid.sas';

option mprint;

* data for 1968 through 1987;
%let idvars  = V3 V442 V1102 V1802 V2402 V3002 V3402 V3802 V4302 V5202 V5702 V6302 V6902 V7502 V8202
				V8802 V10002 V11102 V12502 V13702;
*1969-75;
%let tenyrbins = V642 V1281 V1987 V2585 V3118 V3533 V3984;
*1976-86;
%let tenmonths = V4488 V5397 V5888 V6499 V7102 V7722 V8390 V9021 V10520 V11669 V13069;
*same employer, 68, 76-78,81-86;
%let sameemp = V200 V4480 V5384 V5941 V7711 V8379 V9010 V10519 V11668 V13068;
*whether union member - 68-72, 74-81;
%let union = V294 V766 V1434 V2145 V2787 V3636 V4087 V4624 V5559 V6101 V6707 V7340 V7971;
*moved since last interview - 69-86;
%let relocated = V603 V1274 V1979 V2577 V3110 V3524 V3941 V4452 V5366 V5866 V6484 V7089 V7700 V8369 V8999 V10447 V11628 V13037;

*second job, 68-87;
%let secjob = V227 V660 V1298 V2004 V2602 V3135 V3550 V4005 V4518 V5428 V5915 V6526 V7129 V7744 V8406 V9037 V10564 V11708 V13108 V14206;
*main job wage, 70-87;
%let mainwage = V1297 V2003 V2601 V3134 V3549 V4003 V4513 V5424 V5911 V6522 V7125 V7718 V8386 V9017 
	V10466 V11657 V13060 V14160;
*number of additional jobs, 69-87;
%let num_addljobs = V662 V1300 V2006 V2604 V3137 V3552 V4007 V4520 V5430 V5917 V6528 V7131 V7746 V8408 V9039 V10565 V11709 V13109 V14207;


*second job question asks about previous year;
%macro tenure(yr,idvar,tenvar,secvar,wage,samemp,union,reloc,adljobs);
	*contemporaneous variables;
	%let endyr = %substr(&yr,3);
	%if &yr.<1987 %then %do;
	data tenure&endyr.;
		set psiddata.fam&endyr.;
		id&yr = &idvar.;
		%if &yr>1968 %then tenure&yr. = &tenvar.;
		%else %if &yr=1968 %then sameemp_mths&yr = &samemp.;
		;
		%if &yr>=1976 & &yr<=1978 %then sameemp_mths&yr = &samemp.;
		%else %if &yr>=1981 %then sameemp_mths&yr = &samemp.;
		;
		%if &yr<=1981 AND &yr.^=1973 %then union&yr. = &union.;
		;
		%if &yr>1968 %then %do;
			if &reloc.=1 then relocated&yr. = 1;
			if &reloc.=5 then relocated&yr. = 0;
		%end;


		%if &yr=1968 %then 
			keep id&yr. sameemp_mths&yr. union&yr.;
		%else %if (&yr>1978 & &yr<1981) OR (&yr>=1969 & &yr<1976 & &yr^=1973) %then 
			keep id&yr. tenure&yr. union&yr. relocated&yr.;
		%else %if &yr=1973 %then 
			keep id&yr. tenure&yr. relocated&yr.;
		%else %if (&yr>=1976 & &yr<=1978) OR &yr.=1981 %then 
			keep id&yr. tenure&yr. sameemp_mths&yr. union&yr. relocated&yr.;
		%else 
			keep id&yr. tenure&yr. sameemp_mths&yr. relocated&yr.;
		;
	run;
	%end;

	*retrospective variables;
	%let yr_1 = %eval(&yr.-1);
	data tenure_retro&endyr.;
		set psiddata.fam&endyr.;
		id&yr. = &idvar.;
		%if &yr.>=1970 %then mainwage&yr. = &wage.;
		;
		%if &yr.>1968 %then num_addljobs&yr. = &adljobs.;
		;
		secjob&yr. = &secvar.;

		%if &yr=1968 %then 
			keep id&yr. secjob&yr.;
		%else %if &yr=1969 %then 
			keep id&yr. secjob&yr. num_addljobs&yr.;
		%else 
			keep id&yr. secjob&yr. mainwage&yr. num_addljobs&yr.;
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
		%if &y<1973 %then %let unionvar = %scan(&union,%eval(&i));
		%else %if &y>1973 %then %let unionvar = %scan(&union,%eval(&i-1));
		%if &i>1 %then %let relocate = %scan(&relocated.,%eval(&i.-1));
		%if &i.>1 %then %let adljob = %scan(&num_addljobs.,%eval(&i.-1));
		%tenure(&y.,&id.,&tnvar.,&scvar.,&wgvar.,&smemp.,&unionvar.,&relocate.,&adljob.);
	%end;
	%do i=9 %to 20;
		%let y = %eval(&i+1967);
		%let id = %scan(&idvars,&i);
		%let tnvar = %scan(&tenmonths,%eval(&i-8));
		%let wgvar = %scan(&mainwage,%eval(&i-2));
		%let scvar = %scan(&secjob,&i);
		%if &y>=1976 & &y<=1978 %then %let smemp = %scan(&sameemp,%eval(&i-7));
		%else %if &y>1980 %then %let smemp = %scan(&sameemp,%eval(&i-9));
		%if &y<=1981 %then %let unionvar = %scan(&union,%eval(&i-1));
		%let relocate = %scan(&relocated.,%eval(&i.-1));
		%let adljob = %scan(&num_addljobs.,%eval(&i.-1));
		%tenure(&y.,&id.,&tnvar.,&scvar.,&wgvar.,&smemp.,&unionvar.,&relocate.,&adljob.);
	%end;
%mend;
%allyrs;

data temp.tenure;
	merge tenure68 tenure69 tenure70 tenure71 tenure71 tenure72 tenure73 tenure74 tenure75 tenure76 
	tenure77 tenure78 tenure79 tenure80 tenure81 tenure82 tenure83 tenure84 tenure85 tenure86 
	tenure_retro68 tenure_retro69 tenure_retro70 tenure_retro71 tenure_retro71 tenure_retro72
	tenure_retro73 tenure_retro74 tenure_retro75 tenure_retro76 tenure_retro77 tenure_retro78
	tenure_retro79 tenure_retro80 tenure_retro81 tenure_retro82 tenure_retro83 tenure_retro84
	tenure_retro85 tenure_retro86 tenure_retro87;
run;
