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

data income1995fam;
set psiddata.fam95;

id1995 = ER5002;
HeadExtraInclude1995 =  ER6200;          ***May need the indicator for estimation;

HeadRmmrlabor1995  = ER6185;    HeadRmmrlaborper1995 = ER6186;    ***Roomer and boarder income is not included in income plus data;                                                                                                                                                                                                          
HeadRent1995       = ER6203;         HeadRentper1995 = ER6204;    ******These detailed asset and transfer income are not  included in income plus data; 
HeadDividend1995   = ER6218;     HeadDividendper1995 = ER6219;      
HeadInterest1995   = ER6233;     HeadInterestper1995 = ER6234; 
HeadTrustFund1995  = ER6248;    HeadTrustFundper1995 = ER6249;                                                                                                                                                                                                              
WifeDividend1995   = ER6525;     WifeDividendper1995 = ER6526;
WifeInterest1995   = ER6540;     WifeInterestper1995 = ER6541;                                                                                                                                                                                                               
WifeTrustFund1995  = ER6555;    WifeTrustFundper1995 = ER6556;                                                                                                                                                                                                              
WifeOthAsset1995   = ER6570;     WifeOthAssetper1995 = ER6571;                                                                                                                                                                                                                                                                                                                                                                                                                                                           
HeadADC1995        = ER6263;          HeadADCper1995 = ER6264;                                                                                                                                                                                                        
WifeADC1995        = ER6601;          WifeADCper1995 = ER6602;                                                                                                                                                                                                        
HeadRetIncVet1995  = ER6311;    HeadRetIncVetper1995 = ER6312;                                                                                                
HeadRetIncNV1995   = ER6326;     HeadRetIncNVper1995 = ER6327;                                                                                                 
HeadAnnuity1995    = ER6341;      HeadAnnuityper1995 = ER6342;                                                                                                  
WifeAnnuity1995    = ER6646;      WifeAnnuityper1995 = ER6647;                                                                                                  
HeadOthRet1995     = ER6356;       HeadOthRetper1995 = ER6357;                                                                                                   
HeadUnemp1995      = ER6372;	    HeadUnempper1995 = ER6373;	                        
WifeUnemp1995      = ER6495;        WifeUnempper1995 = ER6496;                                                                                                    
HeadWorkman1995    = ER6387;      HeadWorkmanper1995 = ER6388;       	                                                                                           
WifeWorkman1995    = ER6510;      WifeWorkmanper1995 = ER6511;                                                                                                  
HeadAlimony1995    = ER6417;      HeadAlimonyper1995 = ER6418;                                                                                                  
HeadChldSppt1995   = ER6402;     HeadChldSpptper1995 = ER6403;                                                                                                 
WifeChldSppt1995   = ER6616;     WifeChldSpptper1995 = ER6617;                                                                                                 
HeadRelHelp1995    = ER6432;      HeadRelHelpper1995 = ER6433;                                                                                                  
WifeRelHelp1995    = ER6661;      WifeRelHelpper1995 = ER6662;                                                                                                  
HeadNonRelHelp1995 = ER6447;   HeadNonRelHelpper1995 = ER6448;                                                                                               
WifeNonRelHelp1995 = ER6676;   WifeNonRelHelpper1995 = ER6677;                                                                                               
HeadSuppSec1995    = ER6279;      HeadSuppSecper1995 = ER6280;                                                                                                  
WifeSuppSec1995    = ER6586;      WifeSuppSecper1995 = ER6587;                                                                                                  
HeadOthWel1995     = ER6294;       HeadOthWelper1995 = ER6295;                                                                                                   
WifeOthWel1995     = ER6631;       WifeOthWelper1995 = ER6632;                                                                                                   
HeadOthIncome1995  = ER6462;    HeadOthIncomeper1995 = ER6463;
WifeOthIncome1995  = ER6691; 

