clear all
set more off

use "../../build/output/pooled.dta",clear
label define cstr 0 "unconstrained" 1 "up constr." 2 "down constr"
gen constr = 0
replace constr = 1 if construp==1
replace constr = 2 if constrdown==1
label values constr cstr

tsset pid year
tsfill, full

count if constr==1 & f1.constr==.
count if constr==1 & f1.constr==0
count if constr==1 & f1.constr==1
count if constr==1 & f1.constr==2
