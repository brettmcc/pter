***********************************************************************************************************************
***********************************************************************************************************************
***********************************************PSID HEAD INFORMATION***************************************************
***********************************************************************************************************************
***********************************************************************************************************************
*********************************************************************************************************************** 
**********************************************************************************************************************;


***Include Head AGE, RACE, MARITAL STATUS, EDUCATION, FAMILY SIZE, Whether Self-Employed and Occupation;

***********************************************************************************************************************
***********************************************************************************************************************
***********************************************************************************************************************
******Headedu 1968 - 1990
0 0 - 5 grades and has difficulty reading 
1 0 - 5 grades, no difficulty reading 
2 6 - 8 grades 
3 9 - 11 grades 
4 12 grades (completed high school) 
5 12 grades plus non-academic training 
6 College, no degree 
7 College, bachelors degree (A.B., B.S., etc.) 
8 College, advanced or professional degrees (M.A., Ph.D., LLB, BD, M.S., etc.) 
9 N.A., D.K.
1991 - 2005, years completed,
Education questions were not asked again since 1985 for old heads.


******HeadMarital 
1 Married 
2 Single 
3 Widowed 
4 Divorced 
5 Separated; 

******Headrace
1 White 
2 Black 
3 American Indian, Aleut, Eskimo 
4 Asian, Pacific Islander 
5 Mentions Latino origin or descent 
6 Mentions color other than black or white 
7 Other 
9 NA DK;

******Work Status
1 Working now 
2 Only temporarily laid off, sick leave or maternity leave 
3 Looking for work, unemployed 
4 Retired 
5 Permanently disabled temporarily disabled 
6 Keeping house 
7 Student 
8 Other;  

******Selfemploy
1 Someone else only 
2 Both someone else and self 
3 Self-employed only 
9 NA DK 
0 Inap.: not working for money now;

******Industry and Occupation
Occupation code in family data had 1 digit in 1968 - 1975 and 2 digits in 1976 - 1980 
Inducstry code in family data had 2 digits in 1971 - 1980 
We use the retrospective 3-digit industry and occupation code provide by PSID.
1981 - 1993 1999 - 2001 3 digits   1994 - 1997 income data 3 digits
1968 - 2001 (1970 census)
2003 and 2005 (2000 census) we do not have a good way to map it to the 1 digit.
We try our best to map the industry code between 1970 and 2000 census

Occupation
0                   Not in labor force at all, retired (includes students and housewives who did no work last year and 
                    are not working). Permanently disabled or not in labor force and did no work last year. 
1         1   - 195 Professional, Technical, and Kindred Workers 
2         201 - 245 Managers and Administrators, except Farm 
3         260 - 285 Sales Workers 
4         301 - 395 Clerical and Kindred Workers 
5         401 - 600 Craftsman and Kindred Workers 
6         601 - 695 Operatives, except Transport 
7         701 - 715 Transport Equipment Operatives 
8         740 - 785 Laborers, except Farm 
9         801 - 802 Farmers and Farm Managers 
10        821 - 824 Farm Laborers and Farm Foremen 
11        901 - 965 Service Workers, except Private Household 
12        980 - 984 Private Household Workers 

Industry
0                   Inap. unemployed, retired, permanently disabled, housewife, student, other (V9005=3-8) 
1         17 - 28   Agriculture, Forestry, and Fisheries 
2         47 - 57   Mining 
3         67 - 77   Construction 
4         107 - 398 Manufacturing 
5         407 - 479 Transportation, Communications, and Other Public Utilities 
6         507 - 698 Wholesale and Retail Trade 
7         707 - 718 Finance, Insurance, and Real Estate 
8         727 - 759 Business and Repair Services 
9         769 - 798 Personal Services 
10        807 - 809 Entertainment and Recreation Services 
11        828 - 897 Professional and Related Services 
12        907 - 937 Public Administration; 

***********************************************************************************************************************
***********************************************************************************************************************
***********************************************************************************************************************;
*this macro produces the if-then-else statements to make the employment status variable consistent over time. 
 It should be used for 1976 to 1986;
%macro empStatus(var,year);
	if &var in (1,2) then headstatus&year=1;
	else if &var=3 then headstatus&year=2;
	else if &var in (4,5) then headstatus&year=3;
	else if &var=6 then headstatus&year=4;
	else if &var=7 then headstatus&year=5;
	else if &var=8 then headstatus&year=6;
	*else %put no dice;
%mend;
/*%macro headocc(year);
	if &year>=1976 and &year<=1980 then do;
		if headocc3digit&year in (10:19) then headocc&year = 1;
		else if headocc3digit&year in (20:29) then headocc&year = 2;
		else if headocc3digit&year in (30:39) then headocc&year = 3;
		else if headocc3digit&year in (40:49) then headocc&year = 4;
		else if headocc3digit&year in (50:51) then headocc&year = 5;
		else if headocc3digit&year in (52,55,99) then headocc&year = 9;
		else if headocc3digit&year in (60:69) then headocc&year = 6;
		else if headocc3digit&year in (70:79) then headocc&year = 7;
		else if headocc3digit&year = 80 then headocc&year = 8;
		else if headocc3digit&year =  .   then headocc&year = .;
		else if headocc3digit&year =  0 then headocc&year = 0;
	end;
	*later years combine self employed and non-self-employed managers into one category;
	if &year<=1980 & headocc3digit&year = 3 then headocc&year =2;
	*later years also mix up farmers, farm laborers, and service workers;
	if &year<=1980 & headocc3digit&year = 8 then headocc&year = 7;
	else if year>=1981 then do;
		if headocc3digit&year =  .   then do; headocc&year = .; end;        
	   else if headocc3digit&year =  999 then do; headocc&year = 9; end;        
	   else if headocc3digit&year =  0   then do; headocc&year = 0; end;
	   * 	Professional, Technical, and Kindred Workers;
	   else if headocc3digit&year le 195 then do; headocc&year = 1; end;
	   *Managers and Administrators, except Farm;
	   else if headocc3digit&year le 245 and headocc3digit&year ge 195 then do; headocc&year = 2; end;
	   * 	Sales, Clerical and Kindred Workers;
	   else if headocc3digit&year le 395 and headocc3digit&year ge 245 then do; headocc&year = 4; end;
	   *Craftsman and Kindred Workers;
	   else if headocc3digit&year le 600 and headocc3digit&year ge 401 then do; headocc&year = 5; end;
		*Operatives;
	   else if headocc3digit&year le 715 and headocc3digit&year ge 601 then do; headocc&year = 6; end;
	   * 	Laborers, and service workers, farm laborers;
	   else if headocc3digit&year le 984 and headocc3digit&year ge 716 then do; headocc&year = 7; end;
	end;

%mend;*/
%macro loopOcc;
	%do y=1968 %to 1997;
		%headocc(&y);
	%end;
	%headocc(1999);
	%headocc(2001);
%mend;

data headinfor1968;
set psiddata.fam68; 
id1968                        =                  V3                 ; 
headage1968                   =                  V117               ;      
headrace1968                  =                  V181               ;      
headgender1968                =                  V119               ;
*in only this year the value 8 is used for marital status, meaning "Married, spouse absent";
if v239=8 then headmarital1968=5; else 
headmarital1968               =                  V239               ;      
headedu1968                   =                  V313               ;      
headstatus1968                =                  V196               ;
selfemploy1968                =                  V198               ;
famsize1968                   =                  V115               ;
if famsize1968 = 99 then famsize1968=.;
occupation1968                =                  V197               ;
WGT1968                       =                  V439               ;
keep id1968 headage1968 headgender1968 WGT1968 headmarital1968 headedu1968 headrace1968 headstatus1968 selfemploy1968 famsize1968 homeown1968;

data headinfor1969;
set psiddata.fam69;
id1969                        =                  V442               ;                         
headmarital1969               =                  V607               ;      
headedu1969                   =                  V794               ;      
headrace1969                  =                  V801               ;      
headage1969                   =                  V1008              ;      
headgender1969                =                  V1010              ;      
headstatus1969                =                  V639               ;
selfemploy1969                =                  V641               ;               
famsize1969                   =                  V549               ;               
occupation1969                =                  V640               ;        
WGT1969                       =                  V1014              ;
keep id1969 headage1969 headgender1969 WGT1969 headmarital1969 headedu1969 headrace1969 headstatus1969 selfemploy1969 famsize1969;  

data headinfor1970;
set psiddata.fam70;
id1970                        =                  V1102              ;                        
headage1970                   =                  V1239              ;      
headgender1970                =                  V1240              ;      
headmarital1970               =                  V1365              ;      
headedu1970                   =                  V1485              ;      
headrace1970                  =                  V1490              ;      
headstatus1970                =                  V1278              ;
selfemploy1970                =                  V1280              ;               
famsize1970                   =                  V1238              ;               
occupation1970                =                  V1279              ;        
WGT1970                       =                  V1609               ;
keep id1970 headage1970 headgender1970 WGT1970 headmarital1970 headedu1970 headrace1970 headstatus1970 selfemploy1970 famsize1970; 

data headinfor1971;
set psiddata.fam71;
id1971                        =                  V1802              ;                        
headage1971                   =                  V1942              ;      
headgender1971                =                  V1943              ;      
headmarital1971               =                  V2072              ;      
headedu1971                   =                  V2197              ;      
headrace1971                  =                  V2202              ;      
headstatus1971                =                  V1983              ;
selfemploy1971                =                  V1986              ;               
famsize1971                   =                  V1941              ;               
occupation1971                =                  V1984              ;        
WGT1971                       =                  V2321              ;
keep id1971 headage1971 headgender1971 WGT1971 headmarital1971 headedu1971 headrace1971 headstatus1971 selfemploy1971 famsize1971; 

data headinfor1972;
set psiddata.fam72;
id1972                        =                  V2402              ;                        
headage1972                   =                  V2542              ;      
headgender1972                =                  V2543              ;      
headmarital1972               =                  V2670              ;      
headedu1972                   =                  V2823              ;      
headrace1972                  =                  V2828              ;      
headstatus1972                =                  V2581              ;
selfemploy1972                =                  V2584              ;               
famsize1972                   =                  V2541              ;               
occupation1972                =                  V2582              ;        
WGT1972                       =                  V2968              ;
keep id1972 headage1972 headgender1972 WGT1972 headmarital1972 headedu1972 headrace1972 headstatus1972 selfemploy1972 famsize1972; 

data headinfor1973;
set psiddata.fam73; 
id1973                        =                  V3002              ;                        
headage1973                   =                  V3095              ;      
headgender1973                =                  V3096              ;      
headmarital1973               =                  V3181              ;      
headedu1973                   =                  V3241              ;      
headrace1973                  =                  V3300              ;      
headstatus1973                =                  V3114              ;
selfemploy1973                =                  V3117              ;               
famsize1973                   =                  V3094              ;               
occupation1973                =                  V3115              ;        
WGT1973                       =                  V3301              ;
keep id1973 headage1973 headgender1973 WGT1973 headmarital1973 headedu1973 headrace1973 headstatus1973 selfemploy1973 famsize1973; 

data headinfor1974;
set psiddata.fam74;
id1974                        =                  V3402              ;                        
headage1974                   =                  V3508              ;      
headgender1974                =                  V3509              ;      
headmarital1974               =                  V3598              ;      
headedu1974                   =                  V3663              ;      
headrace1974                  =                  V3720              ;      
headstatus1974                =                  V3528              ;
selfemploy1974                =                  V3532              ;               
famsize1974                   =                  V3507              ;               
occupation1974                =                  V3530              ;        
WGT1974                       =                  V3721               ;
keep id1974 headage1974 headgender1974 WGT1974 headmarital1974 headedu1974 headrace1974 headstatus1974 selfemploy1974 famsize1974; 

data headinfor1975;
set psiddata.fam75;
id1975                        =                  V3802              ;                        
headage1975                   =                  V3921              ;      
headgender1975                =                  V3922              ;      
headmarital1975               =                  V4053              ;      
headedu1975                   =                  V4198              ;      
headrace1975                  =                  V4204              ;      
headstatus1975                =                  V3967              ;
selfemploy1975                =                  V3970              ;               
famsize1975                   =                  V3920              ;               
occupation1975                =                  V3968              ;        
WGT1975                       =                  V4224              ;
keep id1975 headage1975 headgender1975 WGT1975 headmarital1975 headedu1975 headrace1975 headstatus1975 selfemploy1975 famsize1975; 

data headinfor1976;
set psiddata.fam76;
id1976                        =                  V4302              ;                        
headage1976                   =                  V4436              ;      
headgender1976                =                  V4437              ;      
headmarital1976               =                  V4603              ;      
headedu1976                   =                  V5074              ;      
headrace1976                  =                  V5096              ;      
%empstatus(V4458,1976)                                              ;
selfemploy1976                =                  V4461              ;               
famsize1976                   =                  V4435              ;               
occupation1976                =                  V4459              ;        
WGT1976                       =                  V5099              ;
keep id1976 headage1976 headgender1976 WGT1976 headmarital1976 headedu1976 headrace1976 headstatus1976 selfemploy1976 famsize1976; 

