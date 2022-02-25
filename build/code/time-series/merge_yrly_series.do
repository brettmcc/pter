*merge the yearly series into one dataset
set more off

import delimited /href/research3/m1bam03/homeProdHourConstraints/build/input/bls_pter.csv,clear
keep if year>=1967 & year<=2015
rename proppter proppter_bls
rename proppter55plusnonagr proppter55plusnonagr_bls
keep year proppter_bls proppter55plusnonagr_bls
label var proppter_bls "BLS, all"
label var proppter55plusnonagr_bls "BLS, 55+, non-agr"


use "build\output\cps_pter.dta",clear
gen pter_wt = pter*wtfinl if year>=1976
replace pter_wt = pter*asecwt if year<1976
gen pop = wtfinl if year>=1976
replace pop = asecwt if year<1976
collapse (sum) pter_wt pop,by(year)
gen prop_pter_cps = pter_wt/pop
*merge on 
merge 1:1 year using "analysis/input/hrs_construp35_yrly.dta",nogen
merge 1:1 year using "analysis/input/hrs_construp_yrly.dta",nogen

merge 1:1 year using "build/output/psid_construp35_yrly.dta",nogen
merge 1:1 year using "build/output/psid_construp35_age50to70_yrly.dta",nogen
merge 1:1 year using "build/output/psid_construp_yrly.dta",nogen

save "build\output\combined_yrly_series.dta",replace
