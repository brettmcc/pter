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

data income2001fam;
set psiddata.fam01;

id2001 = ER17002;
HeadExtraInclude2001 =  ER18630;          ***May need the indicator for estimation;

HeadRmmrlabor2001  = ER18614;    HeadRmmrlaborper2001 = ER18615;    ***Roomer and boarder income is not included in income plus data;                                                                                                                                                                                                          
HeadRent2001       = ER18634;         HeadRentper2001 = ER18635;    ******These detailed asset and transfer income are not  included in income plus data; 
HeadDividend2001   = ER18650;     HeadDividendper2001 = ER18651;      
HeadInterest2001   = ER18666;     HeadInterestper2001 = ER18667; 
HeadTrustFund2001  = ER18682;    HeadTrustFundper2001 = ER18683;                                                                                                                                                                                                              
WifeDividend2001   = ER18966;     WifeDividendper2001 = ER18967;
WifeInterest2001   = ER18982;     WifeInterestper2001 = ER18983;                                                                                                                                                                                                               
WifeTrustFund2001  = ER18998;    WifeTrustFundper2001 = ER18999;                                                                                                                                                                                                              
WifeOthAsset2001   = ER19014;     WifeOthAssetper2001 = ER19015;                                                                                                                                                                                                                                                                                                                                                                                                                                                           
HeadADC2001        = ER18698;          HeadADCper2001 = ER18699;                                                                                                                                                                                                        
WifeADC2001        = ER19047;          WifeADCper2001 = ER19048;                                                                                                                                                                                                        
HeadRetIncVet2001  = ER18750;    HeadRetIncVetper2001 = ER18751;                                                                                                
HeadRetIncNV2001   = ER18766;     HeadRetIncNVper2001 = ER18767;                                                                                                 
HeadAnnuity2001    = ER18782;      HeadAnnuityper2001 = ER18783;                                                                                                  
WifeAnnuity2001    = ER19095;      WifeAnnuityper2001 = ER19096;                                                                                                  
HeadOthRet2001     = ER18798;       HeadOthRetper2001 = ER18799;                                                                                                   
HeadUnemp2001      = ER18815;	     HeadUnempper2001 = ER18816;	                        
WifeUnemp2001      = ER18934;        WifeUnempper2001 = ER18935;                                                                                                    
HeadWorkman2001    = ER18831;      HeadWorkmanper2001 = ER18832;       	                                                                                           
WifeWorkman2001    = ER18950;      WifeWorkmanper2001 = ER18951;                                                                                                  
HeadAlimony2001    = ER18863;      HeadAlimonyper2001 = ER18864;                                                                                                  
HeadChldSppt2001   = ER18847;     HeadChldSpptper2001 = ER18848;                                                                                                 
WifeChldSppt2001   = ER19063;     WifeChldSpptper2001 = ER19064;                                                                                                 
HeadRelHelp2001    = ER18879;      HeadRelHelpper2001 = ER18880;                                                                                                  
WifeRelHelp2001    = ER19111;      WifeRelHelpper2001 = ER19112;                                                                                                  
HeadNonRelHelp2001 = ER18895;   HeadNonRelHelpper2001 = ER18896;                                                                                               
WifeNonRelHelp2001 = ER19127;   WifeNonRelHelpper2001 = ER19128;                                                                                               
HeadSuppSec2001    = ER18715;      HeadSuppSecper2001 = ER18716;                                                                                                  
WifeSuppSec2001    = ER19031;      WifeSuppSecper2001 = ER19032;                                                                                                  
HeadOthWel2001     = ER18731;       HeadOthWelper2001 = ER18732;                                                                                                   
WifeOthWel2001     = ER19079;       WifeOthWelper2001 = ER19080;                                                                                                   
HeadOthIncome2001  = ER18911;    HeadOthIncomeper2001 = ER18912;
WifeOthIncome2001  = ER19143;    WifeOthIncomeper2001 = ER19144; 

