/************************************************Work Related Data*****************************************************/

******Working Status (survey year) 
Working status for head is asked in all waves, for wife it is asked in 1976 and since 1979. In other years, the stauts
can be inferred from wife occupation questions.

from 1968 - 1975

1 Working now, or laid off only temporarily 
2 Unemployed 
3 Retired, permanently disabled 
4 Housewife 
5 Student 
6 Other 

after 1976

1 Working now 
2 Only temporarily laid off, sick leave or maternity leave 
3 Looking for work, unemployed 
4 Retired 
5 Permanently disabled temporarily disabled 
6 Keeping house 
7 Student 
8 Other;  

******Head and wife labor hours (prior year)
Apart from between 1994 and 2001, annual hours in the prior year are in the family data set.  Between 1994 and 2001,
annual hours are in the income plus data set.  PSID asks total weeks in the previous year and average hours per week.  
Total hours in the previous year is imputed

Did you have any other jobs or any other ways of making money in addition to your main job? Anything else?
[68]V227 [69]V660 [70]V1298 [71]V2004 [72]V2602 [73]V3135 [74]V3550 [75]V4005 [76]V4518 [77]V5428 [78]V5915 [79]V6526 [80]V7129 [81]V7744 [82]V8406 [83]V9037 [84]V10564 [85]V11708 [86]V13108 [87]V14206 [88]V15260 [89]V16761 [90]V18199 [91]V19499 [92]V20799 [93]V22580 [94]ER2228 [95]ER5227 [96]ER7323 [97]ER10235 [99]ER13366 [01]ER17398
;

data labor1968;
set psiddata.fam68; 
id1968                            =                  V3                 ; 
headhour1968                      =                  V47                ;
wifehour1968                      =                  V53                ;
headstatus1968                    =                  V196               ;
headweek1968                      =                  V223               ;
headweeklyhour1968                =                  V225               ;
headovertime1968                  =                  V226               ;   
headaddjob1968                    =                  V227               ;
headaddwage1968                   =                  V229               ;
keep id1968 headhour1968 wifehour1968 headstatus1968 headweeklyhour1968 headweek1968 headovertime1968 headaddjob1968 headaddwage1968;

data labor1969;
set psiddata.fam69;
id1969                            =                  V442               ;                       ;  
headhour1969                      =                  V465               ;
wifehour1969                      =                  V475               ;
headstatus1969                    =                  V639               ;
headweek1969                      =                  V658               ;
headweeklyhour1969                =                  V659               ;
headaddjob1969                    =                  V660               ;
headaddwage1969                   =                  V663               ;
headaddweek1969                   =                  V664               ;
headaddhour1969                   =                  V665               ;
keep id1969 headhour1969 wifehour1969 headstatus1969 headweeklyhour1969 headweek1969 headaddjob1969 headaddwage1969 headaddweek1969 headaddhour1969;

data labor1970;
set psiddata.fam70;
id1970                            =                  V1102              ;                       ; 
headhour1970                      =                  V1138              ;
wifehour1970                      =                  V1148              ;
headstatus1970                    =                  V1278              ;
headweek1970                      =                  V1292              ;
headweeklyhour1970                =                  V1293              ;
headextra1970                     =                  V1294              ;
headextrarate1970                 =                  V1295              ;
headhourly1970                    =                  V1296              ;
headhourlywage1970                =                  V1297              ;
headaddjob1970                    =                  V1298              ;
headaddwage1970                   =                  V1301              ;
headaddweek1970                   =                  V1302              ;
headaddhour1970                   =                  V1303              ;
keep id1970 headhour1970 wifehour1970 headstatus1970 headweeklyhour1970 headweek1970 headextra1970 headextrarate1970 headhourly1970 headhourlywage1970
     headaddjob1970 headaddwage1970 headaddweek1970 headaddhour1970;

data labor1971;
set psiddata.fam71;
id1971                            =                  V1802              ;                       ; 
headhour1971                      =                  V1839              ;
wifehour1971                      =                  V1849              ;
headstatus1971                    =                  V1983              ;
headweek1971                      =                  V1998              ;
headweeklyhour1971                =                  V1999              ;
headextra1971                     =                  V2000              ;
headextrarate1971                 =                  V2001              ;
headhourly1971                    =                  V2002              ;
headhourlywage1971                =                  V2003              ;
headaddjob1971                    =                  V2004              ;
headaddwage1971                   =                  V2007              ;
headaddweek1971                   =                  V2008              ;
headaddhour1971                   =                  V2009              ;
keep id1971 headhour1971 wifehour1971 headstatus1971 headweeklyhour1971 headweek1971 headextra1971 headextrarate1971 headhourly1971 headhourlywage1971
     headaddjob1971 headaddwage1971 headaddweek1971 headaddhour1971;

data labor1972;
set psiddata.fam72;
id1972                            =                  V2402              ;                       ; 
headhour1972                      =                  V2439              ;
wifehour1972                      =                  V2449              ;
headstatus1972                    =                  V2581              ;
headweek1972                      =                  V2596              ;
headweeklyhour1972                =                  V2597              ;
headextra1972                     =                  V2598              ;
headextrarate1972                 =                  V2599              ;
headhourly1972                    =                  V2600              ;
headhourlywage1972                =                  V2601              ;
headaddjob1972                    =                  V2602              ;
headaddwage1972                   =                  V2605              ;
headaddweek1972                   =                  V2606              ;
headaddhour1972                   =                  V2607              ;
keep id1972 headhour1972 wifehour1972 headstatus1972 headweeklyhour1972 headweek1972 headextra1972 headextrarate1972 headhourly1972 headhourlywage1972
     headaddjob1972 headaddwage1972 headaddweek1972 headaddhour1972;

data labor1973;
set psiddata.fam73; 
id1973                            =                  V3002              ;                       ; 
headhour1973                      =                  V3027              ;
wifehour1973                      =                  V3035              ;
headstatus1973                    =                  V3114              ;
headweek1973                      =                  V3129              ;
headweeklyhour1973                =                  V3130              ;
headextra1973                     =                  V3131              ;
headextrarate1973                 =                  V3132              ;
headhourly1973                    =                  V3133              ;
headhourlywage1973                =                  V3134              ;
headaddjob1973                    =                  V3135              ;
headaddwage1973                   =                  V3138              ;
headaddweek1973                   =                  V3139              ;
headaddhour1973                   =                  V3140              ;
keep id1973 headhour1973 wifehour1973 headstatus1973 headweeklyhour1973 headweek1973 headextra1973 headextrarate1973 headhourly1973 headhourlywage1973
     headaddjob1973 headaddwage1973 headaddweek1973 headaddhour1973;

data labor1974;
set psiddata.fam74;
id1974                            =                  V3402              ;                       ; 
headhour1974                      =                  V3423              ;
wifehour1974                      =                  V3431              ;
headstatus1974                    =                  V3528              ;
headweek1974                      =                  V3544              ;
headweeklyhour1974                =                  V3545              ;
headextra1974                     =                  V3546              ;
headextrarate1974                 =                  V3547              ;
headhourly1974                    =                  V3548              ;
headhourlywage1974                =                  V3549              ;
headaddjob1974                    =                  V3550              ;
headaddwage1974                   =                  V3553              ;
headaddweek1974                   =                  V3554              ;
headaddhour1974                   =                  V3555              ;
keep id1974 headhour1974 wifehour1974 headstatus1974 headweeklyhour1974 headweek1974 headextra1974 headextrarate1974 headhourly1974 headhourlywage1974
     headaddjob1974 headaddwage1974 headaddweek1974 headaddhour1974;

data labor1975;
set psiddata.fam75;
id1975                            =                  V3802              ;                       ; 
headhour1975                      =                  V3823              ;
wifehour1975                      =                  V3831              ;
headstatus1975                    =                  V3967              ;
headweek1975                      =                  V3998              ;
headweeklyhour1975                =                  V3999              ;
headextra1975                     =                  V4000              ;
headextrarate1975                 =                  V4001              ;
headhourly1975                    =                  V4002              ;
headhourlywage1975                =                  V4003              ;
headaddjob1975                    =                  V4005              ;
headaddwage1975                   =                  V4008              ;
headaddweek1975                   =                  V4009              ;
headaddhour1975                   =                  V4010              ;
keep id1975 headhour1975 wifehour1975 headstatus1975 headweeklyhour1975 headweek1975 headextra1975 headextrarate1975 headhourly1975 headhourlywage1975
     headaddjob1975 headaddwage1975 headaddweek1975 headaddhour1975;

data labor1976;
set psiddata.fam76;
id1976                            =                  V4302              ;                       ; 
headhour1976                      =                  V4332              ;
wifehour1976                      =                  V4344              ;
headstatus1976                    =                  V4458              ;
headweek1976                      =                  V4507              ;
headweeklyhour1976                =                  V4508              ;
headsalaried1976                  =                  V4509              ;
headsalariedwage1976              =                  V4510              ;
headsalariedextra1976             =                  V4511              ;
headsalariedextrarate1976         =                  V4512              ;
headhourlywage1976                =                  V4513              ;
headhourlyextrarate1976           =                  V4514              ;
headotherpaid1976                 =                  V4515              ;
headotherpaidextrarate1976        =                  V4516              ;
headaddjob1976                    =                  V4518              ;
headaddwage1976                   =                  V4521              ;
headaddweek1976                   =                  V4522              ;
headaddhour1976                   =                  V4523              ;
wifestatus1976                    =                  V4841              ;
wifeweek1976                      =                  V4890              ;
wifeweeklyhour1976                =                  V4891              ;
wifesalaried1976                  =                  V4892              ;
wifesalariedwage1976              =                  V4893              ;
wifesalariedextra1976             =                  V4894              ;
wifesalariedextrarate1976         =                  V4895              ;
wifehourlywage1976                =                  V4896              ;
wifesalariedextrarate1976         =                  V4897              ;
wifeotherpaid1976                 =                  V4898              ;
wifeotherpaidextrarate1976        =                  V4899              ;
wifeaddjob1976                    =                  V4901              ;
wifeaddwage1976                   =                  V4904              ;
wifeaddweek1976                   =                  V4905              ;
wifeaddhour1976                   =                  V4906              ;
keep id1976 headhour1976 wifehour1976 headstatus1976 wifestatus1976   
     headweek1976 headweeklyhour1976 headsalaried1976 headsalariedwage1976 headsalariedextra1976 headsalariedextrarate1976 headhourlywage1976 
     headhourlyextrarate1976 headotherpaid1976 headotherpaidextrarate1976 headaddjob1976 headaddwage1976 headaddweek1976 headaddhour1976 
     wifeweek1976 wifeweeklyhour1976 wifesalaried1976 wifesalariedwage1976 wifesalariedextra1976 wifesalariedextrarate1976 wifehourlywage1976 
     wifesalariedextrarate1976 wifeotherpaid1976 wifeotherpaidextrarate1976 wifeaddjob1976 wifeaddwage1976 wifeaddweek1976 wifeaddhour1976;

