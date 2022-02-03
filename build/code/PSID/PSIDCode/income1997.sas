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

data income1997fam;
set psiddata.fam97;

id1997 = ER10002;
HeadExtraInclude1997 =  ER11210;          ***May need the indicator for estimation;

HeadRmmrlabor1997  = ER11195;    HeadRmmrlaborper1997 = ER11196;    ***Roomer and boarder income is not included in income plus data;                                                                                                                                                                                                          
HeadRent1997       = ER11213;         HeadRentper1997 = ER11214;    ******These detailed asset and transfer income are not  included in income plus data; 
HeadDividend1997   = ER11228;     HeadDividendper1997 = ER11229;      
HeadInterest1997   = ER11243;     HeadInterestper1997 = ER11244; 
HeadTrustFund1997  = ER11258;    HeadTrustFundper1997 = ER11259;                                                                                                                                                                                                              
WifeDividend1997   = ER11524;     WifeDividendper1997 = ER11525;
WifeInterest1997   = ER11539;     WifeInterestper1997 = ER11540;                                                                                                                                                                                                               
WifeTrustFund1997  = ER11554;    WifeTrustFundper1997 = ER11555;                                                                                                                                                                                                              
WifeOthAsset1997   = ER11569;     WifeOthAssetper1997 = ER11570;                                                                                                                                                                                                                                                                                                                                                                                                                                                           
HeadADC1997        = ER11273;          HeadADCper1997 = ER11274;                                                                                                                                                                                                        
WifeADC1997        = ER11600;          WifeADCper1997 = ER11601;                                                                                                                                                                                                        
HeadRetIncVet1997  = ER11322;    HeadRetIncVetper1997 = ER11323;                                                                                                
HeadRetIncNV1997   = ER11337;     HeadRetIncNVper1997 = ER11338;                                                                                                 
HeadAnnuity1997    = ER11352;      HeadAnnuityper1997 = ER11353;                                                                                                  
WifeAnnuity1997    = ER11645;      WifeAnnuityper1997 = ER11646;                                                                                                  
HeadOthRet1997     = ER11367;       HeadOthRetper1997 = ER11368;                                                                                                   
HeadUnemp1997      = ER11383;	     HeadUnempper1997 = ER11384;	                        
WifeUnemp1997      = ER11494;        WifeUnempper1997 = ER11495;                                                                                                    
HeadWorkman1997    = ER11398;      HeadWorkmanper1997 = ER11399;       	                                                                                           
WifeWorkman1997    = ER11509;      WifeWorkmanper1997 = ER11510;                                                                                                  
HeadAlimony1997    = ER11428;      HeadAlimonyper1997 = ER11429;                                                                                                  
HeadChldSppt1997   = ER11413;     HeadChldSpptper1997 = ER11414;                                                                                                 
WifeChldSppt1997   = ER11615;     WifeChldSpptper1997 = ER11616;                                                                                                 
HeadRelHelp1997    = ER11443;      HeadRelHelpper1997 = ER11444;                                                                                                  
WifeRelHelp1997    = ER11660;      WifeRelHelpper1997 = ER11661;                                                                                                  
HeadNonRelHelp1997 = ER11458;   HeadNonRelHelpper1997 = ER11459;                                                                                               
WifeNonRelHelp1997 = ER11675;   WifeNonRelHelpper1997 = ER11676;                                                                                               
HeadSuppSec1997    = ER11289;      HeadSuppSecper1997 = ER11290;                                                                                                  
WifeSuppSec1997    = ER11585;      WifeSuppSecper1997 = ER11586;                                                                                                  
HeadOthWel1997     = ER11304;       HeadOthWelper1997 = ER11305;                                                                                                   
WifeOthWel1997     = ER11630;       WifeOthWelper1997 = ER11631;                                                                                                   
HeadOthIncome1997  = ER11473;    HeadOthIncomeper1997 = ER11474;
WifeOthIncome1997  = ER11690;    WifeOthIncomeper1997 = ER11691; 

