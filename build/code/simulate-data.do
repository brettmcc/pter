***generate simulated data to explore issue of 2SLS with limited variation in dummy variables
clear all

// capture program drop myreg
// program myreg,eclass
	drop _all
	set obs 100000
	gen z = rbinomial(1,0.008)
	gen c = rnormal()
	generate x = uniform() < invlogit(-5+ln(500)*z+0.1*c+rnormal())
	generate y = uniform() < invlogit(-ln(1/0.01-1)+ln(3)*x+ln(1.2)*c+rnormal())
	reg x z,robust
	predict x_fitted
	reg y x,robust
	ivreg2 y (x=z),robust
	logit y x
	logit y x_fitted
/*
end

simulate, reps(100): myreg
*/
