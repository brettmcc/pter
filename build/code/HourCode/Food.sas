%include '..\setlibraries_psid.sas';

data temp.food1968;
set psiddata.fam68;
id1968 = V3;
Foodin1968 = .;
Foodout1968 = .;
keep id1968 Foodin1968 Foodout1968;

data temp.food1969;
set psiddata.fam69;
id1969 = V442;
Foodin1969 = V500;
Foodout1969 = V506;
keep id1969 Foodin1969 Foodout1969;

data temp.food1970;
set psiddata.fam70;
id1970 = V1102;
Foodin1970 = V1175;
Foodout1970 = V1185;
keep id1970 Foodin1970 Foodout1970;

data temp.food1971;
set psiddata.fam71;
id1971 = V1802;
Foodin1971 = V1876;
Foodout1971 = V1886;
keep id1971 Foodin1971 Foodout1971;

data temp.food1972;
set psiddata.fam72;
id1972 = V2402;
Foodin1972 = V2476;
Foodout1972 = V2480;
keep id1972 Foodin1972 Foodout1972;

data temp.food1973;
set psiddata.fam73;
id1973 = V3002;
Foodin1973 = .;
Foodout1973 = .;
keep id1973 Foodin1973 Foodout1973;

data temp.food1974;
set psiddata.fam74;
id1974 = V3402;
Foodin1974 = V3441;
Foodout1974 = V3445;
keep id1974 Foodin1974 Foodout1974;

data temp.food1975;
set psiddata.fam75;
id1975 = V3802;
Foodin1975 = V3841;
Foodout1975 = V3853;
keep id1975 Foodin1975 Foodout1975;

data temp.food1976;
set psiddata.fam76;
id1976 = V4302;
Foodin1976 = V4354;
Foodout1976 = V4368;
keep id1976 Foodin1976 Foodout1976;

data temp.food1977;
set psiddata.fam77;
id1977 = V5202;
Foodin1977 = V5271;
Foodout1977 = V5273;
keep id1977 Foodin1977 Foodout1977;

data temp.food1978;
set psiddata.fam78;
id1978 = V5702;
Foodin1978 = V5770;
Foodout1978 = V5772;
keep id1978 Foodin1978 Foodout1978;

data temp.food1979;
set psiddata.fam79;
id1979 = V6302;
Foodin1979 = V6376;
Foodout1979 = V6378;
keep id1979 Foodin1979 Foodout1979;

data temp.food1980;
set psiddata.fam80;
id1980 = V6902;
Foodin1980 = V6972;
Foodout1980 = V6974;
keep id1980 Foodin1980 Foodout1980;

data temp.food1981;
set psiddata.fam81;
id1981 = V7502;
Foodin1981 = V7564;
Foodout1981 = V7566;
keep id1981 Foodin1981 Foodout1981;

data temp.food1982;
set psiddata.fam82;
id1982 = V8202;
Foodin1982 = V8256;
Foodout1982 = V8258;
keep id1982 Foodin1982 Foodout1982;

data temp.food1983;
set psiddata.fam83;
id1983 = V8802;
Foodin1983 = V8864;
Foodout1983 = V8866;
keep id1983 Foodin1983 Foodout1983;

data temp.food1984;
set psiddata.fam84;
id1984 = V10002;
Foodin1984 = V10235;
Foodout1984 = V10237;
keep id1984 Foodin1984 Foodout1984;

data temp.food1985;
set psiddata.fam85;
id1985 = V11102;
Foodin1985 = V11375;
Foodout1985 = V11377;
keep id1985 Foodin1985 Foodout1985;

data temp.food1986;
set psiddata.fam86;
id1986 = V12502;
Foodin1986 = V12774;
Foodout1986 = V12776;
keep id1986 Foodin1986 Foodout1986;
run;

