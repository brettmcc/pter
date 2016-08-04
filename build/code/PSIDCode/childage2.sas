/**this program produces the Homeprod.childage dataset
	Brett McCully, August 2014
**/
%let idvars =    V3 V442 V1102 V1802 V2402 V3002 V3402 V3802 V4302 V5202 V5702 V6302 V6902 V7502 V8202 V8802 V10002 V11102 V12502 V13702;
%let chagevars = v120 v1013 v1243 v1946 v2546 v3099 v3512 v3925 V4440 v5354 v5854 v6466 v7071 v7662 v8536 v8965 v10423 v11610 v13015 v14118;


%macro age(yr,idvar,chagevar);
	%let endyr = %substr(&yr,3);
	data chage&endyr;
		set psiddata.fam&endyr;
		id&yr = &idvar;
		age&yr = &chagevar;
		%if %eval(&yr<=1969) %then %do;
			if age&yr in (9,0) then age&yr=.;
			*take middle of age bucket;
			else if age&yr=8 then age&yr = 16;
			else if age&yr=7 then age&yr = 11;
			else if age&yr=6 then age&yr = 7;
		%end;
		if age&yr in (0,99) then age&yr=.;
		keep id&yr. age&yr;
	run;
	proc sort data=psiddata.person;
		by id&yr.;
	run;
	data chage&endyr;
		%if %eval(&yr>1968) %then merge chage&endyr. psiddata.person(keep=id&yr. rel&yr. seqno&yr.);
		%else merge chage&endyr. psiddata.person(keep=id&yr. rel&yr.);
		;
		by id&yr.;
	run;
%mend;
%macro allyrs;
	%do i=1 %to 20;
		%let y = %eval(&i + 1967);
		%let id = %scan(&idvars,&i);
		%let agev = %scan(&chagevars,&i);
		%age(&y,&id,&agev);
 	%end;
 %mend;
 
%allyrs;
data HomeProd.childage;
	merge chage68 chage69 chage70 chage70 chage71 chage72 chage73 chage74 chage75 chage76 chage77 chage78 chage79 chage80 chage81 chage82 chage83 chage84 chage85 chage86 chage87;
run;
