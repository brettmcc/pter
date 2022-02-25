* Estimating equation 1 and 2 using CPS

global build "C:\Users\39328\Dropbox\Hours constraints and home prod\build"

global analysis "C:\Users\39328\Dropbox\Hours constraints and home prod\analysis"

cd "$build\output"

clear all

*EQUATION 1


*Option 1:
*Sample ASEC + basic monthly, only those who appear twice in asec have nonmissing change in earnings
*ASEC + Basic Monthly, Use log earnings as a control --> bigger longitudinal sample


global demographic1 "age i.black i.female"
global educ1 "i.highschool i.somecollege i.collegeup" //omitted: less than high school

*** Option 1 - ASEC + Basic Monthly, controlling for log income

use asec_monthly_76_87, clear

cd "$analysis\output"

xtset cpsidp mish

reg pter $demographic1 $educ1 i.married log_faminc i.industry i.monthly_date, vce(robust)

outreg2 using equation1_1.xls, replace ctitle(ASEC + Basic Monthly sample) addtext (More obs per individual, controlling for log income)


*** Without controlling for log income



outreg2 using equation1_2.xls, replace ctitle(Double ASEC) addtext (One obs per individual, controlling for log change in income)

