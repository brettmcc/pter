***********************************************************************************************************************
***********************************************************************************************************************
***********************************************PSID wife INFORMATION***************************************************
***********************************************************************************************************************
***********************************************************************************************************************
***********************************************************************************************************************
**********************************************************************************************************************;

%include 'setlibraries_psid.sas';
***Include wife AGE, RACE, EDUCATION, Whether Self-Employed and Occupation;

data wifeinfor1968;
set psiddata.fam68; 
id1968                        =                  V3                 ; 
wifeage1968                   =                  V118               ;      
wifeedu1968                   =                  V246               ;      
wifeocc3digit1968            =                  V243_A               ; 
wifeind3digit1968            =                  V243_B               ; 
keep id1968 wifeage1968 wifeedu1968 wifeocc3digit1968 wifeind3digit1968;

data wifeinfor1969;
set psiddata.fam69;
id1969                        =                  V442               ;  
wifeage1969                   =                  V1011              ;      
wifeocc3digit1969            =                  V609_A             ;     
wifeind3digit1969            =                  V609_B               ;  
keep id1969 wifeage1969 wifeocc3digit1969 wifeind3digit1969;

data wifeinfor1970;
set psiddata.fam70;
id1970                        =                  V1102              ; 
wifeage1970                   =                  V1241              ;      
wifeocc3digit1970            =                  V1367_A               ;        
wifeind3digit1970            =                  V1367_B               ;   
keep id1970 wifeage1970 wifeocc3digit1970 wifeind3digit1970;

data wifeinfor1971;
set psiddata.fam71;
id1971                        =                  V1802              ; 
wifeage1971                   =                  V1944              ;      
wifeocc3digit1971            =                  V2074_A              ;        
wifeind3digit1971            =                  V2075_A              ;  
keep id1971 wifeage1971 wifeocc3digit1971 wifeind3digit1971;

data wifeinfor1972;
set psiddata.fam72;
id1972                        =                  V2402              ; 
wifeedu1972                   =                  V2687              ;      
wifeage1972                   =                  V2544              ;      
wifeocc3digit1972            =                  V2672_A              ;        
wifeind3digit1972            =                  V2673_A              ;   
keep id1972 wifeage1972 wifeedu1972 wifeocc3digit1972 wifeind3digit1972;

data wifeinfor1973;
set psiddata.fam73;
id1973                        =                  V3002              ; 
wifeedu1973                   =                  V3216              ;      
wifeage1973                   =                  V3097              ;      
wifeocc3digit1973            =                  V3183_A              ;        
wifeind3digit1973            =                  V3184_A              ; 
keep id1973 wifeage1973 wifeedu1973 wifeocc3digit1973 wifeind3digit1973;

data wifeinfor1974;
set psiddata.fam74;
id1974                        =                  V3402              ; 
wifeedu1974                   =                  V3638              ;      
wifeage1974                   =                  V3510              ;      
wifeocc3digit1974            =                  V3601_A              ;        
wifeind3digit1974            =                  V3602_A              ; 
keep id1974 wifeage1974 wifeedu1974 wifeocc3digit1974 wifeind3digit1974;

data wifeinfor1975;
set psiddata.fam75;
id1975                        =                  V3802              ; 
wifeedu1975                   =                  V4199              ;      
wifeage1975                   =                  V3923              ;      
wifeocc3digit1975            =                  V4055_A              ;        
wifeind3digit1975            =                  V4056_A              ; 
keep id1975 wifeage1975 wifeedu1975 wifeocc3digit1975 wifeind3digit1975;

data wifeinfor1976;
set psiddata.fam76;
id1976                        =                  V4302              ; 
wifeedu1976                   =                  V5075              ;      
wifeage1976                   =                  V4438              ;      
wifeocc3digit1976            =                  V4605_A               ;        
wifeind3digit1976            =                  V4606_A               ;    
keep id1976 wifeage1976 wifeedu1976 wifeocc3digit1976 wifeind3digit1976;

