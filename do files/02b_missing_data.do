clear all
set more off


* Load cleaned dataset
use "data\data_clean.dta", clear

* Restrict analysis to intended research period
keep if inrange(year, 2000, 2024)

* STEP 1: Check overall dataset
count
display "Total country-year observations: " r(N)

egen country_tag = tag(iso3)
count if country_tag == 1
display "Number of countries: " r(N)
drop country_tag

summarize year
display "Expected observations if balanced: 200"

* STEP 2: Check missing values in each indicator
foreach v in gdppcgr lifeexp elec secenrol {

    display "------------------------------------------"
    display "Indicator: `v'"

    * Check whether variable is stored as a string
    capture confirm string variable `v'

    if !_rc {
        count if missing(trim(`v')) | trim(`v') == ".."
        local missing_n = r(N)
    }
    else {
        count if missing(`v')
        local missing_n = r(N)
    }

    count
    local total_n = r(N)

    display "Total observations: `total_n'"
    display "Missing observations: `missing_n'"
    display "Nonmissing observations: " `total_n' - `missing_n'
    display "Missing percentage: " %6.2f (100 * `missing_n' / `total_n') "%"
}

* STEP 3: Missing data by country
foreach v in gdppcgr lifeexp elec secenrol {

    display "------------------------------------------"
    display "Indicator: `v'"

    capture confirm string variable `v'

    if !_rc {
        generate byte miss_`v' = missing(trim(`v')) | trim(`v') == ".."
    }
    else {
        generate byte miss_`v' = missing(`v')
    }

    bysort iso3: egen missing_`v' = total(miss_`v')
    egen country_tag_`v' = tag(iso3)

    list iso3 missing_`v' if country_tag_`v' == 1, noobs

    drop miss_`v' missing_`v' country_tag_`v'
}

* STEP 4: Identify country-years with missing indicators
foreach v in gdppcgr lifeexp elec secenrol {

    capture confirm string variable `v'

    if !_rc {
        generate byte miss_`v' = missing(trim(`v')) | trim(`v') == ".."
    }
    else {
        generate byte miss_`v' = missing(`v')
    }
}

egen missing_any = rowmax(miss_gdppcgr miss_lifeexp miss_elec miss_secenrol)

list iso3 year gdppcgr lifeexp elec secenrol ///
    if miss_gdppcgr == 1 | miss_lifeexp == 1 | ///
       miss_elec == 1 | miss_secenrol == 1, noobs
	   
* STEP 5: Missing data patterns
misstable patterns

display "Missing data analysis completed."	   
	   