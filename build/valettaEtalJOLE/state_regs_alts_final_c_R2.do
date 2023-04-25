*************************************************************************
* Created by: 	Rob Valletta 
* Created on: 	12/15/2017
* Description: 	Compare results for some state vars (Lf vs. pop, occ vs. ind, w variables)
* 		Use fracreg logit (need to explicitly include state dummies)
*		Shares in fractions (not %), wages in ln (except minwage is relative)
* Changes:
*		1/1/18: "_c" version uses clustered SEs (by state)
*		8/11/18: "R2" version produces within R-squareds
*		(from SSR and SSY on fractional outcome variable)
*************************************************************************

version 14
cap log close
clear all
set more off
capture program drop _all
cd "C:\data\part-time\manuscript\JOLE revision\Stata"

set linesize 120
log using state_regs_alts_final_c_R2.log, replace
** Compare specs for cyclical component 
** Data 2003-16, else same as Table 2 in working paper, using weighted FE spec only
  ** med_wage in 2016 $

use PT_state_12-16-2017, clear

** Set up main data and variables
xtset state year

** Convert U3 to fraction
replace U3=U3/100
gen U3sq=(U3*U3)*10

**  Convert ipt to fraction
replace ipt=ipt/100

** Emp/pop (in fraction)
gen emp_pop=(cemp_st/pop_st)

** demp, dgdp (data set extended to include 2002 values of cemp_st & gdp, so have 2003 values)
gen demp=ln(cemp_st/L1.cemp_st)
gen dgdp=ln(gdp/L1.gdp)


** GDP relative to 2003 (pre-2007) or 2007 (ln growth)
** May want to do state-specific peaks instead
gen gdp03h=gdp if year==2003
egen gdp03=max(gdp03h), by(state)
gen gdp07h=gdp if year==2007
egen gdp07=max(gdp07h), by(state)
gen gdp_cum=ln(gdp/gdp03)
  replace gdp_cum=ln(gdp/gdp07) if year>2007
drop gdp*h

** Measure minwage relative to median hourly wage in state (hold nominal for potential use below)
gen minwage_nom=minwage
replace minwage=minwage/med_wage
** Same for single coverage health insurance costs (annual, so do for annual full-time worker) 
gen meansc_nom=meansc
replace meansc=meansc/(2000*med_wage)
** Now put other wage vars in real terms (2016 $, using overall pce index)
gen pce_2016=pce_overall if year==2016
egen pce_2016n=max(pce_2016), by(state)
foreach X of var med_wage wage_10pct wage_25pct {
  replace `X'=`X'*(pce_2016n/pce_overall)
}

gen ln_medw=ln(med_wage)
gen ln_w10p=ln(wage_10pct)
gen ln_w25p=ln(wage_25pct)

** Replace construction with mining/logging/construction for consistency
replace cons=cons+minelog if cons!=.
replace cons=minelogcons if cons==.

** Form industry shares (broad industries, available for all states/years)
foreach X of varlist cons manu wtrade rtrade trans info financial prof leisure eduhealth serv  {
  gen `X'_s=(`X'/totnf)
}
local ind_sh cons_s manu_s wtrade_s rtrade_s trans_s info_s financial_s prof_s leisure_s eduhealth_s serv_s

** Form occupation shares (broad)
  ** Need to use "occ_sum" in denominator (rather than occ_all; some slippage, due to armed forces)
foreach X of varlist occ_cons-occ_tran  {
  gen `X'_s=(`X'/occ_sum)
}
** Reorder in local (to match order in descriptive table)
local occ_sh occ_mbf_s occ_prof_s occ_serv_s occ_sale_s occ_off_s occ_fff_s occ_cons_s occ_inst_s occ_prod_s occ_tran_s

** Alternative age shares (pop and LF)  
local age_sh_pop share_t_1624_cen share_m_2534_cen share_f_2534_cen share_m_3554_cen share_f_3554_cen share_t_5564_cen share_t_65p_cen
local age_sh_lf lf_t16_24 lf_m25_34 lf_w25_34 lf_w35_54 lf_t55_64 lf_t65

*Convert pop age share to fraction (initially in %)
foreach x in `age_sh_pop' {
replace `x'=`x'/100
}

drop if (year<2003)
egen cemp_mn=mean(cemp_st), by(state)

** Set 2006 as the omitted base year
char year[omit] 2006

** Var labels for export

label var U3 "Unemployment Rate"
label var U3sq "Unemployment Rate Squared"

