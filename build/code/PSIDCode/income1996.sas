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

data income1996fam;
set psiddata.fam96;

id1996 = ER7002;
HeadExtraInclude1996 =  ER8317;          ***May need the indicator for estimation;

HeadRmmrlabor1996  = ER8302;    HeadRmmrlaborper1996 = ER8303;    ***Roomer and boarder income is not included in income plus data;                                                                                                                                                                                                          
HeadRent1996       = ER8320;         HeadRentper1996 = ER8321;    ******These detailed asset and transfer income are not  included in income plus data; 
HeadDividend1996   = ER8335;     HeadDividendper1996 = ER8336;      
HeadInterest1996   = ER8350;     HeadInterestper1996 = ER8351; 
HeadTrustFund1996  = ER8365;    HeadTrustFundper1996 = ER8366;                                                                                                                                                                                                              
WifeDividend1996   = ER8642;     WifeDividendper1996 = ER8643;
WifeInterest1996   = ER8657;     WifeInterestper1996 = ER8658;                                                                                                                                                                                                               
WifeTrustFund1996  = ER8672;    WifeTrustFundper1996 = ER8673;                                                                                                                                                                                                              
WifeOthAsset1996   = ER8687;     WifeOthAssetper1996 = ER8688;                                                                                                                                                                                                                                                                                                                                                                                                                                                           
HeadADC1996        = ER8380;          HeadADCper1996 = ER8381;                                                                                                                                                                                                        
WifeADC1996        = ER8718;          WifeADCper1996 = ER8719;                                                                                                                                                                                                        
HeadRetIncVet1996  = ER8428;    HeadRetIncVetper1996 = ER8429;                                                                                                
HeadRetIncNV1996   = ER8443;     HeadRetIncNVper1996 = ER8444;                                                                                                 
HeadAnnuity1996    = ER8458;      HeadAnnuityper1996 = ER8459;                                                                                                  
WifeAnnuity1996    = ER8763;      WifeAnnuityper1996 = ER8764;                                                                                                  
HeadOthRet1996     = ER8473;       HeadOthRetper1996 = ER8474;                                                                                                   
HeadUnemp1996      = ER8489;	    HeadUnempper1996 = ER8490;	                        
WifeUnemp1996      = ER8612;        WifeUnempper1996 = ER8613;                                                                                                    
HeadWorkman1996    = ER8504;      HeadWorkmanper1996 = ER8505;       	                                                                                           
WifeWorkman1996    = ER8627;      WifeWorkmanper1996 = ER8628;                                                                                                  
HeadAlimony1996    = ER8534;      HeadAlimonyper1996 = ER8535;                                                                                                  
HeadChldSppt1996   = ER8519;     HeadChldSpptper1996 = ER8520;                                                                                                 
WifeChldSppt1996   = ER8733;     WifeChldSpptper1996 = ER8734;                                                                                                 
HeadRelHelp1996    = ER8549;      HeadRelHelpper1996 = ER8550;                                                                                                  
WifeRelHelp1996    = ER8778;      WifeRelHelpper1996 = ER8779;                                                                                                  
HeadNonRelHelp1996 = ER8564;   HeadNonRelHelpper1996 = ER8565;                                                                                               
WifeNonRelHelp1996 = ER8793;   WifeNonRelHelpper1996 = ER8794;                                                                                               
HeadSuppSec1996    = ER8396;      HeadSuppSecper1996 = ER8397;                                                                                                  
WifeSuppSec1996    = ER8703;      WifeSuppSecper1996 = ER8704;                                                                                                  
HeadOthWel1996     = ER8411;       HeadOthWelper1996 = ER8412;                                                                                                   
WifeOthWel1996     = ER8748;       WifeOthWelper1996 = ER8749;                                                                                                   
HeadOthIncome1996  = ER8579;    HeadOthIncomeper1996 = ER8580;
WifeOthIncome1996  = ER8808;    WifeOthIncomeper1996 = ER8809; 

