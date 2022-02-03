*Creating dataset
*2022.01.17


global build "C:\Users\39328\Dropbox\Hours constraints and home prod\build"
cd "$build\input\CPS-ATUS"

clear all


* Merged CPS ATUS
import sas using merged_atuscps.sas7bdat

svyset, clear

svyset [iw=TUFNWGTP]


*Time variables
tab HRYEAR4

tab HRMONTH // month in interview

tab HRMIS // month in sample --> == 8 as this is when these questions are asked.

tab TUMONTH // month of interview (ATUS)

tab HRMONTH if HRYEAR4 == 2016
tab HRMONTH if HRYEAR4 == 2015

*Identifiers
codebook TUCASEID //household identifier
isid TUCASEID

codebook TULINENO // household member identifier --> always 1, so we only have the respondent for each household. So tucaseid is unique identifier for the individual.

codebook HRHHID
*isid HRHHID HRHHID2 HRSAMPLE

br if TUCASEID == "20030100013280"

destring TUCASEID, replace
format TUCASEID %14.0f

xtset TUCASEID

*Weights
codebook TUFNWGTP // weight for all periods


***
* Labelling
label var HRMONTH "Calendar month in which interview was conducted (CPS)"
label var HRMIS "Month in sample (CPS)"
label var TUMONTH "Month of day about which ATUS respondent was interviewed"
label var PEERNHRY "Hourly / non-hourly worker (ATUS+CPS). Universe: employed - at work"
label var TEERNHRY "Hourly / non-hourly worker (ATUS). Universe: employed not self-employed or without pay."
label var TRERNWA "Weekly earnings at main job (ATUS)"
label var PRERNWA "Weekly earnings at main job (CPS)"
label var TELFS "Labor force status (ATUS)"

*Figure 2a
* Hourly vs salaried worker
tab PEERNHRY, m
tab TEERNHRY, m


*Create hourly, salaried dummy
gen byte hourly_worker = .
replace hourly_worker = 1 if TEERNHRY == 1
replace hourly_worker = 0 if TEERNHRY == 2

tab TEERNHRY hourly_worker, m
tab TELFS hourly_worker

gen byte salaried_worker = .
replace salaried_worker = 1 if TEERNHRY == 2
replace salaried_worker = 0 if TEERNHRY == 1

tab TEERNHRY salaried_worker, m
tab TELFS salaried_worker

*Weekly base pay
sum TRERNWA
tab TRERNWA if TRERNWA < 0 // NB we have blanks (-1)

sum PRERNWA
tab PRERNWA if PRERNWA < 0 // NB we have blanks (-1)

gen weekly_base_pay = TRERNWA
replace weekly_base_pay = . if TRERNWA == -1

svy, subpop(hourly_worker): mean weekly_base_pay
svy, subpop(salaried_worker): mean weekly_base_pay

*Saving dta
cd "$build\output"
save merged_atuscps, replace