label var cons_s "Construction/mining/logging" 
label var manu_s "Manufacturing" 
label var wtrade_s "Wholesale trade" 
label var rtrade_s "Retail trade" 
label var trans_s "Transportation" 
label var info_s "Information" 
label var financial_s "Finance" 
label var prof_s "Professional" 
label var leisure_s "Leisure" 
label var eduhealth_s "Educ./healthcare" 
label var serv_s "Service" 

label var share_t_1624_ce "16-24"
label var share_m_2534_cen "Males 25-34"
label var share_f_2534_cen "Females 25-34"
label var share_m_3554_cen "Males 35-54"
label var share_f_3554_cen "Females 35-54"
label var share_t_5564_cen "55-64"
label var share_t_65p_cen "65+"

** REGRESSIONS HERE
** USE WEIGHTED FE SPEC ONLY

**Baseline (U quadratic as cyclical, complete state factors)
xi: fracreg logit ipt U3 U3sq i.year ln_medw minwage `ind_sh' `age_sh_pop' i.state [iw=cemp_mn], vce(cluster state)
predict ipt_fit if e(sample)
margins, dydx(*) post
eststo m1

** R-squared calcs (unweighted, per PW 1996, p. 629)
** Calculate R^2 as 1-(SSR/SSY), 
*    where SSR=(sum of squared residuals) and SSY=(total sum of squares for dependent var (untransformed))
** To calculate within, need to get SSR separately for equations with/without state effects, difference
gen sr=(ipt-ipt_fit)^2
quietly summ sr if e(sample)
  local ssr1=r(sum)
quietly summ ipt if e(sample)
  local m=r(mean)
