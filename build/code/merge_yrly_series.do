*merge the yearly series into one dataset
global buildout "C:\Users\bmccully\Documents\pter-master\build\output"

set more off

import delimited /href/research3/m1bam03/homeProdHourConstraints/build/input/bls_pter.csv,clear
keep if year>=1967 & year<=2015
rename proppter proppter_bls
rename proppter55plusnonagr proppter55plusnonagr_bls
keep year proppter_bls proppter55plusnonagr_bls
label var proppter_bls "BLS, all"
label var proppter55plusnonagr_bls "BLS, 55+, non-agr"
*merge on 
merge 1:1 year using ../analysis/input/hrs_construp35_yrly.dta,nogen
merge 1:1 year using ../analysis/input/hrs_construp_yrly.dta,nogen

merge 1:1 year using output/psid_construp35_yrly.dta,nogen
merge 1:1 year using output/psid_construp35_age50to70_yrly.dta,nogen
merge 1:1 year using output/psid_construp_yrly.dta,nogen

export delimited using "/lcl/href/research3/m1bam03/homeProdHourConstraints/build/output/merged_yrly_series.csv", replace
