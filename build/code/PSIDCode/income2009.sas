*********Retrieve and process income data from 1994 family and income plus data files        ********* 
*********After 1993, income data collection and release are changed significantly, from 1994 *********
*********to 2001, some income data are processed and released in the income plus data files  *********
*********However, there are still many income components contained only in the main family   *********
*********data. I process the income components using the family data if these variables are  *********
*********not included in the income plus data. In addition, many variable in the main data   ********* 
*********employ the per format, which changed before and after 1995.  In the 2009 wave       *********
*********processed variables were added so we do not have to compute annual income using     *********
*********the per variables.                                                                  *********
*********Geng Li and Michael Mulhall December 2008                                           *********;

data psiddata.income2009;                                                                                                                                                                                                                             
set psiddata.fam09;                                                                                                                                                                                                                          
                                                                                                                                                                                                                                             
id2009 = ER42002;                                                                                                                                                                                                                             
Faminc2009 = ER46935;                                                                                                                                                                                                                        
	HWtaxable2009 = ER46851 ;                                                                                                                                                                                                                   
		HeadLabor2009 = ER46829 ;                                                                                                                                                                                                                 
			HeadBusLabor2009 = ER46808 ;                                                                                                                                                                                                            
			HeadBonus2009 = ER46813 ;                                                                                                                                                                                                               
			HeadOvertime2009 = ER46815;                                                                                                                                                                                                             
			HeadTips2009 = ER46817;                                                                                                                                                                                                                 
			HeadCommission2009 = ER46819;                                                                                                                                                                                                           
			HeadOthJob2009 = ER46825;                                                                                                                                                                                                               
			HeadProf2009 = ER46821 ;                                                                                                                                                                                                                
			HeadMktGrdnLabor2009 = ER46823 ;                                                                                                                                                                                                        
            HeadExtraInclude2009 =  ER42989;
            HeadExtraJob2009 = ER46827;                                                                                                                                                                                                             
			HeadSalary2009 = ER46811;                                                                                                                                                                                                              
                                                                                                                                                                                                                                             
		WifeLabor2009 = ER46841 ;                                                                                                                                                                                                                 
		    WifeSalary2009 = ER43290;
			WifeBusLabor2009 = ER46838;                                                                                                                                                                                                             
 
        HeadFarm2009 = ER46806;                                                                                                                                                                                                                                     
        TotalFarm2009 = ER46806;        
		HeadBus2009 = ER46803;
        HeadBusAsset2009 = ER46809;                                                                                                                                                                                                 
     	HeadRmmrlabor2009 = 0;   
		HeadRent2009 = ER46830; 
		WifeRent2009 = ER46843; 
		HeadDividend2009 = ER46832;
        HeadInterest2009 = ER46834; 
 		HeadTrustFund2009 = ER46836;                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  
    	WifeBusAsset2009 = ER46839;                                                                                                                                                                                                               
		WifeDividend2009 = ER46845;                                                                                                                                          
 		WifeInterest2009 = ER46847;                                                                                                                                                                                                              
 		WifeTrustFund2009 = ER46849;                                                                                                                                                                                                              
                                                                                                                                                                                                                                             
                                                                                                                                                                                                                                             
    HWTrans2009 = ER46900;                                                                                                                                                                                                                    
        HeadADC2009 = ER46852;                                                                                                                                                                                                        
	    WifeADC2009 = ER46880;                                                                                                                                                                                                                  
	    HeadSSI2009 = ER46929;                                                                                                                                                                                                                  
	    WifeSSI2009 = ER46931;                                                                                                                                                                                                                  
        HeadRetIncVet2009 = ER46858;                                                                                                                                                                                                          
		HeadRetIncNV2009 = ER46860;                                                                                                                                                                                                          
        HeadAnnuity2009 = ER46862;                                                                                                                                                                                                            
        WifeAnnuity2009 = ER46886;                                                                                                                                                                                                            
        HeadOthRet2009 = ER46864;                                                                                                                                                                                                         
        HeadUnemp2009 = ER46866;	                                                                                                                          
        WifeUnemp2009 = ER46888;                                                                                                                                                                                                              
        HeadWorkman2009 = ER46868;                                                                                                                                                                                                            
        WifeWorkman2009 = ER46890;                                                                                                                                                                                                           
        HeadAlimony2009 = ER46872;                                                                                                                                                                                                            
		HeadChldSppt2009 = ER46870;                                                                                                                                                                                                             
		WifeChldSppt2009 = ER46892;                                                                                                                                                                                                              
	    HeadRelHelp2009 = ER46874;                                                                                                                                                                                                              
	    WifeRelHelp2009 = ER46894;                                                                                                                                                                                                              
	    HeadNonRelHelp2009 = ER46876;                                                                                                                                                                                                       
	    WifeNonRelHelp2009 = ER46896;                                                                                                                                                                                                       
		HeadSuppSec2009 = ER46854;                                                                                                                                                                                                                
		WifeSuppSec2009 = ER46882;                                                                                                                                                                                                                
	    HeadOthIncome2009 = ER46878;                                                                                                                                                                                                                  
		WifeOthIncome2009 = ER46898;
        HeadOthWel2009 = ER46898;                                                                                                                                                                                                            
		WifeOthWel2009 = ER46884;                                                                                                                                                                                                                
    
	OthTaxable2009 = ER46907;                                                                                                                                                                                                                  
	OthTrans2009 = ER46928;                                                                                                                                                                                                                    