data labor1977;
set psiddata.fam77;
id1977                            =                  V5202              ;                       ; 
headhour1977                      =                  V5232              ;
wifehour1977                      =                  V5244              ;
headstatus1977                    =                  V5373              ;
headweek1977                      =                  V5417              ;
headweeklyhour1977                =                  V5418              ;
headovertime1977                  =                  V5419              ;
headsalaried1977                  =                  V5420              ;
headsalariedwage1977              =                  V5421              ;
headsalariedextra1977             =                  V5422              ;
headsalariedextrarate1977         =                  V5423              ;
headhourlywage1977                =                  V5424              ;
headsalariedextrarate1977         =                  V5425              ;
headotherpaid1977                 =                  V5426              ;
headotherpaidextrarate1977        =                  V5427              ;
headaddjob1977                    =                  V5428              ;
headaddwage1977                   =                  V5431              ;
headaddweek1977                   =                  V5432              ;
headaddhour1977                   =                  V5433              ;
keep id1977 headhour1977 wifehour1977 headstatus1977   
     headweek1977 headweeklyhour1977 headovertime1977 headsalaried1977 headsalariedwage1977 headsalariedextra1977 headsalariedextrarate1977 
     headhourlywage1977 headsalariedextrarate1977 headotherpaid1977 headotherpaidextrarate1977 headaddjob1977 headaddwage1977 headaddweek1977 headaddhour1977;


data labor1978;
set psiddata.fam78;
id1978                            =                  V5702              ;                       ; 
headhour1978                      =                  V5731              ;
wifehour1978                      =                  V5743              ;
headstatus1978                    =                  V5872              ;
headweek1978                      =                  V5904              ;
headweeklyhour1978                =                  V5905              ;
headovertime1978                  =                  V5906              ;
headsalaried1978                  =                  V5907              ;
headsalariedwage1978              =                  V5908              ;
headsalariedextra1978             =                  V5909              ;
headsalariedextrarate1978         =                  V5910              ;
headhourlywage1978                =                  V5911              ;
headsalariedextrarate1978         =                  V5912              ;
headotherpaid1978                 =                  V5913              ;
headotherpaidextrarate1978        =                  V5914              ;
headaddjob1978                    =                  V5915              ;
headaddwage1978                   =                  V5918              ;
headaddweek1978                   =                  V5919              ;
headaddhour1978                   =                  V5920              ;
keep id1978 headhour1978 wifehour1978 headstatus1978   
     headweek1978 headweeklyhour1978 headovertime1978 headsalaried1978 headsalariedwage1978 headsalariedextra1978 headsalariedextrarate1978 
     headhourlywage1978 headsalariedextrarate1978 headotherpaid1978 headotherpaidextrarate1978 headaddjob1978 headaddwage1978 headaddweek1978 headaddhour1978;

data labor1979;
set psiddata.fam79;
id1979                            =                  V6302              ;                       ; 
headhour1979                      =                  V6336              ;
wifehour1979                      =                  V6348              ;
headstatus1979                    =                  V6492              ;
headweek1979                      =                  V6515              ;
headweeklyhour1979                =                  V6516              ;
headovertime1979                  =                  V6517              ;
headsalaried1979                  =                  V6518              ;
headsalariedwage1979              =                  V6519              ;
headsalariedextra1979             =                  V6520              ;
headsalariedextrarate1979         =                  V6521              ;
headhourlywage1979                =                  V6522              ;
headhourlyextrarate1979           =                  V6523              ;
headotherpaid1979                 =                  V6524              ;
headotherpaidextrarate1979        =                  V6525              ;
headaddjob1979                    =                  V6526              ;
headaddwage1979                   =                  V6529              ;
headaddweek1979                   =                  V6530              ;
headaddhour1979                   =                  V6531              ;
wifestatus1979                    =                  V6591              ;
wifeweek1979                      =                  V6611              ;
wifeweeklyhour1979                =                  V6612              ;
wifeovertime1979                  =                  V6613              ;
wifesalaried1979                  =                  V6614              ;
wifesalariedwage1979              =                  V6615              ;
wifehourlywage1979                =                  V6616              ;
wifeotherpaid1979                 =                  V6617              ;
wifeaddjob1979                    =                  V6618              ;
wifeaddweek1979                   =                  V6620              ;
wifeaddhour1979                   =                  V6621              ;
keep id1979 headhour1979 wifehour1979 headstatus1979 wifestatus1979   
     headweek1979 headweeklyhour1979 headovertime1979 headsalaried1979 headsalariedwage1979 headsalariedextra1979 headsalariedextrarate1979 
     headhourlywage1979 headhourlyextrarate1979 headotherpaid1979 headotherpaidextrarate1979 headaddjob1979 headaddwage1979 headaddweek1979 headaddhour1979 
     wifeweek1979 wifeweeklyhour1979 wifeovertime1979 wifesalaried1979 wifesalariedwage1979 wifehourlywage1979 wifeotherpaid1979 
     wifeaddjob1979 wifeaddweek1979 wifeaddhour1979;


data labor1980;
set psiddata.fam80;
id1980                            =                  V6902              ;                       ; 
headhour1980                      =                  V6934              ;
wifehour1980                      =                  V6946              ;
headstatus1980                    =                  V7095              ;
headweek1980                      =                  V7118              ;
headweeklyhour1980                =                  V7119              ;
headovertime1980                  =                  V7120              ;
headsalaried1980                  =                  V7121              ;
headsalariedwage1980              =                  V7122              ;
headsalariedextra1980             =                  V7123              ;
headsalariedextrarate1980         =                  V7124              ;
headhourlywage1980                =                  V7125              ;
headhourlyextrarate1980           =                  V7126              ;
headotherpaid1980                 =                  V7127              ;
headotherpaidextrarate1980        =                  V7128              ;
headaddjob1980                    =                  V7129              ;
headaddwage1980                   =                  V7132              ;
headaddweek1980                   =                  V7133              ;
headaddhour1980                   =                  V7134              ;
wifestatus1980                    =                  V7193              ;
wifeweek1980                      =                  V7213              ;
wifeweeklyhour1980                =                  V7214              ;
wifeovertime1980                  =                  V7215              ;
wifesalaried1980                  =                  V7216              ;
wifesalariedwage1980              =                  V7217              ;
wifehourlywage1980                =                  V7218              ;
wifeotherpaid1980                 =                  V7219              ;
wifeaddjob1980                    =                  V7220              ;
wifeaddweek1980                   =                  V7222              ;
wifeaddhour1980                   =                  V7223              ;
keep id1980 headhour1980 wifehour1980 headstatus1980 wifestatus1980   
     headweek1980 headweeklyhour1980 headovertime1980 headsalaried1980 headsalariedwage1980 headsalariedextra1980 headsalariedextrarate1980 
     headhourlywage1980 headhourlyextrarate1980 headotherpaid1980 headotherpaidextrarate1980 headaddjob1980 headaddwage1980 headaddweek1980 headaddhour1980 
     wifeweek1980 wifeweeklyhour1980 wifeovertime1980 wifesalaried1980 wifesalariedwage1980 wifehourlywage1980 wifeotherpaid1980 
     wifeaddjob1980 wifeaddweek1980 wifeaddhour1980;

data labor1981;
set psiddata.fam81;
id1981                            =                  V7502              ;                       ; 
headhour1981                      =                  V7530              ;
wifehour1981                      =                  V7540              ;
headstatus1981                    =                  V7706              ;
headweek1981                      =                  V7741              ;
headweeklyhour1981                =                  V7742              ;
headovertime1981                  =                  V7743              ;
headsalaried1981                  =                  V7714              ;
headsalariedwage1981              =                  V7715              ;
headsalariedextra1981             =                  V7716              ;
headsalariedextrarate1981         =                  V7717              ;
headhourlywage1981                =                  V7718              ;
headhourlyextrarate1981           =                  V7719              ;
headotherpaid1981                 =                  V7720              ;
headotherpaidextrarate1981        =                  V7721              ;
headaddjob1981                    =                  V7744              ;
headaddwage1981                   =                  V7747              ;
headaddweek1981                   =                  V7748              ;
headaddhour1981                   =                  V7749              ;
wifestatus1981                    =                  V7879              ;
wifeweek1981                      =                  V7904              ;
wifeweeklyhour1981                =                  V7905              ;
wifeovertime1981                  =                  V7906              ;
wifesalaried1981                  =                  V7887              ;
wifesalariedwage1981              =                  V7888              ;
wifehourlywage1981                =                  V7889              ;
wifeotherpaid1981                 =                  V7890              ;
wifeaddjob1981                    =                  V7907              ;
wifeaddweek1981                   =                  V7909              ;
wifeaddhour1981                   =                  V7910              ;
keep id1981 headhour1981 wifehour1981 headstatus1981 wifestatus1981   
     headweek1981 headweeklyhour1981 headovertime1981 headsalaried1981 headsalariedwage1981 headsalariedextra1981 headsalariedextrarate1981 
     headhourlywage1981 headhourlyextrarate1981 headotherpaid1981 headotherpaidextrarate1981 headaddjob1981 headaddwage1981 headaddweek1981 headaddhour1981 
     wifeweek1981 wifeweeklyhour1981 wifeovertime1981 wifesalaried1981 wifesalariedwage1981 wifehourlywage1981 wifeotherpaid1981 
     wifeaddjob1981 wifeaddweek1981 wifeaddhour1981;

