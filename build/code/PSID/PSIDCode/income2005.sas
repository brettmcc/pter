*********Retrieve and process income data from 1994 family and income plus data files        ********* 
*********After 1993, income data collection and release are changed significantly, from 1994 *********
*********to 2001, some income data are processed and released in the income plus data files  *********
*********However, there are still many income components contained only in the main family   *********
*********data. I process the income components using the family data if these variables are  *********
*********not included in the income plus data. In addition, many variable in the main data   ********* 
*********employ the per format, which changed before and after 1995.  In the 2005 wave       *********
*********processed variables were added so we do not have to compute annual income using     *********
*********the per variables.                                                                  *********
*********Geng Li and Michael Mulhall December 2008                                           *********;

data psiddata.income2005;                                                                                                                                                                                                                             
set psiddata.fam05;                                                                                                                                                                                                                          
                                                                                                                                                                                                                                             
id2005 = ER25002;                                                                                                                                                                                                                             
Faminc2005 = ER28037;                                                                                                                                                                                                                        
	HWtaxable2005 = ER27953 ;                                                                                                                                                                                                                   
		HeadLabor2005 = ER27931 ;                                                                                                                                                                                                                 
			HeadBusLabor2005 = ER27910 ;                                                                                                                                                                                                            
			HeadBonus2005 = ER27915 ;                                                                                                                                                                                                               
			HeadOvertime2005 = ER27917;                                                                                                                                                                                                             
			HeadTips2005 = ER27919;                                                                                                                                                                                                                 
			HeadCommission2005 = ER27921;                                                                                                                                                                                                           
			HeadOthJob2005 = ER27927;                                                                                                                                                                                                               
			HeadProf2005 = ER27923 ;                                                                                                                                                                                                                
			HeadMktGrdnLabor2005 = ER27925 ;                                                                                                                                                                                                        
            HeadExtraInclude2005 =  ER25980;
            HeadExtraJob2005 = ER27929;                                                                                                                                                                                                             
			HeadSalary2005 = ER27913;                                                                                                                                                                                                              
                                                                                                                                                                                                                                             
		WifeLabor2005 = ER27943 ;                                                                                                                                                                                                                 
		    WifeSalary2005 = ER26281;
			WifeBusLabor2005 = ER27940;                                                                                                                                                                                                             
 
        HeadFarm2005 = ER27908;                                                                                                                                                                                                                                     
        TotalFarm2005 = ER27908;        
		HeadBus2005 = ER27905;
        HeadBusAsset2005 = ER27911;                                                                                                                                                                                                 
     	HeadRmmrlabor2005 = 0;   
		HeadRent2005 = ER27932; 
		WifeRent2005 = ER27945; 
		HeadDividend2005 = ER27934;
        HeadInterest2005 = ER27936; 
 		HeadTrustFund2005 = ER27938;                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  
    	WifeBusAsset2005 = ER27941;                                                                                                                                                                                                               
		WifeDividend2005 = ER27947;                                                                                                                                          
 		WifeInterest2005 = ER27949;                                                                                                                                                                                                              
 		WifeTrustFund2005 = ER27951;                                                                                                                                                                                                              
                                                                                                                                                                                                                                             
                                                                                                                                                                                                                                             
    HWTrans2005 = ER28002;                                                                                                                                                                                                                    
        HeadADC2005 = ER27954;                                                                                                                                                                                                        
	    WifeADC2005 = ER27982;                                                                                                                                                                                                                  
	    HeadSSI2005 = ER28031;                                                                                                                                                                                                                  
	    WifeSSI2005 = ER28033;                                                                                                                                                                                                                  
        HeadRetIncVet2005 = ER27960;                                                                                                                                                                                                          
		HeadRetIncNV2005 = ER27962;                                                                                                                                                                                                          
        HeadAnnuity2005 = ER27964;                                                                                                                                                                                                            
        WifeAnnuity2005 = ER27988;                                                                                                                                                                                                            
        HeadOthRet2005 = ER27966;                                                                                                                                                                                                         
        HeadUnemp2005 = ER27968;	                                                                                                                          
        WifeUnemp2005 = ER27990;                                                                                                                                                                                                              
        HeadWorkman2005 = ER27970;                                                                                                                                                                                                            
        WifeWorkman2005 = ER27992;                                                                                                                                                                                                           
        HeadAlimony2005 = ER27974;                                                                                                                                                                                                            
		HeadChldSppt2005 = ER27972;                                                                                                                                                                                                             
		WifeChldSppt2005 = ER27994;                                                                                                                                                                                                              
	    HeadRelHelp2005 = ER27976;                                                                                                                                                                                                              
	    WifeRelHelp2005 = ER27996;                                                                                                                                                                                                              
	    HeadNonRelHelp2005 = ER27978;                                                                                                                                                                                                       
	    WifeNonRelHelp2005 = ER27998;                                                                                                                                                                                                       
		HeadSuppSec2005 = ER27956;                                                                                                                                                                                                                
		WifeSuppSec2005 = ER27984;                                                                                                                                                                                                                
	    HeadOthIncome2005 = ER27980;                                                                                                                                                                                                                  
		WifeOthIncome2005 = ER28000;
        HeadOthWel2005 = ER27958;                                                                                                                                                                                                            
		WifeOthWel2005 = ER27986;                                                                                                                                                                                                                
    
	OthTaxable2005 = ER28009;                                                                                                                                                                                                                  
	OthTrans2005 = ER28030;                                                                                                                                                                                                                    

