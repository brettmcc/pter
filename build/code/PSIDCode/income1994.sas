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

data income1994fam;
set psiddata.fam94;

id1994 = ER2002;
HeadExtraInclude1994 =  ER3200;          ***May need the indicator for estimation;

HeadRmmrlabor1994  = ER3185;    HeadRmmrlaborper1994 = ER3186;    ***Roomer and boarder income is not included in income plus data;                                                                                                                                                                                                          
HeadRent1994       = ER3203;         HeadRentper1994 = ER3204;    ******These detailed asset and transfer income are not  included in income plus data; 
HeadDividend1994   = ER3218;     HeadDividendper1994 = ER3219;      
HeadInterest1994   = ER3233;     HeadInterestper1994 = ER3234; 
HeadTrustFund1994  = ER3248;    HeadTrustFundper1994 = ER3249;                                                                                                                                                                                                              
WifeDividend1994   = ER3524;     WifeDividendper1994 = ER3525;
WifeInterest1994   = ER3539;     WifeInterestper1994 = ER3540;                                                                                                                                                                                                               
WifeTrustFund1994  = ER3554;    WifeTrustFundper1994 = ER3555;                                                                                                                                                                                                              
WifeOthAsset1994   = ER3569;     WifeOthAssetper1994 = ER3570;                                                                                                                                                                                                                                                                                                                                                                                                                                                           
HeadADC1994        = ER3263;          HeadADCper1994 = ER3264;                                                                                                                                                                                                        
WifeADC1994        = ER3599;          WifeADCper1994 = ER3600;                                                                                                                                                                                                        
HeadRetIncVet1994  = ER3310;    HeadRetIncVetper1994 = ER3311;                                                                                                
HeadRetIncNV1994   = ER3325;     HeadRetIncNVper1994 = ER3326;                                                                                                 
HeadAnnuity1994    = ER3340;      HeadAnnuityper1994 = ER3341;                                                                                                  
WifeAnnuity1994    = ER3644;      WifeAnnuityper1994 = ER3645;                                                                                                  
HeadOthRet1994     = ER3355;       HeadOthRetper1994 = ER3356;                                                                                                   
HeadUnemp1994      = ER3371;	    HeadUnempper1994 = ER3372;	                        
WifeUnemp1994      = ER3494;        WifeUnempper1994 = ER3495;                                                                                                    
HeadWorkman1994    = ER3386;      HeadWorkmanper1994 = ER3387;       	                                                                                           
WifeWorkman1994    = ER3509;      WifeWorkmanper1994 = ER3510;                                                                                                  
HeadAlimony1994    = ER3416;      HeadAlimonyper1994 = ER3417;                                                                                                  
HeadChldSppt1994   = ER3401;     HeadChldSpptper1994 = ER3402;                                                                                                 
WifeChldSppt1994   = ER3614;     WifeChldSpptper1994 = ER3615;                                                                                                 
HeadRelHelp1994    = ER3431;      HeadRelHelpper1994 = ER3432;                                                                                                  
WifeRelHelp1994    = ER3659;      WifeRelHelpper1994 = ER3660;                                                                                                  
HeadNonRelHelp1994 = ER3446;   HeadNonRelHelpper1994 = ER3447;                                                                                               
WifeNonRelHelp1994 = ER3674;   WifeNonRelHelpper1994 = ER3675;                                                                                               
HeadSuppSec1994    = ER3278;      HeadSuppSecper1994 = ER3279;                                                                                                  
WifeSuppSec1994    = ER3584;      WifeSuppSecper1994 = ER3585;                                                                                                  
HeadOthWel1994     = ER3293;       HeadOthWelper1994 = ER3294;                                                                                                   
WifeOthWel1994     = ER3629;       WifeOthWelper1994 = ER3630;                                                                                                   
HeadOthIncome1994  = ER3461;    HeadOthIncomeper1994 = ER3462;
WifeOthIncome1994  = ER3689; 