data wifeinfor1977;
set psiddata.fam77;
id1977                        =                  V5202              ; 
wifeedu1977                   =                  V5648              ;      
wifeage1977                   =                  V5352              ;      
wifeocc3digit1977            =                  V5507_A              ;        
wifeind3digit1977            =                  V5508_A              ; 
keep id1977 wifeage1977 wifeedu1977 wifeocc3digit1977 wifeind3digit1977;

data wifeinfor1978;
set psiddata.fam78;
id1978                        =                  V5702              ; 
wifeedu1978                   =                  V6195              ;      
wifeage1978                   =                  V5852              ;      
wifeocc3digit1978            =                  V6039_A              ;        
wifeind3digit1978            =                  V6040_A              ;   
keep id1978 wifeage1978 wifeedu1978 wifeocc3digit1978 wifeind3digit1978;

data wifeinfor1979;
set psiddata.fam79;
id1979                        =                  V6302              ; 
wifeage1979                   =                  V6464              ;      
wifeedu1979                   =                  V6788              ;      
wifeselfemploy1979            =                  V6592              ;               
wifeocc3digit1979            =                  V6596_A              ;        
wifeind3digit1979            =                  V6597_A              ;
keep id1979 wifeage1979 wifeedu1979 wifeselfemploy1979 wifeocc3digit1979 wifeind3digit1979; 

data wifeinfor1980;
set psiddata.fam80;
id1980                        =                  V6902              ; 
wifeage1980                   =                  V7069              ;      
wifeedu1980                   =                  V7434              ;      
wifeselfemploy1980            =                  V7194              ;               
wifeocc3digit1980            =                  V7198_A              ;        
wifeind3digit1980            =                  V7199_A              ;     
keep id1980 wifeage1980 wifeedu1980 wifeselfemploy1980 wifeocc3digit1980 wifeind3digit1980; 

data wifeinfor1981;
set psiddata.fam81;
id1981                        =                  V7502              ; 
wifeage1981                   =                  V7660              ;      
wifeedu1981                   =                  V8086              ;      
wifeselfemploy1981            =                  V7880              ;               
wifeocc3digit1981             =                  V7885              ;        
wifeind3digit1981             =                  V7886              ;        
keep id1981 wifeage1981 wifeedu1981 wifeselfemploy1981 wifeocc3digit1981 wifeind3digit1981; 

data wifeinfor1982;
set psiddata.fam82;
id1982                        =                  V8202              ; 
wifeage1982                   =                  V8354              ;      
wifeedu1982                   =                  V8710              ;      
wifeselfemploy1982            =                  V8539              ;               
wifeocc3digit1982             =                  V8544              ;        
wifeind3digit1982             =                  V8545              ;        
keep id1982 wifeage1982 wifeedu1982 wifeselfemploy1982 wifeocc3digit1982 wifeind3digit1982; 

data wifeinfor1983;
set psiddata.fam83;
id1983                        =                  V8802              ; 
wifeage1983                   =                  V8963              ;      
wifeedu1983                   =                  V9396              ;      
wifeselfemploy1983            =                  V9189              ;               
wifeocc3digit1983             =                  V9194              ;        
wifeind3digit1983             =                  V9195              ;        
keep id1983 wifeage1983 wifeedu1983 wifeselfemploy1983 wifeocc3digit1983 wifeind3digit1983; 

data wifeinfor1984;
set psiddata.fam84;
id1984                        =                  V10002             ; 
wifeage1984                   =                  V10421             ;      
wifeedu1984                   =                  V11043             ;      
wifeselfemploy1984            =                  V10674             ;               
wifeocc3digit1984             =                  V10678             ;        
wifeind3digit1984             =                  V10679             ;        
keep id1984 wifeage1984 wifeedu1984 wifeselfemploy1984 wifeocc3digit1984 wifeind3digit1984; 

