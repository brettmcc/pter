/* PSID DATA CENTER *****************************************************
   JOBID            : 132624                            
   DATA_DOMAIN      : PSID                              
   USER_WHERE       : NULL                              
   FILE_TYPE        : All Individuals Data              
   OUTPUT_DATA_TYPE : ASCII                             
   STATEMENTS       : SAS Statements                    
   CODEBOOK_TYPE    : PDF                               
   N_OF_VARIABLES   : 108                               
   N_OF_OBSERVATIONS: 71285                             
   MAX_REC_LENGTH   : 284                               
   DATE & TIME      : October 22, 2011 @ 22:50:16
************************************************************************/

DATA u;
   ATTRIB
      ER30001  FORMAT=F4.   LABEL="1968 INTERVIEW NUMBER"                   
      ER30002  FORMAT=F3.   LABEL="PERSON NUMBER                         68"
      ER30003  FORMAT=F1.   LABEL="RELATIONSHIP TO HEAD                  68"
      ER30020  FORMAT=F4.   LABEL="1969 INTERVIEW NUMBER"                   
      ER30021  FORMAT=F2.   LABEL="SEQUENCE NUMBER                       69"
      ER30022  FORMAT=F1.   LABEL="RELATIONSHIP TO HEAD                  69"
      ER30043  FORMAT=F4.   LABEL="1970 INTERVIEW NUMBER"                   
      ER30044  FORMAT=F2.   LABEL="SEQUENCE NUMBER                       70"
      ER30045  FORMAT=F1.   LABEL="RELATIONSHIP TO HEAD                  70"
      ER30067  FORMAT=F4.   LABEL="1971 INTERVIEW NUMBER"                   
      ER30068  FORMAT=F2.   LABEL="SEQUENCE NUMBER                       71"
      ER30069  FORMAT=F1.   LABEL="RELATIONSHIP TO HEAD                  71"
      ER30091  FORMAT=F4.   LABEL="1972 INTERVIEW NUMBER"                   
      ER30092  FORMAT=F2.   LABEL="SEQUENCE NUMBER                       72"
      ER30093  FORMAT=F1.   LABEL="RELATIONSHIP TO HEAD                  72"
      ER30117  FORMAT=F4.   LABEL="1973 INTERVIEW NUMBER"                   
      ER30118  FORMAT=F2.   LABEL="SEQUENCE NUMBER                       73"
      ER30119  FORMAT=F1.   LABEL="RELATIONSHIP TO HEAD                  73"
      ER30138  FORMAT=F4.   LABEL="1974 INTERVIEW NUMBER"                   
      ER30139  FORMAT=F2.   LABEL="SEQUENCE NUMBER                       74"
      ER30140  FORMAT=F1.   LABEL="RELATIONSHIP TO HEAD                  74"
      ER30160  FORMAT=F4.   LABEL="1975 INTERVIEW NUMBER"                   
      ER30161  FORMAT=F2.   LABEL="SEQUENCE NUMBER                       75"
      ER30162  FORMAT=F1.   LABEL="RELATIONSHIP TO HEAD                  75"
      ER30188  FORMAT=F4.   LABEL="1976 INTERVIEW NUMBER"                   
      ER30189  FORMAT=F2.   LABEL="SEQUENCE NUMBER                       76"
      ER30190  FORMAT=F1.   LABEL="RELATIONSHIP TO HEAD                  76"
      ER30217  FORMAT=F4.   LABEL="1977 INTERVIEW NUMBER"                   
      ER30218  FORMAT=F2.   LABEL="SEQUENCE NUMBER                       77"
      ER30219  FORMAT=F1.   LABEL="RELATIONSHIP TO HEAD                  77"
      ER30246  FORMAT=F4.   LABEL="1978 INTERVIEW NUMBER"                   
      ER30247  FORMAT=F2.   LABEL="SEQUENCE NUMBER                       78"
      ER30248  FORMAT=F1.   LABEL="RELATIONSHIP TO HEAD                  78"
      ER30283  FORMAT=F4.   LABEL="1979 INTERVIEW NUMBER"                   
      ER30284  FORMAT=F2.   LABEL="SEQUENCE NUMBER                       79"
      ER30285  FORMAT=F1.   LABEL="RELATIONSHIP TO HEAD                  79"
      ER30313  FORMAT=F4.   LABEL="1980 INTERVIEW NUMBER"                   
      ER30314  FORMAT=F2.   LABEL="SEQUENCE NUMBER                       80"
      ER30315  FORMAT=F1.   LABEL="RELATIONSHIP TO HEAD                  80"
      ER30343  FORMAT=F4.   LABEL="1981 INTERVIEW NUMBER"                   
      ER30344  FORMAT=F2.   LABEL="SEQUENCE NUMBER                       81"
      ER30345  FORMAT=F1.   LABEL="RELATIONSHIP TO HEAD                  81"
      ER30373  FORMAT=F4.   LABEL="1982 INTERVIEW NUMBER"                   
      ER30374  FORMAT=F2.   LABEL="SEQUENCE NUMBER                       82"
      ER30375  FORMAT=F1.   LABEL="RELATIONSHIP TO HEAD                  82"
      ER30399  FORMAT=F4.   LABEL="1983 INTERVIEW NUMBER"                   
      ER30400  FORMAT=F2.   LABEL="SEQUENCE NUMBER                       83"
      ER30401  FORMAT=F2.   LABEL="RELATIONSHIP TO HEAD                  83"
      ER30429  FORMAT=F4.   LABEL="1984 INTERVIEW NUMBER"                   
      ER30430  FORMAT=F2.   LABEL="SEQUENCE NUMBER                       84"
      ER30431  FORMAT=F2.   LABEL="RELATIONSHIP TO HEAD                  84"
      ER30463  FORMAT=F4.   LABEL="1985 INTERVIEW NUMBER"                   
      ER30464  FORMAT=F2.   LABEL="SEQUENCE NUMBER                       85"
      ER30465  FORMAT=F2.   LABEL="RELATIONSHIP TO HEAD                  85"
      ER30498  FORMAT=F4.   LABEL="1986 INTERVIEW NUMBER"                   
      ER30499  FORMAT=F2.   LABEL="SEQUENCE NUMBER                       86"
      ER30500  FORMAT=F2.   LABEL="RELATIONSHIP TO HEAD                  86"
      ER30535  FORMAT=F4.   LABEL="1987 INTERVIEW NUMBER"                   
      ER30536  FORMAT=F2.   LABEL="SEQUENCE NUMBER                       87"
      ER30537  FORMAT=F2.   LABEL="RELATIONSHIP TO HEAD                  87"
      ER30570  FORMAT=F4.   LABEL="1988 INTERVIEW NUMBER"                   
      ER30571  FORMAT=F2.   LABEL="SEQUENCE NUMBER                       88"
      ER30572  FORMAT=F2.   LABEL="RELATION TO HEAD                      88"
      ER30606  FORMAT=F4.   LABEL="1989 INTERVIEW NUMBER"                   
      ER30607  FORMAT=F2.   LABEL="SEQUENCE NUMBER                       89"
      ER30608  FORMAT=F2.   LABEL="RELATION TO HEAD                      89"
      ER30642  FORMAT=F5.   LABEL="1990 INTERVIEW NUMBER"                   
      ER30643  FORMAT=F2.   LABEL="SEQUENCE NUMBER                       90"
      ER30644  FORMAT=F2.   LABEL="RELATION TO HEAD                      90"
      ER30689  FORMAT=F4.   LABEL="1991 INTERVIEW NUMBER"                   
      ER30690  FORMAT=F2.   LABEL="SEQUENCE NUMBER                       91"
      ER30691  FORMAT=F2.   LABEL="RELATION TO HEAD                      91"
      ER30733  FORMAT=F4.   LABEL="1992 INTERVIEW NUMBER"                   
      ER30734  FORMAT=F2.   LABEL="SEQUENCE NUMBER                       92"
      ER30735  FORMAT=F2.   LABEL="RELATION TO HEAD                      92"
      ER30806  FORMAT=F5.   LABEL="1993 INTERVIEW NUMBER"                   
      ER30807  FORMAT=F2.   LABEL="SEQUENCE NUMBER                       93"
      ER30808  FORMAT=F2.   LABEL="RELATION TO HEAD                      93"
      ER33101  FORMAT=F5.   LABEL="1994 INTERVIEW NUMBER"                   
      ER33102  FORMAT=F2.   LABEL="SEQUENCE NUMBER                       94"
      ER33103  FORMAT=F2.   LABEL="RELATION TO HEAD                      94"
      ER33201  FORMAT=F5.   LABEL="1995 INTERVIEW NUMBER"                   
      ER33202  FORMAT=F2.   LABEL="SEQUENCE NUMBER                       95"
      ER33203  FORMAT=F2.   LABEL="RELATION TO HEAD                      95"
      ER33301  FORMAT=F4.   LABEL="1996 INTERVIEW NUMBER"                   
      ER33302  FORMAT=F2.   LABEL="SEQUENCE NUMBER                       96"
      ER33303  FORMAT=F2.   LABEL="RELATION TO HEAD                      96"
      ER33401  FORMAT=F5.   LABEL="1997 INTERVIEW NUMBER"                   
      ER33402  FORMAT=F2.   LABEL="SEQUENCE NUMBER                       97"
      ER33403  FORMAT=F2.   LABEL="RELATION TO HEAD                      97"
      ER33501  FORMAT=F5.   LABEL="1999 INTERVIEW NUMBER"                   
      ER33502  FORMAT=F2.   LABEL="SEQUENCE NUMBER                       99"
      ER33503  FORMAT=F2.   LABEL="RELATION TO HEAD                      99"
      ER33601  FORMAT=F4.   LABEL="2001 INTERVIEW NUMBER"                   
      ER33602  FORMAT=F2.   LABEL="SEQUENCE NUMBER                       01"
      ER33603  FORMAT=F2.   LABEL="RELATION TO HEAD                      01"
      ER33701  FORMAT=F5.   LABEL="2003 INTERVIEW NUMBER"                   
      ER33702  FORMAT=F2.   LABEL="SEQUENCE NUMBER                       03"
      ER33703  FORMAT=F2.   LABEL="RELATION TO HEAD                      03"
      ER33801  FORMAT=F5.   LABEL="2005 INTERVIEW NUMBER"                   
      ER33802  FORMAT=F2.   LABEL="SEQUENCE NUMBER                       05"
      ER33803  FORMAT=F2.   LABEL="RELATION TO HEAD                      05"
      ER33901  FORMAT=F5.   LABEL="2007 INTERVIEW NUMBER"                   
      ER33902  FORMAT=F2.   LABEL="SEQUENCE NUMBER                       07"
      ER33903  FORMAT=F2.   LABEL="RELATION TO HEAD                      07"
      ER34001  FORMAT=F5.   LABEL="2009 INTERVIEW NUMBER"                   
      ER34002  FORMAT=F2.   LABEL="SEQUENCE NUMBER                       09"
      ER34003  FORMAT=F2.   LABEL="RELATION TO HEAD                      09"
   ;
   INFILE "C:\SurveyData\PSIDData\RawData\J132652.txt" LRECL = 284 ; 
   INPUT 
      ER30001      1 - 4     ER30002      5 - 7     ER30003      8 - 8    
      ER30020      9 - 12    ER30021     13 - 14    ER30022     15 - 15   
      ER30043     16 - 19    ER30044     20 - 21    ER30045     22 - 22   
      ER30067     23 - 26    ER30068     27 - 28    ER30069     29 - 29   
      ER30091     30 - 33    ER30092     34 - 35    ER30093     36 - 36   
      ER30117     37 - 40    ER30118     41 - 42    ER30119     43 - 43   
      ER30138     44 - 47    ER30139     48 - 49    ER30140     50 - 50   
      ER30160     51 - 54    ER30161     55 - 56    ER30162     57 - 57   
      ER30188     58 - 61    ER30189     62 - 63    ER30190     64 - 64   
      ER30217     65 - 68    ER30218     69 - 70    ER30219     71 - 71   
      ER30246     72 - 75    ER30247     76 - 77    ER30248     78 - 78   
      ER30283     79 - 82    ER30284     83 - 84    ER30285     85 - 85   
      ER30313     86 - 89    ER30314     90 - 91    ER30315     92 - 92   
      ER30343     93 - 96    ER30344     97 - 98    ER30345     99 - 99   
      ER30373    100 - 103   ER30374    104 - 105   ER30375    106 - 106  
      ER30399    107 - 110   ER30400    111 - 112   ER30401    113 - 114  
      ER30429    115 - 118   ER30430    119 - 120   ER30431    121 - 122  
      ER30463    123 - 126   ER30464    127 - 128   ER30465    129 - 130  
      ER30498    131 - 134   ER30499    135 - 136   ER30500    137 - 138  
      ER30535    139 - 142   ER30536    143 - 144   ER30537    145 - 146  
      ER30570    147 - 150   ER30571    151 - 152   ER30572    153 - 154  
      ER30606    155 - 158   ER30607    159 - 160   ER30608    161 - 162  
      ER30642    163 - 167   ER30643    168 - 169   ER30644    170 - 171  
      ER30689    172 - 175   ER30690    176 - 177   ER30691    178 - 179  
      ER30733    180 - 183   ER30734    184 - 185   ER30735    186 - 187  
      ER30806    188 - 192   ER30807    193 - 194   ER30808    195 - 196  
      ER33101    197 - 201   ER33102    202 - 203   ER33103    204 - 205  
      ER33201    206 - 210   ER33202    211 - 212   ER33203    213 - 214  
      ER33301    215 - 218   ER33302    219 - 220   ER33303    221 - 222  
      ER33401    223 - 227   ER33402    228 - 229   ER33403    230 - 231  
      ER33501    232 - 236   ER33502    237 - 238   ER33503    239 - 240  
      ER33601    241 - 244   ER33602    245 - 246   ER33603    247 - 248  
      ER33701    249 - 253   ER33702    254 - 255   ER33703    256 - 257  
      ER33801    258 - 262   ER33802    263 - 264   ER33803    265 - 266  
      ER33901    267 - 271   ER33902    272 - 273   ER33903    274 - 275  
      ER34001    276 - 280   ER34002    281 - 282   ER34003    283 - 284  

   ;

