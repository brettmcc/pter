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

data psiddata.income2003;                                                                                                                                                                                                                             
set psiddata.fam03;                                                                                                                                                                                                                          
                                                                                                                                                                                                                                             
id2003 = ER21002;                                                                                                                                                                                                                             
Faminc2003 = ER24099;                                                                                                                                                                                                                        
	HWtaxable2003 = ER24100 ;                                                                                                                                                                                                                   
		HeadLabor2003 = ER24116 ;                                                                                                                                                                                                                 
			HeadBusLabor2003 = ER24109 ;                                                                                                                                                                                                            
			HeadBonus2003 = ER24119 ;                                                                                                                                                                                                               
			HeadOvertime2003 = ER24121;                                                                                                                                                                                                             
			HeadTips2003 = ER24123;                                                                                                                                                                                                                 
			HeadCommission2003 = ER24125;                                                                                                                                                                                                           
			HeadOthJob2003 = ER24133;                                                                                                                                                                                                               
			HeadProf2003 = ER24127 ;                                                                                                                                                                                                                
			HeadMktGrdnLabor2003 = ER24129 ;                                                                                                                                                                                                        
            HeadExtraInclude2003 =  ER21999;
            HeadExtraJob2003 = ER22000;                                                                                                                                                                                                             
			HeadSalary2003 = ER24117 ;                                                                                                                                                                                                              
                                                                                                                                                                                                                                             
		WifeLabor2003 = ER24135 ;                                                                                                                                                                                                                 
		    WifeSalary2003 = ER22300;
			WifeBusLabor2003 = ER24111;                                                                                                                                                                                                             
 
        HeadFarm2003 = ER24105;                                                                                                                                                                                                                                     
        TotalFarm2003 = ER24105;        
		HeadBus2003 = ER24107;
        HeadBusAsset2003 = ER24110;                                                                                                                                                                                                 
     	HeadRmmrlabor2003 = ER21983;    HeadRmmrlaborper2003 = ER21984;
		HeadRent2003 = ER22003;         HeadRentper2003 = ER22004; 
		HeadDividend2003 = ER22020;     HeadDividendper2003 = ER22021;
        HeadInterest2003 = ER22037;     HeadInterestper2003 = ER22038; 
		RHeadDividend2003 = ER22574;    RHeadDividendper2003 = ER22575;
		RHeadInterest2003 = ER22601;    RHeadInterestper2003 = ER22602;
 		HeadTrustFund2003 = ER22054;    HeadTrustFundper2003 = ER22055;                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  
    	WifeBusAsset2003 = ER24112;                                                                                                                                                                                                               
		WifeRent2003 = ER22336;         WifeRentper2003 = ER22337;                                                                                                                                         
		WifeDividend2003 = ER22353;     WifeDividendper2003 = ER22354;                                                                                                                                          
 		WifeInterest2003 = ER22370;     WifeInterestper2003 = ER22371;                                                                                                                                                                                                               
 		WifeTrustFund2003 = ER22387;    WifeTrustFundper2003 = ER22388;                                                                                                                                                                                                              
                                                                                                                                                                                                                                             
                                                                                                                                                                                                                                             
    HWTrans2003 = ER24101;                                                                                                                                                                                                                    
        HeadADC2003 = ER22070;         HeadADCper2003 = ER22071;                                                                                                                                                                                                        
	    WifeADC2003 = ER22420;         WifeADCper2003 = ER22421;                                                                                                                                                                                                                  
	    FamSSI2003 = ER24104;                                                                                                                                                                                                                  
        HeadRetIncVet2003 = ER22120;   HeadRetIncVetper2003 = ER22121;                                                                                                                                                                                                          
		HeadRetIncNV2003 = ER22136;    HeadRetIncNVper2003 = ER22137;                                                                                                                                                                                                           
        HeadAnnuity2003 = ER22152;     HeadAnnuityper2003 = ER22153;                                                                                                                                                                                                            
        WifeAnnuity2003 = ER22468;     WifeAnnuityper2003 = ER22469;                                                                                                                                                                                                            
        HeadOthRet2003 = ER22168;      HeadOthRetper2003 = ER22169;                                                                                                                                                                                                         
        HeadUnemp2003 = ER22185;	   HeadUnempper2003 = ER22186;	                                                                                                                          
        WifeUnemp2003 = ER22304;       WifeUnempper2003 = ER22305;                                                                                                                                                                                                              
        HeadWorkman2003 = ER22201;     HeadWorkmanper2003 = ER22202;                                                                                                                                                                                                            
        WifeWorkman2003 = ER22320;     WifeWorkmanper2003 = ER22321;                                                                                                                                                                                                            
        HeadAlimony2003 = ER22233;     HeadAlimonyper2003 = ER22234;                                                                                                                                                                                                            
		HeadChldSppt2003 = ER22217;    HeadChldSpptper2003 = ER22218;                                                                                                                                                                                                             
		WifeChldSppt2003 = ER22436;    WifeChldSpptper2003 = ER22437;                                                                                                                                                                                                               
	    HeadRelHelp2003 = ER22249;     HeadRelHelpper2003 = ER22250;                                                                                                                                                                                                              
	    WifeRelHelp2003 = ER22484;     WifeRelHelpper2003 = ER22485;                                                                                                                                                                                                              
	    HeadNonRelHelp2003 = ER22265;  HeadNonRelHelpper2003 = ER22266;                                                                                                                                                                                                         
	    WifeNonRelHelp2003 = ER22500;  WifeNonRelHelpper2003 = ER22501;                                                                                                                                                                                                        
		HeadSuppSec2003 = ER22087;     HeadSuppSecper2003 = ER22088;                                                                                                                                                                                                                
		WifeSuppSec2003 = ER22404;     WifeSuppSecper2003 = ER22405;                                                                                                                                                                                                                
	    HeadOthIncome2003 = ER22281;   HeadOthIncomeper2003 = ER22282;                                                                                                                                                                                                                 
		WifeOthIncome2003 = ER22516;   WifeOthIncomeper2003 = ER22517;
        HeadOthWel2003 = ER22103;      HeadOthWelper2003 = ER22104;                                                                                                                                                                                                             
		WifeOthWel2003 = ER22452;      WifeOthWelper2003 = ER22453;                                                                                                                                                                                                                 
    
	OthTaxable2003 = ER24102 ;                                                                                                                                                                                                                  
	OthTrans2003 = ER24103;                                                                                                                                                                                                                    