data headinfor1977;
set psiddata.fam77;
id1977                        =                  V5202              ;                        
headage1977                   =                  V5350              ;      
headgender1977                =                  V5351              ;      
headedu1977                   =                  V5647              ;      
headmarital1977               =                  V5650              ;      
headrace1977                  =                  V5662              ;      
%empstatus(V5373,1977)									            ;
selfemploy1977                =                  V5376              ;               
famsize1977                   =                  V5349              ;               
occupation1977                =                  V5374              ;        
WGT1977                       =                  V5665              ;
keep id1977 headage1977 headgender1977 WGT1977 headmarital1977 headedu1977 headrace1977 headstatus1977 selfemploy1977 famsize1977; 

data headinfor1978;
set psiddata.fam78; 
id1978                        =                  V5702              ;                        
headage1978                   =                  V5850              ;      
headgender1978                =                  V5851              ;      
headedu1978                   =                  V6194              ;      
headmarital1978               =                  V6197              ;      
headrace1978                  =                  V6209              ;      
%empstatus(V5872,1978)              ;
selfemploy1978                =                  V5875              ;               
famsize1978                   =                  V5849              ;               
occupation1978                =                  V5873              ;        
WGT1978                       =                  V6212              ;
keep id1978 headage1978 headgender1978 WGT1978 headmarital1978 headedu1978 headrace1978 headstatus1978 selfemploy1978 famsize1978; 

data headinfor1979;
set psiddata.fam79;
id1979                        =                  V6302              ;                        
headage1979                   =                  V6462              ;      
headgender1979                =                  V6463              ;      
headmarital1979               =                  V6790              ;      
headedu1979                   =                  V6787              ;      
headrace1979                  =                  V6802              ;      
%empstatus(v6492,1979)                                              ;
selfemploy1979                =                  V6493              ;               
famsize1979                   =                  V6461              ;               
occupation1979                =                  V6497              ;        
WGT1979                       =                  V6805              ;
keep id1979 headage1979 headgender1979 WGT1979 headmarital1979 headedu1979 headrace1979 headstatus1979 selfemploy1979 famsize1979; 

data headinfor1980;
set psiddata.fam80;
id1980                        =                  V6902              ;                        
headage1980                   =                  V7067              ;      
headgender1980                =                  V7068              ;      
headedu1980                   =                  V7433              ;      
headmarital1980               =                  V7435              ;      
headrace1980                  =                  V7447              ;      
%empstatus(v7095,1980)                                              ;
selfemploy1980                =                  V7096              ;               
famsize1980                   =                  V7066              ;               
occupation1980                =                  V7100              ;        
WGT1980                       =                  V7451              ;
keep id1980 headage1980 headgender1980 WGT1980 headmarital1980 headedu1980 headrace1980 headstatus1980 selfemploy1980 famsize1980; run;

%macro indocc(year);
proc sort data = headinfor&year;
by id&year;
data indocc&year;
set psiddata.indocc6880;
if id&year ne .;
headocc3digit&year = headocc&year;
headind3digit&year = headind&year;
keep id&year headind3digit&year headocc3digit&year;
proc sort;
by id&year;
data headinfor&year;
merge headinfor&year indocc&year;
by id&year; 
run;
%mend;
%indocc(1968) %indocc(1969) %indocc(1970) %indocc(1971) %indocc(1972) %indocc(1973) %indocc(1974) %indocc(1975)
%indocc(1976) %indocc(1977) %indocc(1978) %indocc(1979) %indocc(1980)

data headinfor1981;
set psiddata.fam81;
id1981                        =                  V7502              ;                        
headage1981                   =                  V7658              ;
headgender1981                =                  V7659             ;      
headedu1981                   =                  V8085              ;      
headmarital1981               =                  V8087              ;      
headrace1981                  =                  V8099              ;      
%empstatus(v7706,1981)                                              ;
selfemploy1981                =                  V7707              ;               
famsize1981                   =                  V7657              ;               
headocc3digit1981             =                  V7712              ;        
headind3digit1981             =                  V7713              ;
WGT1981                       =                  V8103              ;
keep id1981 headage1981 headgender1981 WGT1981 headmarital1981 headedu1981 headrace1981 headstatus1981 selfemploy1981 famsize1981 headocc3digit1981 headind3digit1981; 

data headinfor1982;
set psiddata.fam82;
id1982                        =                  V8202              ;                        
headage1982                   =                  V8352              ;
headgender1982                =                  V8353              ;      
headedu1982                   =                  V8709              ;      
headmarital1982               =                  V8711              ;      
headrace1982                  =                  V8723              ;      
%empstatus(v8374,1982)                            ;
selfemploy1982                =                  V8375              ;               
famsize1982                   =                  V8351              ;               
headocc3digit1982             =                  V8380              ;        
headind3digit1982             =                  V8381              ;
WGT1982                       =                  V8727              ;
keep id1982 headage1982 headgender1982 WGT1982 headmarital1982 headedu1982 headrace1982 headstatus1982 selfemploy1982 famsize1982 headocc3digit1982 headind3digit1982; 

data headinfor1983;
set psiddata.fam83;
id1983                        =                  V8802              ;                        
headage1983                   =                  V8961              ;
headgender1983                =                  V8962              ;      
headedu1983                   =                  V9395              ;      
headrace1983                  =                  V9408              ;      
headmarital1983               =                  V9419              ;      
%empstatus(v9005,1983)                                                ;
selfemploy1983                =                  V9006              ;               
famsize1983                   =                  V8960              ;               
headocc3digit1983             =                  V9011              ;        
headind3digit1983             =                  V9012              ;        
WGT1983                       =                  V9433              ;
keep id1983 headage1983 headgender1983 WGT1983 headmarital1983 headedu1983 headrace1983 headstatus1983 selfemploy1983 famsize1983 headocc3digit1983 headind3digit1983; 

data headinfor1984;
set psiddata.fam84;
id1984                        =                  V10002             ;                        
headage1984                   =                  V10419             ;
headgender1984                =                  V10420              ;      
headedu1984                   =                  V11042             ;      
headrace1984                  =                  V11055             ;      
headmarital1984               =                  V11065             ;      
%empstatus(v10453,1984)                                              ;
selfemploy1984                =                  V10456             ;               
famsize1984                   =                  V10418             ;               
headocc3digit1984             =                  V10460             ;        
headind3digit1984             =                  V10461             ;
WGT1984                       =                  V11079             ;
keep id1984 headage1984 headgender1984 WGT1984 headmarital1984 headedu1984 headrace1984 headstatus1984 selfemploy1984 famsize1984 headocc3digit1984 headind3digit1984; 

data headinfor1985;
set psiddata.fam85;
id1985                        =                  V11102             ;                        
headage1985                   =                  V11606             ;
headgender1985                =                  V11607             ;
*this year race encoding changes; 
if v11937 in (1,2,3,4,5,6,7) then headrace1985 = 3;
if v11938 in (1,2,7) then headrace1985 = v11938;
else if headrace1985=. & v11938 in (3,4) then headrace1985 = 7;
else if headrace1985=. & v11939 in (1,2,7) then headrace1985=v11939;
else if headrace1985=. & v11939 in (3,4) then headrace1985=7;
else if headrace1985=. then headrace1985=9;
 
headedu1985                   =                  V12400             ;      
headmarital1985               =                  V12426             ;      
%empstatus(v11637,1985)                                             ;
selfemploy1985                =                  V11640             ;               
famsize1985                   =                  V11605             ;               
headocc3digit1985             =                  V11651             ;        
headind3digit1985             =                  V11652             ;        
WGT1985                       =                  V12446             ;
keep id1985 headage1985 headgender1985 WGT1985 headmarital1985 headedu1985 headrace1985 headstatus1985 selfemploy1985 famsize1985 headocc3digit1985 headind3digit1985; 

data headinfor1986;
set psiddata.fam86;
id1986                        =                  V12502             ;                        
headage1986                   =                  V13011             ;
headgender1986                =                  V13012              ;      
 
if v13564 in (1,2,3,4,5,6,7) then headrace1986 = 3;
if v13565 in (1,2,7) then headrace1986 = v13565;
else if headrace1986=. & v13565 in (3,4) then headrace1986 = 7;
else if headrace1986=. & v13566 in (1,2,7) then headrace1986=v13566;
else if headrace1986=. & v13566 in (3,4) then headrace1986=7;
else if headrace1986=. then headrace1986=9;
 
headedu1986                   =                  V13640             ;      
headmarital1986               =                  V13665             ;      
%empstatus(v13046,1986)                                             ;
selfemploy1986                =                  V13049             ;               
famsize1986                   =                  V13010             ;               
headocc3digit1986             =                  V13054             ;        
headind3digit1986             =                  V13055             ;        
WGT1986                       =                  V13687             ;
keep id1986 headage1986 headgender1986 WGT1986 headmarital1986 headedu1986 headrace1986 headstatus1986 selfemploy1986 famsize1986 headocc3digit1986 headind3digit1986; 

data headinfor1987;
set psiddata.fam87;
id1987                        =                  V13702             ;                        
headage1987                   =                  V14114             ;
headgender1987                =                  V14115              ;      
headrace1987                  =                  V14612             ;      
headedu1987                   =                  V14687             ;      
headmarital1987               =                  V14712             ;      
headstatus1987                =                  V14146             ;
selfemploy1987                =                  V14149             ;               
famsize1987                   =                  V14113             ;               
headocc3digit1987             =                  V14154             ;        
headind3digit1987             =                  V14155             ;        
WGT1987                       =                  V14737             ;
keep id1987 headage1987 headgender1987 WGT1987 headmarital1987 headedu1987 headrace1987 headstatus1987 selfemploy1987 famsize1987 headocc3digit1987 headind3digit1987; 

data headinfor1988;
set psiddata.fam88;
id1988                        =                  V14802             ;                        
headage1988                   =                  V15130             ;
headgender1988                =                  V15131              ;      
headrace1988                  =                  V16086             ;      
headedu1988                   =                  V16161             ;      
headmarital1988               =                  V16187             ;      
headstatus1988                =                  V15154             ;
selfemploy1988                =                  V15157             ;               
famsize1988                   =                  V15129             ;               
headocc3digit1988             =                  V15162             ;        
headind3digit1988             =                  V15163             ;        
WGT1988                       =                  V16208             ;
keep id1988 headage1988 headgender1988 WGT1988 headmarital1988 headedu1988 headrace1988 headstatus1988 selfemploy1988 famsize1988 headocc3digit1988 headind3digit1988; 

data headinfor1989;
set psiddata.fam89;
id1989                        =                  V16302             ;                        
headage1989                   =                  V16631             ;
headgender1989                =                  V16632              ;      
headrace1989                  =                  V17483             ;      
headedu1989                   =                  V17545             ;      
headmarital1989               =                  V17565             ;      
headstatus1989                =                  V16655             ;
selfemploy1989                =                  V16658             ;               
famsize1989                   =                  V16630             ;               
headocc3digit1989             =                  V16663             ;        
headind3digit1989             =                  V16664             ;        
WGT1989                       =                  V17612             ;
keep id1989 headage1989 headgender1989 WGT1989 headmarital1989 headedu1989 headrace1989 headstatus1989 selfemploy1989 famsize1989 headocc3digit1989 headind3digit1989; 

data headinfor1990;
set psiddata.fam90;
id1990                        =                  V17702             ;                        
headage1990                   =                  V18049             ;
headgender1990                =                  V18050              ;      
headrace1990                  =                  V18814             ;      
headedu1990                   =                  V18898             ;      
headmarital1990               =                  V18916             ;      
headstatus1990                =                  V18093             ;
selfemploy1990                =                  V18096             ;               
famsize1990                   =                  V18048             ;               
headocc3digit1990             =                  V18101             ;        
headind3digit1990             =                  V18102             ;        
WGT1990                       =                  V18943             ;
keep id1990 headage1990 headgender1990 WGT1990 headmarital1990 headedu1990 headrace1990 headstatus1990 selfemploy1990 famsize1990 headocc3digit1990 headind3digit1990; 

data headinfor1991;
set psiddata.fam91;
id1991                        =                  V19002             ;                        
headage1991                   =                  V19349             ;
headgender1991                =                  V19350              ;      
headrace1991                  =                  V20114             ;      
headedu1991                   =                  V20198             ;
headmarital1991               =                  V20216             ;      
headstatus1991                =                  V19393             ;
selfemploy1991                =                  V19396             ;               
famsize1991                   =                  V19348             ;               
headocc3digit1991             =                  V19401             ;        
headind3digit1991             =                  V19402             ;        
WGT1991                       =                  V20243             ;
keep id1991 headage1991 headgender1991 WGT1991 headmarital1991 headedu1991 headrace1991 headstatus1991 selfemploy1991 famsize1991 headocc3digit1991 headind3digit1991; 

data headinfor1992;
set psiddata.fam92;
id1992                        =                  V20302             ;                        
headage1992                   =                  V20651             ;
headgender1992                =                  V20652              ;      
headrace1992                  =                  V21420             ;      
headedu1992                   =                  V21504             ;
headmarital1992               =                  V21522             ;      
headstatus1992                =                  V20693             ;
selfemploy1992                =                  V20696             ;               
famsize1992                   =                  V20650             ;               
headocc3digit1992             =                  V20701             ;        
headind3digit1992             =                  V20702             ;        
WGT1992                       =                  V21547             ;
keep id1992 headage1992 headgender1992 WGT1992 headmarital1992 headedu1992 headrace1992 headstatus1992 selfemploy1992 famsize1992 headocc3digit1992 headind3digit1992; 

