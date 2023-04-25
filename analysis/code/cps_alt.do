******does becoming pter or unemployed increase female labor supply
global controls black highschool somecollege collegeup shr_married unemp_rt unemp_rt2 nchild nadults
global cluster state_monthyear_code cpsid
//cd /hpc/household_finance/BoardResearch/HP/WorkDir/Revision
cd "~/Dropbox/Hours constraints and home prod/"
use build/output/cps_atus_merged_76_21_leaveout, clear

sort cpsidp monthly_date
xtset cpsidp monthly_date

gen into_employed_sp_alt = employed_sp == 1 & (l.employed_sp == 0 | l.employed_sp == .) 

******OLS
reghdfe into_employed_sp_alt into_pter ${controls} if married == 1 & female == 0 & (l1.employed_sp==0 | l1.employed_sp == .) & l1.pter==0 & l1.employed==1 & employed == 1, absorb(monthly_date statefip) cluster(${cluster}) nocons
reghdfe into_employed_sp_alt into_unemployed ${controls} if married == 1 & female == 0 & (l1.employed_sp==0 | l1.employed_sp == .) & l1.employed == 1, absorb(monthly_date statefip) cluster(${cluster}) nocons

******IV Bartik
******first-stage, normalize the predicted value with standard deviation
reghdfe into_pter pter_isyear_hat_leaveout ${controls} if married == 1 & female == 0 & l1.pter==0 & employed == 1 & l1.employed==1, absorb(age monthly_date statefip) cluster(${cluster}) nocons
predict into_pter_hat_1 if e(sample)
sum into_pter_hat_1
gen into_pter_hat_1_norm = into_pter_hat_1 / 0.0136

reghdfe into_pter into_pter_isyear_hat_leaveout ${controls} if married == 1 & female == 0 & l1.pter==0 & employed == 1 & l1.employed==1, absorb(age monthly_date statefip) cluster(${cluster}) nocons
predict into_pter_hat_2 if e(sample)
sum into_pter_hat_2
gen into_pter_hat_2_norm = into_pter_hat_2 / 0.0136

reghdfe into_unemployed unemp_isyear_hat_leaveout ${controls} if married == 1 & female == 0 & l1.employed==1, absorb(age monthly_date statefip) cluster(${cluster}) nocons
predict into_unemp_hat_1 if e(sample)
sum into_unemp_hat_1
gen into_unemp_hat_1_norm = into_unemp_hat_1 / 0.0105

reghdfe into_unemployed into_unemp_isyear_hat_leaveout ${controls} if married == 1 & female == 0 & l1.employed==1, absorb(age monthly_date statefip) cluster(${cluster}) nocons
predict into_unemp_hat_2 if e(sample)
sum into_unemp_hat_2
gen into_unemp_hat_2_norm = into_unemp_hat_2 / 0.0103

sum into_pter       pter_isyear_hat_leaveout  into_pter_isyear_hat_leaveout  into_pter_hat_1  into_pter_hat_2  if married == 1 & female == 0 & l1.pter==0 & employed == 1 & l1.employed==1 & (l1.employed_sp==0 | l1.employed_sp == .)
sum into_unemployed unemp_isyear_hat_leaveout into_unemp_isyear_hat_leaveout into_unemp_hat_1 into_unemp_hat_2 if married == 1 & female == 0 & l1.employed == 1 

******second stage 
logistic into_employed_sp_alt into_pter_hat_1_norm ${controls} i.age i.statefip i.year i.month if married == 1 & female == 0 & l1.pter==0 & employed == 1 & l1.employed==1 & (l1.employed_sp==0 | l1.employed_sp == .), cluster(${cluster}) nocons
logistic into_employed_sp_alt into_pter_hat_2_norm ${controls} i.age i.statefip i.year i.month if married == 1 & female == 0 & l1.pter==0 & employed == 1 & l1.employed==1 & (l1.employed_sp==0 | l1.employed_sp == .), cluster(${cluster}) nocons

sum into_pter_isyear_hat_leaveout
gen pter_IV_normed = (into_pter_isyear_hat_leaveout-r(mean))/r(sd)
ivreghdfe into_employed_sp_alt ${controls} (into_pter=pter_IV_normed) if married == 1 & female == 0 & l1.pter==0 & employed == 1 & l1.employed==1 & (l1.employed_sp==0 | l1.employed_sp == .),a(age statefip year#month) cluster(${cluster}) nocons first

logistic into_employed_sp_alt into_unemp_hat_1_norm ${controls} i.age i.statefip i.year i.month if married == 1 & female == 0 & l1.employed == 1, cluster(${cluster}) nocons
logistic into_employed_sp_alt into_unemp_hat_2_norm ${controls} i.age i.statefip i.year i.month if married == 1 & female == 0 & l1.employed == 1, cluster(${cluster}) nocons 

ivreghdfe into_employed_sp_alt ${controls} (into_unemp=into_unemp_isyear_hat_leaveout) if married == 1 & female == 0 & l1.pter==0 & employed == 1 & l1.employed==1 & (l1.employed_sp==0 | l1.employed_sp == .),a(age statefip year#month) cluster(${cluster}) nocons first