data labor1982;
set psiddata.fam82;
id1982                            =                  V8202              ;                       ; 
headhour1982                      =                  V8228              ;
wifehour1982                      =                  V8238              ;
headstatus1982                    =                  V8374              ;
headweek1982                      =                  V8403              ;
headweeklyhour1982                =                  V8404              ;
headovertime1982                  =                  V8405              ;
headsalaried1982                  =                  V8382              ;
headsalariedwage1982              =                  V8383              ;
headsalariedextra1982             =                  V8384              ;
headsalariedextrarate1982         =                  V8385              ;
headhourlywage1982                =                  V8386              ;
headhourlyextrarate1982           =                  V8387              ;
headotherpaid1982                 =                  V8388              ;
headotherpaidextrarate1982        =                  V8389              ;
headaddjob1982                    =                  V8406              ;
headaddwage1982                   =                  V8409              ;
headaddweek1982                   =                  V8410              ;
headaddhour1982                   =                  V8411              ;
wifestatus1982                    =                  V8538              ;
wifeweek1982                      =                  V8562              ;
wifeweeklyhour1982                =                  V8563              ;
wifeovertime1982                  =                  V8564              ;
wifesalaried1982                  =                  V8546              ;
wifesalariedwage1982              =                  V8547              ;
wifehourlywage1982                =                  V8548              ;
wifeotherpaid1982                 =                  V8549              ;
wifeaddjob1982                    =                  V8565              ;
wifeaddweek1982                   =                  V8567              ;
wifeaddhour1982                   =                  V8568              ;
keep id1982 headhour1982 wifehour1982 headstatus1982 wifestatus1982   
     headweek1982 headweeklyhour1982 headovertime1982 headsalaried1982 headsalariedwage1982 headsalariedextra1982 headsalariedextrarate1982 
     headhourlywage1982 headhourlyextrarate1982 headotherpaid1982 headotherpaidextrarate1982 headaddjob1982 headaddwage1982 headaddweek1982 headaddhour1982 
     wifeweek1982 wifeweeklyhour1982 wifeovertime1982 wifesalaried1982 wifesalariedwage1982 wifehourlywage1982 wifeotherpaid1982 
     wifeaddjob1982 wifeaddweek1982 wifeaddhour1982;

data labor1983;
set psiddata.fam83;
id1983                            =                  V8802              ;                       ; 
headhour1983                      =                  V8830              ;
wifehour1983                      =                  V8840              ;
headstatus1983                    =                  V9005              ;
headweek1983                      =                  V9034              ;
headweeklyhour1983                =                  V9035              ;
headovertime1983                  =                  V9036              ;
headsalaried1983                  =                  V9013              ;
headsalariedwage1983              =                  V9014              ;
headsalariedextra1983             =                  V9015              ;
headsalariedextrarate1983         =                  V9016              ;
headhourlywage1983                =                  V9017              ;
headhourlyextrarate1983           =                  V9018              ;
headotherpaid1983                 =                  V9019              ;
headotherpaidextrarate1983        =                  V9020              ;
headaddjob1983                    =                  V9037              ;
headaddwage1983                   =                  V9040              ;
headaddweek1983                   =                  V9041              ;
headaddhour1983                   =                  V9042              ;
wifestatus1983                    =                  V9188              ;
wifeweek1983                      =                  V9212              ;
wifeweeklyhour1983                =                  V9213              ;
wifeovertime1983                  =                  V9214              ;
wifesalaried1983                  =                  V9196              ;
wifesalariedwage1983              =                  V9197              ;
wifehourlywage1983                =                  V9198              ;
wifeotherpaid1983                 =                  V9199              ;
wifeaddjob1983                    =                  V9215              ;
wifeaddweek1983                   =                  V9217              ;
wifeaddhour1983                   =                  V9218              ;
keep id1983 headhour1983 wifehour1983 headstatus1983 wifestatus1983   
     headweek1983 headweeklyhour1983 headovertime1983 headsalaried1983 headsalariedwage1983 headsalariedextra1983 headsalariedextrarate1983 
     headhourlywage1983 headhourlyextrarate1983 headotherpaid1983 headotherpaidextrarate1983 headaddjob1983 headaddwage1983 headaddweek1983 headaddhour1983 
     wifeweek1983 wifeweeklyhour1983 wifeovertime1983 wifesalaried1983 wifesalariedwage1983 wifehourlywage1983 wifeotherpaid1983 
     wifeaddjob1983 wifeaddweek1983 wifeaddhour1983;

data labor1984;
set psiddata.fam84;
id1984                            =                  V10002              ;                       ; 
headhour1984                      =                  V10037              ;
wifehour1984                      =                  V10131              ;
headstatus1984                    =                  V10453              ;
headweek1984                      =                  V10561              ;
headweeklyhour1984                =                  V10562             ;
headovertime1984                  =                  V10563             ;
headsalaried1984                  =                  V10462             ;
headsalariedwage1984              =                  V10463             ;
headsalariedextra1984             =                  V10464             ;
headsalariedextrarate1984         =                  V10465             ;
headhourlywage1984                =                  V10466             ;
headhourlyextrarate1984           =                  V10467             ;
headotherpaid1984                 =                  V10468             ;
headotherpaidextrarate1984        =                  V10469             ;
headaddjob1984                    =                  V10564             ;
headaddwage1984                   =                  V10567             ;
headaddweek1984                   =                  V10568             ;
headaddhour1984                   =                  V10569             ;
wifestatus1984                    =                  V10671             ;
wifeweek1984                      =                  V10775             ;
wifeweeklyhour1984                =                  V10776             ;
wifeovertime1984                  =                  V10777             ;
wifesalaried1984                  =                  V10680             ;
wifesalariedwage1984              =                  V10681             ;
wifehourlywage1984                =                  V10682             ;
wifeotherpaid1984                 =                  V10683             ;
wifeaddjob1984                    =                  V10778             ;
wifeaddweek1984                   =                  V10781             ;
wifeaddhour1984                   =                  V10782             ;
keep id1984 headhour1984 wifehour1984 headstatus1984 wifestatus1984   
     headweek1984 headweeklyhour1984 headovertime1984 headsalaried1984 headsalariedwage1984 headsalariedextra1984 headsalariedextrarate1984 
     headhourlywage1984 headhourlyextrarate1984 headotherpaid1984 headotherpaidextrarate1984 headaddjob1984 headaddwage1984 headaddweek1984 headaddhour1984 
     wifeweek1984 wifeweeklyhour1984 wifeovertime1984 wifesalaried1984 wifesalariedwage1984 wifehourlywage1984 wifeotherpaid1984 
     wifeaddjob1984 wifeaddweek1984 wifeaddhour1984;

data labor1985;
set psiddata.fam85;
id1985                            =                  V11102              ;                       ; 
headhour1985                      =                  V11146              ;
wifehour1985                      =                  V11258              ;
headstatus1985                    =                  V11637              ;
headweek1985                      =                  V11705              ;
headweeklyhour1985                =                  V11706              ;
headovertime1985                  =                  V11707              ;
headsalaried1985                  =                  V11653              ;
headsalariedwage1985              =                  V11654              ;
headsalariedextra1985             =                  V11655              ;
headsalariedextrarate1985         =                  V11656              ;
headhourlywage1985                =                  V11657              ;
headhourlyextrarate1985           =                  V11658              ;
headotherpaid1985                 =                  V11659              ;
headotherpaidextrarate1985        =                  V11660              ;
headaddjob1985                    =                  V11708              ;
headaddwage1985                   =                  V11711              ;
headaddweek1985                   =                  V11712              ;
headaddhour1985                   =                  V11713              ;
wifestatus1985                    =                  V12000              ;
wifeweek1985                      =                  V12068              ;
wifeweeklyhour1985                =                  V12069              ;
wifeovertime1985                  =                  V12070              ;
wifesalaried1985                  =                  V12016              ;
wifesalariedwage1985              =                  V12017              ;
wifesalariedextra1985             =                  V12018              ;
wifesalariedextrarate1985         =                  V12019              ;
wifehourlywage1985                =                  V12020              ;
wifehourlyextrarate1985           =                  V12021              ;
wifeotherpaid1985                 =                  V12022              ;
wifeotherpaidextrarate1985        =                  V12023              ;
wifeaddjob1985                    =                  V12071              ;
wifeaddwage1985                   =                  V12074              ;
wifeaddweek1985                   =                  V12075              ;
wifeaddhour1985                   =                  V12076              ;
keep id1985 headhour1985 wifehour1985 headstatus1985 wifestatus1985   
     headweek1985 headweeklyhour1985 headovertime1985 headsalaried1985 headsalariedwage1985 headsalariedextra1985 headsalariedextrarate1985 
     headhourlywage1985 headhourlyextrarate1985 headotherpaid1985 headotherpaidextrarate1985 headaddjob1985 headaddwage1985 headaddweek1985 headaddhour1985 
     wifeweek1985 wifeweeklyhour1985 wifeovertime1985 wifesalaried1985 wifesalariedwage1985 wifesalariedextra1985 wifesalariedextrarate1985 
     wifehourlywage1985 wifehourlyextrarate1985 wifeotherpaid1985 wifeotherpaidextrarate1985 wifeaddjob1985 wifeaddwage1985 wifeaddweek1985 wifeaddhour1985;

data labor1986;
set psiddata.fam86;
id1986                            =                  V12502              ;                       ; 
headhour1986                      =                  V12545              ;
wifehour1986                      =                  V12657              ;
headstatus1986                    =                  V13046              ;
headweek1986                      =                  V13105              ;
headweeklyhour1986                =                  V13106              ;
headovertime1986                  =                  V13107              ;
headsalaried1986                  =                  V13056              ;
headsalariedwage1986              =                  V13057              ;
headsalariedextra1986             =                  V13058              ;
headsalariedextrarate1986         =                  V13059              ;
headhourlywage1986                =                  V13060              ;
headhourlyextrarate1986           =                  V13061              ;
headotherpaid1986                 =                  V13062              ;
headotherpaidextrarate1986        =                  V13063              ;
headaddjob1986                    =                  V13108              ;
headaddwage1986                   =                  V13111              ;
headaddweek1986                   =                  V13112              ;
headaddhour1986                   =                  V13113              ;
wifestatus1986                    =                  V13225              ;
wifeweek1986                      =                  V13282              ;
wifeweeklyhour1986                =                  V13283              ;
wifeovertime1986                  =                  V13284              ;
wifesalaried1986                  =                  V13235              ;
wifesalariedwage1986              =                  V13236              ;
wifesalariedextra1986             =                  V13237              ;
wifesalariedextrarate1986         =                  V13238              ;
wifehourlywage1986                =                  V13239              ;
wifehourlyextrarate1986           =                  V13240              ;
wifeotherpaid1986                 =                  V13241              ;
wifeotherpaidextrarate1986        =                  V13242              ;
wifeaddjob1986                    =                  V13285              ;
wifeaddwage1986                   =                  V13288              ;
wifeaddweek1986                   =                  V13289              ;
wifeaddhour1986                   =                  V13290              ;
keep id1986 headhour1986 wifehour1986 headstatus1986 wifestatus1986   
     headweek1986 headweeklyhour1986 headovertime1986 headsalaried1986 headsalariedwage1986 headsalariedextra1986 headsalariedextrarate1986 
     headhourlywage1986 headhourlyextrarate1986 headotherpaid1986 headotherpaidextrarate1986 headaddjob1986 headaddwage1986 headaddweek1986 headaddhour1986 
     wifeweek1986 wifeweeklyhour1986 wifeovertime1986 wifesalaried1986 wifesalariedwage1986 wifesalariedextra1986 wifesalariedextrarate1986 
     wifehourlywage1986 wifehourlyextrarate1986 wifeotherpaid1986 wifeotherpaidextrarate1986 wifeaddjob1986 wifeaddwage1986 wifeaddweek1986 wifeaddhour1986;

