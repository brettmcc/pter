global controls black highschool somecollege collegeup shr_married unemp_rt unemp_rt2 nchild nadults i.famincome_married_decile pt
global buildpter "C:\Users\Brett's Workstation\Dropbox\Hours constraints and home prod\build"

use "${buildpter}\output\cps_atus_merged_76_21.dta",clear
****OLS
*married men
//preferred specification:
reghdfe into_employed_sp into_pter ${controls} if married == 1 & employed == 1 & female == 0 & l1.employed_sp==0 & l1.pter==0 & l1.employed==1, absorb(monthly_date statefip) cluster(state_monthyear_code) nocons
//weighted
reghdfe into_employed_sp into_pter ${controls} if married == 1 & employed == 1 & female == 0 & l1.employed_sp==0 & l1.pter==0 & l1.employed==1 [aw=wtfinl], absorb(monthly_date statefip) cluster(state_monthyear_code) nocons
*married women
reghdfe into_employed_sp into_pter ${controls} if married == 1 & employed == 1 & female == 1, absorb(monthly_date statefip) cluster(state_monthyear_code) nocons
reghdfe into_employed_sp into_pter ${controls} if married == 1 & employed == 1 & female == 1 & l1.employed_sp==0 & l1.pter==0 & l1.employed==1, absorb(monthly_date statefip) cluster(state_monthyear_code) nocons

****IV
**First-stage
reghdfe into_pter bartik_iv_ind ${controls} if married == 1 & employed == 1 & female == 0 & l1.employed_sp==0 & l1.pter==0 & l1.employed==1, absorb(monthly_date statefip) cluster(state_monthyear_code) nocons
**IV
ivreghdfe into_employed_sp (into_pter=bartik_iv_ind) ${controls} if married == 1 & employed == 1 & female == 0 & l1.employed_sp==0 & l1.pter==0 & l1.employed==1, absorb(monthly_date statefip) cluster(state_monthyear_code) nocons

*other specifications:
ppmlhdfe employed_sp pter shr_married unemp_rt unemp_rt2 if married == 1 & employed == 1 & female == 0 & year>=1980 & year<=2019, absorb(monthly_date) cluster(state_monthyear_code) nocons

reghdfe into_employed_sp into_pter shr_married unemp_rt unemp_rt2 if married == 1 & employed == 1 & female == 0 & year>=1980 & year<=2019, absorb(monthly_date) cluster(state_monthyear_code) nocons
reghdfe into_employed_sp into_pter ${controls} if married == 1 & employed == 1 & female == 0, absorb(monthly_date statefip) cluster(state_monthyear_code) nocons