if    HeadRmmrlabor1996     ge     9999996.00    then      HeadRmmrlabor1996       =      .;    
if    HeadRent1996          ge      999996.00    then      HeadRent1996            =      .; 
if    HeadDividend1996      ge      999996.00    then      HeadDividend1996        =      .; 
if    HeadInterest1996      ge      999996.00    then      HeadInterest1996        =      .; 
if    HeadTrustFund1996     ge      999996.00    then      HeadTrustFund1996       =      .; 
if    WifeDividend1996      ge      999996.00    then      WifeDividend1996        =      .; 
if    WifeInterest1996      ge      999996.00    then      WifeInterest1996        =      .; 
if    WifeTrustFund1996     ge       99996.00    then      WifeTrustFund1996       =      .; 
if    WifeOthAsset1996      ge      999996.00    then      WifeOthAsset1996        =      .; 
if    HeadADC1996           ge      999996.00    then      HeadADC1996             =      .; 
if    WifeADC1996           ge       99996.00    then      WifeADC1996             =      .; 
if    HeadRetIncVet1996     ge       99996.00    then      HeadRetIncVet1996       =      .; 
if    HeadRetIncNV1996      ge      999996.00    then      HeadRetIncNV1996        =      .; 
if    HeadAnnuity1996       ge      999996.00    then      HeadAnnuity1996         =      .; 
if    WifeAnnuity1996       ge       99996.00    then      WifeAnnuity1996         =      .; 
if    HeadOthRet1996        ge      999996.00    then      HeadOthRet1996          =      .; 
if    HeadUnemp1996         ge       99996.00    then      HeadUnemp1996           =      .; 
if    WifeUnemp1996         ge       99996.00    then      WifeUnemp1996           =      .; 
if    HeadWorkman1996       ge       99996.00    then      HeadWorkman1996         =      .; 
if    WifeWorkman1996       ge       99996.00    then      WifeWorkman1996         =      .; 
if    HeadAlimony1996       ge       99996.00    then      HeadAlimony1996         =      .; 
if    HeadChldSppt1996      ge       99996.00    then      HeadChldSppt1996        =      .; 
if    WifeChldSppt1996      ge       99996.00    then      WifeChldSppt1996        =      .; 
if    HeadRelHelp1996       ge       99996.00    then      HeadRelHelp1996         =      .; 
if    WifeRelHelp1996       ge       99996.00    then      WifeRelHelp1996         =      .; 
if    HeadNonRelHelp1996    ge       99996.00    then      HeadNonRelHelp1996      =      .; 
if    WifeNonRelHelp1996    ge       99996.00    then      WifeNonRelHelp1996      =      .; 
if    HeadSuppSec1996       ge      999996.00    then      HeadSuppSec1996         =      .; 
if    WifeSuppSec1996       ge       99996.00    then      WifeSuppSec1996         =      .; 
if    HeadOthWel1996        ge      999996.00    then      HeadOthWel1996          =      .; 
if    WifeOthWel1996        ge       99996.00    then      WifeOthWel1996          =      .; 
if    HeadOthIncome1996     ge       99996.00    then      HeadOthIncome1996       =      .; 
if    WifeOthIncome1996     ge       99996.00    then      WifeOthIncome1996       =      .; 