data labor1987;
set psiddata.fam87;
id1987                            =                  V13702              ;                       ; 
headhour1987                      =                  V13745              ;
wifehour1987                      =                  V13809              ;
headstatus1987                    =                  V14146              ;
headweek1987                      =                  V14203              ;
headweeklyhour1987                =                  V14204              ;
headovertime1987                  =                  V14205              ;
headsalaried1987                  =                  V14156              ;
headsalariedwage1987              =                  V14157              ;
headsalariedextra1987             =                  V14158              ;
headsalariedextrarate1987         =                  V14159              ;
headhourlywage1987                =                  V14160              ;
headhourlyextrarate1987           =                  V14161              ;
headotherpaid1987                 =                  V14162              ;
headotherpaidextrarate1987        =                  V14163              ;
headaddjob1987                    =                  V14206              ;
headaddwage1987                   =                  V14209              ;
headaddweek1987                   =                  V14210              ;
headaddhour1987                   =                  V14211              ;
wifestatus1987                    =                  V14321              ;
wifeweek1987                      =                  V14376              ;
wifeweeklyhour1987                =                  V14377              ;
wifeovertime1987                  =                  V14378              ;
wifesalaried1987                  =                  V14331              ;
wifesalariedwage1987              =                  V14332              ;
wifesalariedextra1987             =                  V14333              ;
wifesalariedextrarate1987         =                  V14334              ;
wifehourlywage1987                =                  V14335              ;
wifehourlyextrarate1987           =                  V14336              ;
wifeotherpaid1987                 =                  V14337              ;
wifeotherpaidextrarate1987        =                  V14338              ;
wifeaddjob1987                    =                  V14379              ;
wifeaddwage1987                   =                  V14382              ;
wifeaddweek1987                   =                  V14383              ;
wifeaddhour1987                   =                  V14384              ;
keep id1987 headhour1987 wifehour1987 headstatus1987 wifestatus1987   
     headweek1987 headweeklyhour1987 headovertime1987 headsalaried1987 headsalariedwage1987 headsalariedextra1987 headsalariedextrarate1987 
     headhourlywage1987 headhourlyextrarate1987 headotherpaid1987 headotherpaidextrarate1987 headaddjob1987 headaddwage1987 headaddweek1987 headaddhour1987 
     wifeweek1987 wifeweeklyhour1987 wifeovertime1987 wifesalaried1987 wifesalariedwage1987 wifesalariedextra1987 wifesalariedextrarate1987 
     wifehourlywage1987 wifehourlyextrarate1987 wifeotherpaid1987 wifeotherpaidextrarate1987 wifeaddjob1987 wifeaddwage1987 wifeaddweek1987 wifeaddhour1987;

data labor1988;
set psiddata.fam88;
id1988                            =                  V14802              ;                       ; 
headhour1988                      =                  V14835              ;
wifehour1988                      =                  V14865              ;
headstatus1988                    =                  V15154              ;
headweek1988                      =                  V15257              ;
headweeklyhour1988                =                  V15258              ;
headovertime1988                  =                  V15259              ;
headsalaried1988                  =                  V15164              ;
headsalariedwage1988              =                  V15165              ;
headsalariedextra1988             =                  V15166              ;
headsalariedextrarate1988         =                  V15167              ;
headhourlywage1988                =                  V15168              ;
headhourlyextrarate1988           =                  V15169              ;
headotherpaid1988                 =                  V15170              ;
headotherpaidextrarate1988        =                  V15171              ;
headaddjob1988                    =                  V15260              ;
headaddwage1988                   =                  V15265              ;
headaddweek1988                   =                  V15266              ;
headaddhour1988                   =                  V15267              ;
wifestatus1988                    =                  V15456              ;
wifeweek1988                      =                  V15559              ;
wifeweeklyhour1988                =                  V15560              ;
wifeovertime1988                  =                  V15561              ;
wifesalaried1988                  =                  V15466              ;
wifesalariedwage1988              =                  V15467              ;
wifesalariedextra1988             =                  V15468              ;
wifesalariedextrarate1988         =                  V15469              ;
wifehourlywage1988                =                  V15470              ;
wifehourlyextrarate1988           =                  V15471              ;
wifeotherpaid1988                 =                  V15472              ;
wifeotherpaidextrarate1988        =                  V15473              ;
wifeaddjob1988                    =                  V15562              ;
wifeaddwage1988                   =                  V15567              ;
wifeaddweek1988                   =                  V15568              ;
wifeaddhour1988                   =                  V15569              ;
keep id1988 headhour1988 wifehour1988 headstatus1988 wifestatus1988   
     headweek1988 headweeklyhour1988 headovertime1988 headsalaried1988 headsalariedwage1988 headsalariedextra1988 headsalariedextrarate1988 
     headhourlywage1988 headhourlyextrarate1988 headotherpaid1988 headotherpaidextrarate1988 headaddjob1988 headaddwage1988 headaddweek1988 headaddhour1988 
     wifeweek1988 wifeweeklyhour1988 wifeovertime1988 wifesalaried1988 wifesalariedwage1988 wifesalariedextra1988 wifesalariedextrarate1988 
     wifehourlywage1988 wifehourlyextrarate1988 wifeotherpaid1988 wifeotherpaidextrarate1988 wifeaddjob1988 wifeaddwage1988 wifeaddweek1988 wifeaddhour1988;

data labor1989;
set psiddata.fam89;
id1989                            =                  V16302              ;                       ; 
headhour1989                      =                  V16335              ;
wifehour1989                      =                  V16365              ;
headstatus1989                    =                  V16655              ;
headweek1989                      =                  V16758              ;
headweeklyhour1989                =                  V16759              ;
headovertime1989                  =                  V16760              ;
headsalaried1989                  =                  V16665              ;
headsalariedwage1989              =                  V16666              ;
headsalariedextra1989             =                  V16667              ;
headsalariedextrarate1989         =                  V16668              ;
headhourlywage1989                =                  V16669              ;
headhourlyextrarate1989           =                  V16670              ;
headotherpaid1989                 =                  V16671              ;
headotherpaidextrarate1989        =                  V16672              ;
headaddjob1989                    =                  V16761              ;
headaddwage1989                   =                  V16766              ;
headaddweek1989                   =                  V16767              ;
headaddhour1989                   =                  V16768              ;
wifestatus1989                    =                  V16974              ;
wifeweek1989                      =                  V17077              ;
wifeweeklyhour1989                =                  V17078              ;
wifeovertime1989                  =                  V17079              ;
wifesalaried1989                  =                  V16984              ;
wifesalariedwage1989              =                  V16985              ;
wifesalariedextra1989             =                  V16986              ;
wifesalariedextrarate1989         =                  V16987              ;
wifehourlywage1989                =                  V16988              ;
wifehourlyextrarate1989           =                  V16989              ;
wifeotherpaid1989                 =                  V16990              ;
wifeotherpaidextrarate1989        =                  V16991              ;
wifeaddjob1989                    =                  V17080              ;
wifeaddwage1989                   =                  V17085              ;
wifeaddweek1989                   =                  V17086              ;
wifeaddhour1989                   =                  V17087              ;
keep id1989 headhour1989 wifehour1989 headstatus1989 wifestatus1989   
     headweek1989 headweeklyhour1989 headovertime1989 headsalaried1989 headsalariedwage1989 headsalariedextra1989 headsalariedextrarate1989 
     headhourlywage1989 headhourlyextrarate1989 headotherpaid1989 headotherpaidextrarate1989 headaddjob1989 headaddwage1989 headaddweek1989 headaddhour1989 
     wifeweek1989 wifeweeklyhour1989 wifeovertime1989 wifesalaried1989 wifesalariedwage1989 wifesalariedextra1989 wifesalariedextrarate1989 
     wifehourlywage1989 wifehourlyextrarate1989 wifeotherpaid1989 wifeotherpaidextrarate1989 wifeaddjob1989 wifeaddwage1989 wifeaddweek1989 wifeaddhour1989;

data labor1990;
set psiddata.fam90;
id1990                            =                  V17702              ;                       ; 
headhour1990                      =                  V17744              ;
wifehour1990                      =                  V17774              ;
headstatus1990                    =                  V18093              ;
headweek1990                      =                  V18196              ;
headweeklyhour1990                =                  V18197              ;
headovertime1990                  =                  V18198              ;
headsalaried1990                  =                  V18103              ;
headsalariedwage1990              =                  V18104              ;
headsalariedextra1990             =                  V18105              ;
headsalariedextrarate1990         =                  V18106              ;
headhourlywage1990                =                  V18107              ;
headhourlyextrarate1990           =                  V18108              ;
headotherpaid1990                 =                  V18109              ;
headotherpaidextrarate1990        =                  V18110              ;
headaddjob1990                    =                  V18199              ;
headaddwage1990                   =                  V18204              ;
headaddweek1990                   =                  V18205              ;
headaddhour1990                   =                  V18206              ;
wifestatus1990                    =                  V18395              ;
wifeweek1990                      =                  V18498              ;
wifeweeklyhour1990                =                  V18499              ;
wifeovertime1990                  =                  V18500              ;
wifesalaried1990                  =                  V18405              ;
wifesalariedwage1990              =                  V18406              ;
wifesalariedextra1990             =                  V18407              ;
wifesalariedextrarate1990         =                  V18408              ;
wifehourlywage1990                =                  V18409              ;
wifehourlyextrarate1990           =                  V18410              ;
wifeotherpaid1990                 =                  V18411              ;
wifeotherpaidextrarate1990        =                  V18412              ;
wifeaddjob1990                    =                  V18501              ;
wifeaddwage1990                   =                  V18506              ;
wifeaddweek1990                   =                  V18507              ;
wifeaddhour1990                   =                  V18508              ;
keep id1990 headhour1990 wifehour1990 headstatus1990 wifestatus1990   
     headweek1990 headweeklyhour1990 headovertime1990 headsalaried1990 headsalariedwage1990 headsalariedextra1990 headsalariedextrarate1990 
     headhourlywage1990 headhourlyextrarate1990 headotherpaid1990 headotherpaidextrarate1990 headaddjob1990 headaddwage1990 headaddweek1990 headaddhour1990 
     wifeweek1990 wifeweeklyhour1990 wifeovertime1990 wifesalaried1990 wifesalariedwage1990 wifesalariedextra1990 wifesalariedextrarate1990 
     wifehourlywage1990 wifehourlyextrarate1990 wifeotherpaid1990 wifeotherpaidextrarate1990 wifeaddjob1990 wifeaddwage1990 wifeaddweek1990 wifeaddhour1990;

