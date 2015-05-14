***************************************Health Data***********************************************************************;

data health1972;
set psiddata.fam72;
id1972 = v2402;
headlimit1972 =  V2718	;  headlimit_extent1972 =  V2719  ;
keep id1972  headlimit1972  headlimit_extent1972 				                                                              ;                                                                                                                                                                                                                                                                                                                   

data health1973;
set psiddata.fam73;
id1973 = v3002;
headlimit1973 =  V3244	;  headlimit_extent1973 =  V3245	;			
keep id1973  headlimit1973  headlimit_extent1973 		                                                                  ;                                                                                                                                                                                                                                                                                                                  

data health1974;
set psiddata.fam74;
id1974 = v3402;
headlimit1974 =  V3666	;  headlimit_extent1974 =  V3667	;			
keep id1974  headlimit1974  headlimit_extent1974 		                                                                  ;                                                                                                                                                                                                                                                                                                                  
 
data health1975;
set psiddata.fam75;
id1975 = v3802;
headlimit1975 =  V4145	;  headlimit_extent1975 =  V4146	;			
keep id1975  headlimit1975  headlimit_extent1975 		                                                                  ;                                                                                                                                                                                                                                                                                                                  

data health1976;
set psiddata.fam76;
id1976 = v4302;
headlimit1976 =  V4625	;  headlimit_extent1976 =  V4626	;  wifelimit1976 =  V4766	 ;  wifelimit_extent1976 =  V4767	 ; 
keep id1976  headlimit1976  headlimit_extent1976  wifelimit1976  wifelimit_extent1976                                  ;                                                                                                                                                                                                                                                                                           

data health1977;
set psiddata.fam77;
id1977 = v5202;
headlimit1977 =  V5560	;  headlimit_extent1977 =  V5561	;			                                                       ; 
keep id1977  headlimit1977  headlimit_extent1977 		                                                                  ;                                                                                                                                                                                                                                                                                           

data health1978;
set psiddata.fam78;
id1978 = v5702;
headlimit1978 =  V6102	;  headlimit_extent1978 =  V6103	;			                                                       ; 
keep id1978  headlimit1978  headlimit_extent1978 		                                                                  ;                                                                                                                                                                                                                                                                                           

data health1979;
set psiddata.fam79;
id1979 = v6302;
headlimit1979 =  V6710	;  headlimit_extent1979 =  V6711	;			                                                       ; 
keep id1979  headlimit1979  headlimit_extent1979 		                                                                  ;                                                                                                                                                                                                                                                                                           

data health1980;
set psiddata.fam80;
id1980 = v6902;
headlimit1980 =  V7343	;  headlimit_extent1980 =  V7344	;			                                                       ; 
keep id1980  headlimit1980  headlimit_extent1980 		                                                                  ;                                                                                                                                                                                                                                                                                           

data health1981;
set psiddata.fam81;
id1981 = v7502;
headlimit1981 =  V7974	;  headlimit_extent1981 =  V7975	;  wifelimit1981 =  V7982	 ;  wifelimit_extent1981 =  V7983	 ;
keep id1981  headlimit1981  headlimit_extent1981  wifelimit1981  wifelimit_extent1981                                  ;                                                                                                                                                                                                                                                                                           

data health1982;
set psiddata.fam82;
id1982 = v8202;
headlimit1982 =  V8616	;  headlimit_extent1982 =  V8617	;  wifelimit1982 =  V8619	 ;  wifelimit_extent1982 =  V8620	 ;
keep id1982  headlimit1982  headlimit_extent1982  wifelimit1982  wifelimit_extent1982                                  ;                                                                                                                                                                                                                                                                                           

data health1983;
set psiddata.fam83;
id1983 = v8802;
headlimit1983 =  V9290	;  headlimit_extent1983 =  V9291	;  wifelimit1983 =  V9295	 ;  wifelimit_extent1983 =  V9296	 ;
keep id1983  headlimit1983  headlimit_extent1983  wifelimit1983  wifelimit_extent1983                                  ;                                                                                                                                                                                                                                                                                           

data health1984;
set psiddata.fam84;
id1984 = v10002;
headlimit1984 =  V10879	;  headlimit_extent1984 =  V10880	;  wifelimit1984 =  V10886 ;  wifelimit_extent1984 =  V10887 ;  headhealth1984 =  V10877 ; 	wifehealth1984 =  V10884 ;
keep id1984  headlimit1984  headlimit_extent1984  wifelimit1984  wifelimit_extent1984   headhealth1984  wifehealth1984 ;                                                                                                                                                                                                                                                                    