if    HeadRmmrlabor1994     ge       99996.00    then      HeadRmmrlabor1994       =      .; 
if    HeadRent1994          ge      999996.00    then      HeadRent1994            =      .; 
if    HeadDividend1994      ge      999996.00    then      HeadDividend1994        =      .; 
if    HeadInterest1994      ge      999996.00    then      HeadInterest1994        =      .; 
if    HeadTrustFund1994     ge      999996.00    then      HeadTrustFund1994       =      .; 
if    WifeDividend1994      ge      999996.00    then      WifeDividend1994        =      .; 
if    WifeInterest1994      ge      999996.00    then      WifeInterest1994        =      .; 
if    WifeTrustFund1994     ge       99996.00    then      WifeTrustFund1994       =      .; 
if    WifeOthAsset1994      ge      999996.00    then      WifeOthAsset1994        =      .; 
if    HeadADC1994           ge      999996.00    then      HeadADC1994             =      .; 
if    WifeADC1994           ge       99996.00    then      WifeADC1994             =      .; 
if    HeadRetIncVet1994     ge       99996.00    then      HeadRetIncVet1994       =      .; 
if    HeadRetIncNV1994      ge      999996.00    then      HeadRetIncNV1994        =      .; 
if    HeadAnnuity1994       ge      999996.00    then      HeadAnnuity1994         =      .; 
if    WifeAnnuity1994       ge       99996.00    then      WifeAnnuity1994         =      .; 
if    HeadOthRet1994        ge      999996.00    then      HeadOthRet1994          =      .; 
if    HeadUnemp1994         ge       99996.00    then      HeadUnemp1994           =      .; 
if    WifeUnemp1994         ge       99996.00    then      WifeUnemp1994           =      .; 
if    HeadWorkman1994       ge       99996.00    then      HeadWorkman1994         =      .; 
if    WifeWorkman1994       ge       99996.00    then      WifeWorkman1994         =      .; 
if    HeadAlimony1994       ge       99996.00    then      HeadAlimony1994         =      .; 
if    HeadChldSppt1994      ge       99996.00    then      HeadChldSppt1994        =      .; 
if    WifeChldSppt1994      ge       99996.00    then      WifeChldSppt1994        =      .; 
if    HeadRelHelp1994       ge       99996.00    then      HeadRelHelp1994         =      .; 
if    WifeRelHelp1994       ge       99996.00    then      WifeRelHelp1994         =      .; 
if    HeadNonRelHelp1994    ge       99996.00    then      HeadNonRelHelp1994      =      .; 
if    WifeNonRelHelp1994    ge       99996.00    then      WifeNonRelHelp1994      =      .; 
if    HeadSuppSec1994       ge      999996.00    then      HeadSuppSec1994         =      .; 
if    WifeSuppSec1994       ge       99996.00    then      WifeSuppSec1994         =      .; 
if    HeadOthWel1994        ge      999996.00    then      HeadOthWel1994          =      .; 
if    WifeOthWel1994        ge       99996.00    then      WifeOthWel1994          =      .; 
if    HeadOthIncome1994     ge      999996.00    then      HeadOthIncome1994       =      .; 
if    WifeOthIncome1994     ge       99996.00    then      WifeOthIncome1994       =      .; 