data headinfor1993;
set psiddata.fam93;
id1993                        =                  V21602             ;                        
headage1993                   =                  V22406             ;
headgender1993                =                  V22407             ;      
headrace1993                  =                  V23276             ;      
headedu1993                   =                  V23333             ;
headmarital1993               =                  V23336             ;      
headstatus1993                =                  V22448             ;
selfemploy1993                =                  V22451             ;               
famsize1993                   =                  V22405             ;               
headocc3digit1993             =                  V22456             ;        
headind3digit1993             =                  V22457             ;        
WGT1993                       =                  V23361             ;   *** Core Weight;
keep id1993 headage1993 headgender1993 WGT1993 headmarital1993 headedu1993 headrace1993 headstatus1993 selfemploy1993 famsize1993 headocc3digit1993 headind3digit1993; 

data headinfor1994;
set psiddata.fam94;
id1994                        =                  ER2002             ;                        
headage1994                   =                  ER2007             ;      
headgender1994                =                  ER2008              ;      
headmarital1994               =                  ER2014             ;      
headrace1994                  =                  ER3944             ;      
headstatus1994                =                  ER2069             ;
selfemploy1994                =                  ER2074             ;               
famsize1994                   =                  ER2006             ;               
keep id1994 headage1994 headgender1994 headmarital1994 headrace1994 headstatus1994 selfemploy1994 famsize1994; 
proc sort data = psiddata.racedu9401;
by id1994;
data occupation1994;
set psiddata.income9401;
id1994 = ER2002;
if id1994 ne .;
headocc3digit1994 = hdocc94;
headind3digit1994 = hdind94;
keep id1994 headocc3digit1994 headind3digit1994;
proc sort;
by id1994;

data headinfor1994;
merge headinfor1994(in = in1) occupation1994 psiddata.racedu9401 psiddata.WGT1994;
by id1994;
if in1;
headedu1994 = UPEDU94H;
headrace1994 = UPR94HM1;
keep id1994 headage1994 headgender1994 WGT1994 headmarital1994 headedu1994 headrace1994 headstatus1994 selfemploy1994 famsize1994 headocc3digit1994 headind3digit1994; 
run;

data headinfor1995;
set psiddata.fam95;
id1995                        =                  ER5002             ;                        
headage1995                   =                  ER5006             ;      
headgender1995                =                  ER5007             ;      
headmarital1995               =                  ER5013             ;      
headrace1995                  =                  ER6814             ;      
headstatus1995                =                  ER5068             ;
selfemploy1995                =                  ER5073             ;               
famsize1995                   =                  ER5005             ;               
keep id1995 headage1995 headgender1995 headmarital1995 headrace1995 headstatus1995 selfemploy1995 famsize1995; 
proc sort data = psiddata.racedu9401;
by id1995;
data occupation1995;
set psiddata.income9401;
id1995 = ER5002;
if id1995 ne .;
headocc3digit1995 = hdocc95;
headind3digit1995 = hdind95;
keep id1995 headocc3digit1995 headind3digit1995;
proc sort;
by id1995;
data headinfor1995;
merge headinfor1995(in = in1) occupation1995 psiddata.racedu9401 psiddata.WGT1995;
by id1995;
if in1;
headedu1995 = UPEDU95H;
headrace1995 = UPR95HM1;
keep id1995 headage1995 headgender1995 WGT1995 headmarital1995 headedu1995 headrace1995 headstatus1995 selfemploy1995 famsize1995 headocc3digit1995 headind3digit1995; 

data headinfor1996;
set psiddata.fam96;
id1996                        =                  ER7002             ;                        
headage1996                   =                  ER7006             ;      
headgender1996                =                  ER7007             ;      
headmarital1996               =                  ER7013             ;      
headrace1996                  =                  ER9060             ;      
headstatus1996                =                  ER7164             ;
selfemploy1996                =                  ER7169             ;               
famsize1996                   =                  ER7005             ;               
keep id1996 headage1996 headgender1996 headmarital1996 headrace1996 headstatus1996 selfemploy1996 famsize1996; 
proc sort data = psiddata.racedu9401;
by id1996;
data occupation1996;
set psiddata.income9401;
id1996 = ER7002;
if id1996 ne .;
headocc3digit1996 = hdocc96;
headind3digit1996 = hdind96;
keep id1996 headocc3digit1996 headind3digit1996;
proc sort;
by id1996;
data headinfor1996;
merge headinfor1996(in = in1) occupation1996 psiddata.racedu9401 psiddata.WGT1996;
by id1996;
if in1;
headedu1996 = UPEDU96H;
headrace1996 = UPR96HM1;
keep id1996 headage1996 headgender1996 WGT1996 headmarital1996 headedu1996 headrace1996 headstatus1996 selfemploy1996 famsize1996 headocc3digit1996 headind3digit1996; 

data headinfor1997;
set psiddata.fam97;
id1997                        =                  ER10002            ;                        
headage1997                   =                  ER10009            ;      
headgender1997                =                  ER10010            ;      
headmarital1997               =                  ER10016            ;      
headrace1997                  =                  ER11848            ;      
headstatus1997                =                  ER10081            ;
selfemploy1997                =                  ER10086            ;               
famsize1997                   =                  ER10008            ;               
keep id1997 headage1997 headgender1997 headmarital1997 headrace1997 headstatus1997 selfemploy1997 famsize1997; 
proc sort data = psiddata.racedu9401;
by id1997;
data occupation1997;
set psiddata.income9401;
id1997 = ER10002;
if id1997 ne .;
headocc3digit1997 = hdocc97;
headind3digit1997 = hdind97;
keep id1997 headocc3digit1997 headind3digit1997;
proc sort;
by id1997;
data headinfor1997;
merge headinfor1997(in = in1) occupation1997 psiddata.racedu9401 psiddata.WGT1997;
by id1997;
if in1;
headedu1997 = UPEDU97H;
keep id1997 headage1997 headgender1997 WGT1997 headmarital1997 headedu1997 headrace1997 headstatus1997 selfemploy1997 famsize1997 headocc3digit1997 headind3digit1997; 

data headinfor1999;
set psiddata.fam99;
id1999                        =                  ER13002            ;                        
headage1999                   =                  ER13010            ;      
headgender1999                =                  ER13011            ;      
headmarital1999               =                  ER16423            ;      
headrace1999                  =                  ER15928            ;      
headstatus1999                =                  ER13205            ;
selfemploy1999                =                  ER13210            ;               
famsize1999                   =                  ER13009            ;               
headocc3digit1999             =                  ER13215            ;        
headind3digit1999             =                  ER13216            ;        
keep id1999 headage1999 headgender1999 headmarital1999 headrace1999 headstatus1999 selfemploy1999 famsize1999 headocc3digit1999 headind3digit1999; 
proc sort data = psiddata.racedu9401;
by id1999;
data headinfor1999;
merge headinfor1999(in = in1) psiddata.racedu9401 psiddata.WGT1999;
by id1999;
if in1;
headedu1999 = UPEDU99H;
keep id1999 headage1999 headgender1999 WGT1999 headmarital1999 headedu1999 headrace1999 headstatus1999 selfemploy1999 famsize1999 headocc3digit1999 headind3digit1999; 


data headinfor2001;
set psiddata.fam01;
id2001                        =                  ER17002            ;                        
headage2001                   =                  ER17013            ;      
headgender2001                =                  ER17014            ;      
headmarital2001               =                  ER20369            ;      
headrace2001                  =                  ER19989            ;      
headstatus2001                =                  ER17216            ;
selfemploy2001                =                  ER17221            ;               
famsize2001                   =                  ER17012            ;               
headocc3digit2001             =                  ER17226            ;        
headind3digit2001             =                  ER17227            ;        
WGT2001                       =                  ER20394            ;
keep id2001 headage2001 headgender2001 WGT2001 headmarital2001 headrace2001 headstatus2001 selfemploy2001 famsize2001 headocc3digit2001 headind3digit2001; 
proc sort data = psiddata.racedu9401;
by id2001;
data headinfor2001;
merge headinfor2001(in = in1) psiddata.racedu9401;
by id2001;
if in1;
headedu2001 = UPEDU01H;
keep id2001 headage2001 headgender2001 WGT2001 headmarital2001 headedu2001 headrace2001 headstatus2001 selfemploy2001 famsize2001 headocc3digit2001 headind3digit2001; 

data headinfor2003;
set psiddata.fam03;
id2003                        =                  ER21002            ;                        
headage2003                   =                  ER21017            ;      
headgender2003                =                  ER21018            ;      
headedu2003                   =                  ER24148            ;
headmarital2003               =                  ER24150            ;      
headrace2003                  =                  ER23426            ;       
headstatus2003                =                  ER21123            ;
selfemploy2003                =                  ER21147            ;               
famsize2003                   =                  ER21016            ;               
headocc3digit2003             =                  ER21145            ;        
headind3digit2003             =                  ER21146            ;        
WGT2003                       =                  ER24179            ;
keep id2003 headage2003 headgender2003 WGT2003 headmarital2003 headedu2003 headrace2003 headstatus2003 selfemploy2003 famsize2003 headocc3digit2003 headind3digit2003; 

data headinfor2005;
set psiddata.fam05;
id2005                        =                  ER25002            ;                        
headage2005                   =                  ER25017            ;      
headgender2005                =                  ER25018            ;      
headedu2005                   =                  ER28047            ;
headmarital2005               =                  ER28049            ;      
headrace2005                  =                  ER27393            ;       
headstatus2005                =                  ER25104            ;
selfemploy2005                =                  ER25129            ;               
famsize2005                   =                  ER25016            ;               
headocc3digit2005             =                  ER25127            ;        
headind3digit2005             =                  ER25128            ;        
WGT2005                       =                  ER28078            ;
keep id2005 headage2005 headgender2005 WGT2005 headmarital2005 headedu2005 headrace2005 headstatus2005 selfemploy2005 famsize2005 headocc3digit2005 headind3digit2005; run;

data headinfor2007;
set psiddata.fam07;
id2007                        =                  ER36002            ;                        
headage2007                   =                  ER36017            ;      
headgender2007                =                  ER36018            ;      
headedu2007                   =                  ER41037            ;
headmarital2007               =                  ER41039            ;      
headrace2007                  =                  ER40565            ;       
headstatus2007                =                  ER36109            ;
selfemploy2007                =                  ER36134            ;               
famsize2007                   =                  ER36016            ;               
headocc3digit2007             =                  ER36132            ;        
headind3digit2007             =                  ER36133            ;        
WGT2007                       =                  ER41069            ;
keep id2007 headage2007 headgender2007 WGT2007 headmarital2007 headedu2007 headrace2007 headstatus2007 selfemploy2007 famsize2007 headocc3digit2007 headind3digit2007; run;
 
data headinfor2009;
set psiddata.fam09;
id2009                        =                  ER42002            ;                        
headage2009                   =                  ER42017            ;      
headgender2009                =                  ER42018            ;      
headedu2009                   =                  ER46981            ;
headmarital2009               =                  ER46983            ;      
headrace2009                  =                  ER46543            ;       
headstatus2009                =                  ER42140            ;
selfemploy2009                =                  ER42169            ;               
famsize2009                   =                  ER42016            ;               
headocc3digit2009             =                  ER42167            ;        
headind3digit2009             =                  ER42168            ;        
WGT2009                       =                  ER47012            ;
keep id2009 headage2009 headgender2009 WGT2009 headmarital2009 headedu2009 headrace2009 headstatus2009 selfemploy2009 famsize2009 headocc3digit2009 headind3digit2009; run;

data PSIDDATA.head;
merge headinfor1968 headinfor1969 headinfor1970 headinfor1971 headinfor1972 headinfor1973 headinfor1974 headinfor1975 
      headinfor1976 headinfor1977 headinfor1978 headinfor1979 headinfor1980 headinfor1981 headinfor1982 headinfor1983 
      headinfor1984 headinfor1985 headinfor1986 headinfor1987 headinfor1988 headinfor1989 headinfor1990 headinfor1991 
      headinfor1992 headinfor1993 headinfor1994 headinfor1995 headinfor1996 headinfor1997 headinfor1999 headinfor2001 
      headinfor2003 headinfor2005 headinfor2007 headinfor2009;