data labor1991;
set psiddata.fam91;
id1991                            =                  V19002              ;                       ; 
headhour1991                      =                  V19044              ;
wifehour1991                      =                  V19074              ;
headstatus1991                    =                  V19393              ;
headweek1991                      =                  V19496              ;
headweeklyhour1991                =                  V19497              ;
headovertime1991                  =                  V19498              ;
headsalaried1991                  =                  V19403              ;
headsalariedwage1991              =                  V19404              ;
headsalariedextra1991             =                  V19405              ;
headsalariedextrarate1991         =                  V19406              ;
headhourlywage1991                =                  V19407              ;
headhourlyextrarate1991           =                  V19408              ;
headotherpaid1991                 =                  V19409              ;
headotherpaidextrarate1991        =                  V19410              ;
headaddjob1991                    =                  V19499              ;
headaddwage1991                   =                  V19504              ;
headaddweek1991                   =                  V19505              ;
headaddhour1991                   =                  V19506              ;
wifestatus1991                    =                  V19695              ;
wifeweek1991                      =                  V19798              ;
wifeweeklyhour1991                =                  V19799              ;
wifeovertime1991                  =                  V19800              ;
wifesalaried1991                  =                  V19705              ;
wifesalariedwage1991              =                  V19706              ;
wifesalariedextra1991             =                  V19707              ;
wifesalariedextrarate1991         =                  V19708              ;
wifehourlywage1991                =                  V19709              ;
wifehourlyextrarate1991           =                  V19710              ;
wifeotherpaid1991                 =                  V19711              ;
wifeotherpaidextrarate1991        =                  V19712              ;
wifeaddjob1991                    =                  V19801              ;
wifeaddwage1991                   =                  V19806              ;
wifeaddweek1991                   =                  V19807              ;
wifeaddhour1991                   =                  V19808              ;
keep id1991 headhour1991 wifehour1991 headstatus1991 wifestatus1991   
     headweek1991 headweeklyhour1991 headovertime1991 headsalaried1991 headsalariedwage1991 headsalariedextra1991 headsalariedextrarate1991 
     headhourlywage1991 headhourlyextrarate1991 headotherpaid1991 headotherpaidextrarate1991 headaddjob1991 headaddwage1991 headaddweek1991 headaddhour1991 
     wifeweek1991 wifeweeklyhour1991 wifeovertime1991 wifesalaried1991 wifesalariedwage1991 wifesalariedextra1991 wifesalariedextrarate1991 
     wifehourlywage1991 wifehourlyextrarate1991 wifeotherpaid1991 wifeotherpaidextrarate1991 wifeaddjob1991 wifeaddwage1991 wifeaddweek1991 wifeaddhour1991;

data labor1992;
set psiddata.fam92;
id1992                            =                  V20302              ;                       ; 
headhour1992                      =                  V20344              ;
wifehour1992                      =                  V20374              ;
headstatus1992                    =                  V20693              ;
headweek1992                      =                  V20796              ;
headweeklyhour1992                =                  V20797              ;
headovertime1992                  =                  V20798              ;
headsalaried1992                  =                  V20703              ;
headsalariedwage1992              =                  V20704              ;
headsalariedextra1992             =                  V20705              ;
headsalariedextrarate1992         =                  V20706              ;
headhourlywage1992                =                  V20707              ;
headhourlyextrarate1992           =                  V20708              ;
headotherpaid1992                 =                  V20709              ;
headotherpaidextrarate1992        =                  V20710              ;
headaddjob1992                    =                  V20799              ;
headaddwage1992                   =                  V20804              ;
headaddweek1992                   =                  V20805              ;
headaddhour1992                   =                  V20806              ;
wifestatus1992                    =                  V20995              ;
wifeweek1992                      =                  V21099              ;
wifeweeklyhour1992                =                  V21100              ;
wifeovertime1992                  =                  V21101              ;
wifesalaried1992                  =                  V21005              ;
wifesalariedwage1992              =                  V21006              ;
wifesalariedextra1992             =                  V21007              ;
wifesalariedextrarate1992         =                  V21008              ;
wifehourlywage1992                =                  V21009              ;
wifehourlyextrarate1992           =                  V21010              ;
wifeotherpaid1992                 =                  V21011              ;
wifeotherpaidextrarate1992        =                  V21012              ;
wifeaddjob1992                    =                  V21102              ;
wifeaddwage1992                   =                  V21106              ;
wifeaddweek1992                   =                  V21107              ;
wifeaddhour1992                   =                  V21108              ;
keep id1992 headhour1992 wifehour1992 headstatus1992 wifestatus1992   
     headweek1992 headweeklyhour1992 headovertime1992 headsalaried1992 headsalariedwage1992 headsalariedextra1992 headsalariedextrarate1992 
     headhourlywage1992 headhourlyextrarate1992 headotherpaid1992 headotherpaidextrarate1992 headaddjob1992 headaddwage1992 headaddweek1992 headaddhour1992 
     wifeweek1992 wifeweeklyhour1992 wifeovertime1992 wifesalaried1992 wifesalariedwage1992 wifesalariedextra1992 wifesalariedextrarate1992 
     wifehourlywage1992 wifehourlyextrarate1992 wifeotherpaid1992 wifeotherpaidextrarate1992 wifeaddjob1992 wifeaddwage1992 wifeaddweek1992 wifeaddhour1992;

data labor1993;
set psiddata.fam93;
id1993                            =                  V21602              ;                       ; 
headhour1993                      =                  V21634              ;
wifehour1993                      =                  V21670              ;
headstatus1993                    =                  V22448              ;
headweek1993                      =                  V22575              ;
headweeklyhour1993                =                  V22577              ;
headovertime1993                  =                  V22579              ;
headsalaried1993                  =                  V22463              ;
headsalariedwage1993              =                  V22464              ;
headsalariedwageper1993           =                  V22465              ;
headsalariedextra1993             =                  V22466              ;
headsalariedextrarate1993         =                  V22467              ;
headhourlywage1993                =                  V22470              ;
headhourlyextrarate1993           =                  V22471              ;
headotherpaid1993                 =                  V22478              ;
headotherpaidextrarate1993        =                  V22479              ;
headaddjob1993                    =                  V22580              ;
headaddwage1993                   =                  V22585              ;
headaddwageper1993                =                  V22586              ;
headaddweek1993                   =                  V22587              ;
headaddhour1993                   =                  V22589              ;
wifestatus1993                    =                  V22801              ;
wifeweek1993                      =                  V22928              ;
wifeweeklyhour1993                =                  V22930              ;
wifeovertime1993                  =                  V22932              ;
wifesalaried1993                  =                  V22816              ;
wifesalariedwage1993              =                  V22817              ;
wifesalariedwageper1993           =                  V22818              ;
wifesalariedextra1993             =                  V22819              ;
wifesalariedextrarate1993         =                  V22820              ;
wifehourlywage1993                =                  V22823              ;
wifehourlyextrarate1993           =                  V22824              ;
wifeotherpaid1993                 =                  V22831              ;
wifeotherpaidextrarate1993        =                  V22832              ;
wifeaddjob1993                    =                  V22933              ;
wifeaddwage1993                   =                  V22938              ;
wifeaddwageper1993                =                  V22939              ;
wifeaddweek1993                   =                  V22940              ;
wifeaddhour1993                   =                  V22942              ;
keep id1993 headhour1993 wifehour1993 headstatus1993 wifestatus1993   
     headweek1993 headweeklyhour1993 headovertime1993 headsalaried1993 headsalariedwage1993 headsalariedwageper1993 headsalariedextra1993 headsalariedextrarate1993 
     headhourlywage1993 headhourlyextrarate1993 headotherpaid1993 headotherpaidextrarate1993 headaddjob1993 headaddwage1993 headaddwageper1993 headaddweek1993 headaddhour1993 
     wifeweek1993 wifeweeklyhour1993 wifeovertime1993 wifesalaried1993 wifesalariedwage1993 wifesalariedwageper1993 wifesalariedextra1993 wifesalariedextrarate1993 
     wifehourlywage1993 wifehourlyextrarate1993 wifeotherpaid1993 wifeotherpaidextrarate1993 wifeaddjob1993 wifeaddwage1993 wifeaddwageper1993 wifeaddweek1993 wifeaddhour1993; run;

data labor1994;
set psiddata.HourWage9401;
id1994                            =                  ER2002             ;
if id1994 ne .                                                          ;  
headhour1994                      =                  HDTOT94            ;
wifehour1994                      =                  WFTOT94            ;
headweek1994                      =                  HDWKS94            ;
headweeklyhour1994                =                  HDAVG94            ;
headovertimehour1994              =                  HDOVT94            ;
headaddhour1994                   =                  HDXTR94            ;
wifeweek1994                      =                  WFWKS94            ;
wifeweeklyhour1994                =                  WFAVG94            ;
wifeovertimehour1994              =                  WFOVT94            ;
wifeaddhour1994                   =                  WFXTR94            ;
keep id1994 headhour1994 wifehour1994 headweek1994 headweeklyhour1994 headovertimehour1994 headaddhour1994
     wifeweek1994 wifeweeklyhour1994 wifeovertimehour1994 wifeaddhour1994;

proc sort;
by id1994;

