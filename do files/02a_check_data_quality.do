clear all 
set more off

* 1. Set project directory and load analysis-ready dataset

use "data\data_clean.dta", clear

* 2. Inspect dataset structure

describe

codebook iso3 year
list in 1/10


* 3. Check country coverage
* List countries and their frequencies
tabulate iso3

* Validate that all 8 South Asian countries appear in the dataset
* Count unique countries
egen country_tag = tag(iso3)
count if country_tag == 1
drop country_tag


* 4. Check year coverage

summarize year, detail
tabulate year

* Check whether years fall within the intended period
count if year < 2000 | year > 2024
display "Observations outside 2000-2024: " r(N)

* 5. Check duplicate country-year observations

duplicates report iso3 year

* List duplicate country-year combinations, if any
duplicates tag iso3 year, generate(dup_country_year)
list iso3 year if dup_country_year > 0

drop dup_country_year

* 6. Check indicator variables and storage types

describe iso3 year gdppcgr lifeexp elec secenrol

* Check whether indicators are stored as strings or numeric
foreach v in gdppcgr lifeexp elec secenrol {
    capture confirm string variable `v'
    if !_rc {
        display "`v' is stored as a STRING."
    }
    else {
        capture confirm numeric variable `v'
        if !_rc {
            display "`v' is stored as NUMERIC."
        }
    }
}

* 7. Check missing values

misstable summarize gdppcgr lifeexp elec secenrol

* Check enrollment coverage by country
misstable summarize secenrol

* Count available enrollment observations by country
bysort iso3: egen secenrol_n = count(secenrol)
egen tag_country = tag(iso3)

list iso3 secenrol_n if tag_country, noobs

drop secenrol_n tag_country

* 8. Check whether each country has the expected number
*    of observations (2000-2024 = 25 years)

bysort iso3: egen n_country_years = count(year)
egen country_tag2 = tag(iso3)

list iso3 n_country_years if country_tag2 == 1, noobs

drop n_country_years country_tag2

* 9. Final review

list iso3 year gdppcgr lifeexp elec secenrol in 1/20

display "Data structure and quality checks completed."