if    headage1968       > 96  then headage1968      =.   ;
if    headage1969       > 96  then headage1969      =.   ;
if    headage1970       > 96  then headage1970      =.   ;
if    headage1971       > 96  then headage1971      =.   ;
if    headage1972       > 96  then headage1972      =.   ;
if    headage1973       > 96  then headage1973      =.   ;
if    headage1974       > 96  then headage1974      =.   ;
if    headage1975       > 96  then headage1975      =.   ;
if    headage1976       > 96  then headage1976      =.   ;
if    headage1977       > 96  then headage1977      =.   ;
if    headage1978       > 96  then headage1978      =.   ;
if    headage1979       > 96  then headage1979      =.   ;
if    headage1980       > 96  then headage1980      =.   ;
if    headage1981       > 96  then headage1981      =.   ;
if    headage1982       > 96  then headage1982      =.   ;
if    headage1983       > 96  then headage1983      =.   ;
if    headage1984       > 96  then headage1984      =.   ;
if    headage1985       > 96  then headage1985      =.   ;
if    headage1986       > 96  then headage1986      =.   ;
if    headage1987       > 96  then headage1987      =.   ;
if    headage1988       > 96  then headage1988      =.   ;
if    headage1989       > 96  then headage1989      =.   ;
if    headage1990       > 96  then headage1990      =.   ;
if    headage1991       > 96  then headage1991      =.   ;
if    headage1992       > 96  then headage1992      =.   ;
if    headage1993       > 96  then headage1993      =.   ;
if    headage1994       > 96  then headage1994      =.   ;
if    headage1995       > 96  then headage1995      =.   ;
if    headage1996       > 96  then headage1996      =.   ;
if    headage1997       > 120 then headage1997      =.   ;
if    headage1999       > 120 then headage1999      =.   ;
if    headage2001       > 120 then headage2001      =.   ;
if    headage2003       > 120 then headage2003      =.   ;
if    headage2005       > 120 then headage2005      =.   ;
if    headage2007       > 120 then headage2007      =.   ;
if    headage2009       > 120 then headage2009      =.   ;
                                                    
if    headrace1994      > 7   then headrace1994     =.   ;
if    headrace1995      > 7   then headrace1995     =.   ;
if    headrace1996      > 7   then headrace1996     =.   ;
if    headrace1997      > 7   then headrace1997     =.   ;
if    headrace1999      > 7   then headrace1999     =.   ;
if    headrace2001      > 7   then headrace2001     =.   ;
if    headrace2003      > 7   then headrace2003     =.   ;
if    headrace2005      > 7   then headrace2005     =.   ;
if    headrace2007      > 7   then headrace2007     =.   ;
if    headrace2009      > 7   then headrace2009     =.   ;

if    headmarital1990   > 7   then headmarital1990  =.   ; 
if    headmarital1991   > 7   then headmarital1991  =.   ; 
if    headmarital1992   > 7   then headmarital1992  =.   ; 
if    headmarital1993   > 7   then headmarital1993  =.   ; 
if    headmarital1994   > 7   then headmarital1994  =.   ; 
if    headmarital1995   > 7   then headmarital1995  =.   ; 
if    headmarital1996   > 7   then headmarital1996  =.   ; 
if    headmarital1997   > 7   then headmarital1997  =.   ; 
if    headmarital1999   > 7   then headmarital1999  =.   ; 
if    headmarital2001   > 7   then headmarital2001  =.   ; 
if    headmarital2003   > 7   then headmarital2003  =.   ; 
if    headmarital2005   > 7   then headmarital2005  =.   ; 
if    headmarital2007   > 7   then headmarital2007  =.   ; 
if    headmarital2009   > 7   then headmarital2009  =.   ; 

if    selfemploy1994    > 7   then selfemploy1994   =.   ; 
if    selfemploy1995    > 7   then selfemploy1995   =.   ; 
if    selfemploy1996    > 7   then selfemploy1996   =.   ; 
if    selfemploy1997    > 7   then selfemploy1997   =.   ; 
if    selfemploy1999    > 7   then selfemploy1999   =.   ; 
if    selfemploy2001    > 7   then selfemploy2001   =.   ; 
if    selfemploy2003    > 7   then selfemploy2003   =.   ; 
if    selfemploy2005    > 7   then selfemploy2005   =.   ; 
if    selfemploy2007    > 7   then selfemploy2007   =.   ; 
if    selfemploy2009    > 7   then selfemploy2009   =.   ; 

if    headstatus1994    > 10  then headstatus1994 = .;
if    headstatus1995    > 10  then headstatus1995 = .;
if    headstatus1996    > 10  then headstatus1996 = .;
if    headstatus1997    > 10  then headstatus1997 = .;
if    headstatus1999    > 10  then headstatus1999 = .;
if    headstatus2001    > 10  then headstatus2001 = .;
if    headstatus2003    > 10  then headstatus2003 = .;
if    headstatus2005    > 10  then headstatus2005 = .;
if    headstatus2007    > 10  then headstatus2007 = .;
if    headstatus2009    > 10  then headstatus2009 = .;
                        
if    headedu1968       < 4   and headedu1968 ne .  then      school1968  =  1;  
if    headedu1969       < 4   and headedu1969 ne .  then      school1969  =  1;  
if    headedu1970       < 4   and headedu1970 ne .  then      school1970  =  1;  
if    headedu1971       < 4   and headedu1971 ne .  then      school1971  =  1;  
if    headedu1972       < 4   and headedu1972 ne .  then      school1972  =  1;  
if    headedu1973       < 4   and headedu1973 ne .  then      school1973  =  1;  
if    headedu1974       < 4   and headedu1974 ne .  then      school1974  =  1;  
if    headedu1975       < 4   and headedu1975 ne .  then      school1975  =  1;  
if    headedu1976       < 4   and headedu1976 ne .  then      school1976  =  1;  
if    headedu1977       < 4   and headedu1977 ne .  then      school1977  =  1;  
if    headedu1978       < 4   and headedu1978 ne .  then      school1978  =  1;  
if    headedu1979       < 4   and headedu1979 ne .  then      school1979  =  1;  
if    headedu1980       < 4   and headedu1980 ne .  then      school1980  =  1;  
if    headedu1981       < 4   and headedu1981 ne .  then      school1981  =  1;  
if    headedu1982       < 4   and headedu1982 ne .  then      school1982  =  1;  
if    headedu1983       < 4   and headedu1983 ne .  then      school1983  =  1;  
if    headedu1984       < 4   and headedu1984 ne .  then      school1984  =  1;  
if    headedu1985       < 4   and headedu1985 ne .  then      school1985  =  1;  
if    headedu1986       < 4   and headedu1986 ne .  then      school1986  =  1;  
if    headedu1987       < 4   and headedu1987 ne .  then      school1987  =  1;  
if    headedu1988       < 4   and headedu1988 ne .  then      school1988  =  1;  
if    headedu1989       < 4   and headedu1989 ne .  then      school1989  =  1;  
if    headedu1990       < 4   and headedu1990 ne .  then      school1990  =  1;  
                        
if    headedu1968       = 4   then      school1968  =  2;                        
if    headedu1969       = 4   then      school1969  =  2;                        
if    headedu1970       = 4   then      school1970  =  2;                        
if    headedu1971       = 4   then      school1971  =  2;                        
if    headedu1972       = 4   then      school1972  =  2;                        
if    headedu1973       = 4   then      school1973  =  2;                        
if    headedu1974       = 4   then      school1974  =  2;                        
if    headedu1975       = 4   then      school1975  =  2;                        
if    headedu1976       = 4   then      school1976  =  2;                        
if    headedu1977       = 4   then      school1977  =  2;                        
if    headedu1978       = 4   then      school1978  =  2;                        
if    headedu1979       = 4   then      school1979  =  2;                        
if    headedu1980       = 4   then      school1980  =  2;                        
if    headedu1981       = 4   then      school1981  =  2;                        
if    headedu1982       = 4   then      school1982  =  2;                        
if    headedu1983       = 4   then      school1983  =  2;                        
if    headedu1984       = 4   then      school1984  =  2;                        
if    headedu1985       = 4   then      school1985  =  2;                        
if    headedu1986       = 4   then      school1986  =  2;                        
if    headedu1987       = 4   then      school1987  =  2;                        
if    headedu1988       = 4   then      school1988  =  2;                        
if    headedu1989       = 4   then      school1989  =  2;                        
if    headedu1990       = 4   then      school1990  =  2;                        
                        
if    headedu1968       = 5   or  headedu1968    = 6 then      school1968  =  3;       
if    headedu1969       = 5   or  headedu1969    = 6 then      school1969  =  3;       
if    headedu1970       = 5   or  headedu1970    = 6 then      school1970  =  3;       
if    headedu1971       = 5   or  headedu1971    = 6 then      school1971  =  3;       
if    headedu1972       = 5   or  headedu1972    = 6 then      school1972  =  3;       
if    headedu1973       = 5   or  headedu1973    = 6 then      school1973  =  3;       
if    headedu1974       = 5   or  headedu1974    = 6 then      school1974  =  3;       
if    headedu1975       = 5   or  headedu1975    = 6 then      school1975  =  3;       
if    headedu1976       = 5   or  headedu1976    = 6 then      school1976  =  3;       
if    headedu1977       = 5   or  headedu1977    = 6 then      school1977  =  3;       
if    headedu1978       = 5   or  headedu1978    = 6 then      school1978  =  3;       
if    headedu1979       = 5   or  headedu1979    = 6 then      school1979  =  3;       
if    headedu1980       = 5   or  headedu1980    = 6 then      school1980  =  3;       
if    headedu1981       = 5   or  headedu1981    = 6 then      school1981  =  3;       
if    headedu1982       = 5   or  headedu1982    = 6 then      school1982  =  3;       
if    headedu1983       = 5   or  headedu1983    = 6 then      school1983  =  3;       
if    headedu1984       = 5   or  headedu1984    = 6 then      school1984  =  3;       
if    headedu1985       = 5   or  headedu1985    = 6 then      school1985  =  3;       
if    headedu1986       = 5   or  headedu1986    = 6 then      school1986  =  3;       
if    headedu1987       = 5   or  headedu1987    = 6 then      school1987  =  3;       
if    headedu1988       = 5   or  headedu1988    = 6 then      school1988  =  3;       
if    headedu1989       = 5   or  headedu1989    = 6 then      school1989  =  3;       
if    headedu1990       = 5   or  headedu1990    = 6 then      school1990  =  3;       
                              
if    headedu1968       = 7   or  headedu1968    = 8 then      school1968  =  4;       
if    headedu1969       = 7   or  headedu1969    = 8 then      school1969  =  4;       
if    headedu1970       = 7   or  headedu1970    = 8 then      school1970  =  4;       
if    headedu1971       = 7   or  headedu1971    = 8 then      school1971  =  4;       
if    headedu1972       = 7   or  headedu1972    = 8 then      school1972  =  4;       
if    headedu1973       = 7   or  headedu1973    = 8 then      school1973  =  4;       
if    headedu1974       = 7   or  headedu1974    = 8 then      school1974  =  4;       
if    headedu1975       = 7   or  headedu1975    = 8 then      school1975  =  4;       
if    headedu1976       = 7   or  headedu1976    = 8 then      school1976  =  4;       
if    headedu1977       = 7   or  headedu1977    = 8 then      school1977  =  4;       
if    headedu1978       = 7   or  headedu1978    = 8 then      school1978  =  4;       
if    headedu1979       = 7   or  headedu1979    = 8 then      school1979  =  4;       
if    headedu1980       = 7   or  headedu1980    = 8 then      school1980  =  4;       
if    headedu1981       = 7   or  headedu1981    = 8 then      school1981  =  4;       
if    headedu1982       = 7   or  headedu1982    = 8 then      school1982  =  4;       
if    headedu1983       = 7   or  headedu1983    = 8 then      school1983  =  4;       
if    headedu1984       = 7   or  headedu1984    = 8 then      school1984  =  4;       
if    headedu1985       = 7   or  headedu1985    = 8 then      school1985  =  4;       
if    headedu1986       = 7   or  headedu1986    = 8 then      school1986  =  4;       
if    headedu1987       = 7   or  headedu1987    = 8 then      school1987  =  4;       
if    headedu1988       = 7   or  headedu1988    = 8 then      school1988  =  4;       
if    headedu1989       = 7   or  headedu1989    = 8 then      school1989  =  4;       
if    headedu1990       = 7   or  headedu1990    = 8 then      school1990  =  4;       
                        
if    headedu1968       = 9   then    school1968    =   .;                           
if    headedu1969       = 9   then    school1969    =   .;                           
if    headedu1970       = 9   then    school1970    =   .;                           
if    headedu1971       = 9   then    school1971    =   .;                           
if    headedu1972       = 9   then    school1972    =   .;                           
if    headedu1973       = 9   then    school1973    =   .;                           
if    headedu1974       = 9   then    school1974    =   .;                           
if    headedu1975       = 9   then    school1975    =   .;                           
if    headedu1976       = 9   then    school1976    =   .;                           
if    headedu1977       = 9   then    school1977    =   .;                           
if    headedu1974       = 9   then    school1978    =   .;                           
if    headedu1979       = 9   then    school1979    =   .;                           
if    headedu1980       = 9   then    school1980    =   .;                           
if    headedu1981       = 9   then    school1981    =   .;                           
if    headedu1982       = 9   then    school1982    =   .;                           
if    headedu1983       = 9   then    school1983    =   .;                           
if    headedu1984       = 9   then    school1984    =   .;                           
if    headedu1985       = 9   then    school1985    =   .;                           
if    headedu1986       = 9   then    school1986    =   .;                           
if    headedu1987       = 9   then    school1987    =   .;                           
if    headedu1988       = 9   then    school1988    =   .;                           
if    headedu1989       = 9   then    school1989    =   .;                           
if    headedu1990       = 9   then    school1990    =   .;                           
                                                                               
                                                                               
if    headedu1991       = 99  then    headedu1991   =   .;                                 
if    headedu1992       = 99  then    headedu1992   =   .;                                 
if    headedu1993       = 99  then    headedu1993   =   .;                                 
if    headedu1994       = 99  then    headedu1994   =   .;                                 
if    headedu1995       = 99  then    headedu1995   =   .;                                 
if    headedu1996       = 99  then    headedu1996   =   .;                                 
if    headedu1997       = 99  then    headedu1997   =   .;                                 
if    headedu1999       = 99  then    headedu1999   =   .;                                 
if    headedu2001       = 99  then    headedu2001   =   .;                                 
if    headedu2003       = 99  then    headedu2003   =   .;                                 
if    headedu2005       = 99  then    headedu2005   =   .;                                 
if    headedu2007       = 99  then    headedu2007   =   .;                                 
if    headedu2009       = 99  then    headedu2009   =   .;                                 
      