if    HeadRmmrlabor2001     ge     9999996.00    then      HeadRmmrlabor2001       =      .;      
if    HeadRent2001          ge      999996.00    then      HeadRent2001            =      .;      
if    HeadDividend2001      ge      999996.00    then      HeadDividend2001        =      .;      
if    HeadInterest2001      ge      999996.00    then      HeadInterest2001        =      .;      
if    HeadTrustFund2001     ge      999996.00    then      HeadTrustFund2001       =      .;      
if    WifeDividend2001      ge      999996.00    then      WifeDividend2001        =      .;      
if    WifeInterest2001      ge      999996.00    then      WifeInterest2001        =      .;      
if    WifeTrustFund2001     ge      999996.00    then      WifeTrustFund2001       =      .;      
if    WifeOthAsset2001      ge      999996.00    then      WifeOthAsset2001        =      .;      
if    HeadADC2001           ge      999996.00    then      HeadADC2001             =      .;      
if    WifeADC2001           ge       99996.00    then      WifeADC2001             =      .;      
if    HeadRetIncVet2001     ge       99996.00    then      HeadRetIncVet2001       =      .;      
if    HeadRetIncNV2001      ge      999996.00    then      HeadRetIncNV2001        =      .;      
if    HeadAnnuity2001       ge      999996.00    then      HeadAnnuity2001         =      .;      
if    WifeAnnuity2001       ge       99996.00    then      WifeAnnuity2001         =      .;      
if    HeadOthRet2001        ge      999996.00    then      HeadOthRet2001          =      .;      
if    HeadUnemp2001         ge       99996.00    then      HeadUnemp2001           =      .;      
if    WifeUnemp2001         ge       99996.00    then      WifeUnemp2001           =      .;      
if    HeadWorkman2001       ge       99996.00    then      HeadWorkman2001         =      .;      
if    WifeWorkman2001       ge       99996.00    then      WifeWorkman2001         =      .;      
if    HeadAlimony2001       ge       99996.00    then      HeadAlimony2001         =      .;      
if    HeadChldSppt2001      ge       99996.00    then      HeadChldSppt2001        =      .;      
if    WifeChldSppt2001      ge       99996.00    then      WifeChldSppt2001        =      .;      
if    HeadRelHelp2001       ge       99996.00    then      HeadRelHelp2001         =      .;      
if    WifeRelHelp2001       ge       99996.00    then      WifeRelHelp2001         =      .;      
if    HeadNonRelHelp2001    ge       99996.00    then      HeadNonRelHelp2001      =      .;      
if    WifeNonRelHelp2001    ge       99996.00    then      WifeNonRelHelp2001      =      .;      
if    HeadSuppSec2001       ge      999996.00    then      HeadSuppSec2001         =      .;      
if    WifeSuppSec2001       ge       99996.00    then      WifeSuppSec2001         =      .;      
if    HeadOthWel2001        ge      999996.00    then      HeadOthWel2001          =      .;      
if    WifeOthWel2001        ge       99996.00    then      WifeOthWel2001          =      .;      
if    HeadOthIncome2001     ge       99996.00    then      HeadOthIncome2001       =      .;      
if    WifeOthIncome2001     ge       99996.00    then      WifeOthIncome2001       =      .;      