data wifeinfor1985;
set psiddata.fam85;
id1985                        =                  V11102             ; 
wifeage1985                   =                  V11608             ;
wiferace1985                  =                  V12293             ;      
wifeedu1985                   =                  V12401             ;      
wifeselfemploy1985            =                  V12003             ;               
wifeocc3digit1985             =                  V12014             ;        
wifeind3digit1985             =                  V12015             ;        
keep id1985 wifeage1985 wiferace1985 wifeedu1985 wifeselfemploy1985 wifeocc3digit1985 wifeind3digit1985; 

data wifeinfor1986;
set psiddata.fam86;
id1986                        =                  V12502             ; 
wifeage1986                   =                  V13013             ;
wiferace1986                  =                  V13500             ;      
wifeedu1986                   =                  V13641             ;      
wifeselfemploy1986            =                  V13228             ;               
wifeocc3digit1986             =                  V13233             ;        
wifeind3digit1986             =                  V13234             ;        
keep id1986 wifeage1986 wiferace1986 wifeedu1986 wifeselfemploy1986 wifeocc3digit1986 wifeind3digit1986; 

data wifeinfor1987;
set psiddata.fam87;
id1987                        =                  V13702             ; 
wifeage1987                   =                  V14116             ;
wiferace1987                  =                  V14547             ;      
wifeedu1987                   =                  V14688             ;      
wifeselfemploy1987            =                  V14324             ;               
wifeocc3digit1987             =                  V14329             ;        
wifeind3digit1987             =                  V14330             ;        
keep id1987 wifeage1987 wiferace1987 wifeedu1987 wifeselfemploy1987 wifeocc3digit1987 wifeind3digit1987; 

                                                             

data temp.wife;
merge wifeinfor1968 wifeinfor1969 wifeinfor1970 wifeinfor1971 wifeinfor1972 wifeinfor1973 wifeinfor1974 wifeinfor1975 
      wifeinfor1976 wifeinfor1977 wifeinfor1978 wifeinfor1979 wifeinfor1980 wifeinfor1981 wifeinfor1982 wifeinfor1983 
      wifeinfor1984 wifeinfor1985 wifeinfor1986 wifeinfor1987; 
if     wifeage1968      > 96 then wifeage1968    =.   ;
if     wifeage1969      > 96 then wifeage1969    =.   ;
if     wifeage1970      > 96 then wifeage1970    =.   ;
if     wifeage1971      > 96 then wifeage1971    =.   ;
if     wifeage1972      > 96 then wifeage1972    =.   ;
if     wifeage1973      > 96 then wifeage1973    =.   ;
if     wifeage1974      > 96 then wifeage1974    =.   ;
if     wifeage1975      > 96 then wifeage1975    =.   ;
if     wifeage1976      > 96 then wifeage1976    =.   ;
if     wifeage1977      > 96 then wifeage1977    =.   ;
if     wifeage1978      > 96 then wifeage1978    =.   ;
if     wifeage1979      > 96 then wifeage1979    =.   ;
if     wifeage1980      > 96 then wifeage1980    =.   ;
if     wifeage1981      > 96 then wifeage1981    =.   ;
if     wifeage1982      > 96 then wifeage1982    =.   ;
if     wifeage1983      > 96 then wifeage1983    =.   ;
if     wifeage1984      > 96 then wifeage1984    =.   ;
if     wifeage1985      > 96 then wifeage1985    =.   ;
if     wifeage1986      > 96 then wifeage1986    =.   ;

 if wifeedu1968    <    4  and wifeedu1968 > 0  then      school1968  =  1;  
 if wifeedu1969    <    4  and wifeedu1969 > 0  then      school1969  =  1;  
 if wifeedu1970    <    4  and wifeedu1970 > 0  then      school1970  =  1;  
 if wifeedu1971    <    4  and wifeedu1971 > 0  then      school1971  =  1;  
 if wifeedu1972    <    4  and wifeedu1972 > 0  then      school1972  =  1;  
 if wifeedu1973    <    4  and wifeedu1973 > 0  then      school1973  =  1;  
 if wifeedu1974    <    4  and wifeedu1974 > 0  then      school1974  =  1;  
 if wifeedu1976    <    4  and wifeedu1976 > 0  then      school1976  =  1;  
 if wifeedu1979    <    4  and wifeedu1979 > 0  then      school1979  =  1;  
 if wifeedu1980    <    4  and wifeedu1980 > 0  then      school1980  =  1;  
 if wifeedu1981    <    4  and wifeedu1981 > 0  then      school1981  =  1;  
 if wifeedu1982    <    4  and wifeedu1982 > 0  then      school1982  =  1;  
 if wifeedu1983    <    4  and wifeedu1983 > 0  then      school1983  =  1;  
 if wifeedu1984    <    4  and wifeedu1984 > 0  then      school1984  =  1;  
 if wifeedu1985    <    4  and wifeedu1985 > 0  then      school1985  =  1;  
 if wifeedu1986    <    4  and wifeedu1986 > 0  then      school1986  =  1;  
 if wifeedu1987    <    4  and wifeedu1987 > 0  then      school1987  =  1;  

