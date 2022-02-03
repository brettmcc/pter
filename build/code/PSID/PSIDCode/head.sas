***********************************************************************************************************************
***********************************************************************************************************************
***********************************************PSID HEAD INFORMATION***************************************************
***********************************************************************************************************************
***********************************************************************************************************************
*********************************************************************************************************************** 
**********************************************************************************************************************;

%include 'setlibraries_psid.sas';
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
options mprint;

*this macro produces the if-then-else statements to make the employment status variable consistent over time. 
 It should be used for 1976 to 1986;
%macro empStatus(var,year);
	if &var in (1,2) then headstatus&year=1;
	else if &var=3 then headstatus&year=2;
	else if &var in (4,5) then headstatus&year=3;
	else if &var=6 then headstatus&year=4;
	else if &var=7 then headstatus&year=5;
	else if &var=8 then headstatus&year=6;
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
headocc3digit1968             =                  V197_A             ;
headind3digit1968			  =					 V197_B				;
WGT1968                       =                  V439               ;
keep id1968 headage1968 headgender1968 WGT1968 headmarital1968 headedu1968 headrace1968 headstatus1968 selfemploy1968 famsize1968 headocc3digit1968 headind3digit1968;

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
headocc3digit1969             =                  V640_A             ;        
headind3digit1969			  =					 V640_B				;
WGT1969                       =                  V1014              ;
keep id1969 headage1969 headgender1969 WGT1969 headmarital1969 headedu1969 headrace1969 headstatus1969 selfemploy1969 famsize1969 headocc3digit1969 headind3digit1969;  

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
headocc3digit1970             =                  V1279_A            ; 
headind3digit1970			  =					 V1279_B			; 
WGT1970                       =                  V1609              ;
keep id1970 headage1970 headgender1970 WGT1970 headmarital1970 headedu1970 headrace1970 headstatus1970 selfemploy1970 famsize1970 headocc3digit1970 headind3digit1970; 

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
headocc3digit1971             =                  V1984_A            ;    
headind3digit1971			  =					 V1985_A			; 
WGT1971                       =                  V2321              ;
keep id1971 headage1971 headgender1971 WGT1971 headmarital1971 headedu1971 headrace1971 headstatus1971 selfemploy1971 famsize1971 headocc3digit1971 headind3digit1971; 

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
headocc3digit1972             =                  V2582_A            ;        
headind3digit1972			  =					 V2583_A			;
WGT1972                       =                  V2968              ;
keep id1972 headage1972 headgender1972 WGT1972 headmarital1972 headedu1972 headrace1972 headstatus1972 selfemploy1972 famsize1972 headocc3digit1972 headind3digit1972; 

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
headocc3digit1973             =                  V3115_A            ;        
headind3digit1973			  =					 V3116_A			;
WGT1973                       =                  V3301              ;
keep id1973 headage1973 headgender1973 WGT1973 headmarital1973 headedu1973 headrace1973 headstatus1973 selfemploy1973 famsize1973 headocc3digit1973 headind3digit1973; 

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
headocc3digit1974             =                  V3530_A            ;        
headind3digit1974			  =					 V3531_A			;
WGT1974                       =                  V3721              ;
keep id1974 headage1974 headgender1974 WGT1974 headmarital1974 headedu1974 headrace1974 headstatus1974 selfemploy1974 famsize1974 headocc3digit1974 headind3digit1974; 

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
headocc3digit1975             =                  V3968_A            ;        
headind3digit1975			  =					 V3969_A			;
WGT1975                       =                  V4224              ;
keep id1975 headage1975 headgender1975 WGT1975 headmarital1975 headedu1975 headrace1975 headstatus1975 selfemploy1975 famsize1975 headocc3digit1975 headind3digit1975; 

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
headocc3digit1976             =                  V4459_A            ;        
headind3digit1976			  =					 V4460_A			;
WGT1976                       =                  V5099              ;
keep id1976 headage1976 headgender1976 WGT1976 headmarital1976 headedu1976 headrace1976 headstatus1976 selfemploy1976 famsize1976 headocc3digit1976 headind3digit1976; 

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
headocc3digit1977             =                  V5374_A            ;     
headind3digit1977			  =					 V5375_A			;
WGT1977                       =                  V5665              ;
keep id1977 headage1977 headgender1977 WGT1977 headmarital1977 headedu1977 headrace1977 headstatus1977 selfemploy1977 famsize1977 headocc3digit1977 headind3digit1977; 

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
headocc3digit1978             =                  V5873_A            ;        
headind3digit1978			  =					 V5874_A			;	
WGT1978                       =                  V6212              ;
keep id1978 headage1978 headgender1978 WGT1978 headmarital1978 headedu1978 headrace1978 headstatus1978 selfemploy1978 famsize1978 headocc3digit1978 headind3digit1978; 

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
headocc3digit1979             =                  V6497_A            ;
headind3digit1979			  =					 V6498_A			;
WGT1979                       =                  V6805              ;
keep id1979 headage1979 headgender1979 WGT1979 headmarital1979 headedu1979 headrace1979 headstatus1979 selfemploy1979 famsize1979 headocc3digit1979 headind3digit1979; 

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
headocc3digit1980             =                  V7100_A            ;
headind3digit1980			  =					 V7101_A			; 
WGT1980                       =                  V7451              ;
keep id1980 headage1980 headgender1980 WGT1980 headmarital1980 headedu1980 headrace1980 headstatus1980 selfemploy1980 famsize1980 headocc3digit1980 headind3digit1980;