HeadRmmrlabor2001       = HeadRmmrlabor2001  * (52 * ( HeadRmmrlaborper2001 = 3) + 26 * ( HeadRmmrlaborper2001 = 4) +  12 * ( HeadRmmrlaborper2001 = 5) + ( HeadRmmrlaborper2001 = 6));
HeadRent2001            = HeadRent2001       * (52 * (      HeadRentper2001 = 3) + 26 * (      HeadRentper2001 = 4) +  12 * (      HeadRentper2001 = 5) + (      HeadRentper2001 = 6));
HeadDividend2001        = HeadDividend2001   * (52 * (  HeadDividendper2001 = 3) + 26 * (  HeadDividendper2001 = 4) +  12 * (  HeadDividendper2001 = 5) + (  HeadDividendper2001 = 6));
HeadInterest2001        = HeadInterest2001   * (52 * (  HeadInterestper2001 = 3) + 26 * (  HeadInterestper2001 = 4) +  12 * (  HeadInterestper2001 = 5) + (  HeadInterestper2001 = 6));
HeadTrustFund2001       = HeadTrustFund2001  * (52 * ( HeadTrustFundper2001 = 3) + 26 * ( HeadTrustFundper2001 = 4) +  12 * ( HeadTrustFundper2001 = 5) + ( HeadTrustFundper2001 = 6));
WifeOthAsset2001        = WifeOthAsset2001   * (52 * (  WifeOthAssetper2001 = 3) + 26 * (  WifeOthAssetper2001 = 4) +  12 * (  WifeOthAssetper2001 = 5) + (  WifeOthAssetper2001 = 6));
WifeDividend2001        = WifeDividend2001   * (52 * (  WifeDividendper2001 = 3) + 26 * (  WifeDividendper2001 = 4) +  12 * (  WifeDividendper2001 = 5) + (  WifeDividendper2001 = 6));
WifeInterest2001        = WifeInterest2001   * (52 * (  WifeInterestper2001 = 3) + 26 * (  WifeInterestper2001 = 4) +  12 * (  WifeInterestper2001 = 5) + (  WifeInterestper2001 = 6));
WifeTrustFund2001       = WifeTrustFund2001  * (52 * ( WifeTrustFundper2001 = 3) + 26 * ( WifeTrustFundper2001 = 4) +  12 * ( WifeTrustFundper2001 = 5) + ( WifeTrustFundper2001 = 6));
HeadADC2001             = HeadADC2001        * (52 * (       HeadADCper2001 = 3) + 26 * (       HeadADCper2001 = 4) +  12 * (       HeadADCper2001 = 5) + (       HeadADCper2001 = 6));
WifeADC2001             = WifeADC2001        * (52 * (       WifeADCper2001 = 3) + 26 * (       WifeADCper2001 = 4) +  12 * (       WifeADCper2001 = 5) + (       WifeADCper2001 = 6));
HeadRetIncVet2001       = HeadRetIncVet2001  * (52 * ( HeadRetIncVetper2001 = 3) + 26 * ( HeadRetIncVetper2001 = 4) +  12 * ( HeadRetIncVetper2001 = 5) + ( HeadRetIncVetper2001 = 6));
HeadRetIncNV2001        = HeadRetIncNV2001   * (52 * (  HeadRetIncNVper2001 = 3) + 26 * (  HeadRetIncNVper2001 = 4) +  12 * (  HeadRetIncNVper2001 = 5) + (  HeadRetIncNVper2001 = 6));
HeadSuppSec2001         = HeadSuppSec2001    * (52 * (   HeadSuppSecper2001 = 3) + 26 * (   HeadSuppSecper2001 = 4) +  12 * (   HeadSuppSecper2001 = 5) + (   HeadSuppSecper2001 = 6));
WifeSuppSec2001         = WifeSuppSec2001    * (52 * (   WifeSuppSecper2001 = 3) + 26 * (   WifeSuppSecper2001 = 4) +  12 * (   WifeSuppSecper2001 = 5) + (   WifeSuppSecper2001 = 6));
HeadOthWel2001          = HeadOthWel2001     * (52 * (    HeadOthWelper2001 = 3) + 26 * (    HeadOthWelper2001 = 4) +  12 * (    HeadOthWelper2001 = 5) + (    HeadOthWelper2001 = 6));
WifeOthWel2001          = WifeOthWel2001     * (52 * (    WifeOthWelper2001 = 3) + 26 * (    WifeOthWelper2001 = 4) +  12 * (    WifeOthWelper2001 = 5) + (    WifeOthWelper2001 = 6));
HeadAnnuity2001         = HeadAnnuity2001    * (52 * (   HeadAnnuityper2001 = 3) + 26 * (   HeadAnnuityper2001 = 4) +  12 * (   HeadAnnuityper2001 = 5) + (   HeadAnnuityper2001 = 6));
WifeAnnuity2001         = WifeAnnuity2001    * (52 * (   WifeAnnuityper2001 = 3) + 26 * (   WifeAnnuityper2001 = 4) +  12 * (   WifeAnnuityper2001 = 5) + (   WifeAnnuityper2001 = 6));
HeadOthRet2001          = HeadOthRet2001     * (52 * (    HeadOthRetper2001 = 3) + 26 * (    HeadOthRetper2001 = 4) +  12 * (    HeadOthRetper2001 = 5) + (    HeadOthRetper2001 = 6));
HeadUnemp2001           = HeadUnemp2001      * (52 * (     HeadUnempper2001 = 3) + 26 * (     HeadUnempper2001 = 4) +  12 * (     HeadUnempper2001 = 5) + (     HeadUnempper2001 = 6));
WifeUnemp2001           = WifeUnemp2001      * (52 * (     WifeUnempper2001 = 3) + 26 * (     WifeUnempper2001 = 4) +  12 * (     WifeUnempper2001 = 5) + (     WifeUnempper2001 = 6));
HeadWorkman2001         = HeadWorkman2001    * (52 * (   HeadWorkmanper2001 = 3) + 26 * (   HeadWorkmanper2001 = 4) +  12 * (   HeadWorkmanper2001 = 5) + (   HeadWorkmanper2001 = 6));
WifeWorkman2001         = WifeWorkman2001    * (52 * (   WifeWorkmanper2001 = 3) + 26 * (   WifeWorkmanper2001 = 4) +  12 * (   WifeWorkmanper2001 = 5) + (   WifeWorkmanper2001 = 6));
HeadAlimony2001         = HeadAlimony2001    * (52 * (   HeadAlimonyper2001 = 3) + 26 * (   HeadAlimonyper2001 = 4) +  12 * (   HeadAlimonyper2001 = 5) + (   HeadAlimonyper2001 = 6));
HeadChldSppt2001        = HeadChldSppt2001   * (52 * (  HeadChldSpptper2001 = 3) + 26 * (  HeadChldSpptper2001 = 4) +  12 * (  HeadChldSpptper2001 = 5) + (  HeadChldSpptper2001 = 6));
WifeChldSppt2001        = WifeChldSppt2001   * (52 * (  WifeChldSpptper2001 = 3) + 26 * (  WifeChldSpptper2001 = 4) +  12 * (  WifeChldSpptper2001 = 5) + (  WifeChldSpptper2001 = 6));
HeadRelHelp2001         = HeadRelHelp2001    * (52 * (   HeadRelHelpper2001 = 3) + 26 * (   HeadRelHelpper2001 = 4) +  12 * (   HeadRelHelpper2001 = 5) + (   HeadRelHelpper2001 = 6));
WifeRelHelp2001         = WifeRelHelp2001    * (52 * (   WifeRelHelpper2001 = 3) + 26 * (   WifeRelHelpper2001 = 4) +  12 * (   WifeRelHelpper2001 = 5) + (   WifeRelHelpper2001 = 6));
HeadNonRelHelp2001      = HeadNonRelHelp2001 * (52 * (HeadNonRelHelpper2001 = 3) + 26 * (HeadNonRelHelpper2001 = 4) +  12 * (HeadNonRelHelpper2001 = 5) + (HeadNonRelHelpper2001 = 6));
WifeNonRelHelp2001      = WifeNonRelHelp2001 * (52 * (WifeNonRelHelpper2001 = 3) + 26 * (WifeNonRelHelpper2001 = 4) +  12 * (WifeNonRelHelpper2001 = 5) + (WifeNonRelHelpper2001 = 6));
HeadOthIncome2001       = HeadOthIncome2001  * (52 * ( HeadOthIncomeper2001 = 3) + 26 * ( HeadOthIncomeper2001 = 4) +  12 * ( HeadOthIncomeper2001 = 5) + ( HeadOthIncomeper2001 = 6));
WifeOthIncome2001       = WifeOthIncome2001  * (52 * ( WifeOthIncomeper2001 = 3) + 26 * ( WifeOthIncomeper2001 = 4) +  12 * ( WifeOthIncomeper2001 = 5) + ( WifeOthIncomeper2001 = 6));

