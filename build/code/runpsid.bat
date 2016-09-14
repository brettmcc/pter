del /Q F:\pter-master\build\temp\*	

"C:\Program Files\SASHome\SASFoundation\9.4\Sas.exe" -SYSIN "F:\pter-master\build\code\HourCode\WantAble.sas" -CONFIG "C:\Program Files\SASHome\SASFoundation\9.4\nls\u8\sasv9.cfg" -LOG "F:\pter-master\build\temp\WantAble.log"
"C:\Program Files\SASHome\SASFoundation\9.4\Sas.exe" -SYSIN "F:\pter-master\build\code\HourCode\Food.sas" -CONFIG "C:\Program Files\SASHome\SASFoundation\9.4\nls\u8\sasv9.cfg" -LOG "F:\pter-master\build\temp\Food.log"
"C:\Program Files\SASHome\SASFoundation\9.4\Sas.exe" -SYSIN "F:\pter-master\build\code\HourCode\Housework.sas" -CONFIG "C:\Program Files\SASHome\SASFoundation\9.4\nls\u8\sasv9.cfg" -LOG "F:\pter-master\build\temp\Housework.log"
"C:\Program Files\SASHome\SASFoundation\9.4\Sas.exe" -SYSIN "F:\pter-master\build\code\HourCode\PSIDMerge.sas" -CONFIG "C:\Program Files\SASHome\SASFoundation\9.4\nls\u8\sasv9.cfg" -LOG "F:\pter-master\build\temp\PSIDMerge.log"

"C:\Program Files\StatTransfer11-64\st.exe" "F:\pter-master\build\output\pooled.sas7bdat" "F:\pter-master\build\output\pooled.dta" -y

cd F:\pter-master\build\temp\
"C:\Program Files (x86)\Stata14\Stata-64.exe" /e do F:\pter-master\build\code\format_pooled_psid.do