if wifeedu1968    =    4    then      school1968  =  2;                        
if wifeedu1969    =    4    then      school1969  =  2;                        
if wifeedu1970    =    4    then      school1970  =  2;                        
if wifeedu1971    =    4    then      school1971  =  2;                        
if wifeedu1972    =    4    then      school1972  =  2;                        
if wifeedu1973    =    4    then      school1973  =  2;                        
if wifeedu1974    =    4    then      school1974  =  2;                        
if wifeedu1976    =    4    then      school1976  =  2;                        
if wifeedu1979    =    4    then      school1979  =  2;                        
if wifeedu1980    =    4    then      school1980  =  2;                        
if wifeedu1981    =    4    then      school1981  =  2;                        
if wifeedu1982    =    4    then      school1982  =  2;                        
if wifeedu1983    =    4    then      school1983  =  2;                        
if wifeedu1984    =    4    then      school1984  =  2;                        
if wifeedu1985    =    4    then      school1985  =  2;                        
if wifeedu1986    =    4    then      school1986  =  2;                        
if wifeedu1987    =    4    then      school1987  =  2;                        

if wifeedu1968    = 5 or  wifeedu1968    = 6 then      school1968  =  3;       
if wifeedu1969    = 5 or  wifeedu1969    = 6 then      school1969  =  3;       
if wifeedu1970    = 5 or  wifeedu1970    = 6 then      school1970  =  3;       
if wifeedu1971    = 5 or  wifeedu1971    = 6 then      school1971  =  3;       
if wifeedu1972    = 5 or  wifeedu1972    = 6 then      school1972  =  3;       
if wifeedu1973    = 5 or  wifeedu1973    = 6 then      school1973  =  3;       
if wifeedu1974    = 5 or  wifeedu1974    = 6 then      school1974  =  3;       
if wifeedu1976    = 5 or  wifeedu1976    = 6 then      school1976  =  3;       
if wifeedu1979    = 5 or  wifeedu1979    = 6 then      school1979  =  3;       
if wifeedu1980    = 5 or  wifeedu1980    = 6 then      school1980  =  3;       
if wifeedu1981    = 5 or  wifeedu1981    = 6 then      school1981  =  3;       
if wifeedu1982    = 5 or  wifeedu1982    = 6 then      school1982  =  3;       
if wifeedu1983    = 5 or  wifeedu1983    = 6 then      school1983  =  3;       
if wifeedu1984    = 5 or  wifeedu1984    = 6 then      school1984  =  3;       
if wifeedu1985    = 5 or  wifeedu1985    = 6 then      school1985  =  3;       
if wifeedu1986    = 5 or  wifeedu1986    = 6 then      school1986  =  3;       
if wifeedu1987    = 5 or  wifeedu1987    = 6 then      school1987  =  3;       

