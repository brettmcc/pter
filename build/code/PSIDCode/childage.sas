/* PSID DATA CENTER *****************************************************
   JOBID            : 48611                             
   DATA_DOMAIN      : PSID                              
   USER_WHERE       : None                              
   FILE_TYPE        : None                              
   OUTPUT_DATA_TYPE : ASCII Data File                   
   STATEMENTS       : SAS Statements                    
   CODEBOOK_TYPE    : none                              
   N_OF_VARIABLES   : 149                               
   N_OF_OBSERVATIONS: 23625                             
   MAX_REC_LENGTH   : 629                               
   DATE & TIME      : March 10, 2006 @ 10:04:40
************************************************************************/

filename job48611 "[path]\job48611.txt" ;

data job48611 ;
   infile job48611 dlm = '^' LRECL = 629          dsd ; 
   input 
      V442 V550 V656 V657 V1102 V1242 V1243 V1290 V1291 V1802
      V1945 V1946 V1996 V1997 V2402 V2545 V2546 V2594 V2595 V3002
      V3127 V3128 V3402 V3542 V3543 V3802 V3995 V3996 V4302 V4439
      V4440 V4504 V4505 V5202 V5413 V5414 V5702 V5902 V5903 V6302
      V6465 V6466 V6513 V6514 V6902 V7070 V7071 V7116 V7117 V7502
      V7661 V7662 V7739 V7740 V8202 V8355 V8356 V8401 V8402 V8802
      V8964 V8965 V9032 V9033 V10002 V10422 V10423 V10557 V10558 V11102
      V11609 V11610 V11701 V11702 V12502 V13014 V13015 V13101 V13102 V13702
      V14117 V14118 V14199 V14200 V14802 V15133 V15134 V15253 V15254 V16302
      V16634 V16635 V16754 V16755 V17702 V18052 V18053 V18192 V18193 V19002
      V19352 V19353 V19492 V19493 V20302 V20654 V20655 V20792 V20793 V21507
      V21602 V22409 V22410 V22569 V22570 ER2002 ER2010 ER2011 ER2188 ER2191
      ER5002 ER5009 ER5010 ER5187 ER5190 ER7002 ER7009 ER7010 ER7283 ER7286
      ER10002 ER10012 ER10013 ER10199 ER10201 ER13002 ER13013 ER13014 ER13330 ER13332
      ER17002 ER17016 ER17017 ER17353 ER17356 ER21002 ER21020 ER21021 ER21320
   ;

   label
      V442 = "1969 INT NUMBER   11:6-9"
      V550 = "# CHILDRN IN FU 15:34-35"
      V656 = "UNEMPLOYED? (E)    17:30"
      V657 = "WKS UNEMPLD BKT(E) 17:31"
      V1102 = "1970 INT #        21:6-9"
      V1242 = "# CHILDREN IN FU   26:43"
      V1243 = "AGE YNGST CHILD 26:44-45"
      V1290 = "UNEMPLOYED? (E)    27:24"
      V1291 = "WKS UNEMPLYD(E) 27:25-26"
      V1802 = "71 ID NO."
      V1945 = "# CHILDREN IN FU   38:47"
      V1946 = "AGE YNGST CHILD 38:48-49"
      V1996 = "UNEMPLOYED? (E)    39:43"
      V1997 = "WKS UNEMPLYD (E)39:44-45"
      V2402 = "1972 INT #        46:6-9"
      V2545 = "# CHILDREN IN FU51:48-49"
      V2546 = "AGE YNGST CHILD 51:50-51"
      V2594 = "UNEMPLYD OR STRIKE 52:35"
      V2595 = "WKS UNEMPLYD(E) 52:36-37"
      V3002 = "1973 INT #        59:6-9"
      V3127 = "WTR UNEMP (E)      64:26"
      V3128 = "WKS UNEMP (E)   64:27-28"
      V3402 = "1974 ID NUMBER"
      V3542 = "WTR UNEMPLYD (E)   74:29"
      V3543 = "WKS UNEMPLYD (E)74:30-31"
      V3802 = "1975 INT #        80:6-9"
      V3995 = "WTR UNEMP IN 74(E) 87:44"
      V3996 = "WKS UNEMP 74 (E)87:45-46"
      V4302 = "1976 ID NUMBER       6V2"
      V4439 = "# OF CHILDREN FU   6V139"
      V4440 = "AGE YOUNGEST CHILD 6V140"
      V4504 = "UNEMPL OR LAID OFF 75D48"
      V4505 = "# WEEKS UNEMPL       D49"
      V5202 = "1977 ID"
      V5413 = "WTR UNEMPLD (E)      D42"
      V5414 = "# WKS UNEMPLYD (E)   D43"
      V5702 = "1978 ID"
      V5902 = "D32 WTR UNEMP (E)"
      V5903 = "D33 # WKS UNEMP (E)"
      V6302 = "1979 ID"
      V6465 = "# CHILDREN IN FU"
      V6466 = "AGE YOUNGST CHILD"
      V6513 = "C24 WTR UNEMP (HD-E)"
      V6514 = "C25 #WKS UNEMP (HD-E)"
      V6902 = "1980 INTERVIEW NUMBER"
      V7070 = "# CHILDREN IN FU"
      V7071 = "AGE YOUNGEST CHILD"
      V7116 = "C24 WTR UNEMP (HD-E)"
      V7117 = "C25 #WKS UNEMP (HD-E)"
      V7502 = "1981 INTERVIEW NUMBER"
      V7661 = "# CHILDREN IN FU"
      V7662 = "AGE YOUNGEST CHILD"
      V7739 = "C35 WTR UNEMPLOYD(HD-E)"
      V7740 = "C36 # WK UNEMPLYD(HD-E)"
      V8202 = "1982 INTERVIEW NUMBER"
      V8355 = "# CHILDREN IN FU"
      V8356 = "AGE YOUNGEST CHILD"
      V8401 = "C30 WTR UNEMPLOYD(HD-E)"
      V8402 = "C31 # WK UNEMPLYD(HD-E)"
      V8802 = "1983 INTERVIEW NUMBER"
      V8964 = "# CHILDREN IN FU"
      V8965 = "AGE YOUNGEST CHILD"
      V9032 = "C30 WTR UNEMPLOYD(HD-E)"
      V9033 = "C31 # WK UNEMPLYD(HD-E)"
      V10002 = "1984 INTERVIEW NUMBER"
      V10422 = "# CHILDREN IN FU"
      V10423 = "AGE YOUNGEST CHILD"
      V10557 = "C106 WTR UNEMPLOYD(HD-E)"
      V10558 = "C107 # WK UNEMPLYD(HD-E)"
      V11102 = "1985 INTERVIEW NUMBER"
      V11609 = "# CHILDREN IN FU"
      V11610 = "AGE YOUNGEST CHILD"
      V11701 = "B69 WTR UNEMPLOYED(HD-E)"
      V11702 = "B70 # WK UNEMPLOYED(H-E)"
      V12502 = "1986 INTERVIEW NUMBER"
      V13014 = "# CHILDREN IN FU"
      V13015 = "AGE YOUNGEST CHILD"
      V13101 = "B60 WTR UNEMPLOYED(HD-E)"
      V13102 = "B61 # WK UNEMPLOYED(H-E)"
      V13702 = "1987 INTERVIEW NUMBER"
      V14117 = "# CHILDREN IN FU"
      V14118 = "AGE YOUNGEST CHILD"
      V14199 = "B57 WTR UNEMPLOYED(HD-E)"
      V14200 = "B58 # WK UNEMPLOYED(H-E)"
      V14802 = "1988 INTERVIEW NUMBER"
      V15133 = "# CHILDREN IN FU"
      V15134 = "AGE YOUNGEST CHILD"
      V15253 = "B72 WTR UNEMPLOYED(HD-E)"
      V15254 = "B73 # WK UNEMPLOYED(H-E)"
      V16302 = "1989 INTERVIEW NUMBER"
      V16634 = "# CHILDREN IN FU"
      V16635 = "AGE YOUNGEST CHILD"
      V16754 = "B72 WTR UNEMPLOYED(HD-E)"
      V16755 = "B73 # WK UNEMPLOYED(H-E)"
      V17702 = "1990 INTERVIEW NUMBER 90"
      V18052 = "# CHILDREN IN FU"
      V18053 = "AGE YOUNGEST CHILD"
      V18192 = "B72 WTR UNEMPLOYED(HD-E)"
      V18193 = "B73 # WK UNEMPLOYED(H-E)"
      V19002 = "1991 INTERVIEW NUMBER"
      V19352 = "# CHILDREN IN FU"
      V19353 = "AGE YOUNGEST CHILD"
      V19492 = "B72 WTR UNEMPLOYED(HD-E)"
      V19493 = "B73 # WK UNEMPLOYED(H-E)"
      V20302 = "1992 INTERVIEW NUMBER"
      V20654 = "# CHILDREN IN FU"
      V20655 = "AGE YOUNGEST CHILD"
      V20792 = "B72 WTR UNEMPLOYED(HD-E)"
      V20793 = "B73 # WK UNEMPLOYED(H-E)"
      V21507 = "# CHILDREN AGE 1-2"
      V21602 = "1993 INTERVIEW NUMBER"
      V22409 = "# CHILDREN IN FAMILY UNIT"
      V22410 = "AGE YOUNGEST CHILD"
      V22569 = "B72 WTR TIME OFF-UNEMPLOYED (HD-E)"
      V22570 = "B73 # WKS UNEMPLOYED (HD-E)"
      ER2002 = "1994 INTERVIEW #"
      ER2010 = "# CHILDREN IN FU"
      ER2011 = "AGE YOUNGEST CHILD"
      ER2188 = "B72 WTR UNEMPLOYED(HD-E)"
      ER2191 = "B73 WEEKS UNEMPLOYED"
      ER5002 = "1995 INTERVIEW #"
      ER5009 = "# CHILDREN IN FU"
      ER5010 = "AGE YOUNGEST CHILD"
      ER5187 = "B72 WTR UNEMPLOYED(HD-E)"
      ER5190 = "B73 WEEKS UNEMPLOYED"
      ER7002 = "1996 INTERVIEW #"
      ER7009 = "# CHILDREN IN FU"
      ER7010 = "AGE YOUNGEST CHILD"
      ER7283 = "B72 WTR UNEMPLOYED(HD-E)"
      ER7286 = "B73 WEEKS UNEMPLOYED"
      ER10002 = "1997 INTERVIEW #"
      ER10012 = "# CHILDREN IN FU"
      ER10013 = "AGE YOUNGEST CHILD"
      ER10199 = "B72 WTR UNEMPLOYED(HD-E)"
      ER10201 = "B73 WEEKS UNEMPLOYED"
      ER13002 = "1999 FAMILY INTERVIEW (ID) NUMBER"
      ER13013 = "# CHILDREN IN FU"
      ER13014 = "AGE YOUNGEST CHILD"
      ER13330 = "B72 WTR UNEMPLOYED(HD-E)"
      ER13332 = "B73 WEEKS UNEMPLOYED"
      ER17002 = "2001 FAMILY INTERVIEW (ID) NUMBER"
      ER17016 = "# CHILDREN IN FU"
      ER17017 = "AGE YOUNGEST CHILD"
      ER17353 = "B72 WTR UNEMPLOYED(HD-E)"
      ER17356 = "B73 WEEKS UNEMPLOYED"
      ER21002 = "2003 FAMILY INTERVIEW (ID) NUMBER"
      ER21020 = "# CHILDREN IN FU"
      ER21021 = "AGE YOUNGEST CHILD"
      ER21320 = "BC8 WEEKS UNEMPLOYED"
   ;
run ;