data health1985;
set psiddata.fam85;
id1985 = v11102;
headlimit1985 =  V11993	;  headlimit_extent1985 =  V11994	;  wifelimit1985 =  V12346 ;  wifelimit_extent1985 =  V12347 ;  headhealth1985 =  V11991 ;  wifehealth1985 =  V12344 ;
keep id1985  headlimit1985  headlimit_extent1985  wifelimit1985  wifelimit_extent1985   headhealth1985  wifehealth1985 ;                                                                                                                                                                                                                                                                    

data health1986;
set psiddata.fam86;
id1986 = v12502;
headlimit1986 =  V13427	;  headlimit_extent1986 =  V13429	;  wifelimit1986 =  V13462 ;  wifelimit_extent1986 =  V13464 ;  headhealth1986 =  V13417 ;  wifehealth1986 =  V13452 ;
keep id1986  headlimit1986  headlimit_extent1986  wifelimit1986  wifelimit_extent1986   headhealth1986  wifehealth1986 ;                                                                                                                                                                                                                                                                    

data health1987;
set psiddata.fam87;
id1987 = v13702;
headlimit1987 =  V14515	;  headlimit_extent1987 =  V14517	;  wifelimit1987 =  V14526 ;  wifelimit_extent1987 =  V14528 ;  headhealth1987 =  V14513 ;  wifehealth1987 =  V14524 ;
keep id1987  headlimit1987  headlimit_extent1987  wifelimit1987  wifelimit_extent1987   headhealth1987  wifehealth1987 ;                                                                                                                                                                                                                                                                    

data health1988;
set psiddata.fam88;
id1988 = v14802;
headlimit1988 =  V15994	;  headlimit_extent1988 =  V15996	;  wifelimit1988 =  V16000 ;  wifelimit_extent1988 =  V16002 ;  headhealth1988 =  V15993 ;  wifehealth1988 =  V15999 ;
keep id1988  headlimit1988  headlimit_extent1988  wifelimit1988  wifelimit_extent1988   headhealth1988  wifehealth1988 ;                                                                                                                                                                                                                                                                    

data health1989;
set psiddata.fam89;
id1989 = v16302;
headlimit1989 =  V17391	;  headlimit_extent1989 =  V17393	;  wifelimit1989 =  V17397 ;  wifelimit_extent1989 =  V17399 ;  headhealth1989 =  V17390 ;  wifehealth1989 =  V17396 ;
keep id1989  headlimit1989  headlimit_extent1989  wifelimit1989  wifelimit_extent1989   headhealth1989  wifehealth1989 ;                                                                                                                                                                                                                                                                    

data health1990;
set psiddata.fam90;
id1990 = v17702;
headlimit1990 =  V18722	;  headlimit_extent1990 =  V18724	;  wifelimit1990 =  V18728 ;  wifelimit_extent1990 =  V18730 ;  headhealth1990 =  V18721 ;  wifehealth1990 =  V18727 ;
keep id1990  headlimit1990  headlimit_extent1990  wifelimit1990  wifelimit_extent1990   headhealth1990  wifehealth1990 ;                                                                                                                                                                                                                                                                    

data health1991;
set psiddata.fam91;
id1991 = v19002;
headlimit1991 =  V20022	;  headlimit_extent1991 =  V20024	;  wifelimit1991 =  V20028 ;  wifelimit_extent1991 =  V20030 ;  headhealth1991 =  V20021 ;  wifehealth1991 =  V20027 ;
keep id1991  headlimit1991  headlimit_extent1991  wifelimit1991  wifelimit_extent1991   headhealth1991  wifehealth1991 ;                                                                                                                                                                                                                                                                    

data health1992;
set psiddata.fam92;
id1992 = v20302;
headlimit1992 =  V21322	;  headlimit_extent1992 =  V21324	;  wifelimit1992 =  V21329 ;  wifelimit_extent1992 =  V21331 ;  headhealth1992 =  V21321 ;  wifehealth1992 =  V21328 ;
keep id1992  headlimit1992  headlimit_extent1992  wifelimit1992  wifelimit_extent1992   headhealth1992  wifehealth1992 ;                                                                                                                                                                                                                                                                    

data health1993;
set psiddata.fam93;
id1993 = v21602;
headlimit1993 =  V23181	;  headlimit_extent1993 =  V23183	;  wifelimit1993 =  V23188 ;  wifelimit_extent1993 =  V23190 ;  headhealth1993 =  V23180 ;  wifehealth1993 =  V23187 ;
keep id1993  headlimit1993  headlimit_extent1993  wifelimit1993  wifelimit_extent1993   headhealth1993  wifehealth1993 ;                                                                                                                                                                                                                                                                    