if  HeadRmmrlaborper2001 = 1 or  HeadRmmrlaborper2001 = 2 or  HeadRmmrlaborper2001 ge 7 then  HeadRmmrlabor2001 = .;  
if       HeadRentper2001 = 1 or       HeadRentper2001 = 2 or       HeadRentper2001 ge 7 then       HeadRent2001 = .;  
if   HeadDividendper2001 = 1 or   HeadDividendper2001 = 2 or   HeadDividendper2001 ge 7 then   HeadDividend2001 = .;  
if   HeadInterestper2001 = 1 or   HeadInterestper2001 = 2 or   HeadInterestper2001 ge 7 then   HeadInterest2001 = .;  
if  HeadTrustFundper2001 = 1 or  HeadTrustFundper2001 = 2 or  HeadTrustFundper2001 ge 7 then  HeadTrustFund2001 = .;  
if   WifeOthAssetper2001 = 1 or   WifeOthAssetper2001 = 2 or   WifeOthAssetper2001 ge 7 then   WifeOthAsset2001 = .;  
if   WifeDividendper2001 = 1 or   WifeDividendper2001 = 2 or   WifeDividendper2001 ge 7 then   WifeDividend2001 = .;  
if   WifeInterestper2001 = 1 or   WifeInterestper2001 = 2 or   WifeInterestper2001 ge 7 then   WifeInterest2001 = .;  
if  WifeTrustFundper2001 = 1 or  WifeTrustFundper2001 = 2 or  WifeTrustFundper2001 ge 7 then  WifeTrustFund2001 = .;  
if        HeadADCper2001 = 1 or        HeadADCper2001 = 2 or        HeadADCper2001 ge 7 then        HeadADC2001 = .;  
if        WifeADCper2001 = 1 or        WifeADCper2001 = 2 or        WifeADCper2001 ge 7 then        WifeADC2001 = .;  
if  HeadRetIncVetper2001 = 1 or  HeadRetIncVetper2001 = 2 or  HeadRetIncVetper2001 ge 7 then  HeadRetIncVet2001 = .;  
if   HeadRetIncNVper2001 = 1 or   HeadRetIncNVper2001 = 2 or   HeadRetIncNVper2001 ge 7 then   HeadRetIncNV2001 = .;  
if    HeadSuppSecper2001 = 1 or    HeadSuppSecper2001 = 2 or    HeadSuppSecper2001 ge 7 then    HeadSuppSec2001 = .;  
if    WifeSuppSecper2001 = 1 or    WifeSuppSecper2001 = 2 or    WifeSuppSecper2001 ge 7 then    WifeSuppSec2001 = .;  
if     HeadOthWelper2001 = 1 or     HeadOthWelper2001 = 2 or     HeadOthWelper2001 ge 7 then     HeadOthWel2001 = .;  
if     WifeOthWelper2001 = 1 or     WifeOthWelper2001 = 2 or     WifeOthWelper2001 ge 7 then     WifeOthWel2001 = .;  
if    HeadAnnuityper2001 = 1 or    HeadAnnuityper2001 = 2 or    HeadAnnuityper2001 ge 7 then    HeadAnnuity2001 = .;  
if    WifeAnnuityper2001 = 1 or    WifeAnnuityper2001 = 2 or    WifeAnnuityper2001 ge 7 then    WifeAnnuity2001 = .;  
if     HeadOthRetper2001 = 1 or     HeadOthRetper2001 = 2 or     HeadOthRetper2001 ge 7 then     HeadOthRet2001 = .;  
if      HeadUnempper2001 = 1 or      HeadUnempper2001 = 2 or      HeadUnempper2001 ge 7 then      HeadUnemp2001 = .;  
if      WifeUnempper2001 = 1 or      WifeUnempper2001 = 2 or      WifeUnempper2001 ge 7 then      WifeUnemp2001 = .;  
if    HeadWorkmanper2001 = 1 or    HeadWorkmanper2001 = 2 or    HeadWorkmanper2001 ge 7 then    HeadWorkman2001 = .;  
if    WifeWorkmanper2001 = 1 or    WifeWorkmanper2001 = 2 or    WifeWorkmanper2001 ge 7 then    WifeWorkman2001 = .;  
if    HeadAlimonyper2001 = 1 or    HeadAlimonyper2001 = 2 or    HeadAlimonyper2001 ge 7 then    HeadAlimony2001 = .;  
if   HeadChldSpptper2001 = 1 or   HeadChldSpptper2001 = 2 or   HeadChldSpptper2001 ge 7 then   HeadChldSppt2001 = .;  
if   WifeChldSpptper2001 = 1 or   WifeChldSpptper2001 = 2 or   WifeChldSpptper2001 ge 7 then   WifeChldSppt2001 = .;  
if    HeadRelHelpper2001 = 1 or    HeadRelHelpper2001 = 2 or    HeadRelHelpper2001 ge 7 then    HeadRelHelp2001 = .;  
if    WifeRelHelpper2001 = 1 or    WifeRelHelpper2001 = 2 or    WifeRelHelpper2001 ge 7 then    WifeRelHelp2001 = .;  
if HeadNonRelHelpper2001 = 1 or HeadNonRelHelpper2001 = 2 or HeadNonRelHelpper2001 ge 7 then HeadNonRelHelp2001 = .;  
if WifeNonRelHelpper2001 = 1 or WifeNonRelHelpper2001 = 2 or WifeNonRelHelpper2001 ge 7 then WifeNonRelHelp2001 = .;  
if  HeadOthIncomeper2001 = 1 or  HeadOthIncomeper2001 = 2 or  HeadOthIncomeper2001 ge 7 then  HeadOthIncome2001 = .;  
if  WifeOthIncomeper2001 = 1 or  WifeOthIncomeper2001 = 2 or  WifeOthIncomeper2001 ge 7 then  WifeOthIncome2001 = .;  