HeadRmmrlabor1994       = HeadRmmrlabor1994  * (( HeadRmmrlaborper1994 = 1) +  12 * ( HeadRmmrlaborper1994 = 2) +  26 * ( HeadRmmrlaborper1994 = 3) +  56 * ( HeadRmmrlaborper1994 = 4));                                                                                                                                                                                             
HeadRent1994            = HeadRent1994       * (12 * (      HeadRentper1994 = 1) +  4 * (      HeadRentper1994 = 2) +  2 * (      HeadRentper1994 = 3) + (      HeadRentper1994 = 4));     
HeadDividend1994        = HeadDividend1994   * (12 * (  HeadDividendper1994 = 1) +  4 * (  HeadDividendper1994 = 2) +  2 * (  HeadDividendper1994 = 3) + (  HeadDividendper1994 = 4));     
HeadInterest1994        = HeadInterest1994   * (12 * (  HeadInterestper1994 = 1) +  4 * (  HeadInterestper1994 = 2) +  2 * (  HeadInterestper1994 = 3) + (  HeadInterestper1994 = 4));     
HeadTrustFund1994       = HeadTrustFund1994  * (12 * ( HeadTrustFundper1994 = 1) +  4 * ( HeadTrustFundper1994 = 2) +  2 * ( HeadTrustFundper1994 = 3) + ( HeadTrustFundper1994 = 4));     
WifeOthAsset1994        = WifeOthAsset1994   * (12 * (  WifeOthAssetper1994 = 1) +  4 * (  WifeOthAssetper1994 = 2) +  2 * (  WifeOthAssetper1994 = 3) + (  WifeOthAssetper1994 = 4));     
WifeDividend1994        = WifeDividend1994   * (12 * (  WifeDividendper1994 = 1) +  4 * (  WifeDividendper1994 = 2) +  2 * (  WifeDividendper1994 = 3) + (  WifeDividendper1994 = 4));     
WifeInterest1994        = WifeInterest1994   * (12 * (  WifeInterestper1994 = 1) +  4 * (  WifeInterestper1994 = 2) +  2 * (  WifeInterestper1994 = 3) + (  WifeInterestper1994 = 4));     
WifeTrustFund1994       = WifeTrustFund1994  * (12 * ( WifeTrustFundper1994 = 1) +  4 * ( WifeTrustFundper1994 = 2) +  2 * ( WifeTrustFundper1994 = 3) + ( WifeTrustFundper1994 = 4));     
HeadADC1994             = HeadADC1994        * (12 * (       HeadADCper1994 = 1) +  4 * (       HeadADCper1994 = 2) +  2 * (       HeadADCper1994 = 3) + (       HeadADCper1994 = 4));     
WifeADC1994             = WifeADC1994        * (12 * (       WifeADCper1994 = 1) +  4 * (       WifeADCper1994 = 2) +  2 * (       WifeADCper1994 = 3) + (       WifeADCper1994 = 4));     
HeadRetIncVet1994       = HeadRetIncVet1994  * (12 * ( HeadRetIncVetper1994 = 1) +  4 * ( HeadRetIncVetper1994 = 2) +  2 * ( HeadRetIncVetper1994 = 3) + ( HeadRetIncVetper1994 = 4));     
HeadRetIncNV1994        = HeadRetIncNV1994   * (12 * (  HeadRetIncNVper1994 = 1) +  4 * (  HeadRetIncNVper1994 = 2) +  2 * (  HeadRetIncNVper1994 = 3) + (  HeadRetIncNVper1994 = 4));     
HeadSuppSec1994         = HeadSuppSec1994    * (12 * (   HeadSuppSecper1994 = 1) +  4 * (   HeadSuppSecper1994 = 2) +  2 * (   HeadSuppSecper1994 = 3) + (   HeadSuppSecper1994 = 4));     
WifeSuppSec1994         = WifeSuppSec1994    * (12 * (   WifeSuppSecper1994 = 1) +  4 * (   WifeSuppSecper1994 = 2) +  2 * (   WifeSuppSecper1994 = 3) + (   WifeSuppSecper1994 = 4));     
HeadOthWel1994          = HeadOthWel1994     * (12 * (    HeadOthWelper1994 = 1) +  4 * (    HeadOthWelper1994 = 2) +  2 * (    HeadOthWelper1994 = 3) + (    HeadOthWelper1994 = 4));     
WifeOthWel1994          = WifeOthWel1994     * (12 * (    WifeOthWelper1994 = 1) +  4 * (    WifeOthWelper1994 = 2) +  2 * (    WifeOthWelper1994 = 3) + (    WifeOthWelper1994 = 4));     
HeadAnnuity1994         = HeadAnnuity1994    * (12 * (   HeadAnnuityper1994 = 1) +  4 * (   HeadAnnuityper1994 = 2) +  2 * (   HeadAnnuityper1994 = 3) + (   HeadAnnuityper1994 = 4));     
WifeAnnuity1994         = WifeAnnuity1994    * (12 * (   WifeAnnuityper1994 = 1) +  4 * (   WifeAnnuityper1994 = 2) +  2 * (   WifeAnnuityper1994 = 3) + (   WifeAnnuityper1994 = 4));     
HeadOthRet1994          = HeadOthRet1994     * (12 * (    HeadOthRetper1994 = 1) +  4 * (    HeadOthRetper1994 = 2) +  2 * (    HeadOthRetper1994 = 3) + (    HeadOthRetper1994 = 4));     
HeadUnemp1994           = HeadUnemp1994      * (52 * (     HeadUnempper1994 = 1) +  26 * (     HeadUnempper1994 = 2) +  12 * (     HeadUnempper1994 = 3) +  (     HeadUnempper1994 = 4));  
WifeUnemp1994           = WifeUnemp1994      * (52 * (     WifeUnempper1994 = 1) +  26 * (     WifeUnempper1994 = 2) +  12 * (     WifeUnempper1994 = 3) +  (     WifeUnempper1994 = 4));  
HeadWorkman1994         = HeadWorkman1994    * (52 * (   HeadWorkmanper1994 = 1) +  26 * (   HeadWorkmanper1994 = 2) +  12 * (   HeadWorkmanper1994 = 3) +  (   HeadWorkmanper1994 = 4));  
WifeWorkman1994         = WifeWorkman1994    * (52 * (   WifeWorkmanper1994 = 1) +  26 * (   WifeWorkmanper1994 = 2) +  12 * (   WifeWorkmanper1994 = 3) +  (   WifeWorkmanper1994 = 4));  
HeadAlimony1994         = HeadAlimony1994    * (52 * (   HeadAlimonyper1994 = 1) +  26 * (   HeadAlimonyper1994 = 2) +  12 * (   HeadAlimonyper1994 = 3) +  (   HeadAlimonyper1994 = 4));  
HeadChldSppt1994        = HeadChldSppt1994   * (52 * (  HeadChldSpptper1994 = 1) +  26 * (  HeadChldSpptper1994 = 2) +  12 * (  HeadChldSpptper1994 = 3) +  (  HeadChldSpptper1994 = 4));  
WifeChldSppt1994        = WifeChldSppt1994   * (52 * (  WifeChldSpptper1994 = 1) +  26 * (  WifeChldSpptper1994 = 2) +  12 * (  WifeChldSpptper1994 = 3) +  (  WifeChldSpptper1994 = 4));  
HeadRelHelp1994         = HeadRelHelp1994    * (52 * (   HeadRelHelpper1994 = 1) +  26 * (   HeadRelHelpper1994 = 2) +  12 * (   HeadRelHelpper1994 = 3) +  (   HeadRelHelpper1994 = 4));  
WifeRelHelp1994         = WifeRelHelp1994    * (52 * (   WifeRelHelpper1994 = 1) +  26 * (   WifeRelHelpper1994 = 2) +  12 * (   WifeRelHelpper1994 = 3) +  (   WifeRelHelpper1994 = 4));  
HeadNonRelHelp1994      = HeadNonRelHelp1994 * (52 * (HeadNonRelHelpper1994 = 1) +  26 * (HeadNonRelHelpper1994 = 2) +  12 * (HeadNonRelHelpper1994 = 3) +  (HeadNonRelHelpper1994 = 4));  
WifeNonRelHelp1994      = WifeNonRelHelp1994 * (52 * (WifeNonRelHelpper1994 = 1) +  26 * (WifeNonRelHelpper1994 = 2) +  12 * (WifeNonRelHelpper1994 = 3) +  (WifeNonRelHelpper1994 = 4));  
HeadOthIncome1994       = HeadOthIncome1994  * (52 * ( HeadOthIncomeper1994 = 1) +  26 * ( HeadOthIncomeper1994 = 2) +  12 * ( HeadOthIncomeper1994 = 3) +  ( HeadOthIncomeper1994 = 4));  
                                                                                                                                                                                           