HeadRmmrlabor1996       = HeadRmmrlabor1996  * (52 * ( HeadRmmrlaborper1996 = 3) + 26 * ( HeadRmmrlaborper1996 = 4) +  12 * ( HeadRmmrlaborper1996 = 5) + ( HeadRmmrlaborper1996 = 6));
HeadRent1996            = HeadRent1996       * (52 * (      HeadRentper1996 = 3) + 26 * (      HeadRentper1996 = 4) +  12 * (      HeadRentper1996 = 5) + (      HeadRentper1996 = 6));
HeadDividend1996        = HeadDividend1996   * (52 * (  HeadDividendper1996 = 3) + 26 * (  HeadDividendper1996 = 4) +  12 * (  HeadDividendper1996 = 5) + (  HeadDividendper1996 = 6));
HeadInterest1996        = HeadInterest1996   * (52 * (  HeadInterestper1996 = 3) + 26 * (  HeadInterestper1996 = 4) +  12 * (  HeadInterestper1996 = 5) + (  HeadInterestper1996 = 6));
HeadTrustFund1996       = HeadTrustFund1996  * (52 * ( HeadTrustFundper1996 = 3) + 26 * ( HeadTrustFundper1996 = 4) +  12 * ( HeadTrustFundper1996 = 5) + ( HeadTrustFundper1996 = 6));
WifeOthAsset1996        = WifeOthAsset1996   * (52 * (  WifeOthAssetper1996 = 3) + 26 * (  WifeOthAssetper1996 = 4) +  12 * (  WifeOthAssetper1996 = 5) + (  WifeOthAssetper1996 = 6));
WifeDividend1996        = WifeDividend1996   * (52 * (  WifeDividendper1996 = 3) + 26 * (  WifeDividendper1996 = 4) +  12 * (  WifeDividendper1996 = 5) + (  WifeDividendper1996 = 6));
WifeInterest1996        = WifeInterest1996   * (52 * (  WifeInterestper1996 = 3) + 26 * (  WifeInterestper1996 = 4) +  12 * (  WifeInterestper1996 = 5) + (  WifeInterestper1996 = 6));
WifeTrustFund1996       = WifeTrustFund1996  * (52 * ( WifeTrustFundper1996 = 3) + 26 * ( WifeTrustFundper1996 = 4) +  12 * ( WifeTrustFundper1996 = 5) + ( WifeTrustFundper1996 = 6));
HeadADC1996             = HeadADC1996        * (52 * (       HeadADCper1996 = 3) + 26 * (       HeadADCper1996 = 4) +  12 * (       HeadADCper1996 = 5) + (       HeadADCper1996 = 6));
WifeADC1996             = WifeADC1996        * (52 * (       WifeADCper1996 = 3) + 26 * (       WifeADCper1996 = 4) +  12 * (       WifeADCper1996 = 5) + (       WifeADCper1996 = 6));
HeadRetIncVet1996       = HeadRetIncVet1996  * (52 * ( HeadRetIncVetper1996 = 3) + 26 * ( HeadRetIncVetper1996 = 4) +  12 * ( HeadRetIncVetper1996 = 5) + ( HeadRetIncVetper1996 = 6));
HeadRetIncNV1996        = HeadRetIncNV1996   * (52 * (  HeadRetIncNVper1996 = 3) + 26 * (  HeadRetIncNVper1996 = 4) +  12 * (  HeadRetIncNVper1996 = 5) + (  HeadRetIncNVper1996 = 6));
HeadSuppSec1996         = HeadSuppSec1996    * (52 * (   HeadSuppSecper1996 = 3) + 26 * (   HeadSuppSecper1996 = 4) +  12 * (   HeadSuppSecper1996 = 5) + (   HeadSuppSecper1996 = 6));
WifeSuppSec1996         = WifeSuppSec1996    * (52 * (   WifeSuppSecper1996 = 3) + 26 * (   WifeSuppSecper1996 = 4) +  12 * (   WifeSuppSecper1996 = 5) + (   WifeSuppSecper1996 = 6));
HeadOthWel1996          = HeadOthWel1996     * (52 * (    HeadOthWelper1996 = 3) + 26 * (    HeadOthWelper1996 = 4) +  12 * (    HeadOthWelper1996 = 5) + (    HeadOthWelper1996 = 6));
WifeOthWel1996          = WifeOthWel1996     * (52 * (    WifeOthWelper1996 = 3) + 26 * (    WifeOthWelper1996 = 4) +  12 * (    WifeOthWelper1996 = 5) + (    WifeOthWelper1996 = 6));
HeadAnnuity1996         = HeadAnnuity1996    * (52 * (   HeadAnnuityper1996 = 3) + 26 * (   HeadAnnuityper1996 = 4) +  12 * (   HeadAnnuityper1996 = 5) + (   HeadAnnuityper1996 = 6));
WifeAnnuity1996         = WifeAnnuity1996    * (52 * (   WifeAnnuityper1996 = 3) + 26 * (   WifeAnnuityper1996 = 4) +  12 * (   WifeAnnuityper1996 = 5) + (   WifeAnnuityper1996 = 6));
HeadOthRet1996          = HeadOthRet1996     * (52 * (    HeadOthRetper1996 = 3) + 26 * (    HeadOthRetper1996 = 4) +  12 * (    HeadOthRetper1996 = 5) + (    HeadOthRetper1996 = 6));
HeadUnemp1996           = HeadUnemp1996      * (52 * (     HeadUnempper1996 = 3) + 26 * (     HeadUnempper1996 = 4) +  12 * (     HeadUnempper1996 = 5) + (     HeadUnempper1996 = 6));
WifeUnemp1996           = WifeUnemp1996      * (52 * (     WifeUnempper1996 = 3) + 26 * (     WifeUnempper1996 = 4) +  12 * (     WifeUnempper1996 = 5) + (     WifeUnempper1996 = 6));
HeadWorkman1996         = HeadWorkman1996    * (52 * (   HeadWorkmanper1996 = 3) + 26 * (   HeadWorkmanper1996 = 4) +  12 * (   HeadWorkmanper1996 = 5) + (   HeadWorkmanper1996 = 6));
WifeWorkman1996         = WifeWorkman1996    * (52 * (   WifeWorkmanper1996 = 3) + 26 * (   WifeWorkmanper1996 = 4) +  12 * (   WifeWorkmanper1996 = 5) + (   WifeWorkmanper1996 = 6));
HeadAlimony1996         = HeadAlimony1996    * (52 * (   HeadAlimonyper1996 = 3) + 26 * (   HeadAlimonyper1996 = 4) +  12 * (   HeadAlimonyper1996 = 5) + (   HeadAlimonyper1996 = 6));
HeadChldSppt1996        = HeadChldSppt1996   * (52 * (  HeadChldSpptper1996 = 3) + 26 * (  HeadChldSpptper1996 = 4) +  12 * (  HeadChldSpptper1996 = 5) + (  HeadChldSpptper1996 = 6));
WifeChldSppt1996        = WifeChldSppt1996   * (52 * (  WifeChldSpptper1996 = 3) + 26 * (  WifeChldSpptper1996 = 4) +  12 * (  WifeChldSpptper1996 = 5) + (  WifeChldSpptper1996 = 6));
HeadRelHelp1996         = HeadRelHelp1996    * (52 * (   HeadRelHelpper1996 = 3) + 26 * (   HeadRelHelpper1996 = 4) +  12 * (   HeadRelHelpper1996 = 5) + (   HeadRelHelpper1996 = 6));
WifeRelHelp1996         = WifeRelHelp1996    * (52 * (   WifeRelHelpper1996 = 3) + 26 * (   WifeRelHelpper1996 = 4) +  12 * (   WifeRelHelpper1996 = 5) + (   WifeRelHelpper1996 = 6));
HeadNonRelHelp1996      = HeadNonRelHelp1996 * (52 * (HeadNonRelHelpper1996 = 3) + 26 * (HeadNonRelHelpper1996 = 4) +  12 * (HeadNonRelHelpper1996 = 5) + (HeadNonRelHelpper1996 = 6));
WifeNonRelHelp1996      = WifeNonRelHelp1996 * (52 * (WifeNonRelHelpper1996 = 3) + 26 * (WifeNonRelHelpper1996 = 4) +  12 * (WifeNonRelHelpper1996 = 5) + (WifeNonRelHelpper1996 = 6));
HeadOthIncome1996       = HeadOthIncome1996  * (52 * ( HeadOthIncomeper1996 = 3) + 26 * ( HeadOthIncomeper1996 = 4) +  12 * ( HeadOthIncomeper1996 = 5) + ( HeadOthIncomeper1996 = 6));
WifeOthIncome1996       = WifeOthIncome1996  * (52 * ( WifeOthIncomeper1996 = 3) + 26 * ( WifeOthIncomeper1996 = 4) +  12 * ( WifeOthIncomeper1996 = 5) + ( WifeOthIncomeper1996 = 6));

