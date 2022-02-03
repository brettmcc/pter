/****************************************************************************************/
/**********CREATE MERGED FILE TO RUN COUNT PROGRAM*****************/
/***************************************************************************************/

proc sort data=homeprod1967;
	by pid;
run;
proc sort data=homeprod1968;
	by pid;
run;
proc sort data=homeprod1969;
	by pid;
run;
proc sort data=homeprod1970;
	by pid;
run;
proc sort data=homeprod1971;
	by pid;
run;
proc sort data=homeprod1972;
	by pid;
run;
proc sort data=homeprod1973;
	by pid;
run;
proc sort data=homeprod1974;
	by pid;
run;
proc sort data=homeprod1975;
	by pid;
run;
proc sort data=homeprod1976;
	by pid;
run;
proc sort data=homeprod1977;
	by pid;
run;
proc sort data=homeprod1978;
	by pid;
run;
proc sort data=homeprod1979;
	by pid;
run;
proc sort data=homeprod1980;
	by pid;
run;
proc sort data=homeprod1981;
	by pid;
run;
proc sort data=homeprod1982;
	by pid;
run;
proc sort data=homeprod1983;
	by pid;
run;
proc sort data=homeprod1984;
	by pid;
run;
proc sort data=homeprod1985;
	by pid;
run;
proc sort data=homeprod1986;
	by pid;
run;

data temp;
	merge homeprod1967 homeprod1968;
		by pid;
run;
data temp;
	merge temp homeprod1969;
		by pid;
run;
data temp;
	merge temp homeprod1970;
		by pid;
run;
data temp;
	merge temp homeprod1971;
		by pid;
run;
data temp;
	merge temp homeprod1972;
		by pid;
run;
data temp;
	merge temp homeprod1973;
		by pid;
run;
data temp;
	merge temp homeprod1974;
		by pid;
run;
data temp;
	merge temp homeprod1975;
		by pid;
run;
data temp;
	merge temp homeprod1976;
		by pid;
run;
data temp;
	merge temp homeprod1977;
		by pid;
run;
data temp;
	merge temp homeprod1978;
		by pid;
run;
data temp;
	merge temp homeprod1979;
		by pid;
run;
data temp;
	merge temp homeprod1980;
		by pid;
run;
data temp;
	merge temp homeprod1981;
		by pid;
run;
data temp;
	merge temp homeprod1982;
		by pid;
run;
data temp;
	merge temp homeprod1983;
		by pid;
run;
data temp;
	merge temp homeprod1984;
		by pid;
run;
data temp;
	merge temp homeprod1985;
		by pid;
run;
data homeprod.merged;
	merge temp homeprod1986;
		by pid;
constrdown1987 = 0;
construp1987 = 0;
weight = mean(of wgt1968 - wgt1986); 
keep pid construp1967 - construp1987 constrdown1967 - constrdown1987 weight;
run;

/****************************************************************************************/
/**********RUN COUNT PROGRAM FOR CONSTRDOWN*************************/
/***************************************************************************************/

data HomeProd.constrdowncount;
set HomeProd.merged;
array years(21) constrdown1967-constrdown1987;
longest_str=0;
length_str=0;
num_str=0;
if years[1]=1 then do;
   length_str=1;
   num_str=1;
end;
do i=2 to dim(years);
  select (years[i]);
    when (0) do;
      if years[i-1]=1 then do;
        if length_str>longest_str
          then longest_str=length_str;
      end;
    end;
    when (1) do;
      if years[i-1]=0 then do;
        num_str=num_str+1;
        length_str=1;
      end;
      if years[i-1]=1
        then length_str=length_str+1;
    end;
   otherwise;
   end;
 end;
num_strd = num_str;
run;

proc freq data = HomeProd.constrdowncount;
tables longest_str  num_str; weight weight;
run;
/****************************************************************************************/
/**********RUN COUNT PROGRAM FOR CONSTRUP****************************/
/***************************************************************************************/

data HomeProd.construpcount;
set HomeProd.merged;
array years(21) construp1967-construp1987;
longest_str=0;
length_str=0;
num_str=0;

if years[1]=1 then do;
   length_str=1;
   num_str=1;
end;
do i=2 to dim(years);
  select (years[i]);
    when (.) do;
      if years[i-1]=1 then do;
        if length_str>longest_str
          then longest_str=length_str;
      end;
    end;
    when (0) do;
      if years[i-1]=1 then do;
        if length_str>longest_str
          then longest_str=length_str;
      end;
    end;
    when (1) do;
      if years[i-1]=0 or years[i-1] = . then do;
        num_str=num_str+1;
        length_str=1;
      end;
      if years[i-1]=1
        then length_str=length_str+1;
    end;
   otherwise;
   end;
 end;
num_stru = num_str;
run;

proc freq data = HomeProd.construpcount;
tables longest_str num_str; weight weight;
run;

data u;
merge HomeProd.constrdowncount HomeProd.construpcount;
by pid;
u = (num_strd = 0 and num_stru = 0);

proc freq data = u;
tables u; 
weight weight;
run;
run;
