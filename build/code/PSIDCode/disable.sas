/**this macro produces the HomeProd.disable dataset
	Brett McCully, July 2014
**/
%include 'setlibraries_psid.sas';
%let idvars  = V442 V1102 V1802 V2402 V3002 V3402 V3802 V4302 V5202 V5702 V6302 V6902 V7502 V8202 V8802 V10002 V11102 V12502 V13702;
%let disvars = V745 V1411 V2123 V2718 V3244 V3666 V4145 V4625 V5560 V6102 V6710 V7343 V7974 V8616 V9290 V10879 V11993 V13427 V14515;

%macro dis(yr,idvar,disvar);
	%let endyr = %substr(&yr,3);
	data dis&endyr;
		set psiddata.fam&endyr;
		id&yr = &idvar;
		dis&yr = &disvar;
		%if %eval(&yr<=1971) %then if dis&yr=3 then dis&yr = 1;
		;
		keep id&yr. dis&yr;
	run;
%mend;

%macro allyrs;
	%do i=1 %to 19;
		%let y = %eval(&i + 1968);
		%let id = %scan(&idvars,&i);
		%let disv = %scan(&disvars,&i);
		%dis(&y,&id,&disv);
	%end;
%mend;

%allyrs;

data temp.disable;
	merge dis69 dis70 dis71 dis72 dis73 dis74 dis75 dis76 dis77 dis78 dis79 dis80 dis81 dis82 dis83 dis84 dis85 dis86 dis87;
run;
