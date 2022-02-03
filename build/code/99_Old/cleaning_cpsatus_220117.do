*Creating dataset
*2022.01.17


global build "C:\Users\39328\Dropbox\Hours constraints and home prod\build"
cd "$build\input\CPS-ATUS"

clear all


* Merged CPS ATUS
import sas using merged_atuscps.sas7bdat

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
isid HRHHID HRHHID2 HRSAMPLE

br if TUCASEID == "20030100013280"

destring TUCASEID, replace
format TUCASEID %14.0f

xtset TUCASEID

*Weights
codebook TUFNWGTP // weight for all periods