if    WifeSalary2003        ge     9999996.00    then      WifeSalary2003          =      .;      
if    HeadRmmrlabor2003     ge     9999996.00    then      HeadRmmrlabor2003       =      .;      
if    HeadRent2003          ge      999996.00    then      HeadRent2003            =      .;      
if    HeadDividend2003      ge      999996.00    then      HeadDividend2003        =      .;      
if    HeadInterest2003      ge      999996.00    then      HeadInterest2003        =      .;      
if    RHeadDividend2003     ge      999996.00    then     RHeadDividend2003        =      .;      
if    RHeadInterest2003     ge      999996.00    then     RHeadInterest2003        =      .;      
if    HeadTrustFund2003     ge      999996.00    then      HeadTrustFund2003       =      .;      
if    WifeDividend2003      ge      999996.00    then      WifeDividend2003        =      .;      
if    WifeInterest2003      ge      999996.00    then      WifeInterest2003        =      .;      
if    WifeTrustFund2003     ge      999996.00    then      WifeTrustFund2003       =      .;      
if    HeadADC2003           ge      999996.00    then      HeadADC2003             =      .;      
if    WifeADC2003           ge       99996.00    then      WifeADC2003             =      .;      
if    HeadRetIncVet2003     ge       99996.00    then      HeadRetIncVet2003       =      .;      
if    HeadRetIncNV2003      ge      999996.00    then      HeadRetIncNV2003        =      .;      
if    HeadAnnuity2003       ge      999996.00    then      HeadAnnuity2003         =      .;      
if    WifeAnnuity2003       ge       99996.00    then      WifeAnnuity2003         =      .;      
if    HeadOthRet2003        ge      999996.00    then      HeadOthRet2003          =      .;      
if    HeadUnemp2003         ge       99996.00    then      HeadUnemp2003           =      .;      
if    WifeUnemp2003         ge       99996.00    then      WifeUnemp2003           =      .;      
if    HeadWorkman2003       ge       99996.00    then      HeadWorkman2003         =      .;      
if    WifeWorkman2003       ge       99996.00    then      WifeWorkman2003         =      .;      
if    HeadAlimony2003       ge       99996.00    then      HeadAlimony2003         =      .;      
if    HeadChldSppt2003      ge       99996.00    then      HeadChldSppt2003        =      .;      
if    WifeChldSppt2003      ge       99996.00    then      WifeChldSppt2003        =      .;      
if    HeadRelHelp2003       ge       99996.00    then      HeadRelHelp2003         =      .;      
if    WifeRelHelp2003       ge       99996.00    then      WifeRelHelp2003         =      .;      
if    HeadNonRelHelp2003    ge       99996.00    then      HeadNonRelHelp2003      =      .;      
if    WifeNonRelHelp2003    ge       99996.00    then      WifeNonRelHelp2003      =      .;      
if    HeadSuppSec2003       ge      999996.00    then      HeadSuppSec2003         =      .;      
if    WifeSuppSec2003       ge       99996.00    then      WifeSuppSec2003         =      .;      
if    HeadOthWel2003        ge      999996.00    then      HeadOthWel2003          =      .;      
if    WifeOthWel2003        ge       99996.00    then      WifeOthWel2003          =      .;      
if    HeadOthIncome2003     ge       99996.00    then      HeadOthIncome2003       =      .;      
if    WifeOthIncome2003     ge       99996.00    then      WifeOthIncome2003       =      .;      
                                                                                                                                                             