if    headedu1991       < 12  and  headedu1991 ne . then school1991   = 1;
if    headedu1992       < 12  and  headedu1992 ne . then school1992   = 1;
if    headedu1993       < 12  and  headedu1993 ne . then school1993   = 1;
if    headedu1994       < 12  and  headedu1994 ne . then school1994   = 1;
if    headedu1995       < 12  and  headedu1995 ne . then school1995   = 1;
if    headedu1996       < 12  and  headedu1996 ne . then school1996   = 1;
if    headedu1997       < 12  and  headedu1997 ne . then school1997   = 1;
if    headedu1999       < 12  and  headedu1999 ne . then school1999   = 1;
if    headedu2001       < 12  and  headedu2001 ne . then school2001   = 1;
if    headedu2003       < 12  and  headedu2003 ne . then school2003   = 1;
if    headedu2005       < 12  and  headedu2005 ne . then school2005   = 1;
if    headedu2007       < 12  and  headedu2007 ne . then school2007   = 1;
if    headedu2009       < 12  and  headedu2009 ne . then school2009   = 1;
      
if    headedu1991       = 12 then school1991   = 2;                                 
if    headedu1992       = 12 then school1992   = 2;                                 
if    headedu1993       = 12 then school1993   = 2;                                 
if    headedu1994       = 12 then school1994   = 2;                                 
if    headedu1995       = 12 then school1995   = 2;                                 
if    headedu1996       = 12 then school1996   = 2;                                 
if    headedu1997       = 12 then school1997   = 2;                                 
if    headedu1999       = 12 then school1999   = 2;                                 
if    headedu2001       = 12 then school2001   = 2;                                 
if    headedu2003       = 12 then school2003   = 2;                                 
if    headedu2005       = 12 then school2005   = 2;                                 
if    headedu2007       = 12 then school2007   = 2;                                 
if    headedu2009       = 12 then school2009   = 2;                                 
                                                                                 
if    headedu1991       > 12 and headedu1991  < 16  then school1991   = 3;          
if    headedu1992       > 12 and headedu1992  < 16  then school1992   = 3;          
if    headedu1993       > 12 and headedu1993  < 16  then school1993   = 3;          
if    headedu1994       > 12 and headedu1994  < 16  then school1994   = 3;          
if    headedu1995       > 12 and headedu1995  < 16  then school1995   = 3;          
if    headedu1996       > 12 and headedu1996  < 16  then school1996   = 3;          
if    headedu1997       > 12 and headedu1997  < 16  then school1997   = 3;          
if    headedu1999       > 12 and headedu1999  < 16  then school1999   = 3;          
if    headedu2001       > 12 and headedu2001  < 16  then school2001   = 3;          
if    headedu2003       > 12 and headedu2003  < 16  then school2003   = 3;          
if    headedu2005       > 12 and headedu2005  < 16  then school2005   = 3;          
if    headedu2007       > 12 and headedu2007  < 16  then school2007   = 3;          
if    headedu2009       > 12 and headedu2009  < 16  then school2009   = 3;          
                                                                                    
if    headedu1991       >= 16  then school1991   = 4  ;                              
if    headedu1992       >= 16  then school1992   = 4  ;                              
if    headedu1993       >= 16  then school1993   = 4  ;                              
if    headedu1994       >= 16  then school1994   = 4  ;                              
if    headedu1995       >= 16  then school1995   = 4  ;                              
if    headedu1996       >= 16  then school1996   = 4  ;                              
if    headedu1997       >= 16  then school1997   = 4  ;                              
if    headedu1999       >= 16  then school1999   = 4  ;                              
if    headedu2001       >= 16  then school2001   = 4  ;                              
if    headedu2003       >= 16  then school2003   = 4  ;                              
if    headedu2005       >= 16  then school2005   = 4  ;                              
if    headedu2007       >= 16  then school2007   = 4  ;                              
if    headedu2009       >= 16  then school2009   = 4  ;                              

originalheadedu1968 = headedu1968; 
originalheadedu1969 = headedu1969; 
originalheadedu1970 = headedu1970; 
originalheadedu1971 = headedu1971; 
originalheadedu1972 = headedu1972; 
originalheadedu1973 = headedu1973; 
originalheadedu1974 = headedu1974; 
originalheadedu1975 = headedu1975; 
originalheadedu1976 = headedu1976; 
originalheadedu1977 = headedu1977; 
originalheadedu1978 = headedu1978; 
originalheadedu1979 = headedu1979; 
originalheadedu1980 = headedu1980; 
originalheadedu1981 = headedu1981; 
originalheadedu1982 = headedu1982; 
originalheadedu1983 = headedu1983; 
originalheadedu1984 = headedu1984; 
originalheadedu1985 = headedu1985; 
originalheadedu1986 = headedu1986; 
originalheadedu1987 = headedu1987; 
originalheadedu1988 = headedu1988; 
originalheadedu1989 = headedu1989; 
originalheadedu1990 = headedu1990; 
originalheadedu1991 = headedu1991; 
originalheadedu1992 = headedu1992; 
originalheadedu1993 = headedu1993; 
originalheadedu1994 = headedu1994; 
originalheadedu1995 = headedu1995; 
originalheadedu1996 = headedu1996; 
originalheadedu1997 = headedu1997; 
originalheadedu1999 = headedu1999; 
originalheadedu2001 = headedu2001; 
originalheadedu2003 = headedu2003; 
originalheadedu2005 = headedu2005; 
originalheadedu2007 = headedu2007; 
originalheadedu2009 = headedu2009; 

headedu1968   =   school1968; 
headedu1969   =   school1969; 
headedu1970   =   school1970; 
headedu1971   =   school1971; 
headedu1972   =   school1972; 
headedu1973   =   school1973; 
headedu1974   =   school1974; 
headedu1975   =   school1975; 
headedu1976   =   school1976; 
headedu1977   =   school1977; 
headedu1978   =   school1978; 
headedu1979   =   school1979; 
headedu1980   =   school1980; 
headedu1981   =   school1981; 
headedu1982   =   school1982; 
headedu1983   =   school1983; 
headedu1984   =   school1984; 
headedu1985   =   school1985; 
headedu1986   =   school1986; 
headedu1987   =   school1987; 
headedu1988   =   school1988; 
headedu1989   =   school1989; 
headedu1990   =   school1990; 
headedu1991   =   school1991; 
headedu1992   =   school1992; 
headedu1993   =   school1993; 
headedu1994   =   school1994; 
headedu1995   =   school1995; 
headedu1996   =   school1996; 
headedu1997   =   school1997; 
headedu1999   =   school1999; 
headedu2001   =   school2001; 
headedu2003   =   school2003; 
headedu2005   =   school2005; 
headedu2007   =   school2007; 
headedu2009   =   school2009; 

*%loopOcc;
%macro occind(year);
        if headocc3digit&year =  .   then do; headocc&year = .; end;        
   else if headocc3digit&year =  999 then do; headocc&year = .; end;        
   else if headocc3digit&year =  0   then do; headocc&year = 0; end;
   else if headocc3digit&year le 195 then do; headocc&year = 1; end;
   else if headocc3digit&year le 245 then do; headocc&year = 2; end;
   else if headocc3digit&year le 285 then do; headocc&year = 3; end;
   else if headocc3digit&year le 395 then do; headocc&year = 4; end;
   else if headocc3digit&year le 600 then do; headocc&year = 5; end;
   else if headocc3digit&year le 695 then do; headocc&year = 6; end;
   else if headocc3digit&year le 715 then do; headocc&year = 7; end;
   else if headocc3digit&year le 785 then do; headocc&year = 8; end;
   else if headocc3digit&year le 802 then do; headocc&year = 9; end;
   else if headocc3digit&year le 824 then do; headocc&year = 10; end;
   else if headocc3digit&year le 965 then do; headocc&year = 11; end;
   else if headocc3digit&year le 984 then do; headocc&year = 12; end;

        if headind3digit&year =  .   then do; headind&year = .; end;        
   else if headind3digit&year =  999 then do; headind&year = .; end;        
   else if headind3digit&year =  0   then do; headind&year = 0; end;
   else if headind3digit&year le 28  then do; headind&year = 1; end;
   else if headind3digit&year le 57  then do; headind&year = 2; end;
   else if headind3digit&year le 77  then do; headind&year = 3; end;
   else if headind3digit&year le 398 then do; headind&year = 4; end;
   else if headind3digit&year le 479 then do; headind&year = 5; end;
   else if headind3digit&year le 698 then do; headind&year = 6; end;
   else if headind3digit&year le 718 then do; headind&year = 7; end;
   else if headind3digit&year le 759 then do; headind&year = 8; end;
   else if headind3digit&year le 798 then do; headind&year = 9; end;
   else if headind3digit&year le 809 then do; headind&year = 10; end;
   else if headind3digit&year le 897 then do; headind&year = 11; end;
   else if headind3digit&year le 937 then do; headind&year = 12; end;
%mend;

%occind(1968) %occind(1969) %occind(1970) %occind(1971) %occind(1972) %occind(1973) %occind(1974) %occind(1975)
%occind(1976) %occind(1977) %occind(1978) %occind(1979) %occind(1980) %occind(1981) %occind(1982) %occind(1983)
%occind(1984) %occind(1985) %occind(1986) %occind(1987) %occind(1988) %occind(1989) %occind(1990) %occind(1991)
%occind(1992) %occind(1993) %occind(1994) %occind(1995) %occind(1996) %occind(1997) %occind(1999) %occind(2001) 

if headind3digit2003  =  .                                  then headind2003 = .; 
if headind3digit2003  =  999                                then headind2003 = .; 
if headind3digit2003  =  0                                  then headind2003 = 0; 
if headind3digit2003  > 0     and headind3digit2003 le 29   then headind2003 = 1; 
if headind3digit2003  ge 37   and headind3digit2003 le 49   then headind2003 = 2; 
if headind3digit2003  =  77                                 then headind2003 = 3; 
if headind3digit2003  ge 107  and headind3digit2003 le 399  then headind2003 = 4; 
if (headind3digit2003 ge 57   and headind3digit2003 le 69)                        
or (headind3digit2003 ge 647  and headind3digit2003 le 679) then headind2003 = 5; 
if headind3digit2003  ge 407  and headind3digit2003 le 579  then headind2003 = 6; 
if headind3digit2003  ge 687  and headind3digit2003 le 719  then headind2003 = 7; 
if headind3digit2003  ge 757  and headind3digit2003 le 779  then headind2003 = 8; 
if headind3digit2003  ge 866  and headind3digit2003 le 869  then headind2003 = 9; 
if headind3digit2003  ge 856  and headind3digit2003 le 859  then headind2003 = 10;
if (headind3digit2003 ge 727  and headind3digit2003 le 749)                       
or (headind3digit2003 ge 786  and headind3digit2003 le 847)                       
or (headind3digit2003 ge 877  and headind3digit2003 le 929) then headind2003 = 11;
if headind3digit2003  ge 937  and headind3digit2003 le 987  then headind2003 = 12;

if headind3digit2005  =  .                                  then headind2005 = .; 
if headind3digit2005  =  999                                then headind2005 = .; 
if headind3digit2005  =  0                                  then headind2005 = 0; 
if headind3digit2005  > 0     and headind3digit2005 le 29   then headind2005 = 1; 
if headind3digit2005  ge 37   and headind3digit2005 le 49   then headind2005 = 2; 
if headind3digit2005  =  77                                 then headind2005 = 3; 
if headind3digit2005  ge 107  and headind3digit2005 le 399  then headind2005 = 4; 
if (headind3digit2005 ge 57   and headind3digit2005 le 69)                        
or (headind3digit2005 ge 647  and headind3digit2005 le 679) then headind2005 = 5; 
if headind3digit2005  ge 407  and headind3digit2005 le 579  then headind2005 = 6; 
if headind3digit2005  ge 687  and headind3digit2005 le 719  then headind2005 = 7; 
if headind3digit2005  ge 757  and headind3digit2005 le 779  then headind2005 = 8; 
if headind3digit2005  ge 866  and headind3digit2005 le 869  then headind2005 = 9; 
if headind3digit2005  ge 856  and headind3digit2005 le 859  then headind2005 = 10;
if (headind3digit2005 ge 727  and headind3digit2005 le 749)                       
or (headind3digit2005 ge 786  and headind3digit2005 le 847)                       
or (headind3digit2005 ge 877  and headind3digit2005 le 929) then headind2005 = 11;
if headind3digit2005  ge 937  and headind3digit2005 le 987  then headind2005 = 12;

