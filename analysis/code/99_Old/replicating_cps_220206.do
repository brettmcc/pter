* Estimating equation 1 and 2 using CPS

global build "C:\Users\39328\Dropbox\Hours constraints and home prod\build"

global analysis "C:\Users\39328\Dropbox\Hours constraints and home prod\analysis"

cd "$build\output"

clear all

*EQUATION 1


*Option 1:
*Sample ASEC + basic monthly, only those who appear twice in asec have nonmissing change in earnings
*ASEC + Basic Monthly, Use log earnings as a control --> bigger longitudinal sample


*Option 2: 
*Sample: CPS - ASEC one year apart for the same individual, t = 1, 2
*focus on t = 2 --> only one obs per individual, can use log change in income as control


*Option 3: 
*Sample ASEC + basic monthly, only those who appear twice in asec have nonmissing change in earnings
*ASEC + Basic Monthly, Use change in log earnings as a control --> equivalent to option 2 (only cosidering those who enter ASEC twice) but with longer linked monthly component


global demographic1 "age i.black i.female"
global educ1 "i.highschool i.somecollege i.collegeup" //omitted: less than high school

global demographic2 "age_2 i.black i.female" 
global educ2 "i.highschool_2 i.somecollege_2 i.collegeup_2" //omitted: less than high school

*demographic and age control for option 3 = option 1


*** Option 1 - ASEC + Basic Monthly, controlling for log income

use asec_monthly_76_87, clear

cd "$analysis\output"

xtset cpsidp mish

reg pter $demographic1 $educ1 i.married log_faminc i.industry i.monthly_date, vce(robust)

outreg2 using equation1_1.xls, replace ctitle(ASEC + Basic Monthly sample) addtext (More obs per individual, controlling for log income)


***Option 2: focus on t = 2 --> only one obs per individual, can use log change in income as control
cd "$build\output"

use wide_asec_78_86, clear
cd "$analysis\output"

reg pter_2 $demographic2 $educ2 i.married_2 chglog_faminc i.industry_2 i.year_2, vce(robust)

outreg2 using equation1_2.xls, replace ctitle(Double ASEC) addtext (One obs per individual, controlling for log change in income)


*** Option 3: ASEC + Basic Monthly, Use change in log earnings as a control --> equivalent to option 2 (only cosidering those who enter ASEC twice) but with longer linked monthly component

cd "$build\output"

use asec_monthly_76_87, clear

cd "$analysis\output"

xtset cpsidp mish

reg pter $demographic1 $educ1 i.married chglog_faminc i.industry i.monthly_date, vce(robust)

outreg2 using equation1_3.xls, replace ctitle(ASEC + Basic Monthly sample) addtext (More monthly obs per individual, controlling for change in log income)

******************************************************************************




*Option 4: Repeated ASEC sample, use both t = 1, 2 --> two obs per individual, but unable to control for log change in income --> Equivalent to option 1 (actually option 1 has a longer longitudinal panel)
/*
use long_asec_78_86, clear

xtset cpsidp year_

cd "$analysis\output"



reg pter_ $demographic2 $educ2 i.married_ famincome_ i.industry_ i.year_, vce(robust)

outreg2 using equation1_long.xls, replace ctitle(Long) addtext(Two obs per individual, controlling for log income)
*/