if wifeedu1968    = 7 or  wifeedu1968    = 8 then      school1968  =  4;       
if wifeedu1969    = 7 or  wifeedu1969    = 8 then      school1969  =  4;       
if wifeedu1970    = 7 or  wifeedu1970    = 8 then      school1970  =  4;       
if wifeedu1971    = 7 or  wifeedu1971    = 8 then      school1971  =  4;       
if wifeedu1972    = 7 or  wifeedu1972    = 8 then      school1972  =  4;       
if wifeedu1973    = 7 or  wifeedu1973    = 8 then      school1973  =  4;       
if wifeedu1974    = 7 or  wifeedu1974    = 8 then      school1974  =  4;       
if wifeedu1976    = 7 or  wifeedu1976    = 8 then      school1976  =  4;       
if wifeedu1979    = 7 or  wifeedu1979    = 8 then      school1979  =  4;       
if wifeedu1980    = 7 or  wifeedu1980    = 8 then      school1980  =  4;       
if wifeedu1981    = 7 or  wifeedu1981    = 8 then      school1981  =  4;       
if wifeedu1982    = 7 or  wifeedu1982    = 8 then      school1982  =  4;       
if wifeedu1983    = 7 or  wifeedu1983    = 8 then      school1983  =  4;       
if wifeedu1984    = 7 or  wifeedu1984    = 8 then      school1984  =  4;       
if wifeedu1985    = 7 or  wifeedu1985    = 8 then      school1985  =  4;       
if wifeedu1986    = 7 or  wifeedu1986    = 8 then      school1986  =  4;       
if wifeedu1987    = 7 or  wifeedu1987    = 8 then      school1987  =  4;       

if wifeedu1968    = 9   then    school1968    =   .;                           
if wifeedu1969    = 9   then    school1969    =   .;                           
if wifeedu1970    = 9   then    school1970    =   .;                           
if wifeedu1971    = 9   then    school1971    =   .;                           
if wifeedu1972    = 9   then    school1972    =   .;                           
if wifeedu1973    = 9   then    school1973    =   .;                           
if wifeedu1974    = 9   then    school1974    =   .;                           
if wifeedu1976    = 9   then    school1976    =   .;                           
if wifeedu1979    = 9   then    school1979    =   .;                           
if wifeedu1980    = 9   then    school1980    =   .;                           
if wifeedu1981    = 9   then    school1981    =   .;                           
if wifeedu1982    = 9   then    school1982    =   .;                           
if wifeedu1983    = 9   then    school1983    =   .;                           
if wifeedu1984    = 9   then    school1984    =   .;                           
if wifeedu1985    = 9   then    school1985    =   .;                           
if wifeedu1986    = 9   then    school1986    =   .;                           
if wifeedu1987    = 9   then    school1987    =   .;                                       
                                                                                                                                                           
if  wifeedu1975   = 99  then wifeedu1975   = .;                                 
if  wifeedu1977   = 99  then wifeedu1977   = .;                                 
if  wifeedu1978   = 99  then wifeedu1978   = .;                                                              

if  wifeedu1975    < 12  and  wifeedu1975 > 0 then school1975   = 1;
if  wifeedu1977    < 12  and  wifeedu1977 > 0 then school1977   = 1;
if  wifeedu1978    < 12  and  wifeedu1978 > 0 then school1978   = 1;

if  wifeedu1975    = 12 then school1975   = 2;                                 
if  wifeedu1977    = 12 then school1977   = 2;                                 
if  wifeedu1978    = 12 then school1978   = 2;                                                               
                                                                               