HeadRmmrlabor2003       = HeadRmmrlabor2003  * (52 * ( HeadRmmrlaborper2003 = 3) + 26 * ( HeadRmmrlaborper2003 = 4) +  12 * ( HeadRmmrlaborper2003 = 5) + ( HeadRmmrlaborper2003 = 6));
HeadRent2003            = HeadRent2003       * (52 * (      HeadRentper2003 = 3) + 26 * (      HeadRentper2003 = 4) +  12 * (      HeadRentper2003 = 5) + (      HeadRentper2003 = 6));
HeadDividend2003        = HeadDividend2003   * (52 * (  HeadDividendper2003 = 3) + 26 * (  HeadDividendper2003 = 4) +  12 * (  HeadDividendper2003 = 5) + (  HeadDividendper2003 = 6));
HeadInterest2003        = HeadInterest2003   * (52 * (  HeadInterestper2003 = 3) + 26 * (  HeadInterestper2003 = 4) +  12 * (  HeadInterestper2003 = 5) + (  HeadInterestper2003 = 6));
RHeadDividend2003       = RHeadDividend2003  * (52 * ( RHeadDividendper2003 = 3) + 26 * ( RHeadDividendper2003 = 4) +  12 * ( RHeadDividendper2003 = 5) + ( RHeadDividendper2003 = 6));
RHeadInterest2003       = RHeadInterest2003  * (52 * ( RHeadInterestper2003 = 3) + 26 * ( RHeadInterestper2003 = 4) +  12 * ( RHeadInterestper2003 = 5) + ( RHeadInterestper2003 = 6));
HeadTrustFund2003       = HeadTrustFund2003  * (52 * ( HeadTrustFundper2003 = 3) + 26 * ( HeadTrustFundper2003 = 4) +  12 * ( HeadTrustFundper2003 = 5) + ( HeadTrustFundper2003 = 6));
WifeDividend2003        = WifeDividend2003   * (52 * (  WifeDividendper2003 = 3) + 26 * (  WifeDividendper2003 = 4) +  12 * (  WifeDividendper2003 = 5) + (  WifeDividendper2003 = 6));
WifeInterest2003        = WifeInterest2003   * (52 * (  WifeInterestper2003 = 3) + 26 * (  WifeInterestper2003 = 4) +  12 * (  WifeInterestper2003 = 5) + (  WifeInterestper2003 = 6));
WifeTrustFund2003       = WifeTrustFund2003  * (52 * ( WifeTrustFundper2003 = 3) + 26 * ( WifeTrustFundper2003 = 4) +  12 * ( WifeTrustFundper2003 = 5) + ( WifeTrustFundper2003 = 6));
HeadADC2003             = HeadADC2003        * (52 * (       HeadADCper2003 = 3) + 26 * (       HeadADCper2003 = 4) +  12 * (       HeadADCper2003 = 5) + (       HeadADCper2003 = 6));
WifeADC2003             = WifeADC2003        * (52 * (       WifeADCper2003 = 3) + 26 * (       WifeADCper2003 = 4) +  12 * (       WifeADCper2003 = 5) + (       WifeADCper2003 = 6));
HeadRetIncVet2003       = HeadRetIncVet2003  * (52 * ( HeadRetIncVetper2003 = 3) + 26 * ( HeadRetIncVetper2003 = 4) +  12 * ( HeadRetIncVetper2003 = 5) + ( HeadRetIncVetper2003 = 6));
HeadRetIncNV2003        = HeadRetIncNV2003   * (52 * (  HeadRetIncNVper2003 = 3) + 26 * (  HeadRetIncNVper2003 = 4) +  12 * (  HeadRetIncNVper2003 = 5) + (  HeadRetIncNVper2003 = 6));
HeadSuppSec2003         = HeadSuppSec2003    * (52 * (   HeadSuppSecper2003 = 3) + 26 * (   HeadSuppSecper2003 = 4) +  12 * (   HeadSuppSecper2003 = 5) + (   HeadSuppSecper2003 = 6));
WifeSuppSec2003         = WifeSuppSec2003    * (52 * (   WifeSuppSecper2003 = 3) + 26 * (   WifeSuppSecper2003 = 4) +  12 * (   WifeSuppSecper2003 = 5) + (   WifeSuppSecper2003 = 6));
HeadOthWel2003          = HeadOthWel2003     * (52 * (    HeadOthWelper2003 = 3) + 26 * (    HeadOthWelper2003 = 4) +  12 * (    HeadOthWelper2003 = 5) + (    HeadOthWelper2003 = 6));
WifeOthWel2003          = WifeOthWel2003     * (52 * (    WifeOthWelper2003 = 3) + 26 * (    WifeOthWelper2003 = 4) +  12 * (    WifeOthWelper2003 = 5) + (    WifeOthWelper2003 = 6));
HeadAnnuity2003         = HeadAnnuity2003    * (52 * (   HeadAnnuityper2003 = 3) + 26 * (   HeadAnnuityper2003 = 4) +  12 * (   HeadAnnuityper2003 = 5) + (   HeadAnnuityper2003 = 6));
WifeAnnuity2003         = WifeAnnuity2003    * (52 * (   WifeAnnuityper2003 = 3) + 26 * (   WifeAnnuityper2003 = 4) +  12 * (   WifeAnnuityper2003 = 5) + (   WifeAnnuityper2003 = 6));
HeadOthRet2003          = HeadOthRet2003     * (52 * (    HeadOthRetper2003 = 3) + 26 * (    HeadOthRetper2003 = 4) +  12 * (    HeadOthRetper2003 = 5) + (    HeadOthRetper2003 = 6));
HeadUnemp2003           = HeadUnemp2003      * (52 * (     HeadUnempper2003 = 3) + 26 * (     HeadUnempper2003 = 4) +  12 * (     HeadUnempper2003 = 5) + (     HeadUnempper2003 = 6));
WifeUnemp2003           = WifeUnemp2003      * (52 * (     WifeUnempper2003 = 3) + 26 * (     WifeUnempper2003 = 4) +  12 * (     WifeUnempper2003 = 5) + (     WifeUnempper2003 = 6));
HeadWorkman2003         = HeadWorkman2003    * (52 * (   HeadWorkmanper2003 = 3) + 26 * (   HeadWorkmanper2003 = 4) +  12 * (   HeadWorkmanper2003 = 5) + (   HeadWorkmanper2003 = 6));
WifeWorkman2003         = WifeWorkman2003    * (52 * (   WifeWorkmanper2003 = 3) + 26 * (   WifeWorkmanper2003 = 4) +  12 * (   WifeWorkmanper2003 = 5) + (   WifeWorkmanper2003 = 6));
HeadAlimony2003         = HeadAlimony2003    * (52 * (   HeadAlimonyper2003 = 3) + 26 * (   HeadAlimonyper2003 = 4) +  12 * (   HeadAlimonyper2003 = 5) + (   HeadAlimonyper2003 = 6));
HeadChldSppt2003        = HeadChldSppt2003   * (52 * (  HeadChldSpptper2003 = 3) + 26 * (  HeadChldSpptper2003 = 4) +  12 * (  HeadChldSpptper2003 = 5) + (  HeadChldSpptper2003 = 6));
WifeChldSppt2003        = WifeChldSppt2003   * (52 * (  WifeChldSpptper2003 = 3) + 26 * (  WifeChldSpptper2003 = 4) +  12 * (  WifeChldSpptper2003 = 5) + (  WifeChldSpptper2003 = 6));
HeadRelHelp2003         = HeadRelHelp2003    * (52 * (   HeadRelHelpper2003 = 3) + 26 * (   HeadRelHelpper2003 = 4) +  12 * (   HeadRelHelpper2003 = 5) + (   HeadRelHelpper2003 = 6));
WifeRelHelp2003         = WifeRelHelp2003    * (52 * (   WifeRelHelpper2003 = 3) + 26 * (   WifeRelHelpper2003 = 4) +  12 * (   WifeRelHelpper2003 = 5) + (   WifeRelHelpper2003 = 6));
HeadNonRelHelp2003      = HeadNonRelHelp2003 * (52 * (HeadNonRelHelpper2003 = 3) + 26 * (HeadNonRelHelpper2003 = 4) +  12 * (HeadNonRelHelpper2003 = 5) + (HeadNonRelHelpper2003 = 6));
WifeNonRelHelp2003      = WifeNonRelHelp2003 * (52 * (WifeNonRelHelpper2003 = 3) + 26 * (WifeNonRelHelpper2003 = 4) +  12 * (WifeNonRelHelpper2003 = 5) + (WifeNonRelHelpper2003 = 6));
HeadOthIncome2003       = HeadOthIncome2003  * (52 * ( HeadOthIncomeper2003 = 3) + 26 * ( HeadOthIncomeper2003 = 4) +  12 * ( HeadOthIncomeper2003 = 5) + ( HeadOthIncomeper2003 = 6));
WifeOthIncome2003       = WifeOthIncome2003  * (52 * ( WifeOthIncomeper2003 = 3) + 26 * ( WifeOthIncomeper2003 = 4) +  12 * ( WifeOthIncomeper2003 = 5) + ( WifeOthIncomeper2003 = 6));