if  HeadRmmrlaborper1994 ge 5 then  HeadRmmrlabor1994 = .;                                                                                                                                 
if       HeadRentper1994 ge 5 then       HeadRent1994 = .;                                                                                                                                 
if   HeadDividendper1994 ge 5 then   HeadDividend1994 = .;                                                                                                                                 
if   HeadInterestper1994 ge 5 then   HeadInterest1994 = .;                                                                                                                                 
if  HeadTrustFundper1994 ge 5 then  HeadTrustFund1994 = .;                                                                                                                                 
if   WifeOthAssetper1994 ge 5 then   WifeOthAsset1994 = .;                                                                                                                                 
if   WifeDividendper1994 ge 5 then   WifeDividend1994 = .;                                                                                                                                 
if   WifeInterestper1994 ge 5 then   WifeInterest1994 = .;                                                                                                                                 
if  WifeTrustFundper1994 ge 5 then  WifeTrustFund1994 = .;                                                                                                                                 
if        HeadADCper1994 ge 5 then        HeadADC1994 = .;                                                                                                                                 
if        WifeADCper1994 ge 5 then        WifeADC1994 = .;                                                                                                                                 
if  HeadRetIncVetper1994 ge 5 then  HeadRetIncVet1994 = .;                                                                                                                                 
if   HeadRetIncNVper1994 ge 5 then   HeadRetIncNV1994 = .;                                                                                                                                 
if    HeadSuppSecper1994 ge 5 then    HeadSuppSec1994 = .;                                                                                                                                 
if    WifeSuppSecper1994 ge 5 then    WifeSuppSec1994 = .;                                                                                                                                 
if     HeadOthWelper1994 ge 5 then     HeadOthWel1994 = .;                                                                                                                                 
if     WifeOthWelper1994 ge 5 then     WifeOthWel1994 = .;                                                                                                                                 
if    HeadAnnuityper1994 ge 5 then    HeadAnnuity1994 = .;                                                                                                                                 
if    WifeAnnuityper1994 ge 5 then    WifeAnnuity1994 = .;                                                                                                                                 
if     HeadOthRetper1994 ge 5 then     HeadOthRet1994 = .;                                                                                                                                 
if      HeadUnempper1994 ge 5 then      HeadUnemp1994 = .;                                                                                                                                 
if      WifeUnempper1994 ge 5 then      WifeUnemp1994 = .;                                                                                                                                 
if    HeadWorkmanper1994 ge 5 then    HeadWorkman1994 = .;                                                                                                                                 
if    WifeWorkmanper1994 ge 5 then    WifeWorkman1994 = .;                                                                                                                                 
if    HeadAlimonyper1994 ge 5 then    HeadAlimony1994 = .;                                                                                                                                 
if   HeadChldSpptper1994 ge 5 then   HeadChldSppt1994 = .;                                                                                                                                 
if   WifeChldSpptper1994 ge 5 then   WifeChldSppt1994 = .;                                                                                                                                 
if    HeadRelHelpper1994 ge 5 then    HeadRelHelp1994 = .;                                                                                                                                 
if    WifeRelHelpper1994 ge 5 then    WifeRelHelp1994 = .;                                                                                                                                 
if HeadNonRelHelpper1994 ge 5 then HeadNonRelHelp1994 = .;                                                                                                                                 
if WifeNonRelHelpper1994 ge 5 then WifeNonRelHelp1994 = .;                                                                                                                                 
if  HeadOthIncomeper1994 ge 5 then  HeadOthIncome1994 = .;                                                                                                                                 