if headind3digit2007  =  .                                  then headind2007 = .; 
if headind3digit2007  =  999                                then headind2007 = .; 
if headind3digit2007  =  0                                  then headind2007 = 0; 
if headind3digit2007  > 0     and headind3digit2007 le 29   then headind2007 = 1; 
if headind3digit2007  ge 37   and headind3digit2007 le 49   then headind2007 = 2; 
if headind3digit2007  =  77                                 then headind2007 = 3; 
if headind3digit2007  ge 107  and headind3digit2007 le 399  then headind2007 = 4; 
if (headind3digit2007 ge 57   and headind3digit2007 le 69)                        
or (headind3digit2007 ge 647  and headind3digit2007 le 679) then headind2007 = 5; 
if headind3digit2007  ge 407  and headind3digit2007 le 579  then headind2007 = 6; 
if headind3digit2007  ge 687  and headind3digit2007 le 719  then headind2007 = 7; 
if headind3digit2007  ge 757  and headind3digit2007 le 779  then headind2007 = 8; 
if headind3digit2007  ge 866  and headind3digit2007 le 869  then headind2007 = 9; 
if headind3digit2007  ge 856  and headind3digit2007 le 859  then headind2007 = 10;
if (headind3digit2007 ge 727  and headind3digit2007 le 749)                       
or (headind3digit2007 ge 786  and headind3digit2007 le 847)                       
or (headind3digit2007 ge 877  and headind3digit2007 le 929) then headind2007 = 11;
if headind3digit2007  ge 937  and headind3digit2007 le 987  then headind2007 = 12;

if headind3digit2009  =  .                                  then headind2009 = .; 
if headind3digit2009  =  999                                then headind2009 = .; 
if headind3digit2009  =  0                                  then headind2009 = 0; 
if headind3digit2009  > 0     and headind3digit2009 le 29   then headind2009 = 1; 
if headind3digit2009  ge 37   and headind3digit2009 le 49   then headind2009 = 2; 
if headind3digit2009  =  77                                 then headind2009 = 3; 
if headind3digit2009  ge 107  and headind3digit2009 le 399  then headind2009 = 4; 
if (headind3digit2009 ge 57   and headind3digit2009 le 69)                        
or (headind3digit2009 ge 647  and headind3digit2009 le 679) then headind2009 = 5; 
if headind3digit2009  ge 407  and headind3digit2009 le 579  then headind2009 = 6; 
if headind3digit2009  ge 687  and headind3digit2009 le 719  then headind2009 = 7; 
if headind3digit2009  ge 757  and headind3digit2009 le 779  then headind2009 = 8; 
if headind3digit2009  ge 866  and headind3digit2009 le 869  then headind2009 = 9; 
if headind3digit2009  ge 856  and headind3digit2009 le 859  then headind2009 = 10;
if (headind3digit2009 ge 727  and headind3digit2009 le 749)                       
or (headind3digit2009 ge 786  and headind3digit2009 le 847)                       
or (headind3digit2009 ge 877  and headind3digit2009 le 929) then headind2009 = 11;
if headind3digit2009  ge 937  and headind3digit2009 le 987  then headind2009 = 12;

if headocc3digit2003 =  .                                  then headocc2003 = .;  
if headocc3digit2003 =  999                                then headocc2003 = .;  
if headocc3digit2003 =  0                                  then headocc2003 = 0;  
if (headocc3digit2003 ge 80  and headocc3digit2003 le 196)                        
or (headocc3digit2003 ge 210 and headocc3digit2003 le 365) then headocc2003 = 1;  
if (headocc3digit2003 ge 1   and headocc3digit2003 le 73)  then headocc2003 = 2;  
if (headocc3digit2003 ge 200 and headocc3digit2003 le 206)                        
or (headocc3digit2003 ge 470 and headocc3digit2003 le 496) then headocc2003 = 3;  
if headocc3digit2003 ge 500  and headocc3digit2003 le 593  then headocc2003 = 4;  
if headocc3digit2003 ge 700  and headocc3digit2003 le 896  then headocc2003 = 5;  
if headocc3digit2003 ge 900  and headocc3digit2003 le 975  then headocc2003 = 7;  
if headocc3digit2003 ge 620  and headocc3digit2003 le 694  then headocc2003 = 8;  
if headocc3digit2003 ge 600  and headocc3digit2003 le 613  then headocc2003 = 10; 
if (headocc3digit2003 ge 370 and headocc3digit2003 le 465)                        
or (headocc3digit2003 ge 980 and headocc3digit2003 le 983) then headocc2003 = 11; 

if headocc3digit2005 =  .                                  then headocc2005 = .;  
if headocc3digit2005 =  999                                then headocc2005 = .;  
if headocc3digit2005 =  0                                  then headocc2005 = 0;  
if (headocc3digit2005 ge 80  and headocc3digit2005 le 196)                        
or (headocc3digit2005 ge 210 and headocc3digit2005 le 365) then headocc2005 = 1;  
if (headocc3digit2005 ge 1   and headocc3digit2005 le 73)  then headocc2005 = 2;  
if (headocc3digit2005 ge 200 and headocc3digit2005 le 206)                        
or (headocc3digit2005 ge 470 and headocc3digit2005 le 496) then headocc2005 = 3;  
if headocc3digit2005 ge 500  and headocc3digit2005 le 593  then headocc2005 = 4;  
if headocc3digit2005 ge 700  and headocc3digit2005 le 896  then headocc2005 = 5;  
if headocc3digit2005 ge 900  and headocc3digit2005 le 975  then headocc2005 = 7;  
if headocc3digit2005 ge 620  and headocc3digit2005 le 694  then headocc2005 = 8;  
if headocc3digit2005 ge 600  and headocc3digit2005 le 613  then headocc2005 = 10; 
if (headocc3digit2005 ge 370 and headocc3digit2005 le 465)                        
or (headocc3digit2005 ge 980 and headocc3digit2005 le 983) then headocc2005 = 11; 

if headocc3digit2007 =  .                                  then headocc2007 = .;  
if headocc3digit2007 =  999                                then headocc2007 = .;  
if headocc3digit2007 =  0                                  then headocc2007 = 0;  
if (headocc3digit2007 ge 80  and headocc3digit2007 le 196)                        
or (headocc3digit2007 ge 210 and headocc3digit2007 le 365) then headocc2007 = 1;  
if (headocc3digit2007 ge 1   and headocc3digit2007 le 73)  then headocc2007 = 2;  
if (headocc3digit2007 ge 200 and headocc3digit2007 le 206)                        
or (headocc3digit2007 ge 470 and headocc3digit2007 le 496) then headocc2007 = 3;  
if headocc3digit2007 ge 500  and headocc3digit2007 le 593  then headocc2007 = 4;  
if headocc3digit2007 ge 700  and headocc3digit2007 le 896  then headocc2007 = 5;  
if headocc3digit2007 ge 900  and headocc3digit2007 le 975  then headocc2007 = 7;  
if headocc3digit2007 ge 620  and headocc3digit2007 le 694  then headocc2007 = 8;  
if headocc3digit2007 ge 600  and headocc3digit2007 le 613  then headocc2007 = 10; 
if (headocc3digit2007 ge 370 and headocc3digit2007 le 465)                        
or (headocc3digit2007 ge 980 and headocc3digit2007 le 983) then headocc2007 = 11; 

if headocc3digit2009 =  .                                  then headocc2009 = .;  
if headocc3digit2009 =  999                                then headocc2009 = .;  
if headocc3digit2009 =  0                                  then headocc2009 = 0;  
if (headocc3digit2009 ge 80  and headocc3digit2009 le 196)                        
or (headocc3digit2009 ge 210 and headocc3digit2009 le 365) then headocc2009 = 1;  
if (headocc3digit2009 ge 1   and headocc3digit2009 le 73)  then headocc2009 = 2;  
if (headocc3digit2009 ge 200 and headocc3digit2009 le 206)                        
or (headocc3digit2009 ge 470 and headocc3digit2009 le 496) then headocc2009 = 3;  
if headocc3digit2009 ge 500  and headocc3digit2009 le 593  then headocc2009 = 4;  
if headocc3digit2009 ge 700  and headocc3digit2009 le 896  then headocc2009 = 5;  
if headocc3digit2009 ge 900  and headocc3digit2009 le 975  then headocc2009 = 7;  
if headocc3digit2009 ge 620  and headocc3digit2009 le 694  then headocc2009 = 8;  
if headocc3digit2009 ge 600  and headocc3digit2009 le 613  then headocc2009 = 10; 
if (headocc3digit2009 ge 370 and headocc3digit2009 le 465)                        
or (headocc3digit2009 ge 980 and headocc3digit2009 le 983) then headocc2009 = 11; 

keep
id1968  headage1968  headgender1968   WGT1968  headmarital1968  headedu1968  headrace1968  headstatus1968  selfemploy1968  famsize1968  headocc3digit1968  headind3digit1968  headocc1968  headind1968  originalheadedu1968  
id1969  headage1969  headgender1969   WGT1969  headmarital1969  headedu1969  headrace1969  headstatus1969  selfemploy1969  famsize1969  headocc3digit1969  headind3digit1969  headocc1969  headind1969  originalheadedu1969  
id1970  headage1970  headgender1970   WGT1970  headmarital1970  headedu1970  headrace1970  headstatus1970  selfemploy1970  famsize1970  headocc3digit1970  headind3digit1970  headocc1970  headind1970  originalheadedu1970  
id1971  headage1971  headgender1971   WGT1971  headmarital1971  headedu1971  headrace1971  headstatus1971  selfemploy1971  famsize1971  headocc3digit1971  headind3digit1971  headocc1971  headind1971  originalheadedu1971  
id1972  headage1972  headgender1972   WGT1972  headmarital1972  headedu1972  headrace1972  headstatus1972  selfemploy1972  famsize1972  headocc3digit1972  headind3digit1972  headocc1972  headind1972  originalheadedu1972  
id1973  headage1973  headgender1973   WGT1973  headmarital1973  headedu1973  headrace1973  headstatus1973  selfemploy1973  famsize1973  headocc3digit1973  headind3digit1973  headocc1973  headind1973  originalheadedu1973  
id1974  headage1974  headgender1974   WGT1974  headmarital1974  headedu1974  headrace1974  headstatus1974  selfemploy1974  famsize1974  headocc3digit1974  headind3digit1974  headocc1974  headind1974  originalheadedu1974  
id1975  headage1975  headgender1975   WGT1975  headmarital1975  headedu1975  headrace1975  headstatus1975  selfemploy1975  famsize1975  headocc3digit1975  headind3digit1975  headocc1975  headind1975  originalheadedu1975  
id1976  headage1976  headgender1976   WGT1976  headmarital1976  headedu1976  headrace1976  headstatus1976  selfemploy1976  famsize1976  headocc3digit1976  headind3digit1976  headocc1976  headind1976  originalheadedu1976  
id1977  headage1977  headgender1977   WGT1977  headmarital1977  headedu1977  headrace1977  headstatus1977  selfemploy1977  famsize1977  headocc3digit1977  headind3digit1977  headocc1977  headind1977  originalheadedu1977  
id1978  headage1978  headgender1978   WGT1978  headmarital1978  headedu1978  headrace1978  headstatus1978  selfemploy1978  famsize1978  headocc3digit1978  headind3digit1978  headocc1978  headind1978  originalheadedu1978  
id1979  headage1979  headgender1979   WGT1979  headmarital1979  headedu1979  headrace1979  headstatus1979  selfemploy1979  famsize1979  headocc3digit1979  headind3digit1979  headocc1979  headind1979  originalheadedu1979  
id1980  headage1980  headgender1980   WGT1980  headmarital1980  headedu1980  headrace1980  headstatus1980  selfemploy1980  famsize1980  headocc3digit1980  headind3digit1980  headocc1980  headind1980  originalheadedu1980  
id1981  headage1981  headgender1981   WGT1981  headmarital1981  headedu1981  headrace1981  headstatus1981  selfemploy1981  famsize1981  headocc3digit1981  headind3digit1981  headocc1981  headind1981  originalheadedu1981  
id1982  headage1982  headgender1982   WGT1982  headmarital1982  headedu1982  headrace1982  headstatus1982  selfemploy1982  famsize1982  headocc3digit1982  headind3digit1982  headocc1982  headind1982  originalheadedu1982  
id1983  headage1983  headgender1983   WGT1983  headmarital1983  headedu1983  headrace1983  headstatus1983  selfemploy1983  famsize1983  headocc3digit1983  headind3digit1983  headocc1983  headind1983  originalheadedu1983  
id1984  headage1984  headgender1984   WGT1984  headmarital1984  headedu1984  headrace1984  headstatus1984  selfemploy1984  famsize1984  headocc3digit1984  headind3digit1984  headocc1984  headind1984  originalheadedu1984  
id1985  headage1985  headgender1985   WGT1985  headmarital1985  headedu1985  headrace1985  headstatus1985  selfemploy1985  famsize1985  headocc3digit1985  headind3digit1985  headocc1985  headind1985  originalheadedu1985  
id1986  headage1986  headgender1986   WGT1986  headmarital1986  headedu1986  headrace1986  headstatus1986  selfemploy1986  famsize1986  headocc3digit1986  headind3digit1986  headocc1986  headind1986  originalheadedu1986  
id1987  headage1987  headgender1987   WGT1987  headmarital1987  headedu1987  headrace1987  headstatus1987  selfemploy1987  famsize1987  headocc3digit1987  headind3digit1987  headocc1987  headind1987  originalheadedu1987  
id1988  headage1988  headgender1988   WGT1988  headmarital1988  headedu1988  headrace1988  headstatus1988  selfemploy1988  famsize1988  headocc3digit1988  headind3digit1988  headocc1988  headind1988  originalheadedu1988  
id1989  headage1989  headgender1989   WGT1989  headmarital1989  headedu1989  headrace1989  headstatus1989  selfemploy1989  famsize1989  headocc3digit1989  headind3digit1989  headocc1989  headind1989  originalheadedu1989  
id1990  headage1990  headgender1990   WGT1990  headmarital1990  headedu1990  headrace1990  headstatus1990  selfemploy1990  famsize1990  headocc3digit1990  headind3digit1990  headocc1990  headind1990  originalheadedu1990  
id1991  headage1991  headgender1991   WGT1991  headmarital1991  headedu1991  headrace1991  headstatus1991  selfemploy1991  famsize1991  headocc3digit1991  headind3digit1991  headocc1991  headind1991  originalheadedu1991  
id1992  headage1992  headgender1992   WGT1992  headmarital1992  headedu1992  headrace1992  headstatus1992  selfemploy1992  famsize1992  headocc3digit1992  headind3digit1992  headocc1992  headind1992  originalheadedu1992  
id1993  headage1993  headgender1993   WGT1993  headmarital1993  headedu1993  headrace1993  headstatus1993  selfemploy1993  famsize1993  headocc3digit1993  headind3digit1993  headocc1993  headind1993  originalheadedu1993  
id1994  headage1994  headgender1994   WGT1994  headmarital1994  headedu1994  headrace1994  headstatus1994  selfemploy1994  famsize1994  headocc3digit1994  headind3digit1994  headocc1994  headind1994  originalheadedu1994  
id1995  headage1995  headgender1995   WGT1995  headmarital1995  headedu1995  headrace1995  headstatus1995  selfemploy1995  famsize1995  headocc3digit1995  headind3digit1995  headocc1995  headind1995  originalheadedu1995  
id1996  headage1996  headgender1996   WGT1996  headmarital1996  headedu1996  headrace1996  headstatus1996  selfemploy1996  famsize1996  headocc3digit1996  headind3digit1996  headocc1996  headind1996  originalheadedu1996  
id1997  headage1997  headgender1997   WGT1997  headmarital1997  headedu1997  headrace1997  headstatus1997  selfemploy1997  famsize1997  headocc3digit1997  headind3digit1997  headocc1997  headind1997  originalheadedu1997  
id1999  headage1999  headgender1999   WGT1999  headmarital1999  headedu1999  headrace1999  headstatus1999  selfemploy1999  famsize1999  headocc3digit1999  headind3digit1999  headocc1999  headind1999  originalheadedu1999  
id2001  headage2001  headgender2001   WGT2001  headmarital2001  headedu2001  headrace2001  headstatus2001  selfemploy2001  famsize2001  headocc3digit2001  headind3digit2001  headocc2001  headind2001  originalheadedu2001  
id2003  headage2003  headgender2003   WGT2003  headmarital2003  headedu2003  headrace2003  headstatus2003  selfemploy2003  famsize2003  headocc3digit2003  headind3digit2003  headocc2003  headind2003  originalheadedu2003  
id2005  headage2005  headgender2005   WGT2005  headmarital2005  headedu2005  headrace2005  headstatus2005  selfemploy2005  famsize2005  headocc3digit2005  headind3digit2005  headocc2005  headind2005  originalheadedu2005 
id2007  headage2007  headgender2007   WGT2007  headmarital2007  headedu2007  headrace2007  headstatus2007  selfemploy2007  famsize2007  headocc3digit2007  headind3digit2007  headocc2007  headind2007  originalheadedu2007 
id2009  headage2009  headgender2009   WGT2009  headmarital2009  headedu2009  headrace2009  headstatus2009  selfemploy2009  famsize2009  headocc3digit2009  headind3digit2009  headocc2009  headind2009  originalheadedu2009 ;
run;

