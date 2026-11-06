clear all
set more off

* 1. Set project directory
* 2. Load cleaned data
use "data\data_clean.dta", clear

* 3. Keep intended research period
keep if inrange(year, 2000, 2024)

* 4. Convert indicators into numeric analysis copies
* Original variables remain unchanged
foreach v in gdppcgr lifeexp elec secenrol {

    capture confirm string variable `v'

    if !_rc {
        generate double `v'_num = real(trim(`v'))
    }
    else {
        generate double `v'_num = `v'
    }
}

* STEP 1: Overall Descriptive Statistics
tabstat gdppcgr_num lifeexp_num elec_num secenrol_num, ///
    statistics(n mean sd min p25 p50 p75 max) ///
    columns(statistics)
	
* STEP 2: Detailed Statistics for each Indicator

* GDP per capita growth
summarize gdppcgr_num, detail

* Life Expectancy
summarize lifeexp_num, detail

* Electricity Access
summarize elec_num, detail

* Secondary School Enrollment
summarize secenrol_num, detail


* STEP 3: Descriptive Statistics by Country
tabstat gdppcgr_num lifeexp_num elec_num secenrol_num, ///
    by(iso3) statistics(n mean sd min max) ///
    columns(statistics)
	
* STEP 4: Check usable Observations
foreach v in gdppcgr_num lifeexp_num elec_num secenrol_num {

    quietly count if !missing(`v')
    display "`v': " r(N) " usable observations"
}

display "Descriptive statistics completed."