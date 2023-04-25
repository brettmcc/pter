//use "C:\Users\Brett's Workstation\Dropbox\Hours constraints and home prod\build\input\CPS-ATUS\pter_lf_0216.dta",clear
use "C:\Users\Brett\Dropbox\Hours constraints and home prod\build\input\CPS-ATUS\pter_lf_0216.dta",clear
egen cemp_mn=mean(cemp_st), by(state)
xi: fracreg logit married_female_lfpr married_male_pter i.year minwage i.state [iw=cemp_mn], vce(cluster state)
gen married_male_pter_sq=married_male_pter^2
xi: fracreg logit married_female_lfpr married_male_pter married_male_pter_sq i.year minwage i.state [iw=cemp_mn], vce(cluster state)
gen u3sq = u3^2
xi: fracreg logit married_female_lfpr married_male_pter u3 u3sq i.year minwage i.state [iw=cemp_mn], vce(cluster state)