if  HeadRmmrlaborper1994 = 0  then  HeadRmmrlabor1994 = 0;                                                                                                                                 
if       HeadRentper1994 = 0  then       HeadRent1994 = 0;                                                                                                                                 
if   HeadDividendper1994 = 0  then   HeadDividend1994 = 0;                                                                                                                                 
if   HeadInterestper1994 = 0  then   HeadInterest1994 = 0;                                                                                                                                 
if  HeadTrustFundper1994 = 0  then  HeadTrustFund1994 = 0;                                                                                                                                 
if   WifeOthAssetper1994 = 0  then   WifeOthAsset1994 = 0;                                                                                                                                 
if   WifeDividendper1994 = 0  then   WifeDividend1994 = 0;                                                                                                                                 
if   WifeInterestper1994 = 0  then   WifeInterest1994 = 0;                                                                                                                                 
if  WifeTrustFundper1994 = 0  then  WifeTrustFund1994 = 0;                                                                                                                                 
if        HeadADCper1994 = 0  then        HeadADC1994 = 0;                                                                                                                                 
if        WifeADCper1994 = 0  then        WifeADC1994 = 0;                                                                                                                                 
if  HeadRetIncVetper1994 = 0  then  HeadRetIncVet1994 = 0;                                                                                                                                 
if   HeadRetIncNVper1994 = 0  then   HeadRetIncNV1994 = 0;                                                                                                                                 
if    HeadSuppSecper1994 = 0  then    HeadSuppSec1994 = 0;                                                                                                                                 
if    WifeSuppSecper1994 = 0  then    WifeSuppSec1994 = 0;                                                                                                                                 
if     HeadOthWelper1994 = 0  then     HeadOthWel1994 = 0;                                                                                                                                 
if     WifeOthWelper1994 = 0  then     WifeOthWel1994 = 0;                                                                                                                                 
if    HeadAnnuityper1994 = 0  then    HeadAnnuity1994 = 0;                                                                                                                                 
if    WifeAnnuityper1994 = 0  then    WifeAnnuity1994 = 0;                                                                                                                                 
if     HeadOthRetper1994 = 0  then     HeadOthRet1994 = 0;                                                                                                                                 
if      HeadUnempper1994 = 0  then      HeadUnemp1994 = 0;                                                                                                                                 
if      WifeUnempper1994 = 0  then      WifeUnemp1994 = 0;                                                                                                                                 
if    HeadWorkmanper1994 = 0  then    HeadWorkman1994 = 0;                                                                                                                                 
if    WifeWorkmanper1994 = 0  then    WifeWorkman1994 = 0;                                                                                                                                 
if    HeadAlimonyper1994 = 0  then    HeadAlimony1994 = 0;                                                                                                                                 
if   HeadChldSpptper1994 = 0  then   HeadChldSppt1994 = 0;                                                                                                                                 
if   WifeChldSpptper1994 = 0  then   WifeChldSppt1994 = 0;                                                                                                                                 
if    HeadRelHelpper1994 = 0  then    HeadRelHelp1994 = 0;                                                                                                                                 
if    WifeRelHelpper1994 = 0  then    WifeRelHelp1994 = 0;                                                                                                                                 
if HeadNonRelHelpper1994 = 0  then HeadNonRelHelp1994 = 0;                                                                                                                                 
if WifeNonRelHelpper1994 = 0  then WifeNonRelHelp1994 = 0;                                                                                                                                 
if  HeadOthIncomeper1994 = 0  then  HeadOthIncome1994 = 0;                                                                                                                                 

