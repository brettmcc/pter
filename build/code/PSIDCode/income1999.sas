*********Retrieve and process income data from 1994 family and income plus data files        ********* 
*********After 1993, income data collection and release are changed significantly, from 1994 *********
*********to 2001, some income data are processed and released in the income plus data files  *********
*********However, there are still many income components contained only in the main family   *********
*********data. I process the income components using the family data if these variables are  *********
*********not included in the income plus data. In addition, many variable in the main data   ********* 
*********employ the per format, which changed before and after 1995.  In the 2005 wave       *********
*********processed variables were added so we do not have to compute annual income using     *********
*********the per variables.                                                                  *********
*********Geng Li December 2008                                                               *********;

data income1999fam;
set psiddata.fam99;

id1999 = ER13002;
HeadExtraInclude1999 =  ER14476;          ***May need the indicator for estimation;

HeadRmmrlabor1999  = ER14461;    HeadRmmrlaborper1999 = ER14462;    ***Roomer and boarder income is not included in income plus data;                                                                                                                                                                                                          
HeadRent1999       = ER14479;         HeadRentper1999 = ER14480;    ******These detailed asset and transfer income are not  included in income plus data; 
HeadDividend1999   = ER14494;     HeadDividendper1999 = ER14495;      
HeadInterest1999   = ER14509;     HeadInterestper1999 = ER14510; 
HeadTrustFund1999  = ER14524;    HeadTrustFundper1999 = ER14525;                                                                                                                                                                                                              
WifeDividend1999   = ER14790;     WifeDividendper1999 = ER14791;
WifeInterest1999   = ER14805;     WifeInterestper1999 = ER14806;                                                                                                                                                                                                               
WifeTrustFund1999  = ER14820;    WifeTrustFundper1999 = ER14821;                                                                                                                                                                                                              
WifeOthAsset1999   = ER14835;     WifeOthAssetper1999 = ER14836;                                                                                                                                                                                                                                                                                                                                                                                                                                                           
HeadADC1999        = ER14539;          HeadADCper1999 = ER14540;                                                                                                                                                                                                        
WifeADC1999        = ER14866;          WifeADCper1999 = ER14867;                                                                                                                                                                                                        
HeadRetIncVet1999  = ER14588;    HeadRetIncVetper1999 = ER14589;                                                                                                
HeadRetIncNV1999   = ER14603;     HeadRetIncNVper1999 = ER14604;                                                                                                 
HeadAnnuity1999    = ER14618;      HeadAnnuityper1999 = ER14619;                                                                                                  
WifeAnnuity1999    = ER14911;      WifeAnnuityper1999 = ER14912;                                                                                                  
HeadOthRet1999     = ER14633;       HeadOthRetper1999 = ER14634;                                                                                                   
HeadUnemp1999      = ER14649;	     HeadUnempper1999 = ER14650;	                        
WifeUnemp1999      = ER14760;        WifeUnempper1999 = ER14761;                                                                                                    
HeadWorkman1999    = ER14664;      HeadWorkmanper1999 = ER14665;       	                                                                                           
WifeWorkman1999    = ER14775;      WifeWorkmanper1999 = ER14776;                                                                                                  
HeadAlimony1999    = ER14694;      HeadAlimonyper1999 = ER14695;                                                                                                  
HeadChldSppt1999   = ER14679;     HeadChldSpptper1999 = ER14680;                                                                                                 
WifeChldSppt1999   = ER14881;     WifeChldSpptper1999 = ER14882;                                                                                                 
HeadRelHelp1999    = ER14709;      HeadRelHelpper1999 = ER14710;                                                                                                  
WifeRelHelp1999    = ER14926;      WifeRelHelpper1999 = ER14927;                                                                                                  
HeadNonRelHelp1999 = ER14724;   HeadNonRelHelpper1999 = ER14725;                                                                                               
WifeNonRelHelp1999 = ER14941;   WifeNonRelHelpper1999 = ER14942;                                                                                               
HeadSuppSec1999    = ER14555;      HeadSuppSecper1999 = ER14556;                                                                                                  
WifeSuppSec1999    = ER14851;      WifeSuppSecper1999 = ER14852;                                                                                                  
HeadOthWel1999     = ER14570;       HeadOthWelper1999 = ER14571;                                                                                                   
WifeOthWel1999     = ER14896;       WifeOthWelper1999 = ER14897;                                                                                                   
HeadOthIncome1999  = ER14739;    HeadOthIncomeper1999 = ER14740;
WifeOthIncome1999  = ER14956;    WifeOthIncomeper1999 = ER14957; 