if    HeadRmmrlabor1995     ge     9999996.00    then      HeadRmmrlabor1995       =      .; 
if    HeadRent1995          ge      999996.00    then      HeadRent1995            =      .; 
if    HeadDividend1995      ge      999996.00    then      HeadDividend1995        =      .; 
if    HeadInterest1995      ge      999996.00    then      HeadInterest1995        =      .; 
if    HeadTrustFund1995     ge      999996.00    then      HeadTrustFund1995       =      .; 
if    WifeDividend1995      ge      999996.00    then      WifeDividend1995        =      .; 
if    WifeInterest1995      ge      999996.00    then      WifeInterest1995        =      .; 
if    WifeTrustFund1995     ge       99996.00    then      WifeTrustFund1995       =      .; 
if    WifeOthAsset1995      ge      999996.00    then      WifeOthAsset1995        =      .; 
if    HeadADC1995           ge      999996.00    then      HeadADC1995             =      .; 
if    WifeADC1995           ge       99996.00    then      WifeADC1995             =      .; 
if    HeadRetIncVet1995     ge       99996.00    then      HeadRetIncVet1995       =      .; 
if    HeadRetIncNV1995      ge      999996.00    then      HeadRetIncNV1995        =      .; 
if    HeadAnnuity1995       ge      999996.00    then      HeadAnnuity1995         =      .; 
if    WifeAnnuity1995       ge       99996.00    then      WifeAnnuity1995         =      .; 
if    HeadOthRet1995        ge      999996.00    then      HeadOthRet1995          =      .; 
if    HeadUnemp1995         ge       99996.00    then      HeadUnemp1995           =      .; 
if    WifeUnemp1995         ge       99996.00    then      WifeUnemp1995           =      .; 
if    HeadWorkman1995       ge       99996.00    then      HeadWorkman1995         =      .; 
if    WifeWorkman1995       ge       99996.00    then      WifeWorkman1995         =      .; 
if    HeadAlimony1995       ge       99996.00    then      HeadAlimony1995         =      .; 
if    HeadChldSppt1995      ge       99996.00    then      HeadChldSppt1995        =      .; 
if    WifeChldSppt1995      ge       99996.00    then      WifeChldSppt1995        =      .; 
if    HeadRelHelp1995       ge       99996.00    then      HeadRelHelp1995         =      .; 
if    WifeRelHelp1995       ge       99996.00    then      WifeRelHelp1995         =      .; 
if    HeadNonRelHelp1995    ge       99996.00    then      HeadNonRelHelp1995      =      .; 
if    WifeNonRelHelp1995    ge       99996.00    then      WifeNonRelHelp1995      =      .; 
if    HeadSuppSec1995       ge      999996.00    then      HeadSuppSec1995         =      .; 
if    WifeSuppSec1995       ge       99996.00    then      WifeSuppSec1995         =      .; 
if    HeadOthWel1995        ge      999996.00    then      HeadOthWel1995          =      .; 
if    WifeOthWel1995        ge       99996.00    then      WifeOthWel1995          =      .; 
if    HeadOthIncome1995     ge       99996.00    then      HeadOthIncome1995       =      .; 
if    WifeOthIncome1995     ge       99996.00    then      WifeOthIncome1995       =      .; 