proc freq data = psiddata.head;
tables 
headmarital1968  headedu1968  headrace1968  headstatus1968  selfemploy1968  famsize1968  headocc1968  headind1968  
headmarital1969  headedu1969  headrace1969  headstatus1969  selfemploy1969  famsize1969  headocc1969  headind1969  
headmarital1970  headedu1970  headrace1970  headstatus1970  selfemploy1970  famsize1970  headocc1970  headind1970  
headmarital1971  headedu1971  headrace1971  headstatus1971  selfemploy1971  famsize1971  headocc1971  headind1971  
headmarital1972  headedu1972  headrace1972  headstatus1972  selfemploy1972  famsize1972  headocc1972  headind1972  
headmarital1973  headedu1973  headrace1973  headstatus1973  selfemploy1973  famsize1973  headocc1973  headind1973  
headmarital1974  headedu1974  headrace1974  headstatus1974  selfemploy1974  famsize1974  headocc1974  headind1974  
headmarital1975  headedu1975  headrace1975  headstatus1975  selfemploy1975  famsize1975  headocc1975  headind1975  
headmarital1976  headedu1976  headrace1976  headstatus1976  selfemploy1976  famsize1976  headocc1976  headind1976  
headmarital1977  headedu1977  headrace1977  headstatus1977  selfemploy1977  famsize1977  headocc1977  headind1977  
headmarital1978  headedu1978  headrace1978  headstatus1978  selfemploy1978  famsize1978  headocc1978  headind1978  
headmarital1979  headedu1979  headrace1979  headstatus1979  selfemploy1979  famsize1979  headocc1979  headind1979  
headmarital1980  headedu1980  headrace1980  headstatus1980  selfemploy1980  famsize1980  headocc1980  headind1980  
headmarital1981  headedu1981  headrace1981  headstatus1981  selfemploy1981  famsize1981  headocc1981  headind1981  
headmarital1982  headedu1982  headrace1982  headstatus1982  selfemploy1982  famsize1982  headocc1982  headind1982  
headmarital1983  headedu1983  headrace1983  headstatus1983  selfemploy1983  famsize1983  headocc1983  headind1983  
headmarital1984  headedu1984  headrace1984  headstatus1984  selfemploy1984  famsize1984  headocc1984  headind1984  
headmarital1985  headedu1985  headrace1985  headstatus1985  selfemploy1985  famsize1985  headocc1985  headind1985  
headmarital1986  headedu1986  headrace1986  headstatus1986  selfemploy1986  famsize1986  headocc1986  headind1986  
headmarital1987  headedu1987  headrace1987  headstatus1987  selfemploy1987  famsize1987  headocc1987  headind1987  
headmarital1988  headedu1988  headrace1988  headstatus1988  selfemploy1988  famsize1988  headocc1988  headind1988  
headmarital1989  headedu1989  headrace1989  headstatus1989  selfemploy1989  famsize1989  headocc1989  headind1989  
headmarital1990  headedu1990  headrace1990  headstatus1990  selfemploy1990  famsize1990  headocc1990  headind1990  
headmarital1991  headedu1991  headrace1991  headstatus1991  selfemploy1991  famsize1991  headocc1991  headind1991  
headmarital1992  headedu1992  headrace1992  headstatus1992  selfemploy1992  famsize1992  headocc1992  headind1992  
headmarital1993  headedu1993  headrace1993  headstatus1993  selfemploy1993  famsize1993  headocc1993  headind1993  
headmarital1994  headedu1994  headrace1994  headstatus1994  selfemploy1994  famsize1994  headocc1994  headind1994  
headmarital1995  headedu1995  headrace1995  headstatus1995  selfemploy1995  famsize1995  headocc1995  headind1995  
headmarital1996  headedu1996  headrace1996  headstatus1996  selfemploy1996  famsize1996  headocc1996  headind1996  
headmarital1997  headedu1997  headrace1997  headstatus1997  selfemploy1997  famsize1997  headocc1997  headind1997  
headmarital1999  headedu1999  headrace1999  headstatus1999  selfemploy1999  famsize1999  headocc1999  headind1999  
headmarital2001  headedu2001  headrace2001  headstatus2001  selfemploy2001  famsize2001  headocc2001  headind2001  
headmarital2003  headedu2003  headrace2003  headstatus2003  selfemploy2003  famsize2003  headocc2003  headind2003            
headmarital2005  headedu2005  headrace2005  headstatus2005  selfemploy2005  famsize2005  headocc2005  headind2005                          
headmarital2007  headedu2007  headrace2007  headstatus2007  selfemploy2007  famsize2007  headocc2007  headind2007                          
headmarital2009  headedu2009  headrace2009  headstatus2009  selfemploy2009  famsize2009  headocc2009  headind2009;                          
run;

%macro freq(year);
proc freq data = headinfor&year;
tables headmarital&year headedu&year headrace&year selfemploy&year famsize&year ;
run;
%mend;
%freq(1968); %freq(1969); %freq(1970); %freq(1971); %freq(1972); %freq(1973); %freq(1974); %freq(1975);
%freq(1976); %freq(1977); %freq(1978); %freq(1979); %freq(1980); %freq(1981); %freq(1982); %freq(1983);
%freq(1984); %freq(1985); %freq(1986); %freq(1987); %freq(1988); %freq(1989); %freq(1990); %freq(1991);
%freq(1992); %freq(1993); %freq(1994); %freq(1995); %freq(1996); %freq(1997); %freq(1999); %freq(2001);
%freq(2003); %freq(2005); %freq(2007); %freq(2009); 

******************************************************************************************************************
*****Each year there are some invalid observations of education and race of PSID head and wife, valid information*
*****may be located in other waves, we mapped them cross waves to maximize the number of valid observations******;

%macro vrace(year);
data vrace&year;
set psiddata.head;
if id&year ne . and headrace&year ne .; 
w = &year;
headrace = headrace&year;
keep id&year headrace;
proc sort data = vrace&year;
by id&year;

data person;
set psiddata.person;
%if &year = 1968 %then %do; if rel&year = 1; %end;
%else %if &year le 1982 %then %do; if rel&year = 1 and seqno&year = 1; %end;
%else %do; if rel&year = 10 and seqno&year =1; %end;
keep id&year pid;
proc sort data = person;
by id&year;

data vrace&year;
merge vrace&year(in = in1) person;
by id&year;
keep headrace pid;
if in1;
run;
%mend;
%vrace(1968) %vrace(1969) %vrace(1970) %vrace(1971) %vrace(1972) %vrace(1973) %vrace(1974) %vrace(1975) %vrace(1976)
%vrace(1977) %vrace(1978) %vrace(1979) %vrace(1980) %vrace(1981) %vrace(1982) %vrace(1983) %vrace(1984) 
%vrace(1985) %vrace(1986) %vrace(1987) %vrace(1988) %vrace(1989) %vrace(1990) %vrace(1991) %vrace(1992)
%vrace(1993) %vrace(1994) %vrace(1995) %vrace(1996) %vrace(1997) %vrace(1999) 
%vrace(2001) %vrace(2003) %vrace(2005) %vrace(2007) %vrace(2009)

data vrace;
set vrace1968 vrace1969 vrace1970 vrace1971 vrace1972 vrace1973 vrace1974 vrace1975 vrace1976
    vrace1977 vrace1978 vrace1979 vrace1980 vrace1981 vrace1982 vrace1983 vrace1984 
    vrace1985 vrace1986 vrace1987 vrace1988 vrace1989 vrace1990 vrace1991 vrace1992
    vrace1993 vrace1994 vrace1995 vrace1996 vrace1997 vrace1999 vrace2001 vrace2003 vrace2005 vrace2007 vrace2009;
proc sort data = vrace nodupkey;
by pid;
run;

%macro race(year);
data race&year;
set psiddata.head;
if id&year ne . and headrace&year = .; 
w = &year;
keep id&year w;
proc sort data = race&year;
by id&year;

data person;
set psiddata.person;
%if &year = 1968 %then %do; if rel&year = 1; %end;
%else %if &year = 1969 %then %do; if rel&year = 1 and seqno&year = 1; %end;
%else %do; if rel&year = 10 and seqno&year =1; %end;
keep id&year pid;
proc sort data = person;
by id&year;

data race&year;
merge race&year(in = in1) person;
by id&year;
if in1;
proc sort data = race&year;
by pid;
data race&year;
merge race&year(in = in1) vrace(in = in2);
by pid;
if in1 and in2;
keep id&year headrace;
proc sort data = race&year;
by id&year;
proc print data = race&year;
run;
%mend;
%race(1968) %race(1985) %race(1986) %race(1987) %race(1988) %race(1989) %race(1990) %race(1991) %race(1992)
%race(1993) %race(1994) %race(1995) %race(1996) %race(1997) %race(1999) %race(2001) %race(2003) %race(2005) %race(2007) %race(2009)