if    HeadRmmrlabor1999     ge     9999996.00    then      HeadRmmrlabor1999       =      .;      
if    HeadRent1999          ge      999996.00    then      HeadRent1999            =      .;      
if    HeadDividend1999      ge      999996.00    then      HeadDividend1999        =      .;      
if    HeadInterest1999      ge      999996.00    then      HeadInterest1999        =      .;      
if    HeadTrustFund1999     ge      999996.00    then      HeadTrustFund1999       =      .;      
if    WifeDividend1999      ge      999996.00    then      WifeDividend1999        =      .;      
if    WifeInterest1999      ge      999996.00    then      WifeInterest1999        =      .;      
if    WifeTrustFund1999     ge      999996.00    then      WifeTrustFund1999       =      .;      
if    WifeOthAsset1999      ge      999996.00    then      WifeOthAsset1999        =      .;      
if    HeadADC1999           ge      999996.00    then      HeadADC1999             =      .;      
if    WifeADC1999           ge       99996.00    then      WifeADC1999             =      .;      
if    HeadRetIncVet1999     ge       99996.00    then      HeadRetIncVet1999       =      .;      
if    HeadRetIncNV1999      ge      999996.00    then      HeadRetIncNV1999        =      .;      
if    HeadAnnuity1999       ge      999996.00    then      HeadAnnuity1999         =      .;      
if    WifeAnnuity1999       ge       99996.00    then      WifeAnnuity1999         =      .;      
if    HeadOthRet1999        ge      999996.00    then      HeadOthRet1999          =      .;      
if    HeadUnemp1999         ge       99996.00    then      HeadUnemp1999           =      .;      
if    WifeUnemp1999         ge       99996.00    then      WifeUnemp1999           =      .;      
if    HeadWorkman1999       ge       99996.00    then      HeadWorkman1999         =      .;      
if    WifeWorkman1999       ge       99996.00    then      WifeWorkman1999         =      .;      
if    HeadAlimony1999       ge       99996.00    then      HeadAlimony1999         =      .;      
if    HeadChldSppt1999      ge       99996.00    then      HeadChldSppt1999        =      .;      
if    WifeChldSppt1999      ge       99996.00    then      WifeChldSppt1999        =      .;      
if    HeadRelHelp1999       ge       99996.00    then      HeadRelHelp1999         =      .;      
if    WifeRelHelp1999       ge       99996.00    then      WifeRelHelp1999         =      .;      
if    HeadNonRelHelp1999    ge       99996.00    then      HeadNonRelHelp1999      =      .;      
if    WifeNonRelHelp1999    ge       99996.00    then      WifeNonRelHelp1999      =      .;      
if    HeadSuppSec1999       ge      999996.00    then      HeadSuppSec1999         =      .;      
if    WifeSuppSec1999       ge       99996.00    then      WifeSuppSec1999         =      .;      
if    HeadOthWel1999        ge      999996.00    then      HeadOthWel1999          =      .;      
if    WifeOthWel1999        ge       99996.00    then      WifeOthWel1999          =      .;      
if    HeadOthIncome1999     ge       99996.00    then      HeadOthIncome1999       =      .;      
if    WifeOthIncome1999     ge       99996.00    then      WifeOthIncome1999       =      .;      