HeadRmmrlabor1995       = HeadRmmrlabor1995  * (( HeadRmmrlaborper1995 = 1) +  12 * ( HeadRmmrlaborper1995 = 2) +  26 * ( HeadRmmrlaborper1995 = 3) +  56 * ( HeadRmmrlaborper1995 = 4));                                                                                                                                                                                             
HeadRent1995            = HeadRent1995       * (12 * (      HeadRentper1995 = 1) +  4 * (      HeadRentper1995 = 2) +  2 * (      HeadRentper1995 = 3) + (      HeadRentper1995 = 4));     
HeadDividend1995        = HeadDividend1995   * (12 * (  HeadDividendper1995 = 1) +  4 * (  HeadDividendper1995 = 2) +  2 * (  HeadDividendper1995 = 3) + (  HeadDividendper1995 = 4));     
HeadInterest1995        = HeadInterest1995   * (12 * (  HeadInterestper1995 = 1) +  4 * (  HeadInterestper1995 = 2) +  2 * (  HeadInterestper1995 = 3) + (  HeadInterestper1995 = 4));     
HeadTrustFund1995       = HeadTrustFund1995  * (12 * ( HeadTrustFundper1995 = 1) +  4 * ( HeadTrustFundper1995 = 2) +  2 * ( HeadTrustFundper1995 = 3) + ( HeadTrustFundper1995 = 4));     
WifeOthAsset1995        = WifeOthAsset1995   * (12 * (  WifeOthAssetper1995 = 1) +  4 * (  WifeOthAssetper1995 = 2) +  2 * (  WifeOthAssetper1995 = 3) + (  WifeOthAssetper1995 = 4));     
WifeDividend1995        = WifeDividend1995   * (12 * (  WifeDividendper1995 = 1) +  4 * (  WifeDividendper1995 = 2) +  2 * (  WifeDividendper1995 = 3) + (  WifeDividendper1995 = 4));     
WifeInterest1995        = WifeInterest1995   * (12 * (  WifeInterestper1995 = 1) +  4 * (  WifeInterestper1995 = 2) +  2 * (  WifeInterestper1995 = 3) + (  WifeInterestper1995 = 4));     
WifeTrustFund1995       = WifeTrustFund1995  * (12 * ( WifeTrustFundper1995 = 1) +  4 * ( WifeTrustFundper1995 = 2) +  2 * ( WifeTrustFundper1995 = 3) + ( WifeTrustFundper1995 = 4));     
HeadADC1995             = HeadADC1995        * (12 * (       HeadADCper1995 = 1) +  4 * (       HeadADCper1995 = 2) +  2 * (       HeadADCper1995 = 3) + (       HeadADCper1995 = 4));     
WifeADC1995             = WifeADC1995        * (12 * (       WifeADCper1995 = 1) +  4 * (       WifeADCper1995 = 2) +  2 * (       WifeADCper1995 = 3) + (       WifeADCper1995 = 4));     
HeadRetIncVet1995       = HeadRetIncVet1995  * (12 * ( HeadRetIncVetper1995 = 1) +  4 * ( HeadRetIncVetper1995 = 2) +  2 * ( HeadRetIncVetper1995 = 3) + ( HeadRetIncVetper1995 = 4));     
HeadRetIncNV1995        = HeadRetIncNV1995   * (12 * (  HeadRetIncNVper1995 = 1) +  4 * (  HeadRetIncNVper1995 = 2) +  2 * (  HeadRetIncNVper1995 = 3) + (  HeadRetIncNVper1995 = 4));     
HeadSuppSec1995         = HeadSuppSec1995    * (12 * (   HeadSuppSecper1995 = 1) +  4 * (   HeadSuppSecper1995 = 2) +  2 * (   HeadSuppSecper1995 = 3) + (   HeadSuppSecper1995 = 4));     
WifeSuppSec1995         = WifeSuppSec1995    * (12 * (   WifeSuppSecper1995 = 1) +  4 * (   WifeSuppSecper1995 = 2) +  2 * (   WifeSuppSecper1995 = 3) + (   WifeSuppSecper1995 = 4));     
HeadOthWel1995          = HeadOthWel1995     * (12 * (    HeadOthWelper1995 = 1) +  4 * (    HeadOthWelper1995 = 2) +  2 * (    HeadOthWelper1995 = 3) + (    HeadOthWelper1995 = 4));     
WifeOthWel1995          = WifeOthWel1995     * (12 * (    WifeOthWelper1995 = 1) +  4 * (    WifeOthWelper1995 = 2) +  2 * (    WifeOthWelper1995 = 3) + (    WifeOthWelper1995 = 4));     
HeadAnnuity1995         = HeadAnnuity1995    * (12 * (   HeadAnnuityper1995 = 1) +  4 * (   HeadAnnuityper1995 = 2) +  2 * (   HeadAnnuityper1995 = 3) + (   HeadAnnuityper1995 = 4));     
WifeAnnuity1995         = WifeAnnuity1995    * (12 * (   WifeAnnuityper1995 = 1) +  4 * (   WifeAnnuityper1995 = 2) +  2 * (   WifeAnnuityper1995 = 3) + (   WifeAnnuityper1995 = 4));     
HeadOthRet1995          = HeadOthRet1995     * (12 * (    HeadOthRetper1995 = 1) +  4 * (    HeadOthRetper1995 = 2) +  2 * (    HeadOthRetper1995 = 3) + (    HeadOthRetper1995 = 4));     
HeadUnemp1995           = HeadUnemp1995      * (52 * (     HeadUnempper1995 = 1) +  26 * (     HeadUnempper1995 = 2) +  12 * (     HeadUnempper1995 = 3) +  (     HeadUnempper1995 = 4));  
WifeUnemp1995           = WifeUnemp1995      * (52 * (     WifeUnempper1995 = 1) +  26 * (     WifeUnempper1995 = 2) +  12 * (     WifeUnempper1995 = 3) +  (     WifeUnempper1995 = 4));  
HeadWorkman1995         = HeadWorkman1995    * (52 * (   HeadWorkmanper1995 = 1) +  26 * (   HeadWorkmanper1995 = 2) +  12 * (   HeadWorkmanper1995 = 3) +  (   HeadWorkmanper1995 = 4));  
WifeWorkman1995         = WifeWorkman1995    * (52 * (   WifeWorkmanper1995 = 1) +  26 * (   WifeWorkmanper1995 = 2) +  12 * (   WifeWorkmanper1995 = 3) +  (   WifeWorkmanper1995 = 4));  
HeadAlimony1995         = HeadAlimony1995    * (52 * (   HeadAlimonyper1995 = 1) +  26 * (   HeadAlimonyper1995 = 2) +  12 * (   HeadAlimonyper1995 = 3) +  (   HeadAlimonyper1995 = 4));  
HeadChldSppt1995        = HeadChldSppt1995   * (52 * (  HeadChldSpptper1995 = 1) +  26 * (  HeadChldSpptper1995 = 2) +  12 * (  HeadChldSpptper1995 = 3) +  (  HeadChldSpptper1995 = 4));  
WifeChldSppt1995        = WifeChldSppt1995   * (52 * (  WifeChldSpptper1995 = 1) +  26 * (  WifeChldSpptper1995 = 2) +  12 * (  WifeChldSpptper1995 = 3) +  (  WifeChldSpptper1995 = 4));  
HeadRelHelp1995         = HeadRelHelp1995    * (52 * (   HeadRelHelpper1995 = 1) +  26 * (   HeadRelHelpper1995 = 2) +  12 * (   HeadRelHelpper1995 = 3) +  (   HeadRelHelpper1995 = 4));  
WifeRelHelp1995         = WifeRelHelp1995    * (52 * (   WifeRelHelpper1995 = 1) +  26 * (   WifeRelHelpper1995 = 2) +  12 * (   WifeRelHelpper1995 = 3) +  (   WifeRelHelpper1995 = 4));  
HeadNonRelHelp1995      = HeadNonRelHelp1995 * (52 * (HeadNonRelHelpper1995 = 1) +  26 * (HeadNonRelHelpper1995 = 2) +  12 * (HeadNonRelHelpper1995 = 3) +  (HeadNonRelHelpper1995 = 4));  
WifeNonRelHelp1995      = WifeNonRelHelp1995 * (52 * (WifeNonRelHelpper1995 = 1) +  26 * (WifeNonRelHelpper1995 = 2) +  12 * (WifeNonRelHelpper1995 = 3) +  (WifeNonRelHelpper1995 = 4));  
HeadOthIncome1995       = HeadOthIncome1995  * (52 * ( HeadOthIncomeper1995 = 1) +  26 * ( HeadOthIncomeper1995 = 2) +  12 * ( HeadOthIncomeper1995 = 3) +  ( HeadOthIncomeper1995 = 4));  
                                                                                                                                                                                           
