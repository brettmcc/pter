global buildin "C:\Users\bmccully\Documents\pter-master\build\input"
global buildout "C:\Users\bmccully\Documents\pter-master\build\output"

clear
set more off

import delimited $buildin\bls_pter

drop if year<1955

replace seriesid = "laborForce" if seriesid=="LNS11000000"
replace seriesid = "PTER" if seriesid=="LNS12032194"
replace seriesid = "Employed" if seriesid=="LNS12000000"

reshape wide value, i(year period label) j(seriesid) string
drop if valuePTER==.
gen propPter_cps = valuePTER/valueEmployed
gen yearmonth = monthly(label, "YM")
format yearmonth %tm

save $buildout\bls_pter,replace

collapse (mean) propPter_cps,by(year)

save $buildout\bls_pter_yearly,replace