data status1994;
set psiddata.fam94;
id1994                            =                  ER2002             ;
headstatus1994                    =                  ER2068             ;
headsalaried1994                  =                  ER2081              ;
headsalariedwage1994              =                  ER2082              ;
headsalariedwageper1994           =                  ER2083              ;
headsalariedextra1994             =                  ER2084              ;
headsalariedextrarate1994         =                  ER2085              ;
headhourlywage1994                =                  ER2088              ;
headhourlyextrarate1994           =                  ER2089              ;
headotherpaid1994                 =                  ER2086              ;
headotherpaidextrarate1994        =                  ER2087              ;
headaddjob1994                    =                  ER2228              ;
headaddwage1994                   =                  ER2230              ;
headaddwageper1994                =                  ER2231              ;
headaddweek1994                   =                  ER2232              ;
headaddhour1994                   =                  ER2233              ;
wifestatus1994                    =                  ER2562              ;
wifesalaried1994                  =                  ER2575              ;
wifesalariedwage1994              =                  ER2576              ;
wifesalariedwageper1994           =                  ER2577              ;
wifesalariedextra1994             =                  ER2578              ;
wifesalariedextrarate1994         =                  ER2579              ;
wifehourlywage1994                =                  ER2582              ;
wifehourlyextrarate1994           =                  ER2583              ;
wifeotherpaid1994                 =                  ER2580              ;
wifeotherpaidextrarate1994        =                  ER2581              ;
wifeaddjob1994                    =                  ER2722              ;
wifeaddwage1994                   =                  ER2724              ;
wifeaddwageper1994                =                  ER2725              ;
wifeaddweek1994                   =                  ER2726              ;
wifeaddhour1994                   =                  ER2727              ;
keep id1994 headstatus1994 wifestatus1994   
     headsalaried1994 headsalariedwage1994 headsalariedwageper1994 headsalariedextra1994 headsalariedextrarate1994 
     headhourlywage1994 headhourlyextrarate1994 headotherpaid1994 headotherpaidextrarate1994 headaddjob1994 headaddwage1994 headaddwageper1994 headaddweek1994 headaddhour1994 
     wifesalaried1994 wifesalariedwage1994 wifesalariedwageper1994 wifesalariedextra1994 wifesalariedextrarate1994 
     wifehourlywage1994 wifehourlyextrarate1994 wifeotherpaid1994 wifeotherpaidextrarate1994 wifeaddjob1994 wifeaddwage1994 wifeaddwageper1994 wifeaddweek1994 wifeaddhour1994;

proc sort;
by id1994;

data labor1994;
merge labor1994 status1994;
by id1994;


data labor1995;
set psiddata.HourWage9401;
id1995                            =                  ER5002             ;
if id1995 ne .                                                          ;  
headhour1995                      =                  HDTOT95            ;
wifehour1995                      =                  WFTOT95            ;
headweek1995                      =                  HDWKS95            ;
headweeklyhour1995                =                  HDAVG95            ;
headovertimehour1995              =                  HDOVT95            ;
headaddhour1995                   =                  HDXTR95            ;
wifeweek1995                      =                  WFWKS95            ;
wifeweeklyhour1995                =                  WFAVG95            ;
wifeovertimehour1995              =                  WFOVT95            ;
wifeaddhour1995                   =                  WFXTR95            ;
keep id1995 headhour1995 wifehour1995 headweek1995 headweeklyhour1995 headovertimehour1995 headaddhour1995
     wifeweek1995 wifeweeklyhour1995 wifeovertimehour1995 wifeaddhour1995;

proc sort;
by id1995;

data status1995;
set psiddata.fam95;
id1995                            =                  ER5002             ;
headstatus1995                    =                  ER5067             ;
headsalaried1995                  =                  ER5080              ;
headsalariedwage1995              =                  ER5081              ;
headsalariedwageper1995           =                  ER5082              ;
headsalariedextra1995             =                  ER5083              ;
headsalariedextrarate1995         =                  ER5084              ;
headhourlywage1995                =                  ER5087              ;
headhourlyextrarate1995           =                  ER5088              ;
headotherpaid1995                 =                  ER5085              ;
headotherpaidextrarate1995        =                  ER5086              ;
headaddjob1995                    =                  ER5227              ;
headaddwage1995                   =                  ER5229              ;
headaddwageper1995                =                  ER5230              ;
headaddweek1995                   =                  ER5231              ;
headaddhour1995                   =                  ER5232              ;
wifestatus1995                    =                  ER5561              ;
wifesalaried1995                  =                  ER5574              ;
wifesalariedwage1995              =                  ER5575              ;
wifesalariedwageper1995           =                  ER5576              ;
wifesalariedextra1995             =                  ER5577              ;
wifesalariedextrarate1995         =                  ER5578              ;
wifehourlywage1995                =                  ER5581              ;
wifehourlyextrarate1995           =                  ER5582              ;
wifeotherpaid1995                 =                  ER5579              ;
wifeotherpaidextrarate1995        =                  ER5580              ;
wifeaddjob1995                    =                  ER5721              ;
wifeaddwage1995                   =                  ER5723              ;
wifeaddwageper1995                =                  ER5724              ;
wifeaddweek1995                   =                  ER5725              ;
wifeaddhour1995                   =                  ER5726              ;
keep id1995 headstatus1995 wifestatus1995   
     headsalaried1995 headsalariedwage1995 headsalariedwageper1995 headsalariedextra1995 headsalariedextrarate1995 
     headhourlywage1995 headhourlyextrarate1995 headotherpaid1995 headotherpaidextrarate1995 headaddjob1995 headaddwage1995 headaddwageper1995 headaddweek1995 headaddhour1995 
     wifesalaried1995 wifesalariedwage1995 wifesalariedwageper1995 wifesalariedextra1995 wifesalariedextrarate1995 
     wifehourlywage1995 wifehourlyextrarate1995 wifeotherpaid1995 wifeotherpaidextrarate1995 wifeaddjob1995 wifeaddwage1995 wifeaddwageper1995 wifeaddweek1995 wifeaddhour1995;

proc sort;
by id1995;

data labor1995;
merge labor1995 status1995;
by id1995;

data labor1996;
set psiddata.HourWage9401;
id1996                            =                  ER7002             ;
if id1996 ne .                                                          ;  
headhour1996                      =                  HDTOT96            ;
wifehour1996                      =                  WFTOT96            ;
headweek1996                      =                  HDWKS96            ;
headweeklyhour1996                =                  HDAVG96            ;
headovertimehour1996              =                  HDOVT96            ;
headaddhour1996                   =                  HDXTR96            ;
wifeweek1996                      =                  WFWKS96            ;
wifeweeklyhour1996                =                  WFAVG96            ;
wifeovertimehour1996              =                  WFOVT96            ;
wifeaddhour1996                   =                  WFXTR96            ;
keep id1996 headhour1996 wifehour1996 headweek1996 headweeklyhour1996 headovertimehour1996 headaddhour1996
     wifeweek1996 wifeweeklyhour1996 wifeovertimehour1996 wifeaddhour1996;

proc sort;
by id1996;

data status1996;
set psiddata.fam96;
id1996                            =                  ER7002             ;
headstatus1996                    =                  ER7163             ;
headsalaried1996                  =                  ER7176              ;
headsalariedwage1996              =                  ER7177              ;
headsalariedwageper1996           =                  ER7178              ;
headsalariedextra1996             =                  ER7179              ;
headsalariedextrarate1996         =                  ER7180              ;
headhourlywage1996                =                  ER7183              ;
headhourlyextrarate1996           =                  ER7184              ;
headotherpaid1996                 =                  ER7181              ;
headotherpaidextrarate1996        =                  ER7182              ;
headaddjob1996                    =                  ER7323              ;
headaddwage1996                   =                  ER7325              ;
headaddwageper1996                =                  ER7326              ;
headaddweek1996                   =                  ER7327              ;
headaddhour1996                   =                  ER7328              ;
wifestatus1996                    =                  ER7657              ;
wifesalaried1996                  =                  ER7670              ;
wifesalariedwage1996              =                  ER7671              ;
wifesalariedwageper1996           =                  ER7672              ;
wifesalariedextra1996             =                  ER7673              ;
wifesalariedextrarate1996         =                  ER7674              ;
wifehourlywage1996                =                  ER7677              ;
wifehourlyextrarate1996           =                  ER7678              ;
wifeotherpaid1996                 =                  ER7675              ;
wifeotherpaidextrarate1996        =                  ER7676              ;
wifeaddjob1996                    =                  ER7817              ;
wifeaddwage1996                   =                  ER7819              ;
wifeaddwageper1996                =                  ER7820              ;
wifeaddweek1996                   =                  ER7821              ;
wifeaddhour1996                   =                  ER7822              ;
keep id1996 headstatus1996 wifestatus1996   
     headsalaried1996 headsalariedwage1996 headsalariedwageper1996 headsalariedextra1996 headsalariedextrarate1996 
     headhourlywage1996 headhourlyextrarate1996 headotherpaid1996 headotherpaidextrarate1996 headaddjob1996 headaddwage1996 headaddwageper1996 headaddweek1996 headaddhour1996 
     wifesalaried1996 wifesalariedwage1996 wifesalariedwageper1996 wifesalariedextra1996 wifesalariedextrarate1996 
     wifehourlywage1996 wifehourlyextrarate1996 wifeotherpaid1996 wifeotherpaidextrarate1996 wifeaddjob1996 wifeaddwage1996 wifeaddwageper1996 wifeaddweek1996 wifeaddhour1996;

proc sort;
by id1996;

data labor1996;
merge labor1996 status1996;
by id1996;


data labor1997;
set psiddata.HourWage9401;
id1997                            =                  ER10002             ;
if id1997 ne .                                                          ;  
headhour1997                      =                  HDTOT97            ;
wifehour1997                      =                  WFTOT97            ;
headweek1997                      =                  HDWKS97            ;
headweeklyhour1997                =                  HDAVG97            ;
headovertimehour1997              =                  HDOVT97            ;
headaddhour1997                   =                  HDXTR97            ;
wifeweek1997                      =                  WFWKS97            ;
wifeweeklyhour1997                =                  WFAVG97            ;
wifeovertimehour1997              =                  WFOVT97            ;
wifeaddhour1997                   =                  WFXTR97            ;
keep id1997 headhour1997 wifehour1997 headweek1997 headweeklyhour1997 headovertimehour1997 headaddhour1997
     wifeweek1997 wifeweeklyhour1997 wifeovertimehour1997 wifeaddhour1997;

proc sort;
by id1997;

