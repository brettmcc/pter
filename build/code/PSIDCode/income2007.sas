*********Retrieve and process income data from 1994 family and income plus data files        ********* 
*********After 1993, income data collection and release are changed significantly, from 1994 *********
*********to 2001, some income data are processed and released in the income plus data files  *********
*********However, there are still many income components contained only in the main family   *********
*********data. I process the income components using the family data if these variables are  *********
*********not included in the income plus data. In addition, many variable in the main data   ********* 
*********employ the per format, which changed before and after 1995.  In the 2007 wave       *********
*********processed variables were added so we do not have to compute annual income using     *********
*********the per variables.                                                                  *********
*********Geng Li and Michael Mulhall December 2008                                           *********;

data psiddata.income2007;                                                                                                                                                                                                                             
set psiddata.fam07;                                                                                                                                                                                                                          
                                                                                                                                                                                                                                             
id2007 = ER36002;                                                                                                                                                                                                                             
Faminc2007 = ER41027;                                                                                                                                                                                                                        
	HWtaxable2007 = ER40943 ;                                                                                                                                                                                                                   
		HeadLabor2007 = ER40921 ;                                                                                                                                                                                                                 
			HeadBusLabor2007 = ER40900 ;                                                                                                                                                                                                            
			HeadBonus2007 = ER40905 ;                                                                                                                                                                                                               
			HeadOvertime2007 = ER40907;                                                                                                                                                                                                             
			HeadTips2007 = ER40909;                                                                                                                                                                                                                 
			HeadCommission2007 = ER40911;                                                                                                                                                                                                           
			HeadOthJob2007 = ER40917;                                                                                                                                                                                                               
			HeadProf2007 = ER40913 ;                                                                                                                                                                                                                
			HeadMktGrdnLabor2007 = ER40915 ;                                                                                                                                                                                                        
            HeadExtraInclude2007 =  ER36998;
            HeadExtraJob2007 = ER40919;                                                                                                                                                                                                             
			HeadSalary2007 = ER40903;                                                                                                                                                                                                              
                                                                                                                                                                                                                                             
		WifeLabor2007 = ER40933 ;                                                                                                                                                                                                                 
		    WifeSalary2007 = ER37299;
			WifeBusLabor2007 = ER40930;                                                                                                                                                                                                             
 
        HeadFarm2007 = ER40898;                                                                                                                                                                                                                                     
        TotalFarm2007 = ER40898;        
		HeadBus2007 = ER40895;
        HeadBusAsset2007 = ER40901;                                                                                                                                                                                                 
     	HeadRmmrlabor2007 = 0;   
		HeadRent2007 = ER40922; 
		WifeRent2007 = ER40935; 
		HeadDividend2007 = ER40924;
        HeadInterest2007 = ER40926; 
 		HeadTrustFund2007 = ER40928;                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  
    	WifeBusAsset2007 = ER40931;                                                                                                                                                                                                               
		WifeDividend2007 = ER40937;                                                                                                                                          
 		WifeInterest2007 = ER40939;                                                                                                                                                                                                              
 		WifeTrustFund2007 = ER40941;                                                                                                                                                                                                              
                                                                                                                                                                                                                                             
                                                                                                                                                                                                                                             
    HWTrans2007 = ER40992;                                                                                                                                                                                                                    
        HeadADC2007 = ER40944;                                                                                                                                                                                                        
	    WifeADC2007 = ER40972;                                                                                                                                                                                                                  
	    HeadSSI2007 = ER41021;                                                                                                                                                                                                                  
	    WifeSSI2007 = ER41023;                                                                                                                                                                                                                  
        HeadRetIncVet2007 = ER40950;                                                                                                                                                                                                          
		HeadRetIncNV2007 = ER40952;                                                                                                                                                                                                          
        HeadAnnuity2007 = ER40954;                                                                                                                                                                                                            
        WifeAnnuity2007 = ER40978;                                                                                                                                                                                                            
        HeadOthRet2007 = ER40956;                                                                                                                                                                                                         
        HeadUnemp2007 = ER40958;	                                                                                                                          
        WifeUnemp2007 = ER40980;                                                                                                                                                                                                              
        HeadWorkman2007 = ER40960;                                                                                                                                                                                                            
        WifeWorkman2007 = ER40982;                                                                                                                                                                                                           
        HeadAlimony2007 = ER40964;                                                                                                                                                                                                            
		HeadChldSppt2007 = ER40962;                                                                                                                                                                                                             
		WifeChldSppt2007 = ER40984;                                                                                                                                                                                                              
	    HeadRelHelp2007 = ER40966;                                                                                                                                                                                                              
	    WifeRelHelp2007 = ER40986;                                                                                                                                                                                                              
	    HeadNonRelHelp2007 = ER40968;                                                                                                                                                                                                       
	    WifeNonRelHelp2007 = ER40988;                                                                                                                                                                                                       
		HeadSuppSec2007 = ER40946;                                                                                                                                                                                                                
		WifeSuppSec2007 = ER40974;                                                                                                                                                                                                                
	    HeadOthIncome2007 = ER40970;                                                                                                                                                                                                                  
		WifeOthIncome2007 = ER40990;
        HeadOthWel2007 = ER40948;                                                                                                                                                                                                            
		WifeOthWel2007 = ER40976;                                                                                                                                                                                                                
    
	OthTaxable2007 = ER40999;                                                                                                                                                                                                                  
	OthTrans2007 = ER41020;                                                                                                                                                                                                                    