if  HeadRmmrlaborper1996 = 1 or  HeadRmmrlaborper1996 = 2 or  HeadRmmrlaborper1996 ge 7 then  HeadRmmrlabor1996 = .;  
if       HeadRentper1996 = 1 or       HeadRentper1996 = 2 or       HeadRentper1996 ge 7 then       HeadRent1996 = .;  
if   HeadDividendper1996 = 1 or   HeadDividendper1996 = 2 or   HeadDividendper1996 ge 7 then   HeadDividend1996 = .;  
if   HeadInterestper1996 = 1 or   HeadInterestper1996 = 2 or   HeadInterestper1996 ge 7 then   HeadInterest1996 = .;  
if  HeadTrustFundper1996 = 1 or  HeadTrustFundper1996 = 2 or  HeadTrustFundper1996 ge 7 then  HeadTrustFund1996 = .;  
if   WifeOthAssetper1996 = 1 or   WifeOthAssetper1996 = 2 or   WifeOthAssetper1996 ge 7 then   WifeOthAsset1996 = .;  
if   WifeDividendper1996 = 1 or   WifeDividendper1996 = 2 or   WifeDividendper1996 ge 7 then   WifeDividend1996 = .;  
if   WifeInterestper1996 = 1 or   WifeInterestper1996 = 2 or   WifeInterestper1996 ge 7 then   WifeInterest1996 = .;  
if  WifeTrustFundper1996 = 1 or  WifeTrustFundper1996 = 2 or  WifeTrustFundper1996 ge 7 then  WifeTrustFund1996 = .;  
if        HeadADCper1996 = 1 or        HeadADCper1996 = 2 or        HeadADCper1996 ge 7 then        HeadADC1996 = .;  
if        WifeADCper1996 = 1 or        WifeADCper1996 = 2 or        WifeADCper1996 ge 7 then        WifeADC1996 = .;  
if  HeadRetIncVetper1996 = 1 or  HeadRetIncVetper1996 = 2 or  HeadRetIncVetper1996 ge 7 then  HeadRetIncVet1996 = .;  
if   HeadRetIncNVper1996 = 1 or   HeadRetIncNVper1996 = 2 or   HeadRetIncNVper1996 ge 7 then   HeadRetIncNV1996 = .;  
if    HeadSuppSecper1996 = 1 or    HeadSuppSecper1996 = 2 or    HeadSuppSecper1996 ge 7 then    HeadSuppSec1996 = .;  
if    WifeSuppSecper1996 = 1 or    WifeSuppSecper1996 = 2 or    WifeSuppSecper1996 ge 7 then    WifeSuppSec1996 = .;  
if     HeadOthWelper1996 = 1 or     HeadOthWelper1996 = 2 or     HeadOthWelper1996 ge 7 then     HeadOthWel1996 = .;  
if     WifeOthWelper1996 = 1 or     WifeOthWelper1996 = 2 or     WifeOthWelper1996 ge 7 then     WifeOthWel1996 = .;  
if    HeadAnnuityper1996 = 1 or    HeadAnnuityper1996 = 2 or    HeadAnnuityper1996 ge 7 then    HeadAnnuity1996 = .;  
if    WifeAnnuityper1996 = 1 or    WifeAnnuityper1996 = 2 or    WifeAnnuityper1996 ge 7 then    WifeAnnuity1996 = .;  
if     HeadOthRetper1996 = 1 or     HeadOthRetper1996 = 2 or     HeadOthRetper1996 ge 7 then     HeadOthRet1996 = .;  
if      HeadUnempper1996 = 1 or      HeadUnempper1996 = 2 or      HeadUnempper1996 ge 7 then      HeadUnemp1996 = .;  
if      WifeUnempper1996 = 1 or      WifeUnempper1996 = 2 or      WifeUnempper1996 ge 7 then      WifeUnemp1996 = .;  
if    HeadWorkmanper1996 = 1 or    HeadWorkmanper1996 = 2 or    HeadWorkmanper1996 ge 7 then    HeadWorkman1996 = .;  
if    WifeWorkmanper1996 = 1 or    WifeWorkmanper1996 = 2 or    WifeWorkmanper1996 ge 7 then    WifeWorkman1996 = .;  
if    HeadAlimonyper1996 = 1 or    HeadAlimonyper1996 = 2 or    HeadAlimonyper1996 ge 7 then    HeadAlimony1996 = .;  
if   HeadChldSpptper1996 = 1 or   HeadChldSpptper1996 = 2 or   HeadChldSpptper1996 ge 7 then   HeadChldSppt1996 = .;  
if   WifeChldSpptper1996 = 1 or   WifeChldSpptper1996 = 2 or   WifeChldSpptper1996 ge 7 then   WifeChldSppt1996 = .;  
if    HeadRelHelpper1996 = 1 or    HeadRelHelpper1996 = 2 or    HeadRelHelpper1996 ge 7 then    HeadRelHelp1996 = .;  
if    WifeRelHelpper1996 = 1 or    WifeRelHelpper1996 = 2 or    WifeRelHelpper1996 ge 7 then    WifeRelHelp1996 = .;  
if HeadNonRelHelpper1996 = 1 or HeadNonRelHelpper1996 = 2 or HeadNonRelHelpper1996 ge 7 then HeadNonRelHelp1996 = .;  
if WifeNonRelHelpper1996 = 1 or WifeNonRelHelpper1996 = 2 or WifeNonRelHelpper1996 ge 7 then WifeNonRelHelp1996 = .;  
if  HeadOthIncomeper1996 = 1 or  HeadOthIncomeper1996 = 2 or  HeadOthIncomeper1996 ge 7 then  HeadOthIncome1996 = .;  
if  WifeOthIncomeper1996 = 1 or  WifeOthIncomeper1996 = 2 or  WifeOthIncomeper1996 ge 7 then  WifeOthIncome1996 = .;  
 