%macro crace(year);
proc sort data = psiddata.head;
by id&year;
data psiddata.head;
merge psiddata.head race&year;
by id&year;
if headrace ne . then headrace&year = headrace;
run;
data u;
set psiddata.head;
if id&year ne .;
proc freq data = u;
tables headrace&year;
run;
%mend;
%crace(1968) %crace(1985) %crace(1986) %crace(1987) %crace(1988) %crace(1989) %crace(1990) %crace(1991) %crace(1992)
%crace(1993) %crace(1994) %crace(1995) %crace(1996) %crace(1997) %crace(1999) %crace(2001) %crace(2003) %crace(2005) 
%crace(2007) %crace(2009)
********************************************************************************************************************
********************************************************************************************************************
********************************************************************************************************************
********************************************************************************************************************
********************************************************************************************************************
*******************************************************************************************************************;

%macro vedu(year);
data vedu&year;
set psiddata.head;
if id&year ne . and headedu&year ne .; 
w = &year;
headedu = headedu&year;
keep id&year headedu w;
proc sort data = vedu&year;
by id&year;

data person;
set psiddata.person;
%if &year = 1968 %then %do; if rel&year = 1; %end;
%else %if &year le 1982 %then %do; if rel&year = 1 and seqno&year = 1; %end;
%else %do; if rel&year = 10 and seqno&year =1; %end;
keep id&year pid;
proc sort data = person;
by id&year;

data vedu&year;
merge vedu&year(in = in1) person;
by id&year;
keep headedu pid w;
if in1;
run;
%mend;
%vedu(1968) %vedu(1969) %vedu(1970) %vedu(1971) %vedu(1972) %vedu(1973) %vedu(1974) %vedu(1975) %vedu(1976)
%vedu(1977) %vedu(1978) %vedu(1979) %vedu(1980) %vedu(1981) %vedu(1982) %vedu(1983) %vedu(1984) 
%vedu(1985) %vedu(1986) %vedu(1987) %vedu(1988) %vedu(1989) %vedu(1990) %vedu(1991) %vedu(1992)
%vedu(1993) %vedu(1994) %vedu(1995) %vedu(1996) %vedu(1997) %vedu(1999) %vedu(2001) %vedu(2003) %vedu(2005) %vedu(2007) %vedu(2009) 

data vedu;
set vedu1968 vedu1969 vedu1970 vedu1971 vedu1972 vedu1973 vedu1974 vedu1975 vedu1976
    vedu1977 vedu1978 vedu1979 vedu1980 vedu1981 vedu1982 vedu1983 vedu1984 
    vedu1985 vedu1986 vedu1987 vedu1988 vedu1989 vedu1990 vedu1991 vedu1992
    vedu1993 vedu1994 vedu1995 vedu1996 vedu1997 vedu1999 vedu2001 vedu2003 vedu2005 vedu2007 vedu2009;
proc sort data = vedu nodupkey;
by pid headedu;
run;


data eduvary1;
set vedu;
by pid headedu;
if first.pid = 1 and last.pid = 1;
keep pid headedu;

data eduvary3;
set vedu;
by pid headedu;
if first.pid = 0 and last.pid = 0; 
keep pid;

data eduvary3;
merge vedu eduvary3(in = in1);
by pid;
if in1;

data eduvary31 eduvary32 eduvary33;
set eduvary3;
by pid;
if first.pid = 1 then output eduvary31;
else if last.pid = 1 then output eduvary33;
else if first.pid = 0 and last.pid = 0 then output eduvary32;

data eduvary31;
set eduvary31;
headedu1 = headedu; w1 = w;
keep pid headedu1 w1;

data eduvary32;
set eduvary32;
headedu2 = headedu; w2 = w;
keep pid headedu2 w2;
proc sort nodupkey;
by pid;

data eduvary33;
set eduvary33;
headedu3 = headedu; w3 = w;
keep pid headedu3 w3;

data eduvary3;
merge eduvary31 eduvary32 eduvary33;
by pid;

data eduvary2;
merge vedu(in = in1) eduvary1(in = in2) eduvary3(in = in3);
by pid;
if in1 and not in2 and not in3;

data eduvary21 eduvary22;
set eduvary2;
by pid;
if first.pid = 1 then output eduvary21;
else if last.pid = 1 then output eduvary22;

data eduvary21;
set eduvary21;
headedu1 = headedu; w1 = w;
keep pid headedu1 w1;

data eduvary22;
set eduvary22;
headedu2 = headedu; w2 = w;
keep pid headedu2 w2;

data eduvary2;
merge eduvary21 eduvary22;
by pid;
run;

%macro edu(year);
data edu&year;
set psiddata.head;
if id&year ne . and headedu&year = .; 
w = &year;
keep id&year w;
proc sort data = edu&year;
by id&year;

data person;
set psiddata.person;
%if &year = 1968 %then %do; if rel&year = 1; %end;
%else %if &year le 1982 %then %do; if rel&year = 1 and seqno&year = 1; %end;
%else %do; if rel&year = 10 and seqno&year =1; %end;
keep id&year pid;
proc sort data = person;
by id&year;

data edu&year;
merge edu&year(in = in1) person;
by id&year;
if in1;
proc sort data = edu&year;
by pid;

data edu&year;
merge edu&year(in = in1) eduvary1(in = in2) eduvary2(in = in3) eduvary3(in = in4);
by pid;
if in1 and (in2 or in3 or in4);
if in3 then do; if w < w2 then headedu = headedu1; else headedu = headedu2; end;
if in4 then do; if w < w2 then headedu = headedu1; else if w < w3 then headedu = headedu2; else headedu = headedu3; end;
keep id&year headedu;
proc sort data = edu&year;
by id&year;
run;
%mend;
%edu(1968) %edu(1969) %edu(1970) %edu(1971) %edu(1972) %edu(1973) %edu(1974) %edu(1975) %edu(1976)
%edu(1977) %edu(1978) %edu(1979) %edu(1980) %edu(1981) %edu(1982) %edu(1983) %edu(1984) 
%edu(1985) %edu(1986) %edu(1987) %edu(1988) %edu(1989) %edu(1990) %edu(1991) %edu(1992)
%edu(1993) %edu(1994) %edu(1995) %edu(1996) %edu(1997) %edu(1999) %edu(2001) %edu(2003) %edu(2005) %edu(2007) %edu(2009)

%macro cedu(year);
proc sort data = psiddata.head;
by id&year;
data psiddata.head;
merge psiddata.head edu&year;
by id&year;
if headedu ne . then headedu&year = headedu;
run;
data u;
set psiddata.head;
if id&year ne .;
proc freq data = u;
tables headedu&year;
run;
%mend;
%cedu(1968) %cedu(1969) %cedu(1970) %cedu(1971) %cedu(1972) %cedu(1973) %cedu(1974) %cedu(1975) %cedu(1976)
%cedu(1977) %cedu(1978) %cedu(1979) %cedu(1980) %cedu(1981) %cedu(1982) %cedu(1983) %cedu(1984) 
%cedu(1985) %cedu(1986) %cedu(1987) %cedu(1988) %cedu(1989) %cedu(1990) %cedu(1991) %cedu(1992)
%cedu(1993) %cedu(1994) %cedu(1995) %cedu(1996) %cedu(1997) %cedu(1999) %cedu(2001) %cedu(2003) %cedu(2005) %cedu(2007) %cedu(2009)


*******************************************************;
proc freq data = psiddata.head;                                                                                                    
tables                                                                                                                             
headmarital1968   headgender1968      headedu1968       headrace1968    headstatus1968    selfemploy1968      famsize1968   headocc1968    headind1968 
headmarital1969   headgender1969      headedu1969       headrace1969    headstatus1969    selfemploy1969      famsize1969   headocc1969    headind1969 
headmarital1970   headgender1970      headedu1970       headrace1970    headstatus1970    selfemploy1970      famsize1970   headocc1970    headind1970 
headmarital1971   headgender1971      headedu1971       headrace1971    headstatus1971    selfemploy1971      famsize1971   headocc1971    headind1971 
headmarital1972   headgender1972      headedu1972       headrace1972    headstatus1972    selfemploy1972      famsize1972   headocc1972    headind1972 
headmarital1973   headgender1973      headedu1973       headrace1973    headstatus1973    selfemploy1973      famsize1973   headocc1973    headind1973 
headmarital1974   headgender1974      headedu1974       headrace1974    headstatus1974    selfemploy1974      famsize1974   headocc1974    headind1974 
headmarital1975   headgender1975      headedu1975       headrace1975    headstatus1975    selfemploy1975      famsize1975   headocc1975    headind1975 
headmarital1976   headgender1976      headedu1976       headrace1976    headstatus1976    selfemploy1976      famsize1976   headocc1976    headind1976 
headmarital1977   headgender1977      headedu1977       headrace1977    headstatus1977    selfemploy1977      famsize1977   headocc1977    headind1977 
headmarital1978   headgender1978      headedu1978       headrace1978    headstatus1978    selfemploy1978      famsize1978   headocc1978    headind1978 
headmarital1979   headgender1979      headedu1979       headrace1979    headstatus1979    selfemploy1979      famsize1979   headocc1979    headind1979 
headmarital1980   headgender1980      headedu1980       headrace1980    headstatus1980    selfemploy1980      famsize1980   headocc1980    headind1980 
headmarital1981   headgender1981      headedu1981       headrace1981    headstatus1981    selfemploy1981      famsize1981   headocc1981    headind1981 
headmarital1982   headgender1982      headedu1982       headrace1982    headstatus1982    selfemploy1982      famsize1982   headocc1982    headind1982 
headmarital1983   headgender1983      headedu1983       headrace1983    headstatus1983    selfemploy1983      famsize1983   headocc1983    headind1983 
headmarital1984   headgender1984      headedu1984       headrace1984    headstatus1984    selfemploy1984      famsize1984   headocc1984    headind1984 
headmarital1985   headgender1985      headedu1985       headrace1985    headstatus1985    selfemploy1985      famsize1985   headocc1985    headind1985 
headmarital1986   headgender1986      headedu1986       headrace1986    headstatus1986    selfemploy1986      famsize1986   headocc1986    headind1986 
headmarital1987   headgender1987      headedu1987       headrace1987    headstatus1987    selfemploy1987      famsize1987   headocc1987    headind1987 
headmarital1988   headgender1988      headedu1988       headrace1988    headstatus1988    selfemploy1988      famsize1988   headocc1988    headind1988 
headmarital1989   headgender1989      headedu1989       headrace1989    headstatus1989    selfemploy1989      famsize1989   headocc1989    headind1989 
headmarital1990   headgender1990      headedu1990       headrace1990    headstatus1990    selfemploy1990      famsize1990   headocc1990    headind1990 
headmarital1991   headgender1991      headedu1991       headrace1991    headstatus1991    selfemploy1991      famsize1991   headocc1991    headind1991 
headmarital1992   headgender1992      headedu1992       headrace1992    headstatus1992    selfemploy1992      famsize1992   headocc1992    headind1992 
headmarital1993   headgender1993      headedu1993       headrace1993    headstatus1993    selfemploy1993      famsize1993   headocc1993    headind1993 
headmarital1994   headgender1994      headedu1994       headrace1994    headstatus1994    selfemploy1994      famsize1994   headocc1994    headind1994 
headmarital1995   headgender1995      headedu1995       headrace1995    headstatus1995    selfemploy1995      famsize1995   headocc1995    headind1995 
headmarital1996   headgender1996      headedu1996       headrace1996    headstatus1996    selfemploy1996      famsize1996   headocc1996    headind1996 
headmarital1997   headgender1997      headedu1997       headrace1997    headstatus1997    selfemploy1997      famsize1997   headocc1997    headind1997 
headmarital1999   headgender1999      headedu1999       headrace1999    headstatus1999    selfemploy1999      famsize1999   headocc1999    headind1999 
headmarital2001   headgender2001      headedu2001       headrace2001    headstatus2001    selfemploy2001      famsize2001   headocc2001    headind2001 
headmarital2003   headgender2003      headedu2003       headrace2003    headstatus2003    selfemploy2003      famsize2003   headocc2003    headind2003                              
headmarital2005   headgender2005      headedu2005       headrace2005    headstatus2005    selfemploy2005      famsize2005   headocc2005    headind2005                             
headmarital2007   headgender2007      headedu2007       headrace2007    headstatus2007    selfemploy2007      famsize2007   headocc2007    headind2007                             
headmarital2009   headgender2009      headedu2009       headrace2009    headstatus2009    selfemploy2009      famsize2009   headocc2009    headind2009;                             
run;                                                                                                                               

%macro freq(year);
data u;
set psiddata.head;
if id&year ne .;
proc freq data = u;
tables headmarital&year headedu&year headgender&year headrace&year headstatus&year selfemploy&year famsize&year headocc&year headind&year;
run;
%mend;

%freq(1968); %freq(1969); %freq(1970); %freq(1971); %freq(1972); %freq(1973); %freq(1974); %freq(1975);
%freq(1976); %freq(1977); %freq(1978); %freq(1979); %freq(1980); %freq(1981); %freq(1982); %freq(1983);
%freq(1984); %freq(1985); %freq(1986); %freq(1987); %freq(1988); %freq(1989); %freq(1990); %freq(1991);
%freq(1992); %freq(1993); %freq(1994); %freq(1995); %freq(1996); %freq(1997); %freq(1999); %freq(2001); 
%freq(2003); %freq(2005); %freq(2007); %freq(2009);