if  HeadRmmrlaborper2001 = 0 then  HeadRmmrlabor2001 = 0;                                                                                                                                                                                                    
if       HeadRentper2001 = 0 then       HeadRent2001 = 0;                                                                                                                                                                                                    
if   HeadDividendper2001 = 0 then   HeadDividend2001 = 0;                                                                                                                                                                                                    
if   HeadInterestper2001 = 0 then   HeadInterest2001 = 0;                                                                                                                                                                                                    
if  HeadTrustFundper2001 = 0 then  HeadTrustFund2001 = 0;                                                                                                                                                                                                    
if   WifeOthAssetper2001 = 0 then   WifeOthAsset2001 = 0;                                                                                                                                                                                                    
if   WifeDividendper2001 = 0 then   WifeDividend2001 = 0;                                                                                                                                                                                                    
if   WifeInterestper2001 = 0 then   WifeInterest2001 = 0;                                                                                                                                                                                                    
if  WifeTrustFundper2001 = 0 then  WifeTrustFund2001 = 0;                                                                                                                                                                                                    
if        HeadADCper2001 = 0 then        HeadADC2001 = 0;                                                                                                                                                                                                    
if        WifeADCper2001 = 0 then        WifeADC2001 = 0;                                                                                                                                                                                                    
if  HeadRetIncVetper2001 = 0 then  HeadRetIncVet2001 = 0;                                                                                                                                                                                                    
if   HeadRetIncNVper2001 = 0 then   HeadRetIncNV2001 = 0;                                                                                                                                                                                                    
if    HeadSuppSecper2001 = 0 then    HeadSuppSec2001 = 0;                                                                                                                                                                                                    
if    WifeSuppSecper2001 = 0 then    WifeSuppSec2001 = 0;                                                                                                                                                                                                    
if     HeadOthWelper2001 = 0 then     HeadOthWel2001 = 0;                                                                                                                                                                                                    
if     WifeOthWelper2001 = 0 then     WifeOthWel2001 = 0;                                                                                                                                                                                                    
if    HeadAnnuityper2001 = 0 then    HeadAnnuity2001 = 0;                                                                                                                                                                                                    
if    WifeAnnuityper2001 = 0 then    WifeAnnuity2001 = 0;                                                                                                                                                                                                    
if     HeadOthRetper2001 = 0 then     HeadOthRet2001 = 0;                                                                                                                                                                                                    
if      HeadUnempper2001 = 0 then      HeadUnemp2001 = 0;                                                                                                                                                                                                    
if      WifeUnempper2001 = 0 then      WifeUnemp2001 = 0;                                                                                                                                                                                                    
if    HeadWorkmanper2001 = 0 then    HeadWorkman2001 = 0;                                                                                                                                                                                                    
if    WifeWorkmanper2001 = 0 then    WifeWorkman2001 = 0;                                                                                                                                                                                                    
if    HeadAlimonyper2001 = 0 then    HeadAlimony2001 = 0;                                                                                                                                                                                                    
if   HeadChldSpptper2001 = 0 then   HeadChldSppt2001 = 0;                                                                                                                                                                                                    
if   WifeChldSpptper2001 = 0 then   WifeChldSppt2001 = 0;                                                                                                                                                                                                    
if    HeadRelHelpper2001 = 0 then    HeadRelHelp2001 = 0;                                                                                                                                                                                                    
if    WifeRelHelpper2001 = 0 then    WifeRelHelp2001 = 0;                                                                                                                                                                                                    
if HeadNonRelHelpper2001 = 0 then HeadNonRelHelp2001 = 0;                                                                                                                                                                                                    
if WifeNonRelHelpper2001 = 0 then WifeNonRelHelp2001 = 0;                                                                                                                                                                                                    
if  HeadOthIncomeper2001 = 0 then  HeadOthIncome2001 = 0;                                                                                                                                                                                                    
if  WifeOthIncomeper2001 = 0 then  WifeOthIncome2001 = 0;                                                                                                                                                                                                    