keep id1994 HeadRmmrlabor1994 HeadExtraInclude1994
HeadRent1994       
HeadDividend1994   
HeadInterest1994   
HeadTrustFund1994  
WifeDividend1994   
WifeInterest1994   
WifeTrustFund1994  
WifeOthAsset1994   
HeadADC1994        
WifeADC1994        
HeadRetIncVet1994  
HeadRetIncNV1994   
HeadAnnuity1994    
WifeAnnuity1994    
HeadOthRet1994     
HeadUnemp1994      
WifeUnemp1994      
HeadWorkman1994    
WifeWorkman1994    
HeadAlimony1994    
HeadChldSppt1994   
WifeChldSppt1994   
HeadRelHelp1994    
WifeRelHelp1994    
HeadNonRelHelp1994 
WifeNonRelHelp1994 
HeadSuppSec1994    
WifeSuppSec1994    
HeadOthWel1994     
WifeOthWel1994     
HeadOthIncome1994  
WifeOthIncome1994;
run;

data incomeplus1994;
set psiddata.income9401;

id1994                =             ER2002    ;
Faminc1994            =             FAMINC94  ;
HWtaxable1994         =             TXHW94    ;
HeadLabor1994         =             HDEARN94  ;
WifeLabor1994         =             WFEARN94  ;
HeadSalary1994        =             HDWG94    ;  
HWTrans1994           =             TRHW94    ;                                                                                                                                                                                                                    
OthTaxable1994        =             TXOFM94   ;                                                                                                                                                                                                                  
OthTrans1994          =             TROFM94   ;
FamSSI1994            =             SSec94    ;
HeadFarm1994          =             FRMINC94  ;
TotalFarm1994         =             FRMINC94  ;
FamBus1994            =             BUSINC94  ; 
HeadBusLabor1994      =             HDBUSY94  ;
HeadBusAsset1994      =             HDBUSK94  ;
WifeBusLabor1994      =             WFBUSY94  ;
WifeBusAsset1994      =             WFBUSK94  ;
HeadBonus1994         =             BNUS94    ;
HeadOvertime1994      =             OVTM94    ;
HeadTips1994          =             TIPS94    ;
HeadCommission1994    =             COMS94    ;
HeadProf1994          =             PROF94    ;
HeadMktGrdnLabor1994  =             MKTG94    ;                                                                                                                                                                                                        
HeadExtraJob1994      =             XTRA94    ;

keep id1994               
Faminc1994           
HWtaxable1994        
HeadLabor1994        
WifeLabor1994        
HeadSalary1994       
HWTrans1994          
OthTaxable1994       
OthTrans1994         
FamSSI1994           
HeadFarm1994         
TotalFarm1994         
FamBus1994           
HeadBusLabor1994     
HeadBusAsset1994     
WifeBusLabor1994     
WifeBusAsset1994     
HeadBonus1994        
HeadOvertime1994     
HeadTips1994         
HeadCommission1994   
HeadProf1994         
HeadMktGrdnLabor1994 
HeadExtraJob1994     ;

if id1994 ne .;

proc sort data = incomeplus1994;
by id1994;
run;

data psiddata.income1994;
merge income1994fam incomeplus1994;
by id1994; run;