data status1997;
set psiddata.fam97;
id1997                            =                  ER10002             ;
headstatus1997                    =                  ER10081             ;
headsalaried1997                  =                  ER10091              ;
headsalariedwage1997              =                  ER10092              ;
headsalariedwageper1997           =                  ER10093              ;
headsalariedextra1997             =                  ER10094              ;
headsalariedextrarate1997         =                  ER10095              ;
headhourlywage1997                =                  ER10098              ;
headhourlyextrarate1997           =                  ER10099              ;
headotherpaid1997                 =                  ER10106              ;
headotherpaidextrarate1997        =                  ER10107              ;
headaddjob1997                    =                  ER10258              ;
headaddwage1997                   =                  ER10260              ;
headaddwageper1997                =                  ER10261              ;
headaddweek1997                   =                  ER10262              ;
headaddhour1997                   =                  ER10263              ;
wifestatus1997                    =                  ER10563              ;
wifesalaried1997                  =                  ER10573              ;
wifesalariedwage1997              =                  ER10574              ;
wifesalariedwageper1997           =                  ER10575              ;
wifesalariedextra1997             =                  ER10576              ;
wifesalariedextrarate1997         =                  ER10577              ;
wifehourlywage1997                =                  ER10580              ;
wifehourlyextrarate1997           =                  ER10588              ;
wifeotherpaid1997                 =                  ER10589              ;
wifeotherpaidextrarate1997        =                  ER10581              ;
wifeaddjob1997                    =                  ER10717              ;
wifeaddwage1997                   =                  ER10719              ;
wifeaddwageper1997                =                  ER10720              ;
wifeaddweek1997                   =                  ER10721              ;
wifeaddhour1997                   =                  ER10722              ;
keep id1997 headstatus1997 wifestatus1997   
     headsalaried1997 headsalariedwage1997 headsalariedwageper1997 headsalariedextra1997 headsalariedextrarate1997 
     headhourlywage1997 headhourlyextrarate1997 headotherpaid1997 headotherpaidextrarate1997 headaddjob1997 headaddwage1997 headaddwageper1997 headaddweek1997 headaddhour1997 
     wifesalaried1997 wifesalariedwage1997 wifesalariedwageper1997 wifesalariedextra1997 wifesalariedextrarate1997 
     wifehourlywage1997 wifehourlyextrarate1997 wifeotherpaid1997 wifeotherpaidextrarate1997 wifeaddjob1997 wifeaddwage1997 wifeaddwageper1997 wifeaddweek1997 wifeaddhour1997;

proc sort;
by id1997;

data labor1997;
merge labor1997 status1997;
by id1997;

data labor1999;
set psiddata.HourWage9401;
id1999                            =                  ER13002             ;
if id1999 ne .                                                          ;  
headhour1999                      =                  HDTOT99            ;
wifehour1999                      =                  WFTOT99            ;
headweek1999                      =                  HDWKS99            ;
headweeklyhour1999                =                  HDAVG99            ;
headovertimehour1999              =                  HDOVT99            ;
headaddhour1999                   =                  HDXTR99            ;
wifeweek1999                      =                  WFWKS99            ;
wifeweeklyhour1999                =                  WFAVG99            ;
wifeovertimehour1999              =                  WFOVT99            ;
wifeaddhour1999                   =                  WFXTR99            ;
keep id1999 headhour1999 wifehour1999 headweek1999 headweeklyhour1999 headovertimehour1999 headaddhour1999
     wifeweek1999 wifeweeklyhour1999 wifeovertimehour1999 wifeaddhour1999;

proc sort;
by id1999;

data status1999;
set psiddata.fam99;
id1999                            =                  ER13002             ;
headstatus1999                    =                  ER13205             ;
headsalaried1999                  =                  ER13217              ;
headsalariedwage1999              =                  ER13218              ;
headsalariedwageper1999           =                  ER13219              ;
headsalariedextra1999             =                  ER13220              ;
headsalariedextrarate1999         =                  ER13221              ;
headhourlywage1999                =                  ER13224              ;
headhourlyextrarate1999           =                  ER13225              ;
headotherpaid1999                 =                  ER13232              ;
headotherpaidextrarate1999        =                  ER13233              ;
headaddjob1999                    =                  ER13366              ;
headaddwage1999                   =                  ER13370              ;
headaddwageper1999                =                  ER13371              ;
headaddweek1999                   =                  ER13372              ;
headaddhour1999                   =                  ER13373              ;
wifestatus1999                    =                  ER13717              ;
wifesalaried1999                  =                  ER13729              ;
wifesalariedwage1999              =                  ER13730              ;
wifesalariedwageper1999           =                  ER13731              ;
wifesalariedextra1999             =                  ER13732              ;
wifesalariedextrarate1999         =                  ER13733              ;
wifehourlywage1999                =                  ER13736              ;
wifehourlyextrarate1999           =                  ER13737              ;
wifeotherpaid1999                 =                  ER13744              ;
wifeotherpaidextrarate1999        =                  ER13745              ;
wifeaddjob1999                    =                  ER13878              ;
wifeaddwage1999                   =                  ER13882              ;
wifeaddwageper1999                =                  ER13883              ;
wifeaddweek1999                   =                  ER13884              ;
wifeaddhour1999                   =                  ER13885              ;
keep id1999 headstatus1999 wifestatus1999   
     headsalaried1999 headsalariedwage1999 headsalariedwageper1999 headsalariedextra1999 headsalariedextrarate1999 
     headhourlywage1999 headhourlyextrarate1999 headotherpaid1999 headotherpaidextrarate1999 headaddjob1999 headaddwage1999 headaddwageper1999 headaddweek1999 headaddhour1999 
     wifesalaried1999 wifesalariedwage1999 wifesalariedwageper1999 wifesalariedextra1999 wifesalariedextrarate1999 
     wifehourlywage1999 wifehourlyextrarate1999 wifeotherpaid1999 wifeotherpaidextrarate1999 wifeaddjob1999 wifeaddwage1999 wifeaddwageper1999 wifeaddweek1999 wifeaddhour1999;

proc sort;
by id1999;

data labor1999;
merge labor1999 status1999;
by id1999;

data labor2001;
set psiddata.HourWage9401;
id2001                            =                  ER17002             ;
if id2001 ne .                                                          ;  
headhour2001                      =                  HDTOT01            ;
wifehour2001                      =                  WFTOT01            ;
headweek2001                      =                  HDWKS01            ;
headweeklyhour2001                =                  HDAVG01            ;
headovertimehour2001              =                  HDOVT01            ;
headaddhour2001                   =                  HDXTR01            ;
wifeweek2001                      =                  WFWKS01            ;
wifeweeklyhour2001                =                  WFAVG01            ;
wifeovertimehour2001              =                  WFOVT01            ;
wifeaddhour2001                   =                  WFXTR01            ;
keep id2001 headhour2001 wifehour2001 headweek2001 headweeklyhour2001 headovertimehour2001 headaddhour2001
     wifeweek2001 wifeweeklyhour2001 wifeovertimehour2001 wifeaddhour2001;

proc sort;
by id2001;

data status2001;
set psiddata.fam01;
id2001                            =                  ER17002             ;
headstatus2001                    =                  ER17216             ;
headsalaried2001                  =                  ER17228              ;
headsalariedwage2001              =                  ER17229              ;
headsalariedwageper2001           =                  ER17230              ;
headsalariedextra2001             =                  ER17231              ;
headsalariedextrarate2001         =                  ER17232              ;
headhourlywage2001                =                  ER17235              ;
headhourlyextrarate2001           =                  ER17236              ;
headotherpaid2001                 =                  ER17243              ;
headotherpaidextrarate2001        =                  ER17244              ;
headaddjob2001                    =                  ER17398              ;
headaddwage2001                   =                  ER17402              ;
headaddwageper2001                =                  ER17403              ;
headaddweek2001                   =                  ER17404              ;
headaddhour2001                   =                  ER17406              ;
wifestatus2001                    =                  ER17786              ;
wifesalaried2001                  =                  ER17798              ;
wifesalariedwage2001              =                  ER17799              ;
wifesalariedwageper2001           =                  ER17800              ;
wifesalariedextra2001             =                  ER17801              ;
wifesalariedextrarate2001         =                  ER17802              ;
wifehourlywage2001                =                  ER17805              ;
wifehourlyextrarate2001           =                  ER17806              ;
wifeotherpaid2001                 =                  ER17813              ;
wifeotherpaidextrarate2001        =                  ER17814              ;
wifeaddjob2001                    =                  ER17968              ;
wifeaddwage2001                   =                  ER17972              ;
wifeaddwageper2001                =                  ER17937              ;
wifeaddweek2001                   =                  ER17974              ;
wifeaddhour2001                   =                  ER17976              ;
keep id2001 headstatus2001 wifestatus2001   
     headsalaried2001 headsalariedwage2001 headsalariedwageper2001 headsalariedextra2001 headsalariedextrarate2001 
     headhourlywage2001 headhourlyextrarate2001 headotherpaid2001 headotherpaidextrarate2001 headaddjob2001 headaddwage2001 headaddwageper2001 headaddweek2001 headaddhour2001 
     wifesalaried2001 wifesalariedwage2001 wifesalariedwageper2001 wifesalariedextra2001 wifesalariedextrarate2001 
     wifehourlywage2001 wifehourlyextrarate2001 wifeotherpaid2001 wifeotherpaidextrarate2001 wifeaddjob2001 wifeaddwage2001 wifeaddwageper2001 wifeaddweek2001 wifeaddhour2001;

proc sort;
by id2001;

data labor2001;
merge labor2001 status2001;
by id2001;