/*if    WifeSalary2007        ge     9999996.00    then      WifeSalary2007          =      .;      
if    HeadRmmrlabor2007     ge     9999996.00    then      HeadRmmrlabor2007       =      .;      
if    HeadRent2007          ge      999996.00    then      HeadRent2007            =      .;      
if    HeadDividend2007      ge      999996.00    then      HeadDividend2007        =      .;      
if    HeadInterest2007      ge      999996.00    then      HeadInterest2007        =      .;      
if    RHeadDividend2007     ge      999996.00    then     RHeadDividend2007        =      .;      
if    RHeadInterest2007     ge      999996.00    then     RHeadInterest2007        =      .;      
if    HeadTrustFund2007     ge      999996.00    then      HeadTrustFund2007       =      .;      
if    WifeDividend2007      ge      999996.00    then      WifeDividend2007        =      .;      
if    WifeInterest2007      ge      999996.00    then      WifeInterest2007        =      .;      
if    WifeTrustFund2007     ge      999996.00    then      WifeTrustFund2007       =      .;      
if    HeadADC2007           ge      999996.00    then      HeadADC2007             =      .;      
if    WifeADC2007           ge       99996.00    then      WifeADC2007             =      .;      
if    HeadRetIncVet2007     ge       99996.00    then      HeadRetIncVet2007       =      .;      
if    HeadRetIncNV2007      ge      999996.00    then      HeadRetIncNV2007        =      .;      
if    HeadAnnuity2007       ge      999996.00    then      HeadAnnuity2007         =      .;      
if    WifeAnnuity2007       ge       99996.00    then      WifeAnnuity2007         =      .;      
if    HeadOthRet2007        ge      999996.00    then      HeadOthRet2007          =      .;      
if    HeadUnemp2007         ge       99996.00    then      HeadUnemp2007           =      .;      
if    WifeUnemp2007         ge       99996.00    then      WifeUnemp2007           =      .;      
if    HeadWorkman2007       ge       99996.00    then      HeadWorkman2007         =      .;      
if    WifeWorkman2007       ge       99996.00    then      WifeWorkman2007         =      .;      
if    HeadAlimony2007       ge       99996.00    then      HeadAlimony2007         =      .;      
if    HeadChldSppt2007      ge       99996.00    then      HeadChldSppt2007        =      .;      
if    WifeChldSppt2007      ge       99996.00    then      WifeChldSppt2007        =      .;      
if    HeadRelHelp2007       ge       99996.00    then      HeadRelHelp2007         =      .;      
if    WifeRelHelp2007       ge       99996.00    then      WifeRelHelp2007         =      .;      
if    HeadNonRelHelp2007    ge       99996.00    then      HeadNonRelHelp2007      =      .;      
if    WifeNonRelHelp2007    ge       99996.00    then      WifeNonRelHelp2007      =      .;      
if    HeadSuppSec2007       ge      999996.00    then      HeadSuppSec2007         =      .;      
if    WifeSuppSec2007       ge       99996.00    then      WifeSuppSec2007         =      .;      
if    HeadOthWel2007        ge      999996.00    then      HeadOthWel2007          =      .;      
if    WifeOthWel2007        ge       99996.00    then      WifeOthWel2007          =      .;      
if    HeadOthIncome2007     ge       99996.00    then      HeadOthIncome2007       =      .;      
if    WifeOthIncome2007     ge       99996.00    then      WifeOthIncome2007       =      .;      
                                                                                                                                                             
HeadRmmrlabor2007       = HeadRmmrlabor2007  * (52 * ( HeadRmmrlaborper2007 = 3) + 26 * ( HeadRmmrlaborper2007 = 4) +  12 * ( HeadRmmrlaborper2007 = 5) + ( HeadRmmrlaborper2007 = 6));
HeadRent2007            = HeadRent2007       * (52 * (      HeadRentper2007 = 3) + 26 * (      HeadRentper2007 = 4) +  12 * (      HeadRentper2007 = 5) + (      HeadRentper2007 = 6));
HeadDividend2007        = HeadDividend2007   * (52 * (  HeadDividendper2007 = 3) + 26 * (  HeadDividendper2007 = 4) +  12 * (  HeadDividendper2007 = 5) + (  HeadDividendper2007 = 6));
HeadInterest2007        = HeadInterest2007   * (52 * (  HeadInterestper2007 = 3) + 26 * (  HeadInterestper2007 = 4) +  12 * (  HeadInterestper2007 = 5) + (  HeadInterestper2007 = 6));
RHeadDividend2007       = RHeadDividend2007  * (52 * ( RHeadDividendper2007 = 3) + 26 * ( RHeadDividendper2007 = 4) +  12 * ( RHeadDividendper2007 = 5) + ( RHeadDividendper2007 = 6));
RHeadInterest2007       = RHeadInterest2007  * (52 * ( RHeadInterestper2007 = 3) + 26 * ( RHeadInterestper2007 = 4) +  12 * ( RHeadInterestper2007 = 5) + ( RHeadInterestper2007 = 6));
HeadTrustFund2007       = HeadTrustFund2007  * (52 * ( HeadTrustFundper2007 = 3) + 26 * ( HeadTrustFundper2007 = 4) +  12 * ( HeadTrustFundper2007 = 5) + ( HeadTrustFundper2007 = 6));
WifeDividend2007        = WifeDividend2007   * (52 * (  WifeDividendper2007 = 3) + 26 * (  WifeDividendper2007 = 4) +  12 * (  WifeDividendper2007 = 5) + (  WifeDividendper2007 = 6));
WifeInterest2007        = WifeInterest2007   * (52 * (  WifeInterestper2007 = 3) + 26 * (  WifeInterestper2007 = 4) +  12 * (  WifeInterestper2007 = 5) + (  WifeInterestper2007 = 6));
WifeTrustFund2007       = WifeTrustFund2007  * (52 * ( WifeTrustFundper2007 = 3) + 26 * ( WifeTrustFundper2007 = 4) +  12 * ( WifeTrustFundper2007 = 5) + ( WifeTrustFundper2007 = 6));
HeadADC2007             = HeadADC2007        * (52 * (       HeadADCper2007 = 3) + 26 * (       HeadADCper2007 = 4) +  12 * (       HeadADCper2007 = 5) + (       HeadADCper2007 = 6));
WifeADC2007             = WifeADC2007        * (52 * (       WifeADCper2007 = 3) + 26 * (       WifeADCper2007 = 4) +  12 * (       WifeADCper2007 = 5) + (       WifeADCper2007 = 6));
HeadRetIncVet2007       = HeadRetIncVet2007  * (52 * ( HeadRetIncVetper2007 = 3) + 26 * ( HeadRetIncVetper2007 = 4) +  12 * ( HeadRetIncVetper2007 = 5) + ( HeadRetIncVetper2007 = 6));
HeadRetIncNV2007        = HeadRetIncNV2007   * (52 * (  HeadRetIncNVper2007 = 3) + 26 * (  HeadRetIncNVper2007 = 4) +  12 * (  HeadRetIncNVper2007 = 5) + (  HeadRetIncNVper2007 = 6));
HeadSuppSec2007         = HeadSuppSec2007    * (52 * (   HeadSuppSecper2007 = 3) + 26 * (   HeadSuppSecper2007 = 4) +  12 * (   HeadSuppSecper2007 = 5) + (   HeadSuppSecper2007 = 6));
WifeSuppSec2007         = WifeSuppSec2007    * (52 * (   WifeSuppSecper2007 = 3) + 26 * (   WifeSuppSecper2007 = 4) +  12 * (   WifeSuppSecper2007 = 5) + (   WifeSuppSecper2007 = 6));
HeadOthWel2007          = HeadOthWel2007     * (52 * (    HeadOthWelper2007 = 3) + 26 * (    HeadOthWelper2007 = 4) +  12 * (    HeadOthWelper2007 = 5) + (    HeadOthWelper2007 = 6));
WifeOthWel2007          = WifeOthWel2007     * (52 * (    WifeOthWelper2007 = 3) + 26 * (    WifeOthWelper2007 = 4) +  12 * (    WifeOthWelper2007 = 5) + (    WifeOthWelper2007 = 6));
HeadAnnuity2007         = HeadAnnuity2007    * (52 * (   HeadAnnuityper2007 = 3) + 26 * (   HeadAnnuityper2007 = 4) +  12 * (   HeadAnnuityper2007 = 5) + (   HeadAnnuityper2007 = 6));
WifeAnnuity2007         = WifeAnnuity2007    * (52 * (   WifeAnnuityper2007 = 3) + 26 * (   WifeAnnuityper2007 = 4) +  12 * (   WifeAnnuityper2007 = 5) + (   WifeAnnuityper2007 = 6));
HeadOthRet2007          = HeadOthRet2007     * (52 * (    HeadOthRetper2007 = 3) + 26 * (    HeadOthRetper2007 = 4) +  12 * (    HeadOthRetper2007 = 5) + (    HeadOthRetper2007 = 6));
HeadUnemp2007           = HeadUnemp2007      * (52 * (     HeadUnempper2007 = 3) + 26 * (     HeadUnempper2007 = 4) +  12 * (     HeadUnempper2007 = 5) + (     HeadUnempper2007 = 6));
WifeUnemp2007           = WifeUnemp2007      * (52 * (     WifeUnempper2007 = 3) + 26 * (     WifeUnempper2007 = 4) +  12 * (     WifeUnempper2007 = 5) + (     WifeUnempper2007 = 6));
HeadWorkman2007         = HeadWorkman2007    * (52 * (   HeadWorkmanper2007 = 3) + 26 * (   HeadWorkmanper2007 = 4) +  12 * (   HeadWorkmanper2007 = 5) + (   HeadWorkmanper2007 = 6));
WifeWorkman2007         = WifeWorkman2007    * (52 * (   WifeWorkmanper2007 = 3) + 26 * (   WifeWorkmanper2007 = 4) +  12 * (   WifeWorkmanper2007 = 5) + (   WifeWorkmanper2007 = 6));
HeadAlimony2007         = HeadAlimony2007    * (52 * (   HeadAlimonyper2007 = 3) + 26 * (   HeadAlimonyper2007 = 4) +  12 * (   HeadAlimonyper2007 = 5) + (   HeadAlimonyper2007 = 6));
HeadChldSppt2007        = HeadChldSppt2007   * (52 * (  HeadChldSpptper2007 = 3) + 26 * (  HeadChldSpptper2007 = 4) +  12 * (  HeadChldSpptper2007 = 5) + (  HeadChldSpptper2007 = 6));
WifeChldSppt2007        = WifeChldSppt2007   * (52 * (  WifeChldSpptper2007 = 3) + 26 * (  WifeChldSpptper2007 = 4) +  12 * (  WifeChldSpptper2007 = 5) + (  WifeChldSpptper2007 = 6));
HeadRelHelp2007         = HeadRelHelp2007    * (52 * (   HeadRelHelpper2007 = 3) + 26 * (   HeadRelHelpper2007 = 4) +  12 * (   HeadRelHelpper2007 = 5) + (   HeadRelHelpper2007 = 6));
WifeRelHelp2007         = WifeRelHelp2007    * (52 * (   WifeRelHelpper2007 = 3) + 26 * (   WifeRelHelpper2007 = 4) +  12 * (   WifeRelHelpper2007 = 5) + (   WifeRelHelpper2007 = 6));
HeadNonRelHelp2007      = HeadNonRelHelp2007 * (52 * (HeadNonRelHelpper2007 = 3) + 26 * (HeadNonRelHelpper2007 = 4) +  12 * (HeadNonRelHelpper2007 = 5) + (HeadNonRelHelpper2007 = 6));
WifeNonRelHelp2007      = WifeNonRelHelp2007 * (52 * (WifeNonRelHelpper2007 = 3) + 26 * (WifeNonRelHelpper2007 = 4) +  12 * (WifeNonRelHelpper2007 = 5) + (WifeNonRelHelpper2007 = 6));
HeadOthIncome2007       = HeadOthIncome2007  * (52 * ( HeadOthIncomeper2007 = 3) + 26 * ( HeadOthIncomeper2007 = 4) +  12 * ( HeadOthIncomeper2007 = 5) + ( HeadOthIncomeper2007 = 6));
WifeOthIncome2007       = WifeOthIncome2007  * (52 * ( WifeOthIncomeper2007 = 3) + 26 * ( WifeOthIncomeper2007 = 4) +  12 * ( WifeOthIncomeper2007 = 5) + ( WifeOthIncomeper2007 = 6));

if  HeadRmmrlaborper2007 = 1 or  HeadRmmrlaborper2007 = 2 or  HeadRmmrlaborper2007 ge 7 then  HeadRmmrlabor2007 = .;  
if       HeadRentper2007 = 1 or       HeadRentper2007 = 2 or       HeadRentper2007 ge 7 then       HeadRent2007 = .;  
if   HeadDividendper2007 = 1 or   HeadDividendper2007 = 2 or   HeadDividendper2007 ge 7 then   HeadDividend2007 = .;  
if   HeadInterestper2007 = 1 or   HeadInterestper2007 = 2 or   HeadInterestper2007 ge 7 then   HeadInterest2007 = .;  
if  RHeadDividendper2007 = 1 or  RHeadDividendper2007 = 2 or  RHeadDividendper2007 ge 7 then  RHeadDividend2007 = .;  
if  RHeadInterestper2007 = 1 or  RHeadInterestper2007 = 2 or  RHeadInterestper2007 ge 7 then  RHeadInterest2007 = .;  
if  HeadTrustFundper2007 = 1 or  HeadTrustFundper2007 = 2 or  HeadTrustFundper2007 ge 7 then  HeadTrustFund2007 = .;  
if   WifeDividendper2007 = 1 or   WifeDividendper2007 = 2 or   WifeDividendper2007 ge 7 then   WifeDividend2007 = .;  
if   WifeInterestper2007 = 1 or   WifeInterestper2007 = 2 or   WifeInterestper2007 ge 7 then   WifeInterest2007 = .;  
if  WifeTrustFundper2007 = 1 or  WifeTrustFundper2007 = 2 or  WifeTrustFundper2007 ge 7 then  WifeTrustFund2007 = .;  
if        HeadADCper2007 = 1 or        HeadADCper2007 = 2 or        HeadADCper2007 ge 7 then        HeadADC2007 = .;  
if        WifeADCper2007 = 1 or        WifeADCper2007 = 2 or        WifeADCper2007 ge 7 then        WifeADC2007 = .;  
if  HeadRetIncVetper2007 = 1 or  HeadRetIncVetper2007 = 2 or  HeadRetIncVetper2007 ge 7 then  HeadRetIncVet2007 = .;  
if   HeadRetIncNVper2007 = 1 or   HeadRetIncNVper2007 = 2 or   HeadRetIncNVper2007 ge 7 then   HeadRetIncNV2007 = .;  
if    HeadSuppSecper2007 = 1 or    HeadSuppSecper2007 = 2 or    HeadSuppSecper2007 ge 7 then    HeadSuppSec2007 = .;  
if    WifeSuppSecper2007 = 1 or    WifeSuppSecper2007 = 2 or    WifeSuppSecper2007 ge 7 then    WifeSuppSec2007 = .;  
if     HeadOthWelper2007 = 1 or     HeadOthWelper2007 = 2 or     HeadOthWelper2007 ge 7 then     HeadOthWel2007 = .;  
if     WifeOthWelper2007 = 1 or     WifeOthWelper2007 = 2 or     WifeOthWelper2007 ge 7 then     WifeOthWel2007 = .;  
if    HeadAnnuityper2007 = 1 or    HeadAnnuityper2007 = 2 or    HeadAnnuityper2007 ge 7 then    HeadAnnuity2007 = .;  
if    WifeAnnuityper2007 = 1 or    WifeAnnuityper2007 = 2 or    WifeAnnuityper2007 ge 7 then    WifeAnnuity2007 = .;  
if     HeadOthRetper2007 = 1 or     HeadOthRetper2007 = 2 or     HeadOthRetper2007 ge 7 then     HeadOthRet2007 = .;  
if      HeadUnempper2007 = 1 or      HeadUnempper2007 = 2 or      HeadUnempper2007 ge 7 then      HeadUnemp2007 = .;  
if      WifeUnempper2007 = 1 or      WifeUnempper2007 = 2 or      WifeUnempper2007 ge 7 then      WifeUnemp2007 = .;  
if    HeadWorkmanper2007 = 1 or    HeadWorkmanper2007 = 2 or    HeadWorkmanper2007 ge 7 then    HeadWorkman2007 = .;  
if    WifeWorkmanper2007 = 1 or    WifeWorkmanper2007 = 2 or    WifeWorkmanper2007 ge 7 then    WifeWorkman2007 = .;  
if    HeadAlimonyper2007 = 1 or    HeadAlimonyper2007 = 2 or    HeadAlimonyper2007 ge 7 then    HeadAlimony2007 = .;  
if   HeadChldSpptper2007 = 1 or   HeadChldSpptper2007 = 2 or   HeadChldSpptper2007 ge 7 then   HeadChldSppt2007 = .;  
if   WifeChldSpptper2007 = 1 or   WifeChldSpptper2007 = 2 or   WifeChldSpptper2007 ge 7 then   WifeChldSppt2007 = .;  
if    HeadRelHelpper2007 = 1 or    HeadRelHelpper2007 = 2 or    HeadRelHelpper2007 ge 7 then    HeadRelHelp2007 = .;  
if    WifeRelHelpper2007 = 1 or    WifeRelHelpper2007 = 2 or    WifeRelHelpper2007 ge 7 then    WifeRelHelp2007 = .;  
if HeadNonRelHelpper2007 = 1 or HeadNonRelHelpper2007 = 2 or HeadNonRelHelpper2007 ge 7 then HeadNonRelHelp2007 = .;  
if WifeNonRelHelpper2007 = 1 or WifeNonRelHelpper2007 = 2 or WifeNonRelHelpper2007 ge 7 then WifeNonRelHelp2007 = .;  
if  HeadOthIncomeper2007 = 1 or  HeadOthIncomeper2007 = 2 or  HeadOthIncomeper2007 ge 7 then  HeadOthIncome2007 = .;  
if  WifeOthIncomeper2007 = 1 or  WifeOthIncomeper2007 = 2 or  WifeOthIncomeper2007 ge 7 then  WifeOthIncome2007 = .;  

if  HeadRmmrlaborper2007 = 0 then  HeadRmmrlabor2007 = 0;                                                                                                                                                                                                    
if       HeadRentper2007 = 0 then       HeadRent2007 = 0;                                                                                                                                                                                                    
if   HeadDividendper2007 = 0 then   HeadDividend2007 = 0;                                                                                                                                                                                                    
if   HeadInterestper2007 = 0 then   HeadInterest2007 = 0;                                                                                                                                                                                                    
if  RHeadDividendper2007 = 0 then  RHeadDividend2007 = 0;                                                                                                                                                                                                    
if  RHeadInterestper2007 = 0 then  RHeadInterest2007 = 0;                                                                                                                                                                                                    
if  HeadTrustFundper2007 = 0 then  HeadTrustFund2007 = 0;                                                                                                                                                                                                    
if   WifeDividendper2007 = 0 then   WifeDividend2007 = 0;                                                                                                                                                                                                    
if   WifeInterestper2007 = 0 then   WifeInterest2007 = 0;                                                                                                                                                                                                    
if  WifeTrustFundper2007 = 0 then  WifeTrustFund2007 = 0;                                                                                                                                                                                                    
if        HeadADCper2007 = 0 then        HeadADC2007 = 0;                                                                                                                                                                                                    
if        WifeADCper2007 = 0 then        WifeADC2007 = 0;                                                                                                                                                                                                    
if  HeadRetIncVetper2007 = 0 then  HeadRetIncVet2007 = 0;                                                                                                                                                                                                    
if   HeadRetIncNVper2007 = 0 then   HeadRetIncNV2007 = 0;                                                                                                                                                                                                    
if    HeadSuppSecper2007 = 0 then    HeadSuppSec2007 = 0;                                                                                                                                                                                                    
if    WifeSuppSecper2007 = 0 then    WifeSuppSec2007 = 0;                                                                                                                                                                                                    
if     HeadOthWelper2007 = 0 then     HeadOthWel2007 = 0;                                                                                                                                                                                                    
if     WifeOthWelper2007 = 0 then     WifeOthWel2007 = 0;                                                                                                                                                                                                    
if    HeadAnnuityper2007 = 0 then    HeadAnnuity2007 = 0;                                                                                                                                                                                                    
if    WifeAnnuityper2007 = 0 then    WifeAnnuity2007 = 0;                                                                                                                                                                                                    
if     HeadOthRetper2007 = 0 then     HeadOthRet2007 = 0;                                                                                                                                                                                                    
if      HeadUnempper2007 = 0 then      HeadUnemp2007 = 0;                                                                                                                                                                                                    
if      WifeUnempper2007 = 0 then      WifeUnemp2007 = 0;                                                                                                                                                                                                    
if    HeadWorkmanper2007 = 0 then    HeadWorkman2007 = 0;                                                                                                                                                                                                    
if    WifeWorkmanper2007 = 0 then    WifeWorkman2007 = 0;                                                                                                                                                                                                    
if    HeadAlimonyper2007 = 0 then    HeadAlimony2007 = 0;                                                                                                                                                                                                    
if   HeadChldSpptper2007 = 0 then   HeadChldSppt2007 = 0;                                                                                                                                                                                                    
if   WifeChldSpptper2007 = 0 then   WifeChldSppt2007 = 0;                                                                                                                                                                                                    
if    HeadRelHelpper2007 = 0 then    HeadRelHelp2007 = 0;                                                                                                                                                                                                    
if    WifeRelHelpper2007 = 0 then    WifeRelHelp2007 = 0;                                                                                                                                                                                                    
if HeadNonRelHelpper2007 = 0 then HeadNonRelHelp2007 = 0;                                                                                                                                                                                                    
if WifeNonRelHelpper2007 = 0 then WifeNonRelHelp2007 = 0;                                                                                                                                                                                                    
if  HeadOthIncomeper2007 = 0 then  HeadOthIncome2007 = 0;                                                                                                                                                                                                    
if  WifeOthIncomeper2007 = 0 then  WifeOthIncome2007 = 0;               

if RHeadDividend2007 > 0 then HeadDividend2007 = RHeadDividend2007;
if RHeadInterest2007 > 0 then HeadInterest2007 = RHeadInterest2007;*/

