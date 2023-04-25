bysort statefip ind1950 monthly_date: egen pter_ist = mean(pter_conditional)


save "${buildpter}\output\cps_atus_merged_76_21.dta", replace

*construct Bartik shock //why mean so small for Bartik?
cd "$buildpter\output"
use year employed female ind1950 wtfinl married statefip if year==1977 & married==1 & female==0 & employed==1 using cps_atus_merged_76_21, clear
collapse (sum) employed_is=employed [aw=wtfinl],by(ind1950 statefip) // employment in industry i in state s' in 1977
bysort ind1950: egen employed_i = total(employed_is) //employment in industry i in 1977
gen frac_emp_is_77 = employed_is/employed_i
save "${buildpter}\temp\temp_emp.dta",replace

use "${buildpter}\output\cps_atus_merged_76_21.dta", clear
keep if female == 0 & employed == 1 & married == 1
drop if statefip == . // for some obs we don't have state info

tempname bartik

postfile `bartik' statefip ind1950 year pter using "bartik.dta", replace

levelsof statefip, local(state)
foreach s of local state{
	preserve
	drop if statefip ==`s'
	collapse (mean) into_pter_exclself = into_pter [aw=wtfinl], by(year ind1950)
	gen state = `s'

	post `bartik' state year ind1950 into_pter_exclself

	restore

}

postclose `memhold'

*merge CPS w/ industry shares and exluding-self PTER averages
use "${buildpter}\output\cps_atus_merged_76_21.dta", clear
merge m:1 ind1950 statefip using "${buildpter}\temp\temp_emp.dta" // industry shares
merge m:1 ind1950 statefip year using "${buildpter}\temp\bartik.dta" // adds into_pter_exclself by state industry year

gen shift_share_component_ist = frac_emp_is_77*into_pter_exclself

tempname temp
postfile `temp' statefip ind1950 year pter using "temp.dta", replace

levelsof statefip, local(state)
foreach s of local state{
	preserve
	drop if statefip ==`s'
	gen pter_ist_hat_leaveout = sum(shift_share_component_ist)
	gen state = `s'

	post `temp' state year ind1950 pter_ist_hat_leaveout

	restore

}

postclose `temp'

*merge CPS w/ pter_ist_hat_leaveout
*use "${buildpter}\output\cps_atus_merged_76_21.dta", clear
merge m:1 ind1950 statefip year using "${buildpter}\temp\temp.dta" // adds pter_ist_hat_leaveout by state industry year

save