data health1994;
set psiddata.fam94;
id1994 = ER2002;
headlimit1994 =  ER3854	;  headlimit_extent1994 =  ER3856	;  wifelimit1994 =  ER3859 ;  wifelimit_extent1994 =  ER3861 ;  headhealth1994 =  ER3853 ;  wifehealth1994 =  ER3858 ;
keep id1994  headlimit1994  headlimit_extent1994  wifelimit1994  wifelimit_extent1994   headhealth1994  wifehealth1994 ;                                                                                                                                                                                                                                                                    

data health1995;
set psiddata.fam95;
id1995 = ER5002;
headlimit1995 =  ER6724	;  headlimit_extent1995 =  ER6726	;  wifelimit1995 =  ER6729 ;  wifelimit_extent1995 =  ER6731 ;  headhealth1995 =  ER6723 ;  wifehealth1995 =  ER6728 ;
keep id1995  headlimit1995  headlimit_extent1995  wifelimit1995  wifelimit_extent1995   headhealth1995  wifehealth1995 ;                                                                                                                                                                                                                                                                    

data health1996;
set psiddata.fam96;
id1996 = ER7002;
headlimit1996 =  ER8970	;  headlimit_extent1996 =  ER8972	;  wifelimit1996 =  ER8975 ;  wifelimit_extent1996 =  ER8977 ;  headhealth1996 =  ER8969 ;  wifehealth1996 =  ER8974 ;
keep id1996  headlimit1996  headlimit_extent1996  wifelimit1996  wifelimit_extent1996   headhealth1996  wifehealth1996 ;                                                                                                                                                                                                                                                                    

data health1997;
set psiddata.fam97;
id1997 = ER10002;
headlimit1997 =  ER11724;	 headlimit_extent1997 =  ER11726;  wifelimit1997 =  ER11728;	wifelimit_extent1997 =  ER11730;  headhealth1997 =  ER11723;	wifehealth1997 =  ER11727;
keep id1997  headlimit1997	 headlimit_extent1997  wifelimit1997  wifelimit_extent1997   headhealth1997	 wifehealth1997 ;                                                                                                                                                                                                                                                                    

data health1999;
set psiddata.fam99;
id1999 = ER13002;
headlimit1999 =  ER15449;	 headlimit_extent1999 =  ER15451;  wifelimit1999 =  ER15557;	wifelimit_extent1999 =  ER15559;  headhealth1999 =  ER15447;	wifehealth1999 =  ER15555;
keep id1999  headlimit1999	 headlimit_extent1999  wifelimit1999  wifelimit_extent1999   headhealth1999	 wifehealth1999 ;                                                                                                                                                                                                                                                                    

data health2001;
set psiddata.fam01;
id2001 = ER17002;
headlimit2001 =  ER19614;	 headlimit_extent2001 =  ER19616;  wifelimit2001 =  ER19722;	wifelimit_extent2001 =  ER19724;  headhealth2001 =  ER19612;	wifehealth2001 =  ER19720;
keep id2001  headlimit2001	 headlimit_extent2001  wifelimit2001  wifelimit_extent2001   headhealth2001	 wifehealth2001 ;                                                                                                                                                                                                                                                                    

data health2003;
set psiddata.fam03;
id2003 = ER21002;
headlimit2003 =  ER23014;	 headlimit_extent2003 =  ER23016;  wifelimit2003 =  ER23141;	wifelimit_extent2003 =  ER23143;  headhealth2003 =  ER23009;	wifehealth2003 =  ER23136;
keep id2003  headlimit2003	 headlimit_extent2003  wifelimit2003  wifelimit_extent2003   headhealth2003	 wifehealth2003 ;                                                                                                                                                                                                                                                                    

data health2005;
set psiddata.fam05;
id2005 = ER25002;
headlimit2005 =  ER26995;	 headlimit_extent2005 =  ER26997;  wifelimit2005 =  ER27118;	wifelimit_extent2005 =  ER27120;  headhealth2005 =  ER26990;	wifehealth2005 =  ER27113;
keep id2005  headlimit2005	 headlimit_extent2005  wifelimit2005  wifelimit_extent2005   headhealth2005	 wifehealth2005 ;                                                                                                                                                                                                                                                                    

data health2007;
set psiddata.fam07;
id2007 = ER36002;
headlimit2007 =  ER38206;	 headlimit_extent2007 =  ER38208;  wifelimit2007 =  ER39303;	wifelimit_extent2007 =  ER39305;  headhealth2007 =  ER38202;	wifehealth2007 =  ER39299;
keep id2007  headlimit2007	 headlimit_extent2007  wifelimit2007  wifelimit_extent2007   headhealth2007	 wifehealth2007 ;                                                                                                                                                                                                                                                                    