/*if    WifeSalary2009        ge     9999996.00    then      WifeSalary2009          =      .;      
if    HeadRmmrlabor2009     ge     9999996.00    then      HeadRmmrlabor2009       =      .;      
if    HeadRent2009          ge      999996.00    then      HeadRent2009            =      .;      
if    HeadDividend2009      ge      999996.00    then      HeadDividend2009        =      .;      
if    HeadInterest2009      ge      999996.00    then      HeadInterest2009        =      .;      
if    RHeadDividend2009     ge      999996.00    then     RHeadDividend2009        =      .;      
if    RHeadInterest2009     ge      999996.00    then     RHeadInterest2009        =      .;      
if    HeadTrustFund2009     ge      999996.00    then      HeadTrustFund2009       =      .;      
if    WifeDividend2009      ge      999996.00    then      WifeDividend2009        =      .;      
if    WifeInterest2009      ge      999996.00    then      WifeInterest2009        =      .;      
if    WifeTrustFund2009     ge      999996.00    then      WifeTrustFund2009       =      .;      
if    HeadADC2009           ge      999996.00    then      HeadADC2009             =      .;      
if    WifeADC2009           ge       99996.00    then      WifeADC2009             =      .;      
if    HeadRetIncVet2009     ge       99996.00    then      HeadRetIncVet2009       =      .;      
if    HeadRetIncNV2009      ge      999996.00    then      HeadRetIncNV2009        =      .;      
if    HeadAnnuity2009       ge      999996.00    then      HeadAnnuity2009         =      .;      
if    WifeAnnuity2009       ge       99996.00    then      WifeAnnuity2009         =      .;      
if    HeadOthRet2009        ge      999996.00    then      HeadOthRet2009          =      .;      
if    HeadUnemp2009         ge       99996.00    then      HeadUnemp2009           =      .;      
if    WifeUnemp2009         ge       99996.00    then      WifeUnemp2009           =      .;      
if    HeadWorkman2009       ge       99996.00    then      HeadWorkman2009         =      .;      
if    WifeWorkman2009       ge       99996.00    then      WifeWorkman2009         =      .;      
if    HeadAlimony2009       ge       99996.00    then      HeadAlimony2009         =      .;      
if    HeadChldSppt2009      ge       99996.00    then      HeadChldSppt2009        =      .;      
if    WifeChldSppt2009      ge       99996.00    then      WifeChldSppt2009        =      .;      
if    HeadRelHelp2009       ge       99996.00    then      HeadRelHelp2009         =      .;      
if    WifeRelHelp2009       ge       99996.00    then      WifeRelHelp2009         =      .;      
if    HeadNonRelHelp2009    ge       99996.00    then      HeadNonRelHelp2009      =      .;      
if    WifeNonRelHelp2009    ge       99996.00    then      WifeNonRelHelp2009      =      .;      
if    HeadSuppSec2009       ge      999996.00    then      HeadSuppSec2009         =      .;      
if    WifeSuppSec2009       ge       99996.00    then      WifeSuppSec2009         =      .;      
if    HeadOthWel2009        ge      999996.00    then      HeadOthWel2009          =      .;      
if    WifeOthWel2009        ge       99996.00    then      WifeOthWel2009          =      .;      
if    HeadOthIncome2009     ge       99996.00    then      HeadOthIncome2009       =      .;      
if    WifeOthIncome2009     ge       99996.00    then      WifeOthIncome2009       =      .;      
                                                                                                                                                             
HeadRmmrlabor2009       = HeadRmmrlabor2009  * (52 * ( HeadRmmrlaborper2009 = 3) + 26 * ( HeadRmmrlaborper2009 = 4) +  12 * ( HeadRmmrlaborper2009 = 5) + ( HeadRmmrlaborper2009 = 6));
HeadRent2009            = HeadRent2009       * (52 * (      HeadRentper2009 = 3) + 26 * (      HeadRentper2009 = 4) +  12 * (      HeadRentper2009 = 5) + (      HeadRentper2009 = 6));
HeadDividend2009        = HeadDividend2009   * (52 * (  HeadDividendper2009 = 3) + 26 * (  HeadDividendper2009 = 4) +  12 * (  HeadDividendper2009 = 5) + (  HeadDividendper2009 = 6));
HeadInterest2009        = HeadInterest2009   * (52 * (  HeadInterestper2009 = 3) + 26 * (  HeadInterestper2009 = 4) +  12 * (  HeadInterestper2009 = 5) + (  HeadInterestper2009 = 6));
RHeadDividend2009       = RHeadDividend2009  * (52 * ( RHeadDividendper2009 = 3) + 26 * ( RHeadDividendper2009 = 4) +  12 * ( RHeadDividendper2009 = 5) + ( RHeadDividendper2009 = 6));
RHeadInterest2009       = RHeadInterest2009  * (52 * ( RHeadInterestper2009 = 3) + 26 * ( RHeadInterestper2009 = 4) +  12 * ( RHeadInterestper2009 = 5) + ( RHeadInterestper2009 = 6));
HeadTrustFund2009       = HeadTrustFund2009  * (52 * ( HeadTrustFundper2009 = 3) + 26 * ( HeadTrustFundper2009 = 4) +  12 * ( HeadTrustFundper2009 = 5) + ( HeadTrustFundper2009 = 6));
WifeDividend2009        = WifeDividend2009   * (52 * (  WifeDividendper2009 = 3) + 26 * (  WifeDividendper2009 = 4) +  12 * (  WifeDividendper2009 = 5) + (  WifeDividendper2009 = 6));
WifeInterest2009        = WifeInterest2009   * (52 * (  WifeInterestper2009 = 3) + 26 * (  WifeInterestper2009 = 4) +  12 * (  WifeInterestper2009 = 5) + (  WifeInterestper2009 = 6));
WifeTrustFund2009       = WifeTrustFund2009  * (52 * ( WifeTrustFundper2009 = 3) + 26 * ( WifeTrustFundper2009 = 4) +  12 * ( WifeTrustFundper2009 = 5) + ( WifeTrustFundper2009 = 6));
HeadADC2009             = HeadADC2009        * (52 * (       HeadADCper2009 = 3) + 26 * (       HeadADCper2009 = 4) +  12 * (       HeadADCper2009 = 5) + (       HeadADCper2009 = 6));
WifeADC2009             = WifeADC2009        * (52 * (       WifeADCper2009 = 3) + 26 * (       WifeADCper2009 = 4) +  12 * (       WifeADCper2009 = 5) + (       WifeADCper2009 = 6));
HeadRetIncVet2009       = HeadRetIncVet2009  * (52 * ( HeadRetIncVetper2009 = 3) + 26 * ( HeadRetIncVetper2009 = 4) +  12 * ( HeadRetIncVetper2009 = 5) + ( HeadRetIncVetper2009 = 6));
HeadRetIncNV2009        = HeadRetIncNV2009   * (52 * (  HeadRetIncNVper2009 = 3) + 26 * (  HeadRetIncNVper2009 = 4) +  12 * (  HeadRetIncNVper2009 = 5) + (  HeadRetIncNVper2009 = 6));
HeadSuppSec2009         = HeadSuppSec2009    * (52 * (   HeadSuppSecper2009 = 3) + 26 * (   HeadSuppSecper2009 = 4) +  12 * (   HeadSuppSecper2009 = 5) + (   HeadSuppSecper2009 = 6));
WifeSuppSec2009         = WifeSuppSec2009    * (52 * (   WifeSuppSecper2009 = 3) + 26 * (   WifeSuppSecper2009 = 4) +  12 * (   WifeSuppSecper2009 = 5) + (   WifeSuppSecper2009 = 6));
HeadOthWel2009          = HeadOthWel2009     * (52 * (    HeadOthWelper2009 = 3) + 26 * (    HeadOthWelper2009 = 4) +  12 * (    HeadOthWelper2009 = 5) + (    HeadOthWelper2009 = 6));
WifeOthWel2009          = WifeOthWel2009     * (52 * (    WifeOthWelper2009 = 3) + 26 * (    WifeOthWelper2009 = 4) +  12 * (    WifeOthWelper2009 = 5) + (    WifeOthWelper2009 = 6));
HeadAnnuity2009         = HeadAnnuity2009    * (52 * (   HeadAnnuityper2009 = 3) + 26 * (   HeadAnnuityper2009 = 4) +  12 * (   HeadAnnuityper2009 = 5) + (   HeadAnnuityper2009 = 6));
WifeAnnuity2009         = WifeAnnuity2009    * (52 * (   WifeAnnuityper2009 = 3) + 26 * (   WifeAnnuityper2009 = 4) +  12 * (   WifeAnnuityper2009 = 5) + (   WifeAnnuityper2009 = 6));
HeadOthRet2009          = HeadOthRet2009     * (52 * (    HeadOthRetper2009 = 3) + 26 * (    HeadOthRetper2009 = 4) +  12 * (    HeadOthRetper2009 = 5) + (    HeadOthRetper2009 = 6));
HeadUnemp2009           = HeadUnemp2009      * (52 * (     HeadUnempper2009 = 3) + 26 * (     HeadUnempper2009 = 4) +  12 * (     HeadUnempper2009 = 5) + (     HeadUnempper2009 = 6));
WifeUnemp2009           = WifeUnemp2009      * (52 * (     WifeUnempper2009 = 3) + 26 * (     WifeUnempper2009 = 4) +  12 * (     WifeUnempper2009 = 5) + (     WifeUnempper2009 = 6));
HeadWorkman2009         = HeadWorkman2009    * (52 * (   HeadWorkmanper2009 = 3) + 26 * (   HeadWorkmanper2009 = 4) +  12 * (   HeadWorkmanper2009 = 5) + (   HeadWorkmanper2009 = 6));
WifeWorkman2009         = WifeWorkman2009    * (52 * (   WifeWorkmanper2009 = 3) + 26 * (   WifeWorkmanper2009 = 4) +  12 * (   WifeWorkmanper2009 = 5) + (   WifeWorkmanper2009 = 6));
HeadAlimony2009         = HeadAlimony2009    * (52 * (   HeadAlimonyper2009 = 3) + 26 * (   HeadAlimonyper2009 = 4) +  12 * (   HeadAlimonyper2009 = 5) + (   HeadAlimonyper2009 = 6));
HeadChldSppt2009        = HeadChldSppt2009   * (52 * (  HeadChldSpptper2009 = 3) + 26 * (  HeadChldSpptper2009 = 4) +  12 * (  HeadChldSpptper2009 = 5) + (  HeadChldSpptper2009 = 6));
WifeChldSppt2009        = WifeChldSppt2009   * (52 * (  WifeChldSpptper2009 = 3) + 26 * (  WifeChldSpptper2009 = 4) +  12 * (  WifeChldSpptper2009 = 5) + (  WifeChldSpptper2009 = 6));
HeadRelHelp2009         = HeadRelHelp2009    * (52 * (   HeadRelHelpper2009 = 3) + 26 * (   HeadRelHelpper2009 = 4) +  12 * (   HeadRelHelpper2009 = 5) + (   HeadRelHelpper2009 = 6));
WifeRelHelp2009         = WifeRelHelp2009    * (52 * (   WifeRelHelpper2009 = 3) + 26 * (   WifeRelHelpper2009 = 4) +  12 * (   WifeRelHelpper2009 = 5) + (   WifeRelHelpper2009 = 6));
HeadNonRelHelp2009      = HeadNonRelHelp2009 * (52 * (HeadNonRelHelpper2009 = 3) + 26 * (HeadNonRelHelpper2009 = 4) +  12 * (HeadNonRelHelpper2009 = 5) + (HeadNonRelHelpper2009 = 6));
WifeNonRelHelp2009      = WifeNonRelHelp2009 * (52 * (WifeNonRelHelpper2009 = 3) + 26 * (WifeNonRelHelpper2009 = 4) +  12 * (WifeNonRelHelpper2009 = 5) + (WifeNonRelHelpper2009 = 6));
HeadOthIncome2009       = HeadOthIncome2009  * (52 * ( HeadOthIncomeper2009 = 3) + 26 * ( HeadOthIncomeper2009 = 4) +  12 * ( HeadOthIncomeper2009 = 5) + ( HeadOthIncomeper2009 = 6));
WifeOthIncome2009       = WifeOthIncome2009  * (52 * ( WifeOthIncomeper2009 = 3) + 26 * ( WifeOthIncomeper2009 = 4) +  12 * ( WifeOthIncomeper2009 = 5) + ( WifeOthIncomeper2009 = 6));

if  HeadRmmrlaborper2009 = 1 or  HeadRmmrlaborper2009 = 2 or  HeadRmmrlaborper2009 ge 7 then  HeadRmmrlabor2009 = .;  
if       HeadRentper2009 = 1 or       HeadRentper2009 = 2 or       HeadRentper2009 ge 7 then       HeadRent2009 = .;  
if   HeadDividendper2009 = 1 or   HeadDividendper2009 = 2 or   HeadDividendper2009 ge 7 then   HeadDividend2009 = .;  
if   HeadInterestper2009 = 1 or   HeadInterestper2009 = 2 or   HeadInterestper2009 ge 7 then   HeadInterest2009 = .;  
if  RHeadDividendper2009 = 1 or  RHeadDividendper2009 = 2 or  RHeadDividendper2009 ge 7 then  RHeadDividend2009 = .;  
if  RHeadInterestper2009 = 1 or  RHeadInterestper2009 = 2 or  RHeadInterestper2009 ge 7 then  RHeadInterest2009 = .;  
if  HeadTrustFundper2009 = 1 or  HeadTrustFundper2009 = 2 or  HeadTrustFundper2009 ge 7 then  HeadTrustFund2009 = .;  
if   WifeDividendper2009 = 1 or   WifeDividendper2009 = 2 or   WifeDividendper2009 ge 7 then   WifeDividend2009 = .;  
if   WifeInterestper2009 = 1 or   WifeInterestper2009 = 2 or   WifeInterestper2009 ge 7 then   WifeInterest2009 = .;  
if  WifeTrustFundper2009 = 1 or  WifeTrustFundper2009 = 2 or  WifeTrustFundper2009 ge 7 then  WifeTrustFund2009 = .;  
if        HeadADCper2009 = 1 or        HeadADCper2009 = 2 or        HeadADCper2009 ge 7 then        HeadADC2009 = .;  
if        WifeADCper2009 = 1 or        WifeADCper2009 = 2 or        WifeADCper2009 ge 7 then        WifeADC2009 = .;  
if  HeadRetIncVetper2009 = 1 or  HeadRetIncVetper2009 = 2 or  HeadRetIncVetper2009 ge 7 then  HeadRetIncVet2009 = .;  
if   HeadRetIncNVper2009 = 1 or   HeadRetIncNVper2009 = 2 or   HeadRetIncNVper2009 ge 7 then   HeadRetIncNV2009 = .;  
if    HeadSuppSecper2009 = 1 or    HeadSuppSecper2009 = 2 or    HeadSuppSecper2009 ge 7 then    HeadSuppSec2009 = .;  
if    WifeSuppSecper2009 = 1 or    WifeSuppSecper2009 = 2 or    WifeSuppSecper2009 ge 7 then    WifeSuppSec2009 = .;  
if     HeadOthWelper2009 = 1 or     HeadOthWelper2009 = 2 or     HeadOthWelper2009 ge 7 then     HeadOthWel2009 = .;  
if     WifeOthWelper2009 = 1 or     WifeOthWelper2009 = 2 or     WifeOthWelper2009 ge 7 then     WifeOthWel2009 = .;  
if    HeadAnnuityper2009 = 1 or    HeadAnnuityper2009 = 2 or    HeadAnnuityper2009 ge 7 then    HeadAnnuity2009 = .;  
if    WifeAnnuityper2009 = 1 or    WifeAnnuityper2009 = 2 or    WifeAnnuityper2009 ge 7 then    WifeAnnuity2009 = .;  
if     HeadOthRetper2009 = 1 or     HeadOthRetper2009 = 2 or     HeadOthRetper2009 ge 7 then     HeadOthRet2009 = .;  
if      HeadUnempper2009 = 1 or      HeadUnempper2009 = 2 or      HeadUnempper2009 ge 7 then      HeadUnemp2009 = .;  
if      WifeUnempper2009 = 1 or      WifeUnempper2009 = 2 or      WifeUnempper2009 ge 7 then      WifeUnemp2009 = .;  
if    HeadWorkmanper2009 = 1 or    HeadWorkmanper2009 = 2 or    HeadWorkmanper2009 ge 7 then    HeadWorkman2009 = .;  
if    WifeWorkmanper2009 = 1 or    WifeWorkmanper2009 = 2 or    WifeWorkmanper2009 ge 7 then    WifeWorkman2009 = .;  
if    HeadAlimonyper2009 = 1 or    HeadAlimonyper2009 = 2 or    HeadAlimonyper2009 ge 7 then    HeadAlimony2009 = .;  
if   HeadChldSpptper2009 = 1 or   HeadChldSpptper2009 = 2 or   HeadChldSpptper2009 ge 7 then   HeadChldSppt2009 = .;  
if   WifeChldSpptper2009 = 1 or   WifeChldSpptper2009 = 2 or   WifeChldSpptper2009 ge 7 then   WifeChldSppt2009 = .;  
if    HeadRelHelpper2009 = 1 or    HeadRelHelpper2009 = 2 or    HeadRelHelpper2009 ge 7 then    HeadRelHelp2009 = .;  
if    WifeRelHelpper2009 = 1 or    WifeRelHelpper2009 = 2 or    WifeRelHelpper2009 ge 7 then    WifeRelHelp2009 = .;  
if HeadNonRelHelpper2009 = 1 or HeadNonRelHelpper2009 = 2 or HeadNonRelHelpper2009 ge 7 then HeadNonRelHelp2009 = .;  
if WifeNonRelHelpper2009 = 1 or WifeNonRelHelpper2009 = 2 or WifeNonRelHelpper2009 ge 7 then WifeNonRelHelp2009 = .;  
if  HeadOthIncomeper2009 = 1 or  HeadOthIncomeper2009 = 2 or  HeadOthIncomeper2009 ge 7 then  HeadOthIncome2009 = .;  
if  WifeOthIncomeper2009 = 1 or  WifeOthIncomeper2009 = 2 or  WifeOthIncomeper2009 ge 7 then  WifeOthIncome2009 = .;  

if  HeadRmmrlaborper2009 = 0 then  HeadRmmrlabor2009 = 0;                                                                                                                                                                                                    
if       HeadRentper2009 = 0 then       HeadRent2009 = 0;                                                                                                                                                                                                    
if   HeadDividendper2009 = 0 then   HeadDividend2009 = 0;                                                                                                                                                                                                    
if   HeadInterestper2009 = 0 then   HeadInterest2009 = 0;                                                                                                                                                                                                    
if  RHeadDividendper2009 = 0 then  RHeadDividend2009 = 0;                                                                                                                                                                                                    
if  RHeadInterestper2009 = 0 then  RHeadInterest2009 = 0;                                                                                                                                                                                                    
if  HeadTrustFundper2009 = 0 then  HeadTrustFund2009 = 0;                                                                                                                                                                                                    
if   WifeDividendper2009 = 0 then   WifeDividend2009 = 0;                                                                                                                                                                                                    
if   WifeInterestper2009 = 0 then   WifeInterest2009 = 0;                                                                                                                                                                                                    
if  WifeTrustFundper2009 = 0 then  WifeTrustFund2009 = 0;                                                                                                                                                                                                    
if        HeadADCper2009 = 0 then        HeadADC2009 = 0;                                                                                                                                                                                                    
if        WifeADCper2009 = 0 then        WifeADC2009 = 0;                                                                                                                                                                                                    
if  HeadRetIncVetper2009 = 0 then  HeadRetIncVet2009 = 0;                                                                                                                                                                                                    
if   HeadRetIncNVper2009 = 0 then   HeadRetIncNV2009 = 0;                                                                                                                                                                                                    
if    HeadSuppSecper2009 = 0 then    HeadSuppSec2009 = 0;                                                                                                                                                                                                    
if    WifeSuppSecper2009 = 0 then    WifeSuppSec2009 = 0;                                                                                                                                                                                                    
if     HeadOthWelper2009 = 0 then     HeadOthWel2009 = 0;                                                                                                                                                                                                    
if     WifeOthWelper2009 = 0 then     WifeOthWel2009 = 0;                                                                                                                                                                                                    
if    HeadAnnuityper2009 = 0 then    HeadAnnuity2009 = 0;                                                                                                                                                                                                    
if    WifeAnnuityper2009 = 0 then    WifeAnnuity2009 = 0;                                                                                                                                                                                                    
if     HeadOthRetper2009 = 0 then     HeadOthRet2009 = 0;                                                                                                                                                                                                    
if      HeadUnempper2009 = 0 then      HeadUnemp2009 = 0;                                                                                                                                                                                                    
if      WifeUnempper2009 = 0 then      WifeUnemp2009 = 0;                                                                                                                                                                                                    
if    HeadWorkmanper2009 = 0 then    HeadWorkman2009 = 0;                                                                                                                                                                                                    
if    WifeWorkmanper2009 = 0 then    WifeWorkman2009 = 0;                                                                                                                                                                                                    
if    HeadAlimonyper2009 = 0 then    HeadAlimony2009 = 0;                                                                                                                                                                                                    
if   HeadChldSpptper2009 = 0 then   HeadChldSppt2009 = 0;                                                                                                                                                                                                    
if   WifeChldSpptper2009 = 0 then   WifeChldSppt2009 = 0;                                                                                                                                                                                                    
if    HeadRelHelpper2009 = 0 then    HeadRelHelp2009 = 0;                                                                                                                                                                                                    
if    WifeRelHelpper2009 = 0 then    WifeRelHelp2009 = 0;                                                                                                                                                                                                    
if HeadNonRelHelpper2009 = 0 then HeadNonRelHelp2009 = 0;                                                                                                                                                                                                    
if WifeNonRelHelpper2009 = 0 then WifeNonRelHelp2009 = 0;                                                                                                                                                                                                    
if  HeadOthIncomeper2009 = 0 then  HeadOthIncome2009 = 0;                                                                                                                                                                                                    
if  WifeOthIncomeper2009 = 0 then  WifeOthIncome2009 = 0;               

if RHeadDividend2009 > 0 then HeadDividend2009 = RHeadDividend2009;
if RHeadInterest2009 > 0 then HeadInterest2009 = RHeadInterest2009;*/