if    HeadRmmrlabor1997     ge     9999996.00    then      HeadRmmrlabor1997       =      .;    
if    HeadRent1997          ge      999996.00    then      HeadRent1997            =      .; 
if    HeadDividend1997      ge      999996.00    then      HeadDividend1997        =      .; 
if    HeadInterest1997      ge      999996.00    then      HeadInterest1997        =      .; 
if    HeadTrustFund1997     ge      999996.00    then      HeadTrustFund1997       =      .; 
if    WifeDividend1997      ge      999996.00    then      WifeDividend1997        =      .; 
if    WifeInterest1997      ge      999996.00    then      WifeInterest1997        =      .; 
if    WifeTrustFund1997     ge      999996.00    then      WifeTrustFund1997       =      .; 
if    WifeOthAsset1997      ge      999996.00    then      WifeOthAsset1997        =      .; 
if    HeadADC1997           ge      999996.00    then      HeadADC1997             =      .; 
if    WifeADC1997           ge       99996.00    then      WifeADC1997             =      .; 
if    HeadRetIncVet1997     ge       99996.00    then      HeadRetIncVet1997       =      .; 
if    HeadRetIncNV1997      ge      999996.00    then      HeadRetIncNV1997        =      .; 
if    HeadAnnuity1997       ge      999996.00    then      HeadAnnuity1997         =      .; 
if    WifeAnnuity1997       ge       99996.00    then      WifeAnnuity1997         =      .; 
if    HeadOthRet1997        ge      999996.00    then      HeadOthRet1997          =      .; 
if    HeadUnemp1997         ge       99996.00    then      HeadUnemp1997           =      .; 
if    WifeUnemp1997         ge       99996.00    then      WifeUnemp1997           =      .; 
if    HeadWorkman1997       ge       99996.00    then      HeadWorkman1997         =      .; 
if    WifeWorkman1997       ge       99996.00    then      WifeWorkman1997         =      .; 
if    HeadAlimony1997       ge       99996.00    then      HeadAlimony1997         =      .; 
if    HeadChldSppt1997      ge       99996.00    then      HeadChldSppt1997        =      .; 
if    WifeChldSppt1997      ge       99996.00    then      WifeChldSppt1997        =      .; 
if    HeadRelHelp1997       ge       99996.00    then      HeadRelHelp1997         =      .; 
if    WifeRelHelp1997       ge       99996.00    then      WifeRelHelp1997         =      .; 
if    HeadNonRelHelp1997    ge       99996.00    then      HeadNonRelHelp1997      =      .; 
if    WifeNonRelHelp1997    ge       99996.00    then      WifeNonRelHelp1997      =      .; 
if    HeadSuppSec1997       ge      999996.00    then      HeadSuppSec1997         =      .; 
if    WifeSuppSec1997       ge       99996.00    then      WifeSuppSec1997         =      .; 
if    HeadOthWel1997        ge      999996.00    then      HeadOthWel1997          =      .; 
if    WifeOthWel1997        ge       99996.00    then      WifeOthWel1997          =      .; 
if    HeadOthIncome1997     ge       99996.00    then      HeadOthIncome1997       =      .; 
if    WifeOthIncome1997     ge       99996.00    then      WifeOthIncome1997       =      .; 
                                                                                                                                                             