/*if    WifeSalary2005        ge     9999996.00    then      WifeSalary2005          =      .;      
if    HeadRmmrlabor2005     ge     9999996.00    then      HeadRmmrlabor2005       =      .;      
if    HeadRent2005          ge      999996.00    then      HeadRent2005            =      .;      
if    HeadDividend2005      ge      999996.00    then      HeadDividend2005        =      .;      
if    HeadInterest2005      ge      999996.00    then      HeadInterest2005        =      .;      
if    RHeadDividend2005     ge      999996.00    then     RHeadDividend2005        =      .;      
if    RHeadInterest2005     ge      999996.00    then     RHeadInterest2005        =      .;      
if    HeadTrustFund2005     ge      999996.00    then      HeadTrustFund2005       =      .;      
if    WifeDividend2005      ge      999996.00    then      WifeDividend2005        =      .;      
if    WifeInterest2005      ge      999996.00    then      WifeInterest2005        =      .;      
if    WifeTrustFund2005     ge      999996.00    then      WifeTrustFund2005       =      .;      
if    HeadADC2005           ge      999996.00    then      HeadADC2005             =      .;      
if    WifeADC2005           ge       99996.00    then      WifeADC2005             =      .;      
if    HeadRetIncVet2005     ge       99996.00    then      HeadRetIncVet2005       =      .;      
if    HeadRetIncNV2005      ge      999996.00    then      HeadRetIncNV2005        =      .;      
if    HeadAnnuity2005       ge      999996.00    then      HeadAnnuity2005         =      .;      
if    WifeAnnuity2005       ge       99996.00    then      WifeAnnuity2005         =      .;      
if    HeadOthRet2005        ge      999996.00    then      HeadOthRet2005          =      .;      
if    HeadUnemp2005         ge       99996.00    then      HeadUnemp2005           =      .;      
if    WifeUnemp2005         ge       99996.00    then      WifeUnemp2005           =      .;      
if    HeadWorkman2005       ge       99996.00    then      HeadWorkman2005         =      .;      
if    WifeWorkman2005       ge       99996.00    then      WifeWorkman2005         =      .;      
if    HeadAlimony2005       ge       99996.00    then      HeadAlimony2005         =      .;      
if    HeadChldSppt2005      ge       99996.00    then      HeadChldSppt2005        =      .;      
if    WifeChldSppt2005      ge       99996.00    then      WifeChldSppt2005        =      .;      
if    HeadRelHelp2005       ge       99996.00    then      HeadRelHelp2005         =      .;      
if    WifeRelHelp2005       ge       99996.00    then      WifeRelHelp2005         =      .;      
if    HeadNonRelHelp2005    ge       99996.00    then      HeadNonRelHelp2005      =      .;      
if    WifeNonRelHelp2005    ge       99996.00    then      WifeNonRelHelp2005      =      .;      
if    HeadSuppSec2005       ge      999996.00    then      HeadSuppSec2005         =      .;      
if    WifeSuppSec2005       ge       99996.00    then      WifeSuppSec2005         =      .;      
if    HeadOthWel2005        ge      999996.00    then      HeadOthWel2005          =      .;      
if    WifeOthWel2005        ge       99996.00    then      WifeOthWel2005          =      .;      
if    HeadOthIncome2005     ge       99996.00    then      HeadOthIncome2005       =      .;      
if    WifeOthIncome2005     ge       99996.00    then      WifeOthIncome2005       =      .;      
                                                                                                                                                             
HeadRmmrlabor2005       = HeadRmmrlabor2005  * (52 * ( HeadRmmrlaborper2005 = 3) + 26 * ( HeadRmmrlaborper2005 = 4) +  12 * ( HeadRmmrlaborper2005 = 5) + ( HeadRmmrlaborper2005 = 6));
HeadRent2005            = HeadRent2005       * (52 * (      HeadRentper2005 = 3) + 26 * (      HeadRentper2005 = 4) +  12 * (      HeadRentper2005 = 5) + (      HeadRentper2005 = 6));
HeadDividend2005        = HeadDividend2005   * (52 * (  HeadDividendper2005 = 3) + 26 * (  HeadDividendper2005 = 4) +  12 * (  HeadDividendper2005 = 5) + (  HeadDividendper2005 = 6));
HeadInterest2005        = HeadInterest2005   * (52 * (  HeadInterestper2005 = 3) + 26 * (  HeadInterestper2005 = 4) +  12 * (  HeadInterestper2005 = 5) + (  HeadInterestper2005 = 6));
RHeadDividend2005       = RHeadDividend2005  * (52 * ( RHeadDividendper2005 = 3) + 26 * ( RHeadDividendper2005 = 4) +  12 * ( RHeadDividendper2005 = 5) + ( RHeadDividendper2005 = 6));
RHeadInterest2005       = RHeadInterest2005  * (52 * ( RHeadInterestper2005 = 3) + 26 * ( RHeadInterestper2005 = 4) +  12 * ( RHeadInterestper2005 = 5) + ( RHeadInterestper2005 = 6));
HeadTrustFund2005       = HeadTrustFund2005  * (52 * ( HeadTrustFundper2005 = 3) + 26 * ( HeadTrustFundper2005 = 4) +  12 * ( HeadTrustFundper2005 = 5) + ( HeadTrustFundper2005 = 6));
WifeDividend2005        = WifeDividend2005   * (52 * (  WifeDividendper2005 = 3) + 26 * (  WifeDividendper2005 = 4) +  12 * (  WifeDividendper2005 = 5) + (  WifeDividendper2005 = 6));
WifeInterest2005        = WifeInterest2005   * (52 * (  WifeInterestper2005 = 3) + 26 * (  WifeInterestper2005 = 4) +  12 * (  WifeInterestper2005 = 5) + (  WifeInterestper2005 = 6));
WifeTrustFund2005       = WifeTrustFund2005  * (52 * ( WifeTrustFundper2005 = 3) + 26 * ( WifeTrustFundper2005 = 4) +  12 * ( WifeTrustFundper2005 = 5) + ( WifeTrustFundper2005 = 6));
HeadADC2005             = HeadADC2005        * (52 * (       HeadADCper2005 = 3) + 26 * (       HeadADCper2005 = 4) +  12 * (       HeadADCper2005 = 5) + (       HeadADCper2005 = 6));
WifeADC2005             = WifeADC2005        * (52 * (       WifeADCper2005 = 3) + 26 * (       WifeADCper2005 = 4) +  12 * (       WifeADCper2005 = 5) + (       WifeADCper2005 = 6));
HeadRetIncVet2005       = HeadRetIncVet2005  * (52 * ( HeadRetIncVetper2005 = 3) + 26 * ( HeadRetIncVetper2005 = 4) +  12 * ( HeadRetIncVetper2005 = 5) + ( HeadRetIncVetper2005 = 6));
HeadRetIncNV2005        = HeadRetIncNV2005   * (52 * (  HeadRetIncNVper2005 = 3) + 26 * (  HeadRetIncNVper2005 = 4) +  12 * (  HeadRetIncNVper2005 = 5) + (  HeadRetIncNVper2005 = 6));
HeadSuppSec2005         = HeadSuppSec2005    * (52 * (   HeadSuppSecper2005 = 3) + 26 * (   HeadSuppSecper2005 = 4) +  12 * (   HeadSuppSecper2005 = 5) + (   HeadSuppSecper2005 = 6));
WifeSuppSec2005         = WifeSuppSec2005    * (52 * (   WifeSuppSecper2005 = 3) + 26 * (   WifeSuppSecper2005 = 4) +  12 * (   WifeSuppSecper2005 = 5) + (   WifeSuppSecper2005 = 6));
HeadOthWel2005          = HeadOthWel2005     * (52 * (    HeadOthWelper2005 = 3) + 26 * (    HeadOthWelper2005 = 4) +  12 * (    HeadOthWelper2005 = 5) + (    HeadOthWelper2005 = 6));
WifeOthWel2005          = WifeOthWel2005     * (52 * (    WifeOthWelper2005 = 3) + 26 * (    WifeOthWelper2005 = 4) +  12 * (    WifeOthWelper2005 = 5) + (    WifeOthWelper2005 = 6));
HeadAnnuity2005         = HeadAnnuity2005    * (52 * (   HeadAnnuityper2005 = 3) + 26 * (   HeadAnnuityper2005 = 4) +  12 * (   HeadAnnuityper2005 = 5) + (   HeadAnnuityper2005 = 6));
WifeAnnuity2005         = WifeAnnuity2005    * (52 * (   WifeAnnuityper2005 = 3) + 26 * (   WifeAnnuityper2005 = 4) +  12 * (   WifeAnnuityper2005 = 5) + (   WifeAnnuityper2005 = 6));
HeadOthRet2005          = HeadOthRet2005     * (52 * (    HeadOthRetper2005 = 3) + 26 * (    HeadOthRetper2005 = 4) +  12 * (    HeadOthRetper2005 = 5) + (    HeadOthRetper2005 = 6));
HeadUnemp2005           = HeadUnemp2005      * (52 * (     HeadUnempper2005 = 3) + 26 * (     HeadUnempper2005 = 4) +  12 * (     HeadUnempper2005 = 5) + (     HeadUnempper2005 = 6));
WifeUnemp2005           = WifeUnemp2005      * (52 * (     WifeUnempper2005 = 3) + 26 * (     WifeUnempper2005 = 4) +  12 * (     WifeUnempper2005 = 5) + (     WifeUnempper2005 = 6));
HeadWorkman2005         = HeadWorkman2005    * (52 * (   HeadWorkmanper2005 = 3) + 26 * (   HeadWorkmanper2005 = 4) +  12 * (   HeadWorkmanper2005 = 5) + (   HeadWorkmanper2005 = 6));
WifeWorkman2005         = WifeWorkman2005    * (52 * (   WifeWorkmanper2005 = 3) + 26 * (   WifeWorkmanper2005 = 4) +  12 * (   WifeWorkmanper2005 = 5) + (   WifeWorkmanper2005 = 6));
HeadAlimony2005         = HeadAlimony2005    * (52 * (   HeadAlimonyper2005 = 3) + 26 * (   HeadAlimonyper2005 = 4) +  12 * (   HeadAlimonyper2005 = 5) + (   HeadAlimonyper2005 = 6));
HeadChldSppt2005        = HeadChldSppt2005   * (52 * (  HeadChldSpptper2005 = 3) + 26 * (  HeadChldSpptper2005 = 4) +  12 * (  HeadChldSpptper2005 = 5) + (  HeadChldSpptper2005 = 6));
WifeChldSppt2005        = WifeChldSppt2005   * (52 * (  WifeChldSpptper2005 = 3) + 26 * (  WifeChldSpptper2005 = 4) +  12 * (  WifeChldSpptper2005 = 5) + (  WifeChldSpptper2005 = 6));
HeadRelHelp2005         = HeadRelHelp2005    * (52 * (   HeadRelHelpper2005 = 3) + 26 * (   HeadRelHelpper2005 = 4) +  12 * (   HeadRelHelpper2005 = 5) + (   HeadRelHelpper2005 = 6));
WifeRelHelp2005         = WifeRelHelp2005    * (52 * (   WifeRelHelpper2005 = 3) + 26 * (   WifeRelHelpper2005 = 4) +  12 * (   WifeRelHelpper2005 = 5) + (   WifeRelHelpper2005 = 6));
HeadNonRelHelp2005      = HeadNonRelHelp2005 * (52 * (HeadNonRelHelpper2005 = 3) + 26 * (HeadNonRelHelpper2005 = 4) +  12 * (HeadNonRelHelpper2005 = 5) + (HeadNonRelHelpper2005 = 6));
WifeNonRelHelp2005      = WifeNonRelHelp2005 * (52 * (WifeNonRelHelpper2005 = 3) + 26 * (WifeNonRelHelpper2005 = 4) +  12 * (WifeNonRelHelpper2005 = 5) + (WifeNonRelHelpper2005 = 6));
HeadOthIncome2005       = HeadOthIncome2005  * (52 * ( HeadOthIncomeper2005 = 3) + 26 * ( HeadOthIncomeper2005 = 4) +  12 * ( HeadOthIncomeper2005 = 5) + ( HeadOthIncomeper2005 = 6));
WifeOthIncome2005       = WifeOthIncome2005  * (52 * ( WifeOthIncomeper2005 = 3) + 26 * ( WifeOthIncomeper2005 = 4) +  12 * ( WifeOthIncomeper2005 = 5) + ( WifeOthIncomeper2005 = 6));

if  HeadRmmrlaborper2005 = 1 or  HeadRmmrlaborper2005 = 2 or  HeadRmmrlaborper2005 ge 7 then  HeadRmmrlabor2005 = .;  
if       HeadRentper2005 = 1 or       HeadRentper2005 = 2 or       HeadRentper2005 ge 7 then       HeadRent2005 = .;  
if   HeadDividendper2005 = 1 or   HeadDividendper2005 = 2 or   HeadDividendper2005 ge 7 then   HeadDividend2005 = .;  
if   HeadInterestper2005 = 1 or   HeadInterestper2005 = 2 or   HeadInterestper2005 ge 7 then   HeadInterest2005 = .;  
if  RHeadDividendper2005 = 1 or  RHeadDividendper2005 = 2 or  RHeadDividendper2005 ge 7 then  RHeadDividend2005 = .;  
if  RHeadInterestper2005 = 1 or  RHeadInterestper2005 = 2 or  RHeadInterestper2005 ge 7 then  RHeadInterest2005 = .;  
if  HeadTrustFundper2005 = 1 or  HeadTrustFundper2005 = 2 or  HeadTrustFundper2005 ge 7 then  HeadTrustFund2005 = .;  
if   WifeDividendper2005 = 1 or   WifeDividendper2005 = 2 or   WifeDividendper2005 ge 7 then   WifeDividend2005 = .;  
if   WifeInterestper2005 = 1 or   WifeInterestper2005 = 2 or   WifeInterestper2005 ge 7 then   WifeInterest2005 = .;  
if  WifeTrustFundper2005 = 1 or  WifeTrustFundper2005 = 2 or  WifeTrustFundper2005 ge 7 then  WifeTrustFund2005 = .;  
if        HeadADCper2005 = 1 or        HeadADCper2005 = 2 or        HeadADCper2005 ge 7 then        HeadADC2005 = .;  
if        WifeADCper2005 = 1 or        WifeADCper2005 = 2 or        WifeADCper2005 ge 7 then        WifeADC2005 = .;  
if  HeadRetIncVetper2005 = 1 or  HeadRetIncVetper2005 = 2 or  HeadRetIncVetper2005 ge 7 then  HeadRetIncVet2005 = .;  
if   HeadRetIncNVper2005 = 1 or   HeadRetIncNVper2005 = 2 or   HeadRetIncNVper2005 ge 7 then   HeadRetIncNV2005 = .;  
if    HeadSuppSecper2005 = 1 or    HeadSuppSecper2005 = 2 or    HeadSuppSecper2005 ge 7 then    HeadSuppSec2005 = .;  
if    WifeSuppSecper2005 = 1 or    WifeSuppSecper2005 = 2 or    WifeSuppSecper2005 ge 7 then    WifeSuppSec2005 = .;  
if     HeadOthWelper2005 = 1 or     HeadOthWelper2005 = 2 or     HeadOthWelper2005 ge 7 then     HeadOthWel2005 = .;  
if     WifeOthWelper2005 = 1 or     WifeOthWelper2005 = 2 or     WifeOthWelper2005 ge 7 then     WifeOthWel2005 = .;  
if    HeadAnnuityper2005 = 1 or    HeadAnnuityper2005 = 2 or    HeadAnnuityper2005 ge 7 then    HeadAnnuity2005 = .;  
if    WifeAnnuityper2005 = 1 or    WifeAnnuityper2005 = 2 or    WifeAnnuityper2005 ge 7 then    WifeAnnuity2005 = .;  
if     HeadOthRetper2005 = 1 or     HeadOthRetper2005 = 2 or     HeadOthRetper2005 ge 7 then     HeadOthRet2005 = .;  
if      HeadUnempper2005 = 1 or      HeadUnempper2005 = 2 or      HeadUnempper2005 ge 7 then      HeadUnemp2005 = .;  
if      WifeUnempper2005 = 1 or      WifeUnempper2005 = 2 or      WifeUnempper2005 ge 7 then      WifeUnemp2005 = .;  
if    HeadWorkmanper2005 = 1 or    HeadWorkmanper2005 = 2 or    HeadWorkmanper2005 ge 7 then    HeadWorkman2005 = .;  
if    WifeWorkmanper2005 = 1 or    WifeWorkmanper2005 = 2 or    WifeWorkmanper2005 ge 7 then    WifeWorkman2005 = .;  
if    HeadAlimonyper2005 = 1 or    HeadAlimonyper2005 = 2 or    HeadAlimonyper2005 ge 7 then    HeadAlimony2005 = .;  
if   HeadChldSpptper2005 = 1 or   HeadChldSpptper2005 = 2 or   HeadChldSpptper2005 ge 7 then   HeadChldSppt2005 = .;  
if   WifeChldSpptper2005 = 1 or   WifeChldSpptper2005 = 2 or   WifeChldSpptper2005 ge 7 then   WifeChldSppt2005 = .;  
if    HeadRelHelpper2005 = 1 or    HeadRelHelpper2005 = 2 or    HeadRelHelpper2005 ge 7 then    HeadRelHelp2005 = .;  
if    WifeRelHelpper2005 = 1 or    WifeRelHelpper2005 = 2 or    WifeRelHelpper2005 ge 7 then    WifeRelHelp2005 = .;  
if HeadNonRelHelpper2005 = 1 or HeadNonRelHelpper2005 = 2 or HeadNonRelHelpper2005 ge 7 then HeadNonRelHelp2005 = .;  
if WifeNonRelHelpper2005 = 1 or WifeNonRelHelpper2005 = 2 or WifeNonRelHelpper2005 ge 7 then WifeNonRelHelp2005 = .;  
if  HeadOthIncomeper2005 = 1 or  HeadOthIncomeper2005 = 2 or  HeadOthIncomeper2005 ge 7 then  HeadOthIncome2005 = .;  
if  WifeOthIncomeper2005 = 1 or  WifeOthIncomeper2005 = 2 or  WifeOthIncomeper2005 ge 7 then  WifeOthIncome2005 = .;  

if  HeadRmmrlaborper2005 = 0 then  HeadRmmrlabor2005 = 0;                                                                                                                                                                                                    
if       HeadRentper2005 = 0 then       HeadRent2005 = 0;                                                                                                                                                                                                    
if   HeadDividendper2005 = 0 then   HeadDividend2005 = 0;                                                                                                                                                                                                    
if   HeadInterestper2005 = 0 then   HeadInterest2005 = 0;                                                                                                                                                                                                    
if  RHeadDividendper2005 = 0 then  RHeadDividend2005 = 0;                                                                                                                                                                                                    
if  RHeadInterestper2005 = 0 then  RHeadInterest2005 = 0;                                                                                                                                                                                                    
if  HeadTrustFundper2005 = 0 then  HeadTrustFund2005 = 0;                                                                                                                                                                                                    
if   WifeDividendper2005 = 0 then   WifeDividend2005 = 0;                                                                                                                                                                                                    
if   WifeInterestper2005 = 0 then   WifeInterest2005 = 0;                                                                                                                                                                                                    
if  WifeTrustFundper2005 = 0 then  WifeTrustFund2005 = 0;                                                                                                                                                                                                    
if        HeadADCper2005 = 0 then        HeadADC2005 = 0;                                                                                                                                                                                                    
if        WifeADCper2005 = 0 then        WifeADC2005 = 0;                                                                                                                                                                                                    
if  HeadRetIncVetper2005 = 0 then  HeadRetIncVet2005 = 0;                                                                                                                                                                                                    
if   HeadRetIncNVper2005 = 0 then   HeadRetIncNV2005 = 0;                                                                                                                                                                                                    
if    HeadSuppSecper2005 = 0 then    HeadSuppSec2005 = 0;                                                                                                                                                                                                    
if    WifeSuppSecper2005 = 0 then    WifeSuppSec2005 = 0;                                                                                                                                                                                                    
if     HeadOthWelper2005 = 0 then     HeadOthWel2005 = 0;                                                                                                                                                                                                    
if     WifeOthWelper2005 = 0 then     WifeOthWel2005 = 0;                                                                                                                                                                                                    
if    HeadAnnuityper2005 = 0 then    HeadAnnuity2005 = 0;                                                                                                                                                                                                    
if    WifeAnnuityper2005 = 0 then    WifeAnnuity2005 = 0;                                                                                                                                                                                                    
if     HeadOthRetper2005 = 0 then     HeadOthRet2005 = 0;                                                                                                                                                                                                    
if      HeadUnempper2005 = 0 then      HeadUnemp2005 = 0;                                                                                                                                                                                                    
if      WifeUnempper2005 = 0 then      WifeUnemp2005 = 0;                                                                                                                                                                                                    
if    HeadWorkmanper2005 = 0 then    HeadWorkman2005 = 0;                                                                                                                                                                                                    
if    WifeWorkmanper2005 = 0 then    WifeWorkman2005 = 0;                                                                                                                                                                                                    
if    HeadAlimonyper2005 = 0 then    HeadAlimony2005 = 0;                                                                                                                                                                                                    
if   HeadChldSpptper2005 = 0 then   HeadChldSppt2005 = 0;                                                                                                                                                                                                    
if   WifeChldSpptper2005 = 0 then   WifeChldSppt2005 = 0;                                                                                                                                                                                                    
if    HeadRelHelpper2005 = 0 then    HeadRelHelp2005 = 0;                                                                                                                                                                                                    
if    WifeRelHelpper2005 = 0 then    WifeRelHelp2005 = 0;                                                                                                                                                                                                    
if HeadNonRelHelpper2005 = 0 then HeadNonRelHelp2005 = 0;                                                                                                                                                                                                    
if WifeNonRelHelpper2005 = 0 then WifeNonRelHelp2005 = 0;                                                                                                                                                                                                    
if  HeadOthIncomeper2005 = 0 then  HeadOthIncome2005 = 0;                                                                                                                                                                                                    
if  WifeOthIncomeper2005 = 0 then  WifeOthIncome2005 = 0;               

if RHeadDividend2005 > 0 then HeadDividend2005 = RHeadDividend2005;
if RHeadInterest2005 > 0 then HeadInterest2005 = RHeadInterest2005;*/