HeadRmmrlabor1999       = HeadRmmrlabor1999  * (52 * ( HeadRmmrlaborper1999 = 3) + 26 * ( HeadRmmrlaborper1999 = 4) +  12 * ( HeadRmmrlaborper1999 = 5) + ( HeadRmmrlaborper1999 = 6));
HeadRent1999            = HeadRent1999       * (52 * (      HeadRentper1999 = 3) + 26 * (      HeadRentper1999 = 4) +  12 * (      HeadRentper1999 = 5) + (      HeadRentper1999 = 6));
HeadDividend1999        = HeadDividend1999   * (52 * (  HeadDividendper1999 = 3) + 26 * (  HeadDividendper1999 = 4) +  12 * (  HeadDividendper1999 = 5) + (  HeadDividendper1999 = 6));
HeadInterest1999        = HeadInterest1999   * (52 * (  HeadInterestper1999 = 3) + 26 * (  HeadInterestper1999 = 4) +  12 * (  HeadInterestper1999 = 5) + (  HeadInterestper1999 = 6));
HeadTrustFund1999       = HeadTrustFund1999  * (52 * ( HeadTrustFundper1999 = 3) + 26 * ( HeadTrustFundper1999 = 4) +  12 * ( HeadTrustFundper1999 = 5) + ( HeadTrustFundper1999 = 6));
WifeOthAsset1999        = WifeOthAsset1999   * (52 * (  WifeOthAssetper1999 = 3) + 26 * (  WifeOthAssetper1999 = 4) +  12 * (  WifeOthAssetper1999 = 5) + (  WifeOthAssetper1999 = 6));
WifeDividend1999        = WifeDividend1999   * (52 * (  WifeDividendper1999 = 3) + 26 * (  WifeDividendper1999 = 4) +  12 * (  WifeDividendper1999 = 5) + (  WifeDividendper1999 = 6));
WifeInterest1999        = WifeInterest1999   * (52 * (  WifeInterestper1999 = 3) + 26 * (  WifeInterestper1999 = 4) +  12 * (  WifeInterestper1999 = 5) + (  WifeInterestper1999 = 6));
WifeTrustFund1999       = WifeTrustFund1999  * (52 * ( WifeTrustFundper1999 = 3) + 26 * ( WifeTrustFundper1999 = 4) +  12 * ( WifeTrustFundper1999 = 5) + ( WifeTrustFundper1999 = 6));
HeadADC1999             = HeadADC1999        * (52 * (       HeadADCper1999 = 3) + 26 * (       HeadADCper1999 = 4) +  12 * (       HeadADCper1999 = 5) + (       HeadADCper1999 = 6));
WifeADC1999             = WifeADC1999        * (52 * (       WifeADCper1999 = 3) + 26 * (       WifeADCper1999 = 4) +  12 * (       WifeADCper1999 = 5) + (       WifeADCper1999 = 6));
HeadRetIncVet1999       = HeadRetIncVet1999  * (52 * ( HeadRetIncVetper1999 = 3) + 26 * ( HeadRetIncVetper1999 = 4) +  12 * ( HeadRetIncVetper1999 = 5) + ( HeadRetIncVetper1999 = 6));
HeadRetIncNV1999        = HeadRetIncNV1999   * (52 * (  HeadRetIncNVper1999 = 3) + 26 * (  HeadRetIncNVper1999 = 4) +  12 * (  HeadRetIncNVper1999 = 5) + (  HeadRetIncNVper1999 = 6));
HeadSuppSec1999         = HeadSuppSec1999    * (52 * (   HeadSuppSecper1999 = 3) + 26 * (   HeadSuppSecper1999 = 4) +  12 * (   HeadSuppSecper1999 = 5) + (   HeadSuppSecper1999 = 6));
WifeSuppSec1999         = WifeSuppSec1999    * (52 * (   WifeSuppSecper1999 = 3) + 26 * (   WifeSuppSecper1999 = 4) +  12 * (   WifeSuppSecper1999 = 5) + (   WifeSuppSecper1999 = 6));
HeadOthWel1999          = HeadOthWel1999     * (52 * (    HeadOthWelper1999 = 3) + 26 * (    HeadOthWelper1999 = 4) +  12 * (    HeadOthWelper1999 = 5) + (    HeadOthWelper1999 = 6));
WifeOthWel1999          = WifeOthWel1999     * (52 * (    WifeOthWelper1999 = 3) + 26 * (    WifeOthWelper1999 = 4) +  12 * (    WifeOthWelper1999 = 5) + (    WifeOthWelper1999 = 6));
HeadAnnuity1999         = HeadAnnuity1999    * (52 * (   HeadAnnuityper1999 = 3) + 26 * (   HeadAnnuityper1999 = 4) +  12 * (   HeadAnnuityper1999 = 5) + (   HeadAnnuityper1999 = 6));
WifeAnnuity1999         = WifeAnnuity1999    * (52 * (   WifeAnnuityper1999 = 3) + 26 * (   WifeAnnuityper1999 = 4) +  12 * (   WifeAnnuityper1999 = 5) + (   WifeAnnuityper1999 = 6));
HeadOthRet1999          = HeadOthRet1999     * (52 * (    HeadOthRetper1999 = 3) + 26 * (    HeadOthRetper1999 = 4) +  12 * (    HeadOthRetper1999 = 5) + (    HeadOthRetper1999 = 6));
HeadUnemp1999           = HeadUnemp1999      * (52 * (     HeadUnempper1999 = 3) + 26 * (     HeadUnempper1999 = 4) +  12 * (     HeadUnempper1999 = 5) + (     HeadUnempper1999 = 6));
WifeUnemp1999           = WifeUnemp1999      * (52 * (     WifeUnempper1999 = 3) + 26 * (     WifeUnempper1999 = 4) +  12 * (     WifeUnempper1999 = 5) + (     WifeUnempper1999 = 6));
HeadWorkman1999         = HeadWorkman1999    * (52 * (   HeadWorkmanper1999 = 3) + 26 * (   HeadWorkmanper1999 = 4) +  12 * (   HeadWorkmanper1999 = 5) + (   HeadWorkmanper1999 = 6));
WifeWorkman1999         = WifeWorkman1999    * (52 * (   WifeWorkmanper1999 = 3) + 26 * (   WifeWorkmanper1999 = 4) +  12 * (   WifeWorkmanper1999 = 5) + (   WifeWorkmanper1999 = 6));
HeadAlimony1999         = HeadAlimony1999    * (52 * (   HeadAlimonyper1999 = 3) + 26 * (   HeadAlimonyper1999 = 4) +  12 * (   HeadAlimonyper1999 = 5) + (   HeadAlimonyper1999 = 6));
HeadChldSppt1999        = HeadChldSppt1999   * (52 * (  HeadChldSpptper1999 = 3) + 26 * (  HeadChldSpptper1999 = 4) +  12 * (  HeadChldSpptper1999 = 5) + (  HeadChldSpptper1999 = 6));
WifeChldSppt1999        = WifeChldSppt1999   * (52 * (  WifeChldSpptper1999 = 3) + 26 * (  WifeChldSpptper1999 = 4) +  12 * (  WifeChldSpptper1999 = 5) + (  WifeChldSpptper1999 = 6));
HeadRelHelp1999         = HeadRelHelp1999    * (52 * (   HeadRelHelpper1999 = 3) + 26 * (   HeadRelHelpper1999 = 4) +  12 * (   HeadRelHelpper1999 = 5) + (   HeadRelHelpper1999 = 6));
WifeRelHelp1999         = WifeRelHelp1999    * (52 * (   WifeRelHelpper1999 = 3) + 26 * (   WifeRelHelpper1999 = 4) +  12 * (   WifeRelHelpper1999 = 5) + (   WifeRelHelpper1999 = 6));
HeadNonRelHelp1999      = HeadNonRelHelp1999 * (52 * (HeadNonRelHelpper1999 = 3) + 26 * (HeadNonRelHelpper1999 = 4) +  12 * (HeadNonRelHelpper1999 = 5) + (HeadNonRelHelpper1999 = 6));
WifeNonRelHelp1999      = WifeNonRelHelp1999 * (52 * (WifeNonRelHelpper1999 = 3) + 26 * (WifeNonRelHelpper1999 = 4) +  12 * (WifeNonRelHelpper1999 = 5) + (WifeNonRelHelpper1999 = 6));
HeadOthIncome1999       = HeadOthIncome1999  * (52 * ( HeadOthIncomeper1999 = 3) + 26 * ( HeadOthIncomeper1999 = 4) +  12 * ( HeadOthIncomeper1999 = 5) + ( HeadOthIncomeper1999 = 6));
WifeOthIncome1999       = WifeOthIncome1999  * (52 * ( WifeOthIncomeper1999 = 3) + 26 * ( WifeOthIncomeper1999 = 4) +  12 * ( WifeOthIncomeper1999 = 5) + ( WifeOthIncomeper1999 = 6));