if  wifeedu1975    > 12 and wifeedu1975  < 16  then school1975   = 3;          
if  wifeedu1977    > 12 and wifeedu1977  < 16  then school1977   = 3;          
if  wifeedu1978    > 12 and wifeedu1978  < 16  then school1978   = 3;                
                                                                         
if  wifeedu1975    >= 16  then school1975   = 4  ;                              
if  wifeedu1977    >= 16  then school1977   = 4  ;                              
if  wifeedu1978    >= 16  then school1978   = 4  ;                                                           

wifeedu1968   =   school1968; 
wifeedu1969   =   school1969; 
wifeedu1970   =   school1970; 
wifeedu1971   =   school1971; 
wifeedu1972   =   school1972; 
wifeedu1973   =   school1973; 
wifeedu1974   =   school1974; 
wifeedu1975   =   school1975; 
wifeedu1976   =   school1976; 
wifeedu1977   =   school1977; 
wifeedu1978   =   school1978; 
wifeedu1979   =   school1979; 
wifeedu1980   =   school1980; 
wifeedu1981   =   school1981; 
wifeedu1982   =   school1982; 
wifeedu1983   =   school1983; 
wifeedu1984   =   school1984; 
wifeedu1985   =   school1985; 
wifeedu1986   =   school1986; 
wifeedu1987   =   school1987; 

wifeocc1968 = wifeocc3digit1968;
wifeocc1969 = wifeocc3digit1969;
wifeocc1970 = wifeocc3digit1970;
wifeocc1971 = wifeocc3digit1971;
wifeocc1972 = wifeocc3digit1972;
wifeocc1973 = wifeocc3digit1973;
wifeocc1974 = wifeocc3digit1974;
wifeocc1975 = wifeocc3digit1975;

%macro occind(year);
        if wifeocc3digit&year =  .   then do; wifeocc&year = .; end;        
   else if wifeocc3digit&year =  999 then do; wifeocc&year = .; end;        
   else if wifeocc3digit&year =  0   then do; wifeocc&year = 0; end;
   else if wifeocc3digit&year le 195 then do; wifeocc&year = 1; end;
   else if wifeocc3digit&year le 245 then do; wifeocc&year = 2; end;
   else if wifeocc3digit&year le 285 then do; wifeocc&year = 3; end;
   else if wifeocc3digit&year le 395 then do; wifeocc&year = 4; end;
   else if wifeocc3digit&year le 600 then do; wifeocc&year = 5; end;
   else if wifeocc3digit&year le 695 then do; wifeocc&year = 6; end;
   else if wifeocc3digit&year le 715 then do; wifeocc&year = 7; end;
   else if wifeocc3digit&year le 785 then do; wifeocc&year = 8; end;
   else if wifeocc3digit&year le 802 then do; wifeocc&year = 9; end;
   else if wifeocc3digit&year le 824 then do; wifeocc&year = 10; end;
   else if wifeocc3digit&year le 965 then do; wifeocc&year = 11; end;
   else if wifeocc3digit&year le 984 then do; wifeocc&year = 12; end;

        if wifeind3digit&year =  .   then do; wifeind&year = .; end;        
   else if wifeind3digit&year =  999 then do; wifeind&year = .; end;        
   else if wifeind3digit&year =  0   then do; wifeind&year = 0; end;
   else if wifeind3digit&year le 28  then do; wifeind&year = 1; end;
   else if wifeind3digit&year le 57  then do; wifeind&year = 2; end;
   else if wifeind3digit&year le 77  then do; wifeind&year = 3; end;
   else if wifeind3digit&year le 398 then do; wifeind&year = 4; end;
   else if wifeind3digit&year le 479 then do; wifeind&year = 5; end;
   else if wifeind3digit&year le 698 then do; wifeind&year = 6; end;
   else if wifeind3digit&year le 718 then do; wifeind&year = 7; end;
   else if wifeind3digit&year le 759 then do; wifeind&year = 8; end;
   else if wifeind3digit&year le 798 then do; wifeind&year = 9; end;
   else if wifeind3digit&year le 809 then do; wifeind&year = 10; end;
   else if wifeind3digit&year le 897 then do; wifeind&year = 11; end;
   else if wifeind3digit&year le 937 then do; wifeind&year = 12; end;