data labor2003;
set psiddata.fam03;
id2003                            =                  ER21002              ;
headhour2003                      =                  ER24080              ;
wifehour2003                      =                  ER24091              ;
headstatus2003                    =                  ER21123              ;
headweek2003                      =                  ER24077              ;
headweeklyhour2003                =                  ER24078              ;
headovertimehour2003              =                  ER21179              ;
headsalaried2003                  =                  ER21152              ;
headsalariedwage2003              =                  ER21153              ;
headsalariedwageper2003           =                  ER21154              ;
headsalariedextra2003             =                  ER21155              ;
headsalariedextrarate2003         =                  ER21156              ;
headsalariedextraamount2003       =                  ER21157              ;
headsalariedextraamountper2003    =                  ER21158              ;
headhourlywage2003                =                  ER21159              ;
headhourlyextrarate2003           =                  ER21160              ;
headhourlyextraamount2003         =                  ER21163              ;
headhourlyextraamountper2003      =                  ER21164              ;
headotherpaid2003                 =                  ER21169              ;
headotherpaidextrarate2003        =                  ER21170              ;
wifestatus2003                    =                  ER21373              ;
wifeweek2003                      =                  ER24088              ;
wifeweeklyhour2003                =                  ER24089              ;
wifeovertimehour2003              =                  ER21429              ;
wifesalaried2003                  =                  ER21402              ;
wifesalariedwage2003              =                  ER21403              ;
wifesalariedwageper2003           =                  ER21404              ;
wifesalariedextra2003             =                  ER21405              ;
wifesalariedextrarate2003         =                  ER21406              ;
wifesalariedextraamount2003       =                  ER21407              ;
wifesalariedextraamountper2003    =                  ER21408              ;
wifehourlywage2003                =                  ER21409              ;
wifehourlyextrarate2003           =                  ER21410              ;
wifehourlyextraamount2003         =                  ER21413              ;
wifehourlyextraamountper2003      =                  ER21414              ;
wifeotherpaid2003                 =                  ER21419              ;
wifeotherpaidextrarate2003        =                  ER21420              ;
keep id2003 headstatus2003 wifestatus2003 headhour2003 wifehour2003 headweek2003 headweeklyhour2003 headovertimehour2003 
     wifeweek2003 wifeweeklyhour2003 wifeovertimehour2003  
     headsalaried2003 headsalariedwage2003 headsalariedwageper2003 headsalariedextra2003 headsalariedextrarate2003 
     headhourlywage2003 headhourlyextrarate2003 headotherpaid2003 headotherpaidextrarate2003
     wifesalaried2003 wifesalariedwage2003 wifesalariedwageper2003 wifesalariedextra2003 wifesalariedextrarate2003 
     wifehourlywage2003 wifehourlyextrarate2003 wifeotherpaid2003 wifeotherpaidextrarate2003;

data labor2005;
set psiddata.fam05;
id2005                            =                  ER25002              ;
headhour2005                      =                  ER27886              ;
wifehour2005                      =                  ER27897              ;
headstatus2005                    =                  ER25104              ;
headweek2005                      =                  ER27883              ;
headweeklyhour2005                =                  ER27884              ;
headovertimehour2005              =                  ER25168              ;
headsalaried2005                  =                  ER25141              ;
headsalariedwage2005              =                  ER25142              ;
headsalariedwageper2005           =                  ER25143              ;
headsalariedextra2005             =                  ER25144              ;
headsalariedextrarate2005         =                  ER25145              ;
headsalariedextraamount2005       =                  ER25146              ;
headsalariedextraamountper2005    =                  ER25147              ;
headhourlywage2005                =                  ER25148              ;
headhourlyextrarate2005           =                  ER25149              ;
headhourlyextraamount2005         =                  ER25152              ;
headhourlyextraamountper2005      =                  ER25153              ;
headotherpaid2005                 =                  ER25158              ;
headotherpaidextrarate2005        =                  ER25159              ;
wifestatus2005                    =                  ER25362              ;
wifeweek2005                      =                  ER27894              ;
wifeweeklyhour2005                =                  ER27895              ;
wifeovertimehour2005              =                  ER25426              ;
wifesalaried2005                  =                  ER25399              ;
wifesalariedwage2005              =                  ER25400              ;
wifesalariedwageper2005           =                  ER25401              ;
wifesalariedextra2005             =                  ER25402              ;
wifesalariedextrarate2005         =                  ER25403              ;
wifesalariedextraamount2005       =                  ER25404              ;
wifesalariedextraamountper2005    =                  ER25405              ;
wifehourlywage2005                =                  ER25406              ;
wifehourlyextrarate2005           =                  ER25407              ;
wifehourlyextraamount2005         =                  ER25410              ;
wifehourlyextraamountper2005      =                  ER25411              ;
wifeotherpaid2005                 =                  ER25416              ;
wifeotherpaidextrarate2005        =                  ER25417              ;
keep id2005 headstatus2005 wifestatus2005 headhour2005 wifehour2005 headweek2005 headweeklyhour2005 headovertimehour2005 
     wifeweek2005 wifeweeklyhour2005 wifeovertimehour2005  
     headsalaried2005 headsalariedwage2005 headsalariedwageper2005 headsalariedextra2005 headsalariedextrarate2005 
     headhourlywage2005 headhourlyextrarate2005 headotherpaid2005 headotherpaidextrarate2005
     wifesalaried2005 wifesalariedwage2005 wifesalariedwageper2005 wifesalariedextra2005 wifesalariedextrarate2005 
     wifehourlywage2005 wifehourlyextrarate2005 wifeotherpaid2005 wifeotherpaidextrarate2005;
run;

data labor2007;
set psiddata.fam07;
id2007                            =                  ER36002              ;
headhour2007                      =                  ER40876              ;
wifehour2007                      =                  ER40887              ;
headstatus2007                    =                  ER36109              ;
headweek2007                      =                  ER36349              ;
headweeklyhour2007                =                  ER36350              ;
headovertimehour2007              =                  ER36173              ;
headsalaried2007                  =                  ER36146              ;
headsalariedwage2007              =                  ER36147              ;
headsalariedwageper2007           =                  ER36148              ;
headsalariedextra2007             =                  ER36149              ;
headsalariedextrarate2007         =                  ER36150              ;
headsalariedextraamount2007       =                  ER36151              ;
headsalariedextraamountper2007    =                  ER36152              ;
headhourlywage2007                =                  ER36153              ;
headhourlyextrarate2007           =                  ER36154              ;
headhourlyextraamount2007         =                  ER36157              ;
headhourlyextraamountper2007      =                  ER36158              ;
headotherpaid2007                 =                  ER36163              ;
headotherpaidextrarate2007        =                  ER36164              ;
wifestatus2007                    =                  ER36367              ;
wifeweek2007                      =                  ER36607              ;
wifeweeklyhour2007                =                  ER36608              ;
wifeovertimehour2007              =                  ER36431              ;
wifesalaried2007                  =                  ER36404              ;
wifesalariedwage2007              =                  ER36405              ;
wifesalariedwageper2007           =                  ER36406              ;
wifesalariedextra2007             =                  ER36407              ;
wifesalariedextrarate2007         =                  ER36408              ;
wifesalariedextraamount2007       =                  ER36409              ;
wifesalariedextraamountper2007    =                  ER36410              ;
wifehourlywage2007                =                  ER36411              ;
wifehourlyextrarate2007           =                  ER36412              ;
wifehourlyextraamount2007         =                  ER36415              ;
wifehourlyextraamountper2007      =                  ER36416              ;
wifeotherpaid2007                 =                  ER36421              ;
wifeotherpaidextrarate2007        =                  ER36422              ;
keep id2007 headstatus2007 wifestatus2007 headhour2007 wifehour2007 headweek2007 headweeklyhour2007 headovertimehour2007 
     wifeweek2007 wifeweeklyhour2007 wifeovertimehour2007  
     headsalaried2007 headsalariedwage2007 headsalariedwageper2007 headsalariedextra2007 headsalariedextrarate2007 
     headhourlywage2007 headhourlyextrarate2007 headotherpaid2007 headotherpaidextrarate2007
     wifesalaried2007 wifesalariedwage2007 wifesalariedwageper2007 wifesalariedextra2007 wifesalariedextrarate2007 
     wifehourlywage2007 wifehourlyextrarate2007 wifeotherpaid2007 wifeotherpaidextrarate2007;
run;

data labor2009;
set psiddata.fam09;
id2009                            =                  ER42002              ;
headhour2009                      =                  ER46767              ;
wifehour2009                      =                  ER46788              ;
headstatus2009                    =                  ER42140              ;
headweek2009                      =                  ER46761              ; ***
headweeklyhour2009                =                  ER46763              ; ***
headovertimehour2009              =                  ER42206              ;
headsalaried2009                  =                  ER42181              ;
headsalariedwage2009              =                  ER42182              ;
headsalariedwageper2009           =                  ER42183              ;
headsalariedextra2009             =                  ER42184              ;
headsalariedextrarate2009         =                  ER42185              ;
headsalariedextraamount2009       =                  ER42186              ;
headsalariedextraamountper2009    =                  ER42187              ;
headhourlywage2009                =                  ER42188              ;
headhourlyextrarate2009           =                  ER42189              ;
headhourlyextraamount2009         =                  ER42192              ;
headhourlyextraamountper2009      =                  ER42193              ;
headotherpaid2009                 =                  ER42198              ;
headotherpaidextrarate2009        =                  ER42199              ;
wifestatus2009                    =                  ER42392              ;
wifeweek2009                      =                  ER46782              ; ***
wifeweeklyhour2009                =                  ER46784              ; ***
wifeovertimehour2009              =                  ER42458              ;         
wifesalaried2009                  =                  ER42433              ;         
wifesalariedwage2009              =                  ER42434              ;         
wifesalariedwageper2009           =                  ER42435              ;         
wifesalariedextra2009             =                  ER42436              ;         
wifesalariedextrarate2009         =                  ER42437              ;         
wifesalariedextraamount2009       =                  ER42438              ;         
wifesalariedextraamountper2009    =                  ER42439              ;         
wifehourlywage2009                =                  ER42440              ;         
wifehourlyextrarate2009           =                  ER42441              ;         
wifehourlyextraamount2009         =                  ER42444              ;         
wifehourlyextraamountper2009      =                  ER42445              ;         
wifeotherpaid2009                 =                  ER42450              ;         
wifeotherpaidextrarate2009        =                  ER42451              ;         
keep id2009 headstatus2009 wifestatus2009 headhour2009 wifehour2009 headweek2009 headweeklyhour2009 headovertimehour2009 
     wifeweek2009 wifeweeklyhour2009 wifeovertimehour2009  
     headsalaried2009 headsalariedwage2009 headsalariedwageper2009 headsalariedextra2009 headsalariedextrarate2009 
     headhourlywage2009 headhourlyextrarate2009 headotherpaid2009 headotherpaidextrarate2009
     wifesalaried2009 wifesalariedwage2009 wifesalariedwageper2009 wifesalariedextra2009 wifesalariedextrarate2009 
     wifehourlywage2009 wifehourlyextrarate2009 wifeotherpaid2009 wifeotherpaidextrarate2009;

run;

data PSIDDATA.labor;
merge labor1968 labor1969 labor1970 labor1971 labor1972 labor1973 labor1974 labor1975 
      labor1976 labor1977 labor1978 labor1979 labor1980 labor1981 labor1982 labor1983 
      labor1984 labor1985 labor1986 labor1987 labor1988 labor1989 labor1990 labor1991 
      labor1992 labor1993 labor1994 labor1995 labor1996 labor1997 labor1999 labor2001 
      labor2003 labor2005 labor2007 labor2009; 
run;

proc means data = psiddata.labor;
run;
run;