if  HeadRmmrlaborper1999 = 1 or  HeadRmmrlaborper1999 = 2 or  HeadRmmrlaborper1999 ge 7 then  HeadRmmrlabor1999 = .;  
if       HeadRentper1999 = 1 or       HeadRentper1999 = 2 or       HeadRentper1999 ge 7 then       HeadRent1999 = .;  
if   HeadDividendper1999 = 1 or   HeadDividendper1999 = 2 or   HeadDividendper1999 ge 7 then   HeadDividend1999 = .;  
if   HeadInterestper1999 = 1 or   HeadInterestper1999 = 2 or   HeadInterestper1999 ge 7 then   HeadInterest1999 = .;  
if  HeadTrustFundper1999 = 1 or  HeadTrustFundper1999 = 2 or  HeadTrustFundper1999 ge 7 then  HeadTrustFund1999 = .;  
if   WifeOthAssetper1999 = 1 or   WifeOthAssetper1999 = 2 or   WifeOthAssetper1999 ge 7 then   WifeOthAsset1999 = .;  
if   WifeDividendper1999 = 1 or   WifeDividendper1999 = 2 or   WifeDividendper1999 ge 7 then   WifeDividend1999 = .;  
if   WifeInterestper1999 = 1 or   WifeInterestper1999 = 2 or   WifeInterestper1999 ge 7 then   WifeInterest1999 = .;  
if  WifeTrustFundper1999 = 1 or  WifeTrustFundper1999 = 2 or  WifeTrustFundper1999 ge 7 then  WifeTrustFund1999 = .;  
if        HeadADCper1999 = 1 or        HeadADCper1999 = 2 or        HeadADCper1999 ge 7 then        HeadADC1999 = .;  
if        WifeADCper1999 = 1 or        WifeADCper1999 = 2 or        WifeADCper1999 ge 7 then        WifeADC1999 = .;  
if  HeadRetIncVetper1999 = 1 or  HeadRetIncVetper1999 = 2 or  HeadRetIncVetper1999 ge 7 then  HeadRetIncVet1999 = .;  
if   HeadRetIncNVper1999 = 1 or   HeadRetIncNVper1999 = 2 or   HeadRetIncNVper1999 ge 7 then   HeadRetIncNV1999 = .;  
if    HeadSuppSecper1999 = 1 or    HeadSuppSecper1999 = 2 or    HeadSuppSecper1999 ge 7 then    HeadSuppSec1999 = .;  
if    WifeSuppSecper1999 = 1 or    WifeSuppSecper1999 = 2 or    WifeSuppSecper1999 ge 7 then    WifeSuppSec1999 = .;  
if     HeadOthWelper1999 = 1 or     HeadOthWelper1999 = 2 or     HeadOthWelper1999 ge 7 then     HeadOthWel1999 = .;  
if     WifeOthWelper1999 = 1 or     WifeOthWelper1999 = 2 or     WifeOthWelper1999 ge 7 then     WifeOthWel1999 = .;  
if    HeadAnnuityper1999 = 1 or    HeadAnnuityper1999 = 2 or    HeadAnnuityper1999 ge 7 then    HeadAnnuity1999 = .;  
if    WifeAnnuityper1999 = 1 or    WifeAnnuityper1999 = 2 or    WifeAnnuityper1999 ge 7 then    WifeAnnuity1999 = .;  
if     HeadOthRetper1999 = 1 or     HeadOthRetper1999 = 2 or     HeadOthRetper1999 ge 7 then     HeadOthRet1999 = .;  
if      HeadUnempper1999 = 1 or      HeadUnempper1999 = 2 or      HeadUnempper1999 ge 7 then      HeadUnemp1999 = .;  
if      WifeUnempper1999 = 1 or      WifeUnempper1999 = 2 or      WifeUnempper1999 ge 7 then      WifeUnemp1999 = .;  
if    HeadWorkmanper1999 = 1 or    HeadWorkmanper1999 = 2 or    HeadWorkmanper1999 ge 7 then    HeadWorkman1999 = .;  
if    WifeWorkmanper1999 = 1 or    WifeWorkmanper1999 = 2 or    WifeWorkmanper1999 ge 7 then    WifeWorkman1999 = .;  
if    HeadAlimonyper1999 = 1 or    HeadAlimonyper1999 = 2 or    HeadAlimonyper1999 ge 7 then    HeadAlimony1999 = .;  
if   HeadChldSpptper1999 = 1 or   HeadChldSpptper1999 = 2 or   HeadChldSpptper1999 ge 7 then   HeadChldSppt1999 = .;  
if   WifeChldSpptper1999 = 1 or   WifeChldSpptper1999 = 2 or   WifeChldSpptper1999 ge 7 then   WifeChldSppt1999 = .;  
if    HeadRelHelpper1999 = 1 or    HeadRelHelpper1999 = 2 or    HeadRelHelpper1999 ge 7 then    HeadRelHelp1999 = .;  
if    WifeRelHelpper1999 = 1 or    WifeRelHelpper1999 = 2 or    WifeRelHelpper1999 ge 7 then    WifeRelHelp1999 = .;  
if HeadNonRelHelpper1999 = 1 or HeadNonRelHelpper1999 = 2 or HeadNonRelHelpper1999 ge 7 then HeadNonRelHelp1999 = .;  
if WifeNonRelHelpper1999 = 1 or WifeNonRelHelpper1999 = 2 or WifeNonRelHelpper1999 ge 7 then WifeNonRelHelp1999 = .;  
if  HeadOthIncomeper1999 = 1 or  HeadOthIncomeper1999 = 2 or  HeadOthIncomeper1999 ge 7 then  HeadOthIncome1999 = .;  
if  WifeOthIncomeper1999 = 1 or  WifeOthIncomeper1999 = 2 or  WifeOthIncomeper1999 ge 7 then  WifeOthIncome1999 = .;  