HeadRmmrlabor1997       = HeadRmmrlabor1997  * (52 * ( HeadRmmrlaborper1997 = 3) + 26 * ( HeadRmmrlaborper1997 = 4) +  12 * ( HeadRmmrlaborper1997 = 5) + ( HeadRmmrlaborper1997 = 6));
HeadRent1997            = HeadRent1997       * (52 * (      HeadRentper1997 = 3) + 26 * (      HeadRentper1997 = 4) +  12 * (      HeadRentper1997 = 5) + (      HeadRentper1997 = 6));
HeadDividend1997        = HeadDividend1997   * (52 * (  HeadDividendper1997 = 3) + 26 * (  HeadDividendper1997 = 4) +  12 * (  HeadDividendper1997 = 5) + (  HeadDividendper1997 = 6));
HeadInterest1997        = HeadInterest1997   * (52 * (  HeadInterestper1997 = 3) + 26 * (  HeadInterestper1997 = 4) +  12 * (  HeadInterestper1997 = 5) + (  HeadInterestper1997 = 6));
HeadTrustFund1997       = HeadTrustFund1997  * (52 * ( HeadTrustFundper1997 = 3) + 26 * ( HeadTrustFundper1997 = 4) +  12 * ( HeadTrustFundper1997 = 5) + ( HeadTrustFundper1997 = 6));
WifeOthAsset1997        = WifeOthAsset1997   * (52 * (  WifeOthAssetper1997 = 3) + 26 * (  WifeOthAssetper1997 = 4) +  12 * (  WifeOthAssetper1997 = 5) + (  WifeOthAssetper1997 = 6));
WifeDividend1997        = WifeDividend1997   * (52 * (  WifeDividendper1997 = 3) + 26 * (  WifeDividendper1997 = 4) +  12 * (  WifeDividendper1997 = 5) + (  WifeDividendper1997 = 6));
WifeInterest1997        = WifeInterest1997   * (52 * (  WifeInterestper1997 = 3) + 26 * (  WifeInterestper1997 = 4) +  12 * (  WifeInterestper1997 = 5) + (  WifeInterestper1997 = 6));
WifeTrustFund1997       = WifeTrustFund1997  * (52 * ( WifeTrustFundper1997 = 3) + 26 * ( WifeTrustFundper1997 = 4) +  12 * ( WifeTrustFundper1997 = 5) + ( WifeTrustFundper1997 = 6));
HeadADC1997             = HeadADC1997        * (52 * (       HeadADCper1997 = 3) + 26 * (       HeadADCper1997 = 4) +  12 * (       HeadADCper1997 = 5) + (       HeadADCper1997 = 6));
WifeADC1997             = WifeADC1997        * (52 * (       WifeADCper1997 = 3) + 26 * (       WifeADCper1997 = 4) +  12 * (       WifeADCper1997 = 5) + (       WifeADCper1997 = 6));
HeadRetIncVet1997       = HeadRetIncVet1997  * (52 * ( HeadRetIncVetper1997 = 3) + 26 * ( HeadRetIncVetper1997 = 4) +  12 * ( HeadRetIncVetper1997 = 5) + ( HeadRetIncVetper1997 = 6));
HeadRetIncNV1997        = HeadRetIncNV1997   * (52 * (  HeadRetIncNVper1997 = 3) + 26 * (  HeadRetIncNVper1997 = 4) +  12 * (  HeadRetIncNVper1997 = 5) + (  HeadRetIncNVper1997 = 6));
HeadSuppSec1997         = HeadSuppSec1997    * (52 * (   HeadSuppSecper1997 = 3) + 26 * (   HeadSuppSecper1997 = 4) +  12 * (   HeadSuppSecper1997 = 5) + (   HeadSuppSecper1997 = 6));
WifeSuppSec1997         = WifeSuppSec1997    * (52 * (   WifeSuppSecper1997 = 3) + 26 * (   WifeSuppSecper1997 = 4) +  12 * (   WifeSuppSecper1997 = 5) + (   WifeSuppSecper1997 = 6));
HeadOthWel1997          = HeadOthWel1997     * (52 * (    HeadOthWelper1997 = 3) + 26 * (    HeadOthWelper1997 = 4) +  12 * (    HeadOthWelper1997 = 5) + (    HeadOthWelper1997 = 6));
WifeOthWel1997          = WifeOthWel1997     * (52 * (    WifeOthWelper1997 = 3) + 26 * (    WifeOthWelper1997 = 4) +  12 * (    WifeOthWelper1997 = 5) + (    WifeOthWelper1997 = 6));
HeadAnnuity1997         = HeadAnnuity1997    * (52 * (   HeadAnnuityper1997 = 3) + 26 * (   HeadAnnuityper1997 = 4) +  12 * (   HeadAnnuityper1997 = 5) + (   HeadAnnuityper1997 = 6));
WifeAnnuity1997         = WifeAnnuity1997    * (52 * (   WifeAnnuityper1997 = 3) + 26 * (   WifeAnnuityper1997 = 4) +  12 * (   WifeAnnuityper1997 = 5) + (   WifeAnnuityper1997 = 6));
HeadOthRet1997          = HeadOthRet1997     * (52 * (    HeadOthRetper1997 = 3) + 26 * (    HeadOthRetper1997 = 4) +  12 * (    HeadOthRetper1997 = 5) + (    HeadOthRetper1997 = 6));
HeadUnemp1997           = HeadUnemp1997      * (52 * (     HeadUnempper1997 = 3) + 26 * (     HeadUnempper1997 = 4) +  12 * (     HeadUnempper1997 = 5) + (     HeadUnempper1997 = 6));
WifeUnemp1997           = WifeUnemp1997      * (52 * (     WifeUnempper1997 = 3) + 26 * (     WifeUnempper1997 = 4) +  12 * (     WifeUnempper1997 = 5) + (     WifeUnempper1997 = 6));
HeadWorkman1997         = HeadWorkman1997    * (52 * (   HeadWorkmanper1997 = 3) + 26 * (   HeadWorkmanper1997 = 4) +  12 * (   HeadWorkmanper1997 = 5) + (   HeadWorkmanper1997 = 6));
WifeWorkman1997         = WifeWorkman1997    * (52 * (   WifeWorkmanper1997 = 3) + 26 * (   WifeWorkmanper1997 = 4) +  12 * (   WifeWorkmanper1997 = 5) + (   WifeWorkmanper1997 = 6));
HeadAlimony1997         = HeadAlimony1997    * (52 * (   HeadAlimonyper1997 = 3) + 26 * (   HeadAlimonyper1997 = 4) +  12 * (   HeadAlimonyper1997 = 5) + (   HeadAlimonyper1997 = 6));
HeadChldSppt1997        = HeadChldSppt1997   * (52 * (  HeadChldSpptper1997 = 3) + 26 * (  HeadChldSpptper1997 = 4) +  12 * (  HeadChldSpptper1997 = 5) + (  HeadChldSpptper1997 = 6));
WifeChldSppt1997        = WifeChldSppt1997   * (52 * (  WifeChldSpptper1997 = 3) + 26 * (  WifeChldSpptper1997 = 4) +  12 * (  WifeChldSpptper1997 = 5) + (  WifeChldSpptper1997 = 6));
HeadRelHelp1997         = HeadRelHelp1997    * (52 * (   HeadRelHelpper1997 = 3) + 26 * (   HeadRelHelpper1997 = 4) +  12 * (   HeadRelHelpper1997 = 5) + (   HeadRelHelpper1997 = 6));
WifeRelHelp1997         = WifeRelHelp1997    * (52 * (   WifeRelHelpper1997 = 3) + 26 * (   WifeRelHelpper1997 = 4) +  12 * (   WifeRelHelpper1997 = 5) + (   WifeRelHelpper1997 = 6));
HeadNonRelHelp1997      = HeadNonRelHelp1997 * (52 * (HeadNonRelHelpper1997 = 3) + 26 * (HeadNonRelHelpper1997 = 4) +  12 * (HeadNonRelHelpper1997 = 5) + (HeadNonRelHelpper1997 = 6));
WifeNonRelHelp1997      = WifeNonRelHelp1997 * (52 * (WifeNonRelHelpper1997 = 3) + 26 * (WifeNonRelHelpper1997 = 4) +  12 * (WifeNonRelHelpper1997 = 5) + (WifeNonRelHelpper1997 = 6));
HeadOthIncome1997       = HeadOthIncome1997  * (52 * ( HeadOthIncomeper1997 = 3) + 26 * ( HeadOthIncomeper1997 = 4) +  12 * ( HeadOthIncomeper1997 = 5) + ( HeadOthIncomeper1997 = 6));
WifeOthIncome1997       = WifeOthIncome1997  * (52 * ( WifeOthIncomeper1997 = 3) + 26 * ( WifeOthIncomeper1997 = 4) +  12 * ( WifeOthIncomeper1997 = 5) + ( WifeOthIncomeper1997 = 6));