keep id2009 HeadExtraInclude2009
HeadRmmrlabor2009          
HeadRent2009               
HeadDividend2009           
HeadInterest2009           
HeadTrustFund2009          
HeadFarm2009 				   
TotalFarm2009 
HeadBus2009 				       
HeadBusAsset2009 		       
WifeRent2009
WifeDividend2009           
WifeInterest2009           
WifeTrustFund2009          
HeadADC2009                
WifeADC2009 
HeadSSI2009
WifeSSI2009 
HeadRetIncVet2009          
HeadRetIncNV2009           
HeadSuppSec2009            
WifeSuppSec2009            
HeadOthWel2009             
WifeOthWel2009             
HeadAnnuity2009            
WifeAnnuity2009            
HeadOthRet2009             
HeadUnemp2009              
WifeUnemp2009              
HeadWorkman2009            
WifeWorkman2009            
HeadAlimony2009            
HeadChldSppt2009           
WifeChldSppt2009           
HeadRelHelp2009            
WifeRelHelp2009            
HeadNonRelHelp2009         
WifeNonRelHelp2009         
HeadOthIncome2009          
WifeOthIncome2009          
Faminc2009                 
HWtaxable2009    		       
HeadLabor2009				       
HeadBusLabor2009 		       
HeadBonus2009				       
HeadOvertime2009		       
HeadTips2009 				       
HeadCommission2009 	       
HeadOthJob2009 			       
HeadProf2009 				       
HeadMktGrdnLabor2009       
HeadExtraJob2009		       
HeadSalary2009			       
WifeLabor2009 			       
WifeSalary2009 			       
WifeBusLabor2009 		       
HWTrans2009                
OthTaxable2009 			       
OthTrans2009 				       
;

proc means data = psiddata.income2009;
run; 