if  HeadRmmrlaborper2003 = 1 or  HeadRmmrlaborper2003 = 2 or  HeadRmmrlaborper2003 ge 7 then  HeadRmmrlabor2003 = .;  
if       HeadRentper2003 = 1 or       HeadRentper2003 = 2 or       HeadRentper2003 ge 7 then       HeadRent2003 = .;  
if   HeadDividendper2003 = 1 or   HeadDividendper2003 = 2 or   HeadDividendper2003 ge 7 then   HeadDividend2003 = .;  
if   HeadInterestper2003 = 1 or   HeadInterestper2003 = 2 or   HeadInterestper2003 ge 7 then   HeadInterest2003 = .;  
if  RHeadDividendper2003 = 1 or  RHeadDividendper2003 = 2 or  RHeadDividendper2003 ge 7 then  RHeadDividend2003 = .;  
if  RHeadInterestper2003 = 1 or  RHeadInterestper2003 = 2 or  RHeadInterestper2003 ge 7 then  RHeadInterest2003 = .;  
if  HeadTrustFundper2003 = 1 or  HeadTrustFundper2003 = 2 or  HeadTrustFundper2003 ge 7 then  HeadTrustFund2003 = .;  
if   WifeDividendper2003 = 1 or   WifeDividendper2003 = 2 or   WifeDividendper2003 ge 7 then   WifeDividend2003 = .;  
if   WifeInterestper2003 = 1 or   WifeInterestper2003 = 2 or   WifeInterestper2003 ge 7 then   WifeInterest2003 = .;  
if  WifeTrustFundper2003 = 1 or  WifeTrustFundper2003 = 2 or  WifeTrustFundper2003 ge 7 then  WifeTrustFund2003 = .;  
if        HeadADCper2003 = 1 or        HeadADCper2003 = 2 or        HeadADCper2003 ge 7 then        HeadADC2003 = .;  
if        WifeADCper2003 = 1 or        WifeADCper2003 = 2 or        WifeADCper2003 ge 7 then        WifeADC2003 = .;  
if  HeadRetIncVetper2003 = 1 or  HeadRetIncVetper2003 = 2 or  HeadRetIncVetper2003 ge 7 then  HeadRetIncVet2003 = .;  
if   HeadRetIncNVper2003 = 1 or   HeadRetIncNVper2003 = 2 or   HeadRetIncNVper2003 ge 7 then   HeadRetIncNV2003 = .;  
if    HeadSuppSecper2003 = 1 or    HeadSuppSecper2003 = 2 or    HeadSuppSecper2003 ge 7 then    HeadSuppSec2003 = .;  
if    WifeSuppSecper2003 = 1 or    WifeSuppSecper2003 = 2 or    WifeSuppSecper2003 ge 7 then    WifeSuppSec2003 = .;  
if     HeadOthWelper2003 = 1 or     HeadOthWelper2003 = 2 or     HeadOthWelper2003 ge 7 then     HeadOthWel2003 = .;  
if     WifeOthWelper2003 = 1 or     WifeOthWelper2003 = 2 or     WifeOthWelper2003 ge 7 then     WifeOthWel2003 = .;  
if    HeadAnnuityper2003 = 1 or    HeadAnnuityper2003 = 2 or    HeadAnnuityper2003 ge 7 then    HeadAnnuity2003 = .;  
if    WifeAnnuityper2003 = 1 or    WifeAnnuityper2003 = 2 or    WifeAnnuityper2003 ge 7 then    WifeAnnuity2003 = .;  
if     HeadOthRetper2003 = 1 or     HeadOthRetper2003 = 2 or     HeadOthRetper2003 ge 7 then     HeadOthRet2003 = .;  
if      HeadUnempper2003 = 1 or      HeadUnempper2003 = 2 or      HeadUnempper2003 ge 7 then      HeadUnemp2003 = .;  
if      WifeUnempper2003 = 1 or      WifeUnempper2003 = 2 or      WifeUnempper2003 ge 7 then      WifeUnemp2003 = .;  
if    HeadWorkmanper2003 = 1 or    HeadWorkmanper2003 = 2 or    HeadWorkmanper2003 ge 7 then    HeadWorkman2003 = .;  
if    WifeWorkmanper2003 = 1 or    WifeWorkmanper2003 = 2 or    WifeWorkmanper2003 ge 7 then    WifeWorkman2003 = .;  
if    HeadAlimonyper2003 = 1 or    HeadAlimonyper2003 = 2 or    HeadAlimonyper2003 ge 7 then    HeadAlimony2003 = .;  
if   HeadChldSpptper2003 = 1 or   HeadChldSpptper2003 = 2 or   HeadChldSpptper2003 ge 7 then   HeadChldSppt2003 = .;  
if   WifeChldSpptper2003 = 1 or   WifeChldSpptper2003 = 2 or   WifeChldSpptper2003 ge 7 then   WifeChldSppt2003 = .;  
if    HeadRelHelpper2003 = 1 or    HeadRelHelpper2003 = 2 or    HeadRelHelpper2003 ge 7 then    HeadRelHelp2003 = .;  
if    WifeRelHelpper2003 = 1 or    WifeRelHelpper2003 = 2 or    WifeRelHelpper2003 ge 7 then    WifeRelHelp2003 = .;  
if HeadNonRelHelpper2003 = 1 or HeadNonRelHelpper2003 = 2 or HeadNonRelHelpper2003 ge 7 then HeadNonRelHelp2003 = .;  
if WifeNonRelHelpper2003 = 1 or WifeNonRelHelpper2003 = 2 or WifeNonRelHelpper2003 ge 7 then WifeNonRelHelp2003 = .;  
if  HeadOthIncomeper2003 = 1 or  HeadOthIncomeper2003 = 2 or  HeadOthIncomeper2003 ge 7 then  HeadOthIncome2003 = .;  
if  WifeOthIncomeper2003 = 1 or  WifeOthIncomeper2003 = 2 or  WifeOthIncomeper2003 ge 7 then  WifeOthIncome2003 = .;  

