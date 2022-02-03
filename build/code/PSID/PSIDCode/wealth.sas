DATA WLTH1984 ; 
INFILE 'C:\SurveyData\PSIDDATA\Rawdata\WLTH1984.txt' LRECL = 103 ; 
   INPUT 
      S100         1 - 1      S101         2 - 6      S102         7 - 7    
      S103         8 - 16     S104        17 - 17     S105        18 - 26   
      S106        27 - 27     S107        28 - 36     S108        37 - 37   
      S109        38 - 46     S110        47 - 47     S111        48 - 56   
      S113        57 - 65     S114        66 - 66     S115        67 - 75   
      S116        76 - 84     S117        85 - 93;   

id1984        =  S101; vbus1984      =  S103; vchecking1984 =  S105; vdebt1984     =  S107;
vreal1984     =  S109; vstock1984    =  S111; vtran1984     =  S113; vother1984    =  S115;
wealtha1984   =  S116; wealthb1984   =  S117;

keep id1984 vbus1984 vchecking1984 vdebt1984 vreal1984 vstock1984 vtran1984 vother1984 wealtha1984 wealthb1984;

DATA WLTH1989 ; 
INFILE 'C:\SurveyData\PSIDDATA\Rawdata\WLTH1989.txt' LRECL = 93 ; 
   INPUT 
      S200         1 - 1      S201         2 - 6      S202         7 - 7    
      S203         8 - 16     S204        17 - 17     S205        18 - 26   
      S206        27 - 27     S207        28 - 36     S208        37 - 37   
      S209        38 - 46     S210        47 - 47     S211        48 - 56   
      S213        57 - 65     S214        66 - 66     S215        67 - 75   
      S216        76 - 84     S217        85 - 93   ;

id1989        =  S201; vbus1989      =  S203; vchecking1989 =  S205; vdebt1989     =  S207;
vreal1989     =  S209; vstock1989    =  S211; vtran1989     =  S213; vother1989    =  S215;
wealtha1989   =  S216; wealthb1989   =  S217;
keep id1989 vbus1989 vchecking1989 vdebt1989 vreal1989 vstock1989 vtran1989 vother1989 wealtha1989 wealthb1989   ;


DATA WLTH1994 ; 
INFILE 'C:\SurveyData\PSIDDATA\Rawdata\WLTH1994.txt' LRECL = 93 ; 
   INPUT 
      S300         1 - 1      S301         2 - 6      S302         7 - 7    
      S303         8 - 16     S304        17 - 17     S305        18 - 26   
      S306        27 - 27     S307        28 - 36     S308        37 - 37   
      S309        38 - 46     S310        47 - 47     S311        48 - 56   
      S313        57 - 65     S314        66 - 66     S315        67 - 75   
      S316        76 - 84     S317        85 - 93;   

id1994        =  S301; vbus1994      =  S303; vchecking1994 =  S305; vdebt1994     =  S307;
vreal1994     =  S309; vstock1994    =  S311; vtran1994     =  S313; vother1994    =  S315;
wealtha1994   =  S316; wealthb1994   =  S317;

keep id1994 vbus1994 vchecking1994 vdebt1994 vreal1994 vstock1994 vtran1994 vother1994 wealtha1994 wealthb1994   ;

DATA WLTH1999 ; 
INFILE 'C:\SurveyData\PSIDDATA\Rawdata\WLTH1999.txt' LRECL = 113 ; 
   INPUT 
      S400         1 - 1      S401         2 - 6      S402         7 - 7    
      S403         8 - 16     S404        17 - 17     S405        18 - 26   
      S406        27 - 27     S407        28 - 36     S408        37 - 37   
      S409        38 - 46     S410        47 - 47     S411        48 - 56   
      S413        57 - 65     S414        66 - 66     S415        67 - 75   
      S416        76 - 84     S417        85 - 93     S418        94 - 94   
      S419        95 - 103  ;

id1999        =  S401; vbus1999      =  S403; vchecking1999 =  S405; vdebt1999     =  S407;
vreal1999     =  S409; vstock1999    =  S411; vtran1999     =  S413; vother1999    =  S415;
wealtha1999   =  S416; wealthb1999   =  S417; vira1999      =  S419;

keep id1999 vbus1999 vchecking1999 vdebt1999 vreal1999 vstock1999 vtran1999 vother1999 wealtha1999 wealthb1999 vira1999;

DATA WLTH2001 ; 
INFILE 'C:\SurveyData\PSIDDATA\Rawdata\WLTH2001.txt' LRECL = 103 ; 
   INPUT 
      S500         1 - 1      S501         2 - 6      S502         7 - 7    
      S503         8 - 16     S504        17 - 17     S505        18 - 26   
      S506        27 - 27     S507        28 - 36     S508        37 - 37   
      S509        38 - 46     S510        47 - 47     S511        48 - 56   
      S513        57 - 65     S514        66 - 66     S515        67 - 75   
      S516        76 - 84     S517        85 - 93     S518        94 - 94   
      S519        95 - 103;