if  HeadRmmrlaborper1996 = 0 then  HeadRmmrlabor1996 = 0;                                                                                                                                                                                                    
if       HeadRentper1996 = 0 then       HeadRent1996 = 0;                                                                                                                                                                                                    
if   HeadDividendper1996 = 0 then   HeadDividend1996 = 0;                                                                                                                                                                                                    
if   HeadInterestper1996 = 0 then   HeadInterest1996 = 0;                                                                                                                                                                                                    
if  HeadTrustFundper1996 = 0 then  HeadTrustFund1996 = 0;                                                                                                                                                                                                    
if   WifeOthAssetper1996 = 0 then   WifeOthAsset1996 = 0;                                                                                                                                                                                                    
if   WifeDividendper1996 = 0 then   WifeDividend1996 = 0;                                                                                                                                                                                                    
if   WifeInterestper1996 = 0 then   WifeInterest1996 = 0;                                                                                                                                                                                                    
if  WifeTrustFundper1996 = 0 then  WifeTrustFund1996 = 0;                                                                                                                                                                                                    
if        HeadADCper1996 = 0 then        HeadADC1996 = 0;                                                                                                                                                                                                    
if        WifeADCper1996 = 0 then        WifeADC1996 = 0;                                                                                                                                                                                                    
if  HeadRetIncVetper1996 = 0 then  HeadRetIncVet1996 = 0;                                                                                                                                                                                                    
if   HeadRetIncNVper1996 = 0 then   HeadRetIncNV1996 = 0;                                                                                                                                                                                                    
if    HeadSuppSecper1996 = 0 then    HeadSuppSec1996 = 0;                                                                                                                                                                                                    
if    WifeSuppSecper1996 = 0 then    WifeSuppSec1996 = 0;                                                                                                                                                                                                    
if     HeadOthWelper1996 = 0 then     HeadOthWel1996 = 0;                                                                                                                                                                                                    
if     WifeOthWelper1996 = 0 then     WifeOthWel1996 = 0;                                                                                                                                                                                                    
if    HeadAnnuityper1996 = 0 then    HeadAnnuity1996 = 0;                                                                                                                                                                                                    
if    WifeAnnuityper1996 = 0 then    WifeAnnuity1996 = 0;                                                                                                                                                                                                    
if     HeadOthRetper1996 = 0 then     HeadOthRet1996 = 0;                                                                                                                                                                                                    
if      HeadUnempper1996 = 0 then      HeadUnemp1996 = 0;                                                                                                                                                                                                    
if      WifeUnempper1996 = 0 then      WifeUnemp1996 = 0;                                                                                                                                                                                                    
if    HeadWorkmanper1996 = 0 then    HeadWorkman1996 = 0;                                                                                                                                                                                                    
if    WifeWorkmanper1996 = 0 then    WifeWorkman1996 = 0;                                                                                                                                                                                                    
if    HeadAlimonyper1996 = 0 then    HeadAlimony1996 = 0;                                                                                                                                                                                                    
if   HeadChldSpptper1996 = 0 then   HeadChldSppt1996 = 0;                                                                                                                                                                                                    
if   WifeChldSpptper1996 = 0 then   WifeChldSppt1996 = 0;                                                                                                                                                                                                    
if    HeadRelHelpper1996 = 0 then    HeadRelHelp1996 = 0;                                                                                                                                                                                                    
if    WifeRelHelpper1996 = 0 then    WifeRelHelp1996 = 0;                                                                                                                                                                                                    
if HeadNonRelHelpper1996 = 0 then HeadNonRelHelp1996 = 0;                                                                                                                                                                                                    
if WifeNonRelHelpper1996 = 0 then WifeNonRelHelp1996 = 0;                                                                                                                                                                                                    
if  HeadOthIncomeper1996 = 0 then  HeadOthIncome1996 = 0;                                                                                                                                                                                                    
if  WifeOthIncomeper1996 = 0 then  WifeOthIncome1996 = 0;                                                                                                                                                                                                    
                                                                                                              