if  HeadRmmrlaborper2003 = 0 then  HeadRmmrlabor2003 = 0;                                                                                                                                                                                                    
if       HeadRentper2003 = 0 then       HeadRent2003 = 0;                                                                                                                                                                                                    
if   HeadDividendper2003 = 0 then   HeadDividend2003 = 0;                                                                                                                                                                                                    
if   HeadInterestper2003 = 0 then   HeadInterest2003 = 0;                                                                                                                                                                                                    
if  RHeadDividendper2003 = 0 then  RHeadDividend2003 = 0;                                                                                                                                                                                                    
if  RHeadInterestper2003 = 0 then  RHeadInterest2003 = 0;                                                                                                                                                                                                    
if  HeadTrustFundper2003 = 0 then  HeadTrustFund2003 = 0;                                                                                                                                                                                                    
if   WifeDividendper2003 = 0 then   WifeDividend2003 = 0;                                                                                                                                                                                                    
if   WifeInterestper2003 = 0 then   WifeInterest2003 = 0;                                                                                                                                                                                                    
if  WifeTrustFundper2003 = 0 then  WifeTrustFund2003 = 0;                                                                                                                                                                                                    
if        HeadADCper2003 = 0 then        HeadADC2003 = 0;                                                                                                                                                                                                    
if        WifeADCper2003 = 0 then        WifeADC2003 = 0;                                                                                                                                                                                                    
if  HeadRetIncVetper2003 = 0 then  HeadRetIncVet2003 = 0;                                                                                                                                                                                                    
if   HeadRetIncNVper2003 = 0 then   HeadRetIncNV2003 = 0;                                                                                                                                                                                                    
if    HeadSuppSecper2003 = 0 then    HeadSuppSec2003 = 0;                                                                                                                                                                                                    
if    WifeSuppSecper2003 = 0 then    WifeSuppSec2003 = 0;                                                                                                                                                                                                    
if     HeadOthWelper2003 = 0 then     HeadOthWel2003 = 0;                                                                                                                                                                                                    
if     WifeOthWelper2003 = 0 then     WifeOthWel2003 = 0;                                                                                                                                                                                                    
if    HeadAnnuityper2003 = 0 then    HeadAnnuity2003 = 0;                                                                                                                                                                                                    
if    WifeAnnuityper2003 = 0 then    WifeAnnuity2003 = 0;                                                                                                                                                                                                    
if     HeadOthRetper2003 = 0 then     HeadOthRet2003 = 0;                                                                                                                                                                                                    
if      HeadUnempper2003 = 0 then      HeadUnemp2003 = 0;                                                                                                                                                                                                    
if      WifeUnempper2003 = 0 then      WifeUnemp2003 = 0;                                                                                                                                                                                                    
if    HeadWorkmanper2003 = 0 then    HeadWorkman2003 = 0;                                                                                                                                                                                                    
if    WifeWorkmanper2003 = 0 then    WifeWorkman2003 = 0;                                                                                                                                                                                                    
if    HeadAlimonyper2003 = 0 then    HeadAlimony2003 = 0;                                                                                                                                                                                                    
if   HeadChldSpptper2003 = 0 then   HeadChldSppt2003 = 0;                                                                                                                                                                                                    
if   WifeChldSpptper2003 = 0 then   WifeChldSppt2003 = 0;                                                                                                                                                                                                    
if    HeadRelHelpper2003 = 0 then    HeadRelHelp2003 = 0;                                                                                                                                                                                                    
if    WifeRelHelpper2003 = 0 then    WifeRelHelp2003 = 0;                                                                                                                                                                                                    
if HeadNonRelHelpper2003 = 0 then HeadNonRelHelp2003 = 0;                                                                                                                                                                                                    
if WifeNonRelHelpper2003 = 0 then WifeNonRelHelp2003 = 0;                                                                                                                                                                                                    
if  HeadOthIncomeper2003 = 0 then  HeadOthIncome2003 = 0;                                                                                                                                                                                                    
if  WifeOthIncomeper2003 = 0 then  WifeOthIncome2003 = 0;               