proc means data = psiddata.income1994;
run;
run;

 
/*proc univariate data = income94fam noprint;
var HeadRmmrlabor1994 HeadRent1994    HeadDividend1994   HeadInterest1994   
HeadTrustFund1994  WifeOthAsset1994   WifeDividend1994   WifeInterest1994   
WifeTrustFund1994  HeadADC1994        WifeADC1994        HeadRetIncVet1994  
HeadRetIncNV1994   HeadSuppSec1994    WifeSuppSec1994    HeadOthWel1994     
WifeOthWel1994     HeadAnnuity1994    WifeAnnuity1994    HeadOthRet1994     
HeadUnemp1994      WifeUnemp1994      HeadWorkman1994    WifeWorkman1994    
HeadAlimony1994    HeadChldSppt1994   WifeChldSppt1994   HeadRelHelp1994    
WifeRelHelp1994    HeadNonRelHelp1994 WifeNonRelHelp1994 HeadOthIncome1994;  
output out = u 
pctlpre = HeadRmmrlabor1994_ HeadRent1994_    HeadDividend1994_   HeadInterest1994_   
HeadTrustFund1994_  WifeOthAsset1994_   WifeDividend1994_   WifeInterest1994_   
WifeTrustFund1994_  HeadADC1994_        WifeADC1994_        HeadRetIncVet1994_  
HeadRetIncNV1994_   HeadSuppSec1994_    WifeSuppSec1994_    HeadOthWel1994_     
WifeOthWel1994_     HeadAnnuity1994_    WifeAnnuity1994_    HeadOthRet1994_     
HeadUnemp1994_      WifeUnemp1994_      HeadWorkman1994_    WifeWorkman1994_    
HeadAlimony1994_    HeadChldSppt1994_   WifeChldSppt1994_   HeadRelHelp1994_    
WifeRelHelp1994_    HeadNonRelHelp1994_ WifeNonRelHelp1994_ HeadOthIncome1994_
pctlpts = 99;
run;

proc means data = income94fam;
var HeadRmmrlabor1994 HeadRent1994    HeadDividend1994   HeadInterest1994   
HeadTrustFund1994  WifeOthAsset1994   WifeDividend1994   WifeInterest1994   
WifeTrustFund1994  HeadADC1994        WifeADC1994        HeadRetIncVet1994  
HeadRetIncNV1994   HeadSuppSec1994    WifeSuppSec1994    HeadOthWel1994     
WifeOthWel1994     HeadAnnuity1994    WifeAnnuity1994    HeadOthRet1994     
HeadUnemp1994      WifeUnemp1994      HeadWorkman1994    WifeWorkman1994    
HeadAlimony1994    HeadChldSppt1994   WifeChldSppt1994   HeadRelHelp1994    
WifeRelHelp1994    HeadNonRelHelp1994 WifeNonRelHelp1994 HeadOthIncome1994;  
run;

data u;
set u;
m = 1; run;
%macro income(var);
data &var.;
merge income94fam u;
by m;
if &var. > &var._99;
*if faminc1994 ne . and faminc1994 < 0.9 * &var.;
keep faminc1994 &var.;
run;
%mend;

%income(HeadRmmrlabor1994)
%income(HeadRent1994)
%income(HeadDividend1994   )
%income(HeadInterest1994   )
%income(HeadTrustFund1994  )
%income(WifeDividend1994   )
%income(WifeInterest1994   )
%income(WifeTrustFund1994  )
%income(WifeOthAsset1994   )
%income(HeadADC1994        )
%income(WifeADC1994        )
%income(HeadRetIncVet1994  )
%income(HeadRetIncNV1994   )
%income(HeadAnnuity1994    )
%income(WifeAnnuity1994    )
%income(HeadOthRet1994     )
%income(HeadUnemp1994      )
%income(WifeUnemp1994      )
%income(HeadWorkman1994    )
%income(WifeWorkman1994    )
%income(HeadAlimony1994    )
%income(HeadChldSppt1994   )
%income(WifeChldSppt1994   )
%income(HeadRelHelp1994    )
%income(WifeRelHelp1994    )
%income(HeadNonRelHelp1994 )
%income(WifeNonRelHelp1994 )
%income(HeadSuppSec1994    )
%income(WifeSuppSec1994    )
%income(HeadOthWel1994     )
%income(WifeOthWel1994     )
%income(HeadOthIncome1994  )
%income(WifeOthIncome1994  )


*/
