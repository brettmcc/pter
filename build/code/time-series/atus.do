global temp = "C:\Users\bmccully\Documents\pter-master\build\temp\"

use $temp\atusresp0316,clear
merge 1:1 tucaseid using $temp\atussum0316,nogen
merge 1:m tucaseid using $temp\atuscps0316

//keep those in labor force; use telfs, as it is has imputed missing vals
drop if telfs==5

tab telfs prcivlf
tab trdpftpt