data health2009;
set psiddata.fam09;
id2009 = ER42002;
headlimit2009 =  ER44179;	 headlimit_extent2009 =  ER44181;  wifelimit2009 =  ER45276;	wifelimit_extent2009 =  ER45278;  headhealth2009 =  ER44175;	wifehealth2009 =  ER45272;
keep id2009  headlimit2009	 headlimit_extent2009  wifelimit2009  wifelimit_extent2009   headhealth2009	 wifehealth2009 ;                                                                                                                                                                                                                                                                    

data PSIDDATA.health;
merge health1972 health1973 health1974 health1975 health1976 health1977 health1978 health1979 health1980 
      health1981 health1982 health1983 health1984 health1985 health1986 health1987 health1988 health1989 
      health1990 health1991 health1992 health1993 health1994 health1995 health1996 health1997 health1999 health2001 health2003 health2005 health2007 health2009; 

proc freq data = PSIDDATA.health;
tables 
headlimit1972  headlimit_extent1972 		                                                             
headlimit1973  headlimit_extent1973 		                                                             
headlimit1974  headlimit_extent1974 		                                                                 
headlimit1975  headlimit_extent1975 		                                                                 
headlimit1976  headlimit_extent1976  wifelimit1976  wifelimit_extent1976                                  
headlimit1977  headlimit_extent1977 		                                                                 
headlimit1978  headlimit_extent1978 		                                                                 
headlimit1979  headlimit_extent1979 		                                                                 
headlimit1980  headlimit_extent1980 		                                                                 
headlimit1981  headlimit_extent1981  wifelimit1981  wifelimit_extent1981                                  
headlimit1982  headlimit_extent1982  wifelimit1982  wifelimit_extent1982                                  
headlimit1983  headlimit_extent1983  wifelimit1983  wifelimit_extent1983                                  
headlimit1984  headlimit_extent1984  wifelimit1984  wifelimit_extent1984   headhealth1984  wifehealth1984 
headlimit1985  headlimit_extent1985  wifelimit1985  wifelimit_extent1985   headhealth1985  wifehealth1985 
headlimit1986  headlimit_extent1986  wifelimit1986  wifelimit_extent1986   headhealth1986  wifehealth1986 
headlimit1987  headlimit_extent1987  wifelimit1987  wifelimit_extent1987   headhealth1987  wifehealth1987 
headlimit1988  headlimit_extent1988  wifelimit1988  wifelimit_extent1988   headhealth1988  wifehealth1988 
headlimit1989  headlimit_extent1989  wifelimit1989  wifelimit_extent1989   headhealth1989  wifehealth1989 
headlimit1990  headlimit_extent1990  wifelimit1990  wifelimit_extent1990   headhealth1990  wifehealth1990 
headlimit1991  headlimit_extent1991  wifelimit1991  wifelimit_extent1991   headhealth1991  wifehealth1991 
headlimit1992  headlimit_extent1992  wifelimit1992  wifelimit_extent1992   headhealth1992  wifehealth1992 
headlimit1993  headlimit_extent1993  wifelimit1993  wifelimit_extent1993   headhealth1993  wifehealth1993 
headlimit1994  headlimit_extent1994  wifelimit1994  wifelimit_extent1994   headhealth1994  wifehealth1994 
headlimit1995  headlimit_extent1995  wifelimit1995  wifelimit_extent1995   headhealth1995  wifehealth1995 
headlimit1996  headlimit_extent1996  wifelimit1996  wifelimit_extent1996   headhealth1996  wifehealth1996 
headlimit1997  headlimit_extent1997  wifelimit1997  wifelimit_extent1997   headhealth1997  wifehealth1997
headlimit1999  headlimit_extent1999  wifelimit1999  wifelimit_extent1999   headhealth1999  wifehealth1999
headlimit2001  headlimit_extent2001  wifelimit2001  wifelimit_extent2001   headhealth2001  wifehealth2001
headlimit2003  headlimit_extent2003  wifelimit2003  wifelimit_extent2003   headhealth2003  wifehealth2003
headlimit2005  headlimit_extent2005  wifelimit2005  wifelimit_extent2005   headhealth2005  wifehealth2005
headlimit2007  headlimit_extent2007  wifelimit2007  wifelimit_extent2007   headhealth2007  wifehealth2007
headlimit2009  headlimit_extent2009  wifelimit2009  wifelimit_extent2009   headhealth2009  wifehealth2009;
run;