if  HeadRmmrlaborper1995 ge 5 then  HeadRmmrlabor1995 = .; 
if       HeadRentper1995 ge 5 then       HeadRent1995 = .; 
if   HeadDividendper1995 ge 5 then   HeadDividend1995 = .; 
if   HeadInterestper1995 ge 5 then   HeadInterest1995 = .; 
if  HeadTrustFundper1995 ge 5 then  HeadTrustFund1995 = .; 
if   WifeOthAssetper1995 ge 5 then   WifeOthAsset1995 = .; 
if   WifeDividendper1995 ge 5 then   WifeDividend1995 = .; 
if   WifeInterestper1995 ge 5 then   WifeInterest1995 = .; 
if  WifeTrustFundper1995 ge 5 then  WifeTrustFund1995 = .; 
if        HeadADCper1995 ge 5 then        HeadADC1995 = .; 
if        WifeADCper1995 ge 5 then        WifeADC1995 = .; 
if  HeadRetIncVetper1995 ge 5 then  HeadRetIncVet1995 = .; 
if   HeadRetIncNVper1995 ge 5 then   HeadRetIncNV1995 = .; 
if    HeadSuppSecper1995 ge 5 then    HeadSuppSec1995 = .; 
if    WifeSuppSecper1995 ge 5 then    WifeSuppSec1995 = .; 
if     HeadOthWelper1995 ge 5 then     HeadOthWel1995 = .; 
if     WifeOthWelper1995 ge 5 then     WifeOthWel1995 = .; 
if    HeadAnnuityper1995 ge 5 then    HeadAnnuity1995 = .; 
if    WifeAnnuityper1995 ge 5 then    WifeAnnuity1995 = .; 
if     HeadOthRetper1995 ge 5 then     HeadOthRet1995 = .; 
if      HeadUnempper1995 ge 5 then      HeadUnemp1995 = .; 
if      WifeUnempper1995 ge 5 then      WifeUnemp1995 = .; 
if    HeadWorkmanper1995 ge 5 then    HeadWorkman1995 = .; 
if    WifeWorkmanper1995 ge 5 then    WifeWorkman1995 = .; 
if    HeadAlimonyper1995 ge 5 then    HeadAlimony1995 = .; 
if   HeadChldSpptper1995 ge 5 then   HeadChldSppt1995 = .; 
if   WifeChldSpptper1995 ge 5 then   WifeChldSppt1995 = .; 
if    HeadRelHelpper1995 ge 5 then    HeadRelHelp1995 = .; 
if    WifeRelHelpper1995 ge 5 then    WifeRelHelp1995 = .; 
if HeadNonRelHelpper1995 ge 5 then HeadNonRelHelp1995 = .; 
if WifeNonRelHelpper1995 ge 5 then WifeNonRelHelp1995 = .; 
if  HeadOthIncomeper1995 ge 5 then  HeadOthIncome1995 = .; 
if  HeadRmmrlaborper1995  = 0 then  HeadRmmrlabor1995 = 0; 
if       HeadRentper1995  = 0 then       HeadRent1995 = 0; 
if   HeadDividendper1995  = 0 then   HeadDividend1995 = 0; 
if   HeadInterestper1995  = 0 then   HeadInterest1995 = 0; 
if  HeadTrustFundper1995  = 0 then  HeadTrustFund1995 = 0; 
if   WifeOthAssetper1995  = 0 then   WifeOthAsset1995 = 0; 
if   WifeDividendper1995  = 0 then   WifeDividend1995 = 0; 
if   WifeInterestper1995  = 0 then   WifeInterest1995 = 0; 
if  WifeTrustFundper1995  = 0 then  WifeTrustFund1995 = 0; 
if        HeadADCper1995  = 0 then        HeadADC1995 = 0; 
if        WifeADCper1995  = 0 then        WifeADC1995 = 0; 
if  HeadRetIncVetper1995  = 0 then  HeadRetIncVet1995 = 0; 
if   HeadRetIncNVper1995  = 0 then   HeadRetIncNV1995 = 0; 
if    HeadSuppSecper1995  = 0 then    HeadSuppSec1995 = 0; 
if    WifeSuppSecper1995  = 0 then    WifeSuppSec1995 = 0; 
if     HeadOthWelper1995  = 0 then     HeadOthWel1995 = 0; 
if     WifeOthWelper1995  = 0 then     WifeOthWel1995 = 0; 
if    HeadAnnuityper1995  = 0 then    HeadAnnuity1995 = 0; 
if    WifeAnnuityper1995  = 0 then    WifeAnnuity1995 = 0; 
if     HeadOthRetper1995  = 0 then     HeadOthRet1995 = 0; 
if      HeadUnempper1995  = 0 then      HeadUnemp1995 = 0; 
if      WifeUnempper1995  = 0 then      WifeUnemp1995 = 0; 
if    HeadWorkmanper1995  = 0 then    HeadWorkman1995 = 0; 
if    WifeWorkmanper1995  = 0 then    WifeWorkman1995 = 0; 
if    HeadAlimonyper1995  = 0 then    HeadAlimony1995 = 0; 
if   HeadChldSpptper1995  = 0 then   HeadChldSppt1995 = 0; 
if   WifeChldSpptper1995  = 0 then   WifeChldSppt1995 = 0; 
if    HeadRelHelpper1995  = 0 then    HeadRelHelp1995 = 0; 
if    WifeRelHelpper1995  = 0 then    WifeRelHelp1995 = 0; 
if HeadNonRelHelpper1995  = 0 then HeadNonRelHelp1995 = 0; 
if WifeNonRelHelpper1995  = 0 then WifeNonRelHelp1995 = 0; 
if  HeadOthIncomeper1995  = 0 then  HeadOthIncome1995 = 0; 