if  HeadRmmrlaborper1997 = 1 or  HeadRmmrlaborper1997 = 2 or  HeadRmmrlaborper1997 ge 7 then  HeadRmmrlabor1997 = .;  
if       HeadRentper1997 = 1 or       HeadRentper1997 = 2 or       HeadRentper1997 ge 7 then       HeadRent1997 = .;  
if   HeadDividendper1997 = 1 or   HeadDividendper1997 = 2 or   HeadDividendper1997 ge 7 then   HeadDividend1997 = .;  
if   HeadInterestper1997 = 1 or   HeadInterestper1997 = 2 or   HeadInterestper1997 ge 7 then   HeadInterest1997 = .;  
if  HeadTrustFundper1997 = 1 or  HeadTrustFundper1997 = 2 or  HeadTrustFundper1997 ge 7 then  HeadTrustFund1997 = .;  
if   WifeOthAssetper1997 = 1 or   WifeOthAssetper1997 = 2 or   WifeOthAssetper1997 ge 7 then   WifeOthAsset1997 = .;  
if   WifeDividendper1997 = 1 or   WifeDividendper1997 = 2 or   WifeDividendper1997 ge 7 then   WifeDividend1997 = .;  
if   WifeInterestper1997 = 1 or   WifeInterestper1997 = 2 or   WifeInterestper1997 ge 7 then   WifeInterest1997 = .;  
if  WifeTrustFundper1997 = 1 or  WifeTrustFundper1997 = 2 or  WifeTrustFundper1997 ge 7 then  WifeTrustFund1997 = .;  
if        HeadADCper1997 = 1 or        HeadADCper1997 = 2 or        HeadADCper1997 ge 7 then        HeadADC1997 = .;  
if        WifeADCper1997 = 1 or        WifeADCper1997 = 2 or        WifeADCper1997 ge 7 then        WifeADC1997 = .;  
if  HeadRetIncVetper1997 = 1 or  HeadRetIncVetper1997 = 2 or  HeadRetIncVetper1997 ge 7 then  HeadRetIncVet1997 = .;  
if   HeadRetIncNVper1997 = 1 or   HeadRetIncNVper1997 = 2 or   HeadRetIncNVper1997 ge 7 then   HeadRetIncNV1997 = .;  
if    HeadSuppSecper1997 = 1 or    HeadSuppSecper1997 = 2 or    HeadSuppSecper1997 ge 7 then    HeadSuppSec1997 = .;  
if    WifeSuppSecper1997 = 1 or    WifeSuppSecper1997 = 2 or    WifeSuppSecper1997 ge 7 then    WifeSuppSec1997 = .;  
if     HeadOthWelper1997 = 1 or     HeadOthWelper1997 = 2 or     HeadOthWelper1997 ge 7 then     HeadOthWel1997 = .;  
if     WifeOthWelper1997 = 1 or     WifeOthWelper1997 = 2 or     WifeOthWelper1997 ge 7 then     WifeOthWel1997 = .;  
if    HeadAnnuityper1997 = 1 or    HeadAnnuityper1997 = 2 or    HeadAnnuityper1997 ge 7 then    HeadAnnuity1997 = .;  
if    WifeAnnuityper1997 = 1 or    WifeAnnuityper1997 = 2 or    WifeAnnuityper1997 ge 7 then    WifeAnnuity1997 = .;  
if     HeadOthRetper1997 = 1 or     HeadOthRetper1997 = 2 or     HeadOthRetper1997 ge 7 then     HeadOthRet1997 = .;  
if      HeadUnempper1997 = 1 or      HeadUnempper1997 = 2 or      HeadUnempper1997 ge 7 then      HeadUnemp1997 = .;  
if      WifeUnempper1997 = 1 or      WifeUnempper1997 = 2 or      WifeUnempper1997 ge 7 then      WifeUnemp1997 = .;  
if    HeadWorkmanper1997 = 1 or    HeadWorkmanper1997 = 2 or    HeadWorkmanper1997 ge 7 then    HeadWorkman1997 = .;  
if    WifeWorkmanper1997 = 1 or    WifeWorkmanper1997 = 2 or    WifeWorkmanper1997 ge 7 then    WifeWorkman1997 = .;  
if    HeadAlimonyper1997 = 1 or    HeadAlimonyper1997 = 2 or    HeadAlimonyper1997 ge 7 then    HeadAlimony1997 = .;  
if   HeadChldSpptper1997 = 1 or   HeadChldSpptper1997 = 2 or   HeadChldSpptper1997 ge 7 then   HeadChldSppt1997 = .;  
if   WifeChldSpptper1997 = 1 or   WifeChldSpptper1997 = 2 or   WifeChldSpptper1997 ge 7 then   WifeChldSppt1997 = .;  
if    HeadRelHelpper1997 = 1 or    HeadRelHelpper1997 = 2 or    HeadRelHelpper1997 ge 7 then    HeadRelHelp1997 = .;  
if    WifeRelHelpper1997 = 1 or    WifeRelHelpper1997 = 2 or    WifeRelHelpper1997 ge 7 then    WifeRelHelp1997 = .;  
if HeadNonRelHelpper1997 = 1 or HeadNonRelHelpper1997 = 2 or HeadNonRelHelpper1997 ge 7 then HeadNonRelHelp1997 = .;  
if WifeNonRelHelpper1997 = 1 or WifeNonRelHelpper1997 = 2 or WifeNonRelHelpper1997 ge 7 then WifeNonRelHelp1997 = .;  
if  HeadOthIncomeper1997 = 1 or  HeadOthIncomeper1997 = 2 or  HeadOthIncomeper1997 ge 7 then  HeadOthIncome1997 = .;  
if  WifeOthIncomeper1997 = 1 or  WifeOthIncomeper1997 = 2 or  WifeOthIncomeper1997 ge 7 then  WifeOthIncome1997 = .;  