if  HeadRmmrlaborper1999 = 0 then  HeadRmmrlabor1999 = 0;                                                                                                                                                                                                    
if       HeadRentper1999 = 0 then       HeadRent1999 = 0;                                                                                                                                                                                                    
if   HeadDividendper1999 = 0 then   HeadDividend1999 = 0;                                                                                                                                                                                                    
if   HeadInterestper1999 = 0 then   HeadInterest1999 = 0;                                                                                                                                                                                                    
if  HeadTrustFundper1999 = 0 then  HeadTrustFund1999 = 0;                                                                                                                                                                                                    
if   WifeOthAssetper1999 = 0 then   WifeOthAsset1999 = 0;                                                                                                                                                                                                    
if   WifeDividendper1999 = 0 then   WifeDividend1999 = 0;                                                                                                                                                                                                    
if   WifeInterestper1999 = 0 then   WifeInterest1999 = 0;                                                                                                                                                                                                    
if  WifeTrustFundper1999 = 0 then  WifeTrustFund1999 = 0;                                                                                                                                                                                                    
if        HeadADCper1999 = 0 then        HeadADC1999 = 0;                                                                                                                                                                                                    
if        WifeADCper1999 = 0 then        WifeADC1999 = 0;                                                                                                                                                                                                    
if  HeadRetIncVetper1999 = 0 then  HeadRetIncVet1999 = 0;                                                                                                                                                                                                    
if   HeadRetIncNVper1999 = 0 then   HeadRetIncNV1999 = 0;                                                                                                                                                                                                    
if    HeadSuppSecper1999 = 0 then    HeadSuppSec1999 = 0;                                                                                                                                                                                                    
if    WifeSuppSecper1999 = 0 then    WifeSuppSec1999 = 0;                                                                                                                                                                                                    
if     HeadOthWelper1999 = 0 then     HeadOthWel1999 = 0;                                                                                                                                                                                                    
if     WifeOthWelper1999 = 0 then     WifeOthWel1999 = 0;                                                                                                                                                                                                    
if    HeadAnnuityper1999 = 0 then    HeadAnnuity1999 = 0;                                                                                                                                                                                                    
if    WifeAnnuityper1999 = 0 then    WifeAnnuity1999 = 0;                                                                                                                                                                                                    
if     HeadOthRetper1999 = 0 then     HeadOthRet1999 = 0;                                                                                                                                                                                                    
if      HeadUnempper1999 = 0 then      HeadUnemp1999 = 0;                                                                                                                                                                                                    
if      WifeUnempper1999 = 0 then      WifeUnemp1999 = 0;                                                                                                                                                                                                    
if    HeadWorkmanper1999 = 0 then    HeadWorkman1999 = 0;                                                                                                                                                                                                    
if    WifeWorkmanper1999 = 0 then    WifeWorkman1999 = 0;                                                                                                                                                                                                    
if    HeadAlimonyper1999 = 0 then    HeadAlimony1999 = 0;                                                                                                                                                                                                    
if   HeadChldSpptper1999 = 0 then   HeadChldSppt1999 = 0;                                                                                                                                                                                                    
if   WifeChldSpptper1999 = 0 then   WifeChldSppt1999 = 0;                                                                                                                                                                                                    
if    HeadRelHelpper1999 = 0 then    HeadRelHelp1999 = 0;                                                                                                                                                                                                    
if    WifeRelHelpper1999 = 0 then    WifeRelHelp1999 = 0;                                                                                                                                                                                                    
if HeadNonRelHelpper1999 = 0 then HeadNonRelHelp1999 = 0;                                                                                                                                                                                                    
if WifeNonRelHelpper1999 = 0 then WifeNonRelHelp1999 = 0;                                                                                                                                                                                                    
if  HeadOthIncomeper1999 = 0 then  HeadOthIncome1999 = 0;                                                                                                                                                                                                    
if  WifeOthIncomeper1999 = 0 then  WifeOthIncome1999 = 0;                                                                                                                                                                                                    

