clear all

import delimited "data\wdi_raw.csv", varnames(nonames) stringcols(_all) clear

drop in 1
keep if length(v2) == 3
count

drop v6 v3

rename v1 country
rename v2 iso3
rename v4 series
foreach n of numlist 5 7/30 {
	local yr = cond(`n'==5, 2000, `n'+1994)
	rename v`n' val`yr'
}

replace series = "gdppcgr" if series == "NY.GDP.PCAP.KD.ZG"
replace series = "lifeexp"  if series == "SP.DYN.LE00.IN"
replace series = "elec"     if series == "EG.ELC.ACCS.ZS"
replace series = "secenrol" if series == "SE.SEC.ENRR"

ds val*, has(type string)
foreach v of varlist `r(varlist)' {
    replace `v' = "" if `v' == ".."
    destring `v', replace
}

describe val*

destring val*, replace force
ds val*, has(type string)

reshape long val, i(iso3 series) j(year)
reshape wide val, i(iso3 year) j(series) string 
rename val* *

describe
count
misstable summarize gdppcgr lifeexp elec secenrol
save "data_clean.dta", replace