data headinfor1981;
set psiddata.fam81;
id1981                        =                  V7502              ;                        
headage1981                   =                  V7658              ;
headgender1981                =                  V7659              ;      
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

data temp.head;
merge headinfor1968 headinfor1969 headinfor1970 headinfor1971 headinfor1972 headinfor1973 headinfor1974 headinfor1975 
      headinfor1976 headinfor1977 headinfor1978 headinfor1979 headinfor1980 headinfor1981 headinfor1982 headinfor1983 
      headinfor1984 headinfor1985 headinfor1986 headinfor1987;
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
%occind(1984) %occind(1985) %occind(1986) %occind(1987)

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
run;

******************************************************************************************************************
*****Each year there are some invalid observations of education and race of PSID head and wife, valid information*
*****may be located in other waves, we mapped them cross waves to maximize the number of valid observations******;

%macro vrace(year);
data vrace&year;
set temp.head;
if id&year ne . and headrace&year ne .; 
w = &year;
headrace = headrace&year;
keep id&year headrace;
proc sort data = vrace&year;
by id&year;

data person;
set temp.person;
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
%vrace(1985) %vrace(1986) %vrace(1987) 

data vrace;
set vrace1968 vrace1969 vrace1970 vrace1971 vrace1972 vrace1973 vrace1974 vrace1975 vrace1976
    vrace1977 vrace1978 vrace1979 vrace1980 vrace1981 vrace1982 vrace1983 vrace1984 
    vrace1985 vrace1986 vrace1987;
proc sort data = vrace nodupkey;
by pid;
run;

%macro race(year);
data race&year;
set temp.head;
if id&year ne . and headrace&year = .; 
w = &year;
keep id&year w;
proc sort data = race&year;
by id&year;

data person;
set temp.person;
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
%race(1968) %race(1985) %race(1986) %race(1987) 

%macro crace(year);
proc sort data = temp.head;
by id&year;
data temp.head;
merge temp.head race&year;
by id&year;
if headrace ne . then headrace&year = headrace;
run;
data u;
set temp.head;
if id&year ne .;
proc freq data = u;
tables headrace&year;
run;
%mend;
%crace(1968) %crace(1985) %crace(1986) %crace(1987)
********************************************************************************************************************
********************************************************************************************************************
********************************************************************************************************************
********************************************************************************************************************
********************************************************************************************************************
*******************************************************************************************************************;

%macro vedu(year);
data vedu&year;
set temp.head;
if id&year ne . and headedu&year ne .; 
w = &year;
headedu = headedu&year;
keep id&year headedu w;
proc sort data = vedu&year;
by id&year;

data person;
set temp.person;
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
%vedu(1985) %vedu(1986) %vedu(1987)

data vedu;
set vedu1968 vedu1969 vedu1970 vedu1971 vedu1972 vedu1973 vedu1974 vedu1975 vedu1976
    vedu1977 vedu1978 vedu1979 vedu1980 vedu1981 vedu1982 vedu1983 vedu1984 
    vedu1985 vedu1986 vedu1987;
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
set temp.head;
if id&year ne . and headedu&year = .; 
w = &year;
keep id&year w;
proc sort data = edu&year;
by id&year;

data person;
set temp.person;
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
%edu(1985) %edu(1986) %edu(1987)

%macro cedu(year);
proc sort data = temp.head;
by id&year;
data temp.head;
merge temp.head edu&year;
by id&year;
if headedu ne . then headedu&year = headedu;
run;
data u;
set temp.head;
if id&year ne .;
proc freq data = u;
tables headedu&year;
run;
%mend;
%cedu(1968) %cedu(1969) %cedu(1970) %cedu(1971) %cedu(1972) %cedu(1973) %cedu(1974) %cedu(1975) %cedu(1976)
%cedu(1977) %cedu(1978) %cedu(1979) %cedu(1980) %cedu(1981) %cedu(1982) %cedu(1983) %cedu(1984) 
%cedu(1985) %cedu(1986) %cedu(1987)