keep id2005 HeadExtraInclude2005
HeadRmmrlabor2005          
HeadRent2005               
HeadDividend2005           
HeadInterest2005           
HeadTrustFund2005          
HeadFarm2005 				   
TotalFarm2005 
HeadBus2005 				       
HeadBusAsset2005 		       
WifeRent2005
WifeDividend2005           
WifeInterest2005           
WifeTrustFund2005          
HeadADC2005                
WifeADC2005 
HeadSSI2005
WifeSSI2005 
HeadRetIncVet2005          
HeadRetIncNV2005           
HeadSuppSec2005            
WifeSuppSec2005            
HeadOthWel2005             
WifeOthWel2005             
HeadAnnuity2005            
WifeAnnuity2005            
HeadOthRet2005             
HeadUnemp2005              
WifeUnemp2005              
HeadWorkman2005            
WifeWorkman2005            
HeadAlimony2005            
HeadChldSppt2005           
WifeChldSppt2005           
HeadRelHelp2005            
WifeRelHelp2005            
HeadNonRelHelp2005         
WifeNonRelHelp2005         
HeadOthIncome2005          
WifeOthIncome2005          
Faminc2005                 
HWtaxable2005    		       
HeadLabor2005				       
HeadBusLabor2005 		       
HeadBonus2005				       
HeadOvertime2005		       
HeadTips2005 				       
HeadCommission2005 	       
HeadOthJob2005 			       
HeadProf2005 				       
HeadMktGrdnLabor2005       
HeadExtraJob2005		       
HeadSalary2005			       
WifeLabor2005 			       
WifeSalary2005 			       
WifeBusLabor2005 		       
HWTrans2005                
OthTaxable2005 			       
OthTrans2005 				       
;

proc means data = psiddata.income2005;
run; 