gen sy=(ipt-`m')^2
quietly summ sy if e(sample)
  local ssy=r(sum)
drop ipt_fit sr sy

** Now get ssr2 (from equation without state effects)
quietly xi: fracreg logit ipt U3 U3sq i.year ln_medw minwage `ind_sh' `age_sh_pop' [iw=cemp_mn], vce(cluster state)
predict ipt_fit if e(sample)
quietly summ ipt ipt_fit
gen sr=(ipt-ipt_fit)^2
quietly summ sr if e(sample)
  local ssr2=r(sum)
** Within R^2
local r2_w=1-((`ssr2'-`ssr1')/`ssy')
drop ipt_fit sr

** List R^2
di "R^2 within is `r2_w'"


** Use LF rather than pop
xi: fracreg logit ipt U3 U3sq i.year ln_medw minwage `ind_sh' `age_sh_lf' i.state [iw=cemp_mn], vce(cluster state)
predict ipt_fit if e(sample)
margins, dydx(*) post
eststo m2

** R-squared calcs (unweighted, per PW 1996, p. 629)
** Calculate R^2 as 1-(SSR/SSY), 
*    where SSR=(sum of squared residuals) and SSY=(total sum of squares for dependent var (untransformed))
** To calculate within, need to get SSR separately for equations with/without state effects, difference
gen sr=(ipt-ipt_fit)^2
quietly summ sr if e(sample)
  local ssr1=r(sum)
quietly summ ipt if e(sample)
  local m=r(mean)
gen sy=(ipt-`m')^2
quietly summ sy if e(sample)
  local ssy=r(sum)
drop ipt_fit sr sy

** Now get ssr2 (from equation without state effects)
quietly xi: fracreg logit ipt U3 U3sq i.year ln_medw minwage `ind_sh' `age_sh_lf' [iw=cemp_mn], vce(cluster state)
predict ipt_fit if e(sample)
quietly summ ipt ipt_fit
gen sr=(ipt-ipt_fit)^2
quietly summ sr if e(sample)
  local ssr2=r(sum)
** Within R^2
local r2_w=1-((`ssr2'-`ssr1')/`ssy')
drop ipt_fit sr

** List R^2
di "R^2 within is `r2_w'"


** Use occ rather than industry
xi: fracreg logit ipt U3 U3sq i.year ln_medw minwage `occ_sh' `age_sh_pop' i.state [iw=cemp_mn], vce(cluster state)
predict ipt_fit if e(sample)
margins, dydx(*) post
eststo m3

** R-squared calcs (unweighted, per PW 1996, p. 629)
** Calculate R^2 as 1-(SSR/SSY), 
*    where SSR=(sum of squared residuals) and SSY=(total sum of squares for dependent var (untransformed))
** To calculate within, need to get SSR separately for equations with/without state effects, difference
gen sr=(ipt-ipt_fit)^2
quietly summ sr if e(sample)
  local ssr1=r(sum)
quietly summ ipt if e(sample)
  local m=r(mean)
gen sy=(ipt-`m')^2
quietly summ sy if e(sample)
  local ssy=r(sum)
drop ipt_fit sr sy

** Now get ssr2 (from equation without state effects)
quietly xi: fracreg logit ipt U3 U3sq i.year ln_medw minwage `occ_sh' `age_sh_pop' [iw=cemp_mn], vce(cluster state)
predict ipt_fit if e(sample)
quietly summ ipt ipt_fit
gen sr=(ipt-ipt_fit)^2
quietly summ sr if e(sample)
  local ssr2=r(sum)
** Within R^2
local r2_w=1-((`ssr2'-`ssr1')/`ssy')
drop ipt_fit sr

** List R^2
di "R^2 within is `r2_w'"


** Use occ and industry
xi: fracreg logit ipt U3 U3sq i.year ln_medw minwage `ind_sh' `occ_sh' `age_sh_pop' i.state [iw=cemp_mn], vce(cluster state)
predict ipt_fit if e(sample)
margins, dydx(*) post
eststo m4

** R-squared calcs (unweighted, per PW 1996, p. 629)
** Calculate R^2 as 1-(SSR/SSY), 
*    where SSR=(sum of squared residuals) and SSY=(total sum of squares for dependent var (untransformed))
** To calculate within, need to get SSR separately for equations with/without state effects, difference
gen sr=(ipt-ipt_fit)^2
quietly summ sr if e(sample)
  local ssr1=r(sum)
quietly summ ipt if e(sample)
  local m=r(mean)
gen sy=(ipt-`m')^2
quietly summ sy if e(sample)
  local ssy=r(sum)
drop ipt_fit sr sy

** Now get ssr2 (from equation without state effects)
quietly xi: fracreg logit ipt U3 U3sq i.year ln_medw minwage `ind_sh' `occ_sh' `age_sh_pop' [iw=cemp_mn], vce(cluster state)
predict ipt_fit if e(sample)
quietly summ ipt ipt_fit
gen sr=(ipt-ipt_fit)^2
quietly summ sr if e(sample)
  local ssr2=r(sum)
** Within R^2
local r2_w=1-((`ssr2'-`ssr1')/`ssy')
drop ipt_fit sr

** List R^2
di "R^2 within is `r2_w'"


** Use the wage at the 25th percentile rather than median
xi: fracreg logit ipt U3 U3sq i.year ln_w25p minwage `ind_sh' `age_sh_pop' i.state [iw=cemp_mn], vce(cluster state)
predict ipt_fit if e(sample)
margins, dydx(*) post
eststo m5

** R-squared calcs (unweighted, per PW 1996, p. 629)
** Calculate R^2 as 1-(SSR/SSY), 
*    where SSR=(sum of squared residuals) and SSY=(total sum of squares for dependent var (untransformed))
** To calculate within, need to get SSR separately for equations with/without state effects, difference
gen sr=(ipt-ipt_fit)^2
quietly summ sr if e(sample)
  local ssr1=r(sum)
quietly summ ipt if e(sample)
  local m=r(mean)
gen sy=(ipt-`m')^2
quietly summ sy if e(sample)
  local ssy=r(sum)
drop ipt_fit sr sy

** Now get ssr2 (from equation without state effects)
quietly xi: fracreg logit ipt U3 U3sq i.year ln_w25p minwage `ind_sh' `age_sh_pop' [iw=cemp_mn], vce(cluster state)
predict ipt_fit if e(sample)
quietly summ ipt ipt_fit
gen sr=(ipt-ipt_fit)^2
quietly summ sr if e(sample)
  local ssr2=r(sum)
** Within R^2
local r2_w=1-((`ssr2'-`ssr1')/`ssy')
drop ipt_fit sr

** List R^2
di "R^2 within is `r2_w'"



** Export using estout

#delimit ;
**esttab 
m1 m2 m3 m4 m5
using "C:\data\part-time\manuscript\JOLE revision\Excel\state_regs_alts_final_c_R2", 
csv nodepvars keep(U3* _Iyear* ln_medw ln_w25p minwage `ind_sh' `age_sh_pop' `age_sh_lf' `occ_sh')
order(U3* _Iyear* ln_medw ln_w25p minwage `ind_sh' `age_sh_pop' `age_sh_lf' `occ_sh')
cells(b(vacant(-) star fmt(3)) se(fmt(3) par)) label
stats(N ll r2_p p, fmt(0 2 4 4)) collabels(none) mlabels(none) eqlabels(none)
starlevels(* 0.10 ** 0.05 *** .01)
replace;

#delimit cr

log close