id2001        =  S501; vbus2001      =  S503; vchecking2001 =  S505; vdebt2001     =  S507;
vreal2001     =  S509; vstock2001    =  S511; vtran2001     =  S513; vother2001    =  S515;
wealtha2001   =  S516; wealthb2001   =  S517; vira2001      =  S519; 

keep id2001 vbus2001 vchecking2001 vdebt2001 vreal2001 vstock2001 vtran2001 vother2001 wealtha2001 wealthb2001 vira2001;

DATA WLTH2003 ; 
INFILE 'C:\SurveyData\PSIDDATA\Rawdata\WLTH2003.txt' LRECL = 113 ; 
   INPUT 
      S600         1 - 1      S601         2 - 6      S602         7 - 7    
      S603         8 - 16     S604        17 - 17     S605        18 - 26   
      S606        27 - 27     S607        28 - 36     S608        37 - 37   
      S609        38 - 46     S610        47 - 47     S611        48 - 56   
      S613        57 - 65     S614        66 - 66     S615        67 - 75   
      S616        76 - 84     S617        85 - 93     S618        94 - 94   
      S619        95 - 103    ;

id2003        =  S601; vbus2003      =  S603; vchecking2003 =  S605; vdebt2003     =  S607;
vreal2003     =  S609; vstock2003    =  S611; vtran2003     =  S613; vother2003    =  S615;
wealtha2003   =  S616; wealthb2003   =  S617; vira2003      =  S619;

keep id2003 vbus2003 vchecking2003 vdebt2003 vreal2003 vstock2003 vtran2003 vother2003 wealtha2003 wealthb2003 vira2003;

DATA WLTH2005 ; 
INFILE 'C:\SurveyData\PSIDDATA\Rawdata\WLTH2005.txt' LRECL = 103 ; 
   INPUT 
      S700         1 - 1      S701         2 - 6      S702         7 - 7    
      S703         8 - 16     S704        17 - 17     S705        18 - 26   
      S706        27 - 27     S707        28 - 36     S708        37 - 37   
      S709        38 - 46     S710        47 - 47     S711        48 - 56   
      S713        57 - 65     S714        66 - 66     S715        67 - 75   
      S716        76 - 84     S717        85 - 93     S718        94 - 94   
      S719        95 - 103 ;

id2005        =  S701; vbus2005      =  S703; vchecking2005 =  S705; vdebt2005     =  S707;
vreal2005     =  S709; vstock2005    =  S711; vtran2005     =  S713; vother2005    =  S715;
wealtha2005   =  S716; wealthb2005   =  S717; vira2005      =  S719;

keep id2005 vbus2005 vchecking2005 vdebt2005 vreal2005 vstock2005 vtran2005 vother2005 wealtha2005 wealthb2005 vira2005;

DATA WLTH2007 ; 
INFILE 'C:\SurveyData\PSIDDATA\Rawdata\WLTH2007.txt' LRECL = 103 ; 
   INPUT 
      S800            1 - 1         S801            2 - 6         S802            7 - 7    
      S803            8 - 16        S804           17 - 17        S805           18 - 26   
      S806           27 - 27        S807           28 - 36        S808           37 - 37   
      S809           38 - 46        S810           47 - 47        S811           48 - 56   
      S813           57 - 65        S814           66 - 66        S815           67 - 75   
      S816           76 - 84        S817           85 - 93        S818           94 - 94   
      S819           95 - 103  
   ;

id2007        =  S801; vbus2007      =  S803; vchecking2007 =  S805; vdebt2007     =  S807;
vreal2007     =  S809; vstock2007    =  S811; vtran2007     =  S813; vother2007    =  S815;
wealtha2007   =  S816; wealthb2007   =  S817; vira2007      =  S819;

keep id2007 vbus2007 vchecking2007 vdebt2007 vreal2007 vstock2007 vtran2007 vother2007 wealtha2007 wealthb2007 vira2007;

data WLTH2009;
set PSIDDATA.fam09;
id2009        =  ER42002; vbus2009      =  ER46938; vchecking2009 =  ER46942; vdebt2009     =  ER46946;
vreal2009     =  ER46950; vstock2009    =  ER46954; vtran2009     =  ER46956; vother2009    =  ER46960;
wealtha2009   =  ER46968; wealthb2009   =  ER46970; vira2009      =  ER46964;

keep id2009 vbus2009 vchecking2009 vdebt2009 vreal2009 vstock2009 vtran2009 vother2009 wealtha2009 wealthb2009 vira2009; run;

data psiddata.wealth;
merge wlth1984 wlth1989 wlth1994 wlth1999 wlth2001 wlth2003 wlth2005 wlth2007 wlth2009;
run;