%mend;

%occind(1968) %occind(1969) %occind(1970) %occind(1971) %occind(1972) %occind(1973) %occind(1974) %occind(1975)
%occind(1976) %occind(1977) %occind(1978) %occind(1979) %occind(1980) %occind(1981) %occind(1982) %occind(1983)
%occind(1984) %occind(1985) %occind(1986) %occind(1987)
keep

id1968  wifeage1968  wifeedu1968                                    wifeocc3digit1968  wifeind3digit1968  wifeocc1968  wifeind1968 
id1969  wifeage1969  wifeedu1969                                    wifeocc3digit1969  wifeind3digit1969  wifeocc1969  wifeind1969 
id1970  wifeage1970  wifeedu1970                                    wifeocc3digit1970  wifeind3digit1970  wifeocc1970  wifeind1970 
id1971  wifeage1971  wifeedu1971                                    wifeocc3digit1971  wifeind3digit1971  wifeocc1971  wifeind1971 
id1972  wifeage1972  wifeedu1972                                    wifeocc3digit1972  wifeind3digit1972  wifeocc1972  wifeind1972 
id1973  wifeage1973  wifeedu1973                                    wifeocc3digit1973  wifeind3digit1973  wifeocc1973  wifeind1973 
id1974  wifeage1974  wifeedu1974                                    wifeocc3digit1974  wifeind3digit1974  wifeocc1974  wifeind1974 
id1975  wifeage1975  wifeedu1975                                    wifeocc3digit1975  wifeind3digit1975  wifeocc1975  wifeind1975 
id1976  wifeage1976  wifeedu1976                                    wifeocc3digit1976  wifeind3digit1976  wifeocc1976  wifeind1976 
id1977  wifeage1977  wifeedu1977                                    wifeocc3digit1977  wifeind3digit1977  wifeocc1977  wifeind1977 
id1978  wifeage1978  wifeedu1978                                    wifeocc3digit1978  wifeind3digit1978  wifeocc1978  wifeind1978 
id1979  wifeage1979  wifeedu1979                wifeselfemploy1979  wifeocc3digit1979  wifeind3digit1979  wifeocc1979  wifeind1979 
id1980  wifeage1980  wifeedu1980                wifeselfemploy1980  wifeocc3digit1980  wifeind3digit1980  wifeocc1980  wifeind1980 
id1981  wifeage1981  wifeedu1981                wifeselfemploy1981  wifeocc3digit1981  wifeind3digit1981  wifeocc1981  wifeind1981 
id1982  wifeage1982  wifeedu1982                wifeselfemploy1982  wifeocc3digit1982  wifeind3digit1982  wifeocc1982  wifeind1982 
id1983  wifeage1983  wifeedu1983                wifeselfemploy1983  wifeocc3digit1983  wifeind3digit1983  wifeocc1983  wifeind1983 
id1984  wifeage1984  wifeedu1984                wifeselfemploy1984  wifeocc3digit1984  wifeind3digit1984  wifeocc1984  wifeind1984 
id1985  wifeage1985  wifeedu1985  wiferace1985  wifeselfemploy1985  wifeocc3digit1985  wifeind3digit1985  wifeocc1985  wifeind1985 
id1986  wifeage1986  wifeedu1986  wiferace1986  wifeselfemploy1986  wifeocc3digit1986  wifeind3digit1986  wifeocc1986  wifeind1986 
id1987  wifeage1987  wifeedu1987  wiferace1987  wifeselfemploy1987  wifeocc3digit1987  wifeind3digit1987  wifeocc1987  wifeind1987 ;                          


run;