keep id2001 HeadExtraInclude2001
HeadRmmrlabor2001  
HeadRent2001       
HeadDividend2001   
HeadInterest2001   
HeadTrustFund2001  
WifeDividend2001   
WifeInterest2001   
WifeTrustFund2001  
WifeOthAsset2001   
HeadADC2001        
WifeADC2001        
HeadRetIncVet2001  
HeadRetIncNV2001   
HeadAnnuity2001    
WifeAnnuity2001    
HeadOthRet2001     
HeadUnemp2001      
WifeUnemp2001      
HeadWorkman2001    
WifeWorkman2001    
HeadAlimony2001    
HeadChldSppt2001   
WifeChldSppt2001   
HeadRelHelp2001    
WifeRelHelp2001    
HeadNonRelHelp2001 
WifeNonRelHelp2001 
HeadSuppSec2001    
WifeSuppSec2001    
HeadOthWel2001     
WifeOthWel2001     
HeadOthIncome2001  
WifeOthIncome2001; 
run;


data incomeplus2001;
set psiddata.income9401;

id2001                =             ER17002    ;
Faminc2001            =             FAMINC01  ;
HWtaxable2001         =             TXHW01    ;
HeadLabor2001         =             HDEARN01  ;
WifeLabor2001         =             WFEARN01  ;
HeadSalary2001        =             HDWG01    ;  
HWTrans2001           =             TRHW01    ;                                                                                                                                                                                                                    
OthTaxable2001        =             TXOFM01   ;                                                                                                                                                                                                                  
OthTrans2001          =             TROFM01   ;
FamSSI2001            =             SSEC01    ;
HeadFarm2001          =             FRMINC01  ;
TotalFarm2001         =             FRMINC01  ;        
FamBus2001            =             BUSINC01  ; 
HeadBusLabor2001      =             HDBUSY01  ;
HeadBusAsset2001      =             HDBUSK01  ;
WifeBusLabor2001      =             WFBUSY01  ;
WifeBusAsset2001      =             WFBUSK01  ;
HeadBonus2001         =             BNUS01    ;
HeadOvertime2001      =             OVTM01    ;
HeadTips2001          =             TIPS01    ;
HeadCommission2001    =             COMS01    ;
HeadProf2001          =             PROF01    ;
HeadMktGrdnLabor2001  =             MKTG01    ;                                                                                                                                                                                                        
HeadExtraJob2001      =             XTRA01    ;

keep id2001                
Faminc2001            
HWtaxable2001         
HeadLabor2001         
WifeLabor2001         
HeadSalary2001        
HWTrans2001           
OthTaxable2001        
OthTrans2001          
FamSSI2001            
HeadFarm2001  
TotalFarm2001 
FamBus2001            
HeadBusLabor2001      
HeadBusAsset2001      
WifeBusLabor2001      
WifeBusAsset2001      
HeadBonus2001         
HeadOvertime2001      
HeadTips2001          
HeadCommission2001    
HeadProf2001          
HeadMktGrdnLabor2001  
HeadExtraJob2001;

if id2001 ne .;

proc sort data = incomeplus2001;
by id2001;
run;

data psiddata.income2001;
merge income2001fam incomeplus2001;
by id2001; run;
proc means data = psiddata.income2001;
run;