keep id1996 HeadExtraInclude1996
HeadRmmrlabor1996  
HeadRent1996       
HeadDividend1996   
HeadInterest1996   
HeadTrustFund1996  
WifeDividend1996   
WifeInterest1996   
WifeTrustFund1996  
WifeOthAsset1996   
HeadADC1996        
WifeADC1996        
HeadRetIncVet1996  
HeadRetIncNV1996   
HeadAnnuity1996    
WifeAnnuity1996    
HeadOthRet1996     
HeadUnemp1996      
WifeUnemp1996      
HeadWorkman1996    
WifeWorkman1996    
HeadAlimony1996    
HeadChldSppt1996   
WifeChldSppt1996   
HeadRelHelp1996    
WifeRelHelp1996    
HeadNonRelHelp1996 
WifeNonRelHelp1996 
HeadSuppSec1996    
WifeSuppSec1996    
HeadOthWel1996     
WifeOthWel1996     
HeadOthIncome1996  
WifeOthIncome1996; 
run;


data incomeplus1996;
set psiddata.income9401;

id1996                =             ER7002    ;
Faminc1996            =             FAMINC96  ;
HWtaxable1996         =             TXHW96    ;
HeadLabor1996         =             HDEARN96  ;
WifeLabor1996         =             WFEARN96  ;
HeadSalary1996        =             HDWG96    ;  
HWTrans1996           =             TRHW96    ;                                                                                                                                                                                                                    
OthTaxable1996        =             TXOFM96   ;                                                                                                                                                                                                                  
OthTrans1996          =             TROFM96   ;
FamSSI1996            =             SSEC96    ;
HeadFarm1996          =             FRMINC96  ;
TotalFarm1996         =             FRMINC96  ;        
FamBus1996            =             BUSINC96  ; 
HeadBusLabor1996      =             HDBUSY96  ;
HeadBusAsset1996      =             HDBUSK96  ;
WifeBusLabor1996      =             WFBUSY96  ;
WifeBusAsset1996      =             WFBUSK96  ;
HeadBonus1996         =             BNUS96    ;
HeadOvertime1996      =             OVTM96    ;
HeadTips1996          =             TIPS96    ;
HeadCommission1996    =             COMS96    ;
HeadProf1996          =             PROF96    ;
HeadMktGrdnLabor1996  =             MKTG96    ;                                                                                                                                                                                                        
HeadExtraJob1996      =             XTRA96    ;

keep id1996               
Faminc1996           
HWtaxable1996        
HeadLabor1996        
WifeLabor1996        
HeadSalary1996       
HWTrans1996          
OthTaxable1996       
OthTrans1996         
FamSSI1996           
HeadFarm1996         
FamBus1996           
TotalFarm1996
HeadBusLabor1996     
HeadBusAsset1996     
WifeBusLabor1996     
WifeBusAsset1996     
HeadBonus1996        
HeadOvertime1996     
HeadTips1996         
HeadCommission1996   
HeadProf1996         
HeadMktGrdnLabor1996 
HeadExtraJob1996     ;
if id1996 ne .;

proc sort data = incomeplus1996;
by id1996;
run;

data psiddata.income1996;
merge income1996fam incomeplus1996;
by id1996; run;

proc means data = psiddata.income1996;
run;