if RHeadDividend2003 > 0 then HeadDividend2003 = RHeadDividend2003;
if RHeadInterest2003 > 0 then HeadInterest2003 = RHeadInterest2003;

keep id2003 HeadExtraInclude2003
HeadRmmrlabor2003          
HeadRent2003               
HeadDividend2003           
HeadInterest2003           
HeadTrustFund2003   
WifeRent2003 
WifeDividend2003           
WifeInterest2003           
WifeTrustFund2003          
HeadADC2003                
WifeADC2003         
HeadRetIncVet2003          
HeadRetIncNV2003           
HeadSuppSec2003            
WifeSuppSec2003            
HeadOthWel2003             
WifeOthWel2003             
HeadAnnuity2003            
WifeAnnuity2003            
HeadOthRet2003             
HeadUnemp2003              
WifeUnemp2003              
HeadWorkman2003            
WifeWorkman2003            
HeadAlimony2003            
HeadChldSppt2003           
WifeChldSppt2003           
HeadRelHelp2003            
WifeRelHelp2003            
HeadNonRelHelp2003         
WifeNonRelHelp2003         
HeadOthIncome2003          
WifeOthIncome2003          
Faminc2003                 
HWtaxable2003    		       
HeadLabor2003				       
HeadBusLabor2003 		       
HeadBonus2003				       
HeadOvertime2003		       
HeadTips2003 				       
HeadCommission2003 	       
HeadOthJob2003 			       
HeadProf2003 				       
HeadMktGrdnLabor2003       
HeadExtraJob2003		       
HeadSalary2003			       
WifeLabor2003 			       
WifeSalary2003 			       
WifeBusLabor2003 		       
WifeBusAsset2003 		       
HeadFarm2003 				       
TotalFarm2003
HeadBus2003 				       
HeadBusAsset2003 		       
HWTrans2003                
FamSSI2003                 
OthTaxable2003 			       
OthTrans2003 				       
;

proc means data = psiddata.income2003;
run; 