data psiddata.person;
set u;
id1968       =      ER30001;
id1969       =      ER30020;
id1970       =      ER30043;
id1971       =      ER30067;
id1972       =      ER30091;
id1973       =      ER30117;
id1974       =      ER30138;
id1975       =      ER30160;
id1976       =      ER30188;
id1977       =      ER30217;
id1978       =      ER30246;
id1979       =      ER30283;
id1980       =      ER30313;
id1981       =      ER30343;
id1982       =      ER30373;
id1983       =      ER30399;
id1984       =      ER30429;
id1985       =      ER30463;
id1986       =      ER30498;
id1987       =      ER30535;
id1988       =      ER30570;
id1989       =      ER30606;
id1990       =      ER30642;
id1991       =      ER30689;
id1992       =      ER30733;
id1993       =      ER30806;
id1994       =      ER33101;
id1995       =      ER33201;
id1996       =      ER33301;
id1997       =      ER33401;
id1999       =      ER33501;
id2001       =      ER33601;
id2003       =      ER33701;
id2005       =      ER33801;
id2007       =      ER33901;
id2009       =      ER34001;
seqno1969      =      ER30021;
seqno1970      =      ER30044;
seqno1971      =      ER30068;
seqno1972      =      ER30092;
seqno1973      =      ER30118;
seqno1974      =      ER30139;
seqno1975      =      ER30161;
seqno1976      =      ER30189;
seqno1977      =      ER30218;
seqno1978      =      ER30247;
seqno1979      =      ER30284;
seqno1980      =      ER30314;
seqno1981      =      ER30344;
seqno1982      =      ER30374;
seqno1983      =      ER30400;
seqno1984      =      ER30430;
seqno1985      =      ER30464;
seqno1986      =      ER30499;
seqno1987      =      ER30536;
seqno1988      =      ER30571;
seqno1989      =      ER30607;
seqno1990      =      ER30643;
seqno1991      =      ER30690;
seqno1992      =      ER30734;
seqno1993      =      ER30807;
seqno1994      =      ER33102;
seqno1995      =      ER33202;
seqno1996      =      ER33302;
seqno1997      =      ER33402;
seqno1999      =      ER33502;
seqno2001      =      ER33602;
seqno2003      =      ER33702;
seqno2005      =      ER33802;
seqno2007      =      ER33902;
seqno2009      =      ER34002;
rel1968      =      ER30003;
rel1969      =      ER30022;
rel1970      =      ER30045;
rel1971      =      ER30069;
rel1972      =      ER30093;
rel1973      =      ER30119;
rel1974      =      ER30140;
rel1975      =      ER30162;
rel1976      =      ER30190;
rel1977      =      ER30219;
rel1978      =      ER30248;
rel1979      =      ER30285;
rel1980      =      ER30315;
rel1981      =      ER30345;
rel1982      =      ER30375;
rel1983      =      ER30401;
rel1984      =      ER30431;
rel1985      =      ER30465;
rel1986      =      ER30500;
rel1987      =      ER30537;
rel1988      =      ER30572;
rel1989      =      ER30608;
rel1990      =      ER30644;
rel1991      =      ER30691;
rel1992      =      ER30735;
rel1993      =      ER30808;
rel1994      =      ER33103;
rel1995      =      ER33203;
rel1996      =      ER33303;
rel1997      =      ER33403;
rel1999      =      ER33503;
rel2001      =      ER33603;
rel2003      =      ER33703;
rel2005      =      ER33803;
rel2007      =      ER33903;
rel2009      =      ER34003;

pid = ER30001 * 1000 + ER30002;

keep id1968 - id1997 id1999 id2001 id2003 id2005 id2007 id2009
     seqno1969 - seqno1997 seqno1999 seqno2001 seqno2003 seqno2005 seqno2007 seqno2009
	 rel1968 - rel1997 rel1999 rel2001 rel2003 rel2005 rel2007 rel2009 pid;
run;

run ;