if  HeadRmmrlaborper1997 = 0 then  HeadRmmrlabor1997 = 0;                                                                                                                                                                                                    
if       HeadRentper1997 = 0 then       HeadRent1997 = 0;                                                                                                                                                                                                    
if   HeadDividendper1997 = 0 then   HeadDividend1997 = 0;                                                                                                                                                                                                    
if   HeadInterestper1997 = 0 then   HeadInterest1997 = 0;                                                                                                                                                                                                    
if  HeadTrustFundper1997 = 0 then  HeadTrustFund1997 = 0;                                                                                                                                                                                                    
if   WifeOthAssetper1997 = 0 then   WifeOthAsset1997 = 0;                                                                                                                                                                                                    
if   WifeDividendper1997 = 0 then   WifeDividend1997 = 0;                                                                                                                                                                                                    
if   WifeInterestper1997 = 0 then   WifeInterest1997 = 0;                                                                                                                                                                                                    
if  WifeTrustFundper1997 = 0 then  WifeTrustFund1997 = 0;                                                                                                                                                                                                    
if        HeadADCper1997 = 0 then        HeadADC1997 = 0;                                                                                                                                                                                                    
if        WifeADCper1997 = 0 then        WifeADC1997 = 0;                                                                                                                                                                                                    
if  HeadRetIncVetper1997 = 0 then  HeadRetIncVet1997 = 0;                                                                                                                                                                                                    
if   HeadRetIncNVper1997 = 0 then   HeadRetIncNV1997 = 0;                                                                                                                                                                                                    
if    HeadSuppSecper1997 = 0 then    HeadSuppSec1997 = 0;                                                                                                                                                                                                    
if    WifeSuppSecper1997 = 0 then    WifeSuppSec1997 = 0;                                                                                                                                                                                                    
if     HeadOthWelper1997 = 0 then     HeadOthWel1997 = 0;                                                                                                                                                                                                    
if     WifeOthWelper1997 = 0 then     WifeOthWel1997 = 0;                                                                                                                                                                                                    
if    HeadAnnuityper1997 = 0 then    HeadAnnuity1997 = 0;                                                                                                                                                                                                    
if    WifeAnnuityper1997 = 0 then    WifeAnnuity1997 = 0;                                                                                                                                                                                                    
if     HeadOthRetper1997 = 0 then     HeadOthRet1997 = 0;                                                                                                                                                                                                    
if      HeadUnempper1997 = 0 then      HeadUnemp1997 = 0;                                                                                                                                                                                                    
if      WifeUnempper1997 = 0 then      WifeUnemp1997 = 0;                                                                                                                                                                                                    
if    HeadWorkmanper1997 = 0 then    HeadWorkman1997 = 0;                                                                                                                                                                                                    
if    WifeWorkmanper1997 = 0 then    WifeWorkman1997 = 0;                                                                                                                                                                                                    
if    HeadAlimonyper1997 = 0 then    HeadAlimony1997 = 0;                                                                                                                                                                                                    
if   HeadChldSpptper1997 = 0 then   HeadChldSppt1997 = 0;                                                                                                                                                                                                    
if   WifeChldSpptper1997 = 0 then   WifeChldSppt1997 = 0;                                                                                                                                                                                                    
if    HeadRelHelpper1997 = 0 then    HeadRelHelp1997 = 0;                                                                                                                                                                                                    
if    WifeRelHelpper1997 = 0 then    WifeRelHelp1997 = 0;                                                                                                                                                                                                    
if HeadNonRelHelpper1997 = 0 then HeadNonRelHelp1997 = 0;                                                                                                                                                                                                    
if WifeNonRelHelpper1997 = 0 then WifeNonRelHelp1997 = 0;                                                                                                                                                                                                    
if  HeadOthIncomeper1997 = 0 then  HeadOthIncome1997 = 0;                                                                                                                                                                                                    
if  WifeOthIncomeper1997 = 0 then  WifeOthIncome1997 = 0;                                                                                                                                                                                                    