keep id2007 HeadExtraInclude2007
HeadRmmrlabor2007          
HeadRent2007               
HeadDividend2007           
HeadInterest2007           
HeadTrustFund2007          
HeadFarm2007 				   
TotalFarm2007 
HeadBus2007 				       
HeadBusAsset2007 		       
WifeRent2007
WifeDividend2007           
WifeInterest2007           
WifeTrustFund2007          
HeadADC2007                
WifeADC2007 
HeadSSI2007
WifeSSI2007 
HeadRetIncVet2007          
HeadRetIncNV2007           
HeadSuppSec2007            
WifeSuppSec2007            
HeadOthWel2007             
WifeOthWel2007             
HeadAnnuity2007            
WifeAnnuity2007            
HeadOthRet2007             
HeadUnemp2007              
WifeUnemp2007              
HeadWorkman2007            
WifeWorkman2007            
HeadAlimony2007            
HeadChldSppt2007           
WifeChldSppt2007           
HeadRelHelp2007            
WifeRelHelp2007            
HeadNonRelHelp2007         
WifeNonRelHelp2007         
HeadOthIncome2007          
WifeOthIncome2007          
Faminc2007                 
HWtaxable2007    		       
HeadLabor2007				       
HeadBusLabor2007 		       
HeadBonus2007				       
HeadOvertime2007		       
HeadTips2007 				       
HeadCommission2007 	       
HeadOthJob2007 			       
HeadProf2007 				       
HeadMktGrdnLabor2007       
HeadExtraJob2007		       
HeadSalary2007			       
WifeLabor2007 			       
WifeSalary2007 			       
WifeBusLabor2007 		       
HWTrans2007                
OthTaxable2007 			       
OthTrans2007 				       
;

proc means data = psiddata.income2007;
run; 
