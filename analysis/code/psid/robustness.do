/*Robustness checks*/

clear all
set more off, permanently

global analysisout /*
	*/"C:\Users\bmccully\Documents\pter-master\analysis\output"
global build /*
	*/"C:\Users\bmccully\Documents\pter-master\build\output\"
global analysisin /*
	*/"C:\Users\bmccully\Documents\pter-master\analysis\input"


use "$analysisin\pooled.dta",clear

/*How often does the marginal wage differ from main/avg wage?
--> provides sense for how much overtime pay affects our sample*/

gen marwg_eql_usualwg = .
replace marwg_eql_usualwg = 1 if abs(marwage-headwage)/headwage<=0.05 /*
	*/ & abs(marwage-headwage)/headwage!=.
replace marwg_eql_usualwg = 0 if (marwage-headwage)/headwage>0.05 /*
	*/& marwage !=. & headwage!=. & headwage!=0
replace marwg_eql_usualwg = -1 if (marwage-headwage)/headwage<-0.05 /*
	*/& marwage !=. & headwage!=. & headwage!=0
preserve
contract marwg_eql_usualwg
di "Fraction earning significantly (>5%) higher wage for extra work: " _freq[2]/(_freq[1]+_freq[2]+_freq[3])
restore

gen marwg_eql_usualwg2 = .
replace marwg_eql_usualwg2 = 1 if abs(marwage-mainwage)/mainwage<=0.05 /*
	*/ & abs(marwage-mainwage)/mainwage!=.
replace marwg_eql_usualwg2 = 0 if (marwage-mainwage)/mainwage>0.05 /*
	*/& marwage !=. & mainwage!=. & mainwage!=0
replace marwg_eql_usualwg2 = -1 if (marwage-mainwage)/mainwage<-0.05 /*
	*/& marwage !=. & mainwage!=. & mainwage!=0
preserve
contract marwg_eql_usualwg2
di "Fraction earning significantly (>5%) higher wage for extra work (alt def.): "_freq[2]/(_freq[1]+_freq[2]+_freq[3])
restore


/**/