keep id1997 HeadExtraInclude1997
HeadRmmrlabor1997  
HeadRent1997       
HeadDividend1997   
HeadInterest1997   
HeadTrustFund1997  
WifeDividend1997   
WifeInterest1997   
WifeTrustFund1997  
WifeOthAsset1997   
HeadADC1997        
WifeADC1997        
HeadRetIncVet1997  
HeadRetIncNV1997   
HeadAnnuity1997    
WifeAnnuity1997    
HeadOthRet1997     
HeadUnemp1997      
WifeUnemp1997      
HeadWorkman1997    
WifeWorkman1997    
HeadAlimony1997    
HeadChldSppt1997   
WifeChldSppt1997   
HeadRelHelp1997    
WifeRelHelp1997    
HeadNonRelHelp1997 
WifeNonRelHelp1997 
HeadSuppSec1997    
WifeSuppSec1997    
HeadOthWel1997     
WifeOthWel1997     
HeadOthIncome1997  
WifeOthIncome1997; 
run;


data incomeplus1997;
set psiddata.income9401;

id1997                =             ER10002    ;
Faminc1997            =             FAMINC97  ;
HWtaxable1997         =             TXHW97    ;
HeadLabor1997         =             HDEARN97  ;
WifeLabor1997         =             WFEARN97  ;
HeadSalary1997        =             HDWG97    ;  
HWTrans1997           =             TRHW97    ;                                                                                                                                                                                                                    
OthTaxable1997        =             TXOFM97   ;                                                                                                                                                                                                                  
OthTrans1997          =             TROFM97   ;
FamSSI1997            =             SSEC97    ;
HeadFarm1997          =             FRMINC97  ;
TotalFarm1997         =             FRMINC97  ;        
FamBus1997            =             BUSINC97  ; 
HeadBusLabor1997      =             HDBUSY97  ;
HeadBusAsset1997      =             HDBUSK97  ;
WifeBusLabor1997      =             WFBUSY97  ;
WifeBusAsset1997      =             WFBUSK97  ;
HeadBonus1997         =             BNUS97    ;
HeadOvertime1997      =             OVTM97    ;
HeadTips1997          =             TIPS97    ;
HeadCommission1997    =             COMS97    ;
HeadProf1997          =             PROF97    ;
HeadMktGrdnLabor1997  =             MKTG97    ;                                                                                                                                                                                                        
HeadExtraJob1997      =             XTRA97    ;

keep id1997                
Faminc1997            
HWtaxable1997         
HeadLabor1997         
WifeLabor1997         
HeadSalary1997        
HWTrans1997           
OthTaxable1997        
OthTrans1997          
FamSSI1997            
HeadFarm1997          
TotalFarm1997
FamBus1997            
HeadBusLabor1997      
HeadBusAsset1997      
WifeBusLabor1997      
WifeBusAsset1997      
HeadBonus1997         
HeadOvertime1997      
HeadTips1997          
HeadCommission1997    
HeadProf1997          
HeadMktGrdnLabor1997  
HeadExtraJob1997      ;

if id1997 ne .;

proc sort data = incomeplus1997;
by id1997;
run;

data psiddata.income1997;
merge income1997fam incomeplus1997;
by id1997; run;
proc means data = psiddata.income1997;
run;

