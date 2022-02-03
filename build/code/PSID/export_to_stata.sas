%include 'setlibraries_psid.sas';

proc export
	data=out.pooled
	outfile="C:\Users\bmccully\Documents\pter-master\build\output\pooled.dta"
	dbms=STATA
	replace;
run;