keep id1995 HeadExtraInclude1995
HeadRmmrlabor1995  
HeadRent1995       
HeadDividend1995   
HeadInterest1995   
HeadTrustFund1995  
WifeDividend1995   
WifeInterest1995   
WifeTrustFund1995  
WifeOthAsset1995   
HeadADC1995        
WifeADC1995        
HeadRetIncVet1995  
HeadRetIncNV1995   
HeadAnnuity1995    
WifeAnnuity1995    
HeadOthRet1995     
HeadUnemp1995      
WifeUnemp1995      
HeadWorkman1995    
WifeWorkman1995    
HeadAlimony1995    
HeadChldSppt1995   
WifeChldSppt1995   
HeadRelHelp1995    
WifeRelHelp1995    
HeadNonRelHelp1995 
WifeNonRelHelp1995 
HeadSuppSec1995    
WifeSuppSec1995    
HeadOthWel1995     
WifeOthWel1995     
HeadOthIncome1995  
WifeOthIncome1995;
run;

data incomeplus1995;
set psiddata.income9401;

id1995                =             ER5002    ;
Faminc1995            =             FAMINC95  ;
HWtaxable1995         =             TXHW95    ;
HeadLabor1995         =             HDEARN95  ;
WifeLabor1995         =             WFEARN95  ;
HeadSalary1995        =             HDWG95    ;  
HWTrans1995           =             TRHW95    ;                                                                                                                                                                                                                    
OthTaxable1995        =             TXOFM95   ;                                                                                                                                                                                                                  
OthTrans1995          =             TROFM95   ;
FamSSI1995            =             SSEC95    ;
HeadFarm1995          =             FRMINC95  ;
TotalFarm1995         =             FRMINC95  ;        
FamBus1995            =             BUSINC95  ; 
HeadBusLabor1995      =             HDBUSY95  ;
HeadBusAsset1995      =             HDBUSK95  ;
WifeBusLabor1995      =             WFBUSY95  ;
WifeBusAsset1995      =             WFBUSK95  ;
HeadBonus1995         =             BNUS95    ;
HeadOvertime1995      =             OVTM95    ;
HeadTips1995          =             TIPS95    ;
HeadCommission1995    =             COMS95    ;
HeadProf1995          =             PROF95    ;
HeadMktGrdnLabor1995  =             MKTG95    ;                                                                                                                                                                                                        
HeadExtraJob1995      =             XTRA95    ;

keep id1995               
Faminc1995           
HWtaxable1995        
HeadLabor1995        
WifeLabor1995        
HeadSalary1995       
HWTrans1995          
OthTaxable1995       
OthTrans1995         
FamSSI1995           
HeadFarm1995         
TotalFarm1995
FamBus1995           
HeadBusLabor1995     
HeadBusAsset1995     
WifeBusLabor1995     
WifeBusAsset1995     
HeadBonus1995        
HeadOvertime1995     
HeadTips1995         
HeadCommission1995   
HeadProf1995         
HeadMktGrdnLabor1995 
HeadExtraJob1995     
;
if id1995 ne .;

proc sort data = incomeplus1995;
by id1995;
run;

data psiddata.income1995;
merge income1995fam incomeplus1995;
by id1995; 
run;
proc means data = psiddata.income1995; 
run;