keep id1999 HeadExtraInclude1999
HeadRmmrlabor1999  
HeadRent1999       
HeadDividend1999   
HeadInterest1999   
HeadTrustFund1999  
WifeDividend1999   
WifeInterest1999   
WifeTrustFund1999  
WifeOthAsset1999   
HeadADC1999        
WifeADC1999        
HeadRetIncVet1999  
HeadRetIncNV1999   
HeadAnnuity1999    
WifeAnnuity1999    
HeadOthRet1999     
HeadUnemp1999      
WifeUnemp1999      
HeadWorkman1999    
WifeWorkman1999    
HeadAlimony1999    
HeadChldSppt1999   
WifeChldSppt1999   
HeadRelHelp1999    
WifeRelHelp1999    
HeadNonRelHelp1999 
WifeNonRelHelp1999 
HeadSuppSec1999    
WifeSuppSec1999    
HeadOthWel1999     
WifeOthWel1999     
HeadOthIncome1999  
WifeOthIncome1999; 
run;


data incomeplus1999;
set psiddata.income9401;

id1999                =             ER13002    ;
Faminc1999            =             FAMINC99  ;
HWtaxable1999         =             TXHW99    ;
HeadLabor1999         =             HDEARN99  ;
WifeLabor1999         =             WFEARN99  ;
HeadSalary1999        =             HDWG99    ;  
HWTrans1999           =             TRHW99    ;                                                                                                                                                                                                                    
OthTaxable1999        =             TXOFM99   ;                                                                                                                                                                                                                  
OthTrans1999          =             TROFM99   ;
FamSSI1999            =             SSEC99    ;
HeadFarm1999          =             FRMINC99  ;
TotalFarm1999         =             FRMINC99  ;        
FamBus1999            =             BUSINC99  ; 
HeadBusLabor1999      =             HDBUSY99  ;
HeadBusAsset1999      =             HDBUSK99  ;
WifeBusLabor1999      =             WFBUSY99  ;
WifeBusAsset1999      =             WFBUSK99  ;
HeadBonus1999         =             BNUS99    ;
HeadOvertime1999      =             OVTM99    ;
HeadTips1999          =             TIPS99    ;
HeadCommission1999    =             COMS99    ;
HeadProf1999          =             PROF99    ;
HeadMktGrdnLabor1999  =             MKTG99    ;                                                                                                                                                                                                        
HeadExtraJob1999      =             XTRA99    ;

keep id1999                
Faminc1999            
HWtaxable1999         
HeadLabor1999         
WifeLabor1999         
HeadSalary1999        
HWTrans1999           
OthTaxable1999        
OthTrans1999          
FamSSI1999            
HeadFarm1999          
TotalFarm1999
FamBus1999            
HeadBusLabor1999      
HeadBusAsset1999      
WifeBusLabor1999      
WifeBusAsset1999      
HeadBonus1999         
HeadOvertime1999      
HeadTips1999          
HeadCommission1999    
HeadProf1999          
HeadMktGrdnLabor1999  
HeadExtraJob1999;

if id1999 ne .;

proc sort data = incomeplus1999;
by id1999;
run;

data psiddata.income1999;
merge income1999fam incomeplus1999;
by id1999; run;
proc means data = psiddata.income1999;
run;

