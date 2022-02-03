set sasexe=C:\Program Files\SASHome\SASFoundation\9.4\Sas.exe
set sascfg=C:\Program Files\SASHome\SASFoundation\9.4\nls\u8\sasv9.cfg
set builddir=C:\Users\bmccully\Documents\pter-master\build\

del /Q %builddir%temp\*	

cd %builddir%code\PSIDCode
"%sasexe%" -SYSIN "person.sas" -CONFIG "%sascfg%" -LOG "%builddir%temp\person.log"
"%sasexe%" -SYSIN "income6893.sas" -CONFIG "%sascfg%" -LOG "%builddir%temp\income6893.log" -PRINT "%builddir%temp\income6893.lst"
"%sasexe%" -SYSIN "NonAssetIncome.sas" -CONFIG "%sascfg%" -LOG "%builddir%temp\NonAssetIncome.log" -PRINT "%builddir%temp\NonAssetIncome.lst"
"%sasexe%" -SYSIN "wife.sas" -CONFIG "%sascfg%" -LOG "%builddir%temp\wife.log"
"%sasexe%" -SYSIN "empbus.sas" -CONFIG "%sascfg%" -LOG "%builddir%temp\empbus.log" -PRINT "%builddir%temp\empbus.lst"
"%sasexe%" -SYSIN "head.sas" -CONFIG "%sascfg%" -LOG "%builddir%temp\head.log" -PRINT "%builddir%temp\head.lst"
"%sasexe%" -SYSIN "childage.sas" -CONFIG "%sascfg%" -LOG "%builddir%temp\childage.log"
"%sasexe%" -SYSIN "disable.sas" -CONFIG "%sascfg%" -LOG "%builddir%temp\disable.log"
"%sasexe%" -SYSIN "housing.sas" -CONFIG "%sascfg%" -LOG "%builddir%temp\housing.log"
"%sasexe%" -SYSIN "Children.sas" -CONFIG "%sascfg%" -LOG "%builddir%temp\Children.log"

cd %builddir%code\HourCode\
"%sasexe%" -SYSIN "headgender.sas" -CONFIG "%sascfg%" -LOG "%builddir%temp\headgender.log"
"%sasexe%" -SYSIN "tenure.sas" -CONFIG "%sascfg%" -LOG "%builddir%temp\tenure.log"
"%sasexe%" -SYSIN "WantAble.sas" -CONFIG "%sascfg%" -LOG "%builddir%temp\WantAble.log"
"%sasexe%" -SYSIN "Food.sas" -CONFIG "%sascfg%" -LOG "%builddir%temp\Food.log"
"%sasexe%" -SYSIN "Housework.sas" -CONFIG "%sascfg%" -LOG "%builddir%temp\Housework.log"
"%sasexe%" -SYSIN "PSIDMerge.sas" -CONFIG "%sascfg%" -LOG "%builddir%temp\PSIDMerge.log"

cd %builddir%code\
"%sasexe%" -SYSIN "export_to_stata.sas" -CONFIG "%sascfg%" -LOG "%builddir%temp\export_to_stata.log"

cd %builddir%temp\
"C:\Program Files (x86)\Stata15\StataMP-64.exe" /e do %builddir%code\format_pooled_psid.do

::Findstr "WARNING:" %builddir%temp\*.log

Findstr "ERROR:" %builddir%temp\*.log

pause