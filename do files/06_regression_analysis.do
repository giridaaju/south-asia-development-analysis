clear all
set more off

use "data\data_clean.dta", clear

keep if inrange(year, 2000, 2024)
foreach v in gdppcgr lifeexp elec secenrol {

    capture drop `v'_num
    capture confirm string variable `v'

    if !_rc {
        generate double `v'_num = real(trim(`v'))
        replace `v'_num = . if trim(`v') == ".." | trim(`v') == ""
    }
    else {
        generate double `v'_num = `v'
    }
}
	
capture drop country_id
encode iso3, generate(country_id)

isid country_id year
xtset country_id year

capture mkdir "outputs"

misstable summarize gdppcgr_num lifeexp_num elec_num secenrol_num

*OUTCOME 1: Life Expectancy
* Model 1: Pooled OLS
regress lifeexp_num gdppcgr_num, vce(robust)
estimates store life_pooled

* Model 2: Country fixed effects
regress lifeexp_num gdppcgr_num i.country_id, ///
vce(cluster country_id)
estimates store life_countryfe

* Model 3: Country and year fixed effects
regress lifeexp_num gdppcgr_num i.country_id i.year, ///
vce(cluster country_id)
estimates store life_twfe

* Compare the three specifications
estimates table life_pooled life_countryfe life_twfe, ///
b(%9.3f) se(%9.3f) stats(N r2)


*OUTCOME 2: Electricity Access
* Model 1: Pooled OLS
regress elec_num gdppcgr_num, vce(robust)
estimates store elec_pooled

* Model 2: Country fixed effects
regress elec_num gdppcgr_num i.country_id, ///
vce(cluster country_id)
estimates store elec_countryfe

* Model 3: Country and year fixed effects
regress elec_num gdppcgr_num i.country_id i.year, ///
vce(cluster country_id)
estimates store elec_twfe

* Compare the three specifications
estimates table elec_pooled elec_countryfe elec_twfe, ///
b(%9.3f) se(%9.3f) stats(N r2)


* OUTCOME 3: Secondary School Enrollment
* Model 1: Pooled OLS
regress secenrol_num gdppcgr_num, vce(robust)
estimates store enrol_pooled

* Model 2: Country fixed effects
regress secenrol_num gdppcgr_num i.country_id, ///
vce(cluster country_id)
estimates store enrol_countryfe

* Model 3: Country and year fixed effects
regress secenrol_num gdppcgr_num i.country_id i.year, ///
vce(cluster country_id)
estimates store enrol_twfe

* Compare the three specifications
estimates table enrol_pooled enrol_countryfe enrol_twfe, ///
b(%9.3f) se(%9.3f) stats(N r2)


save "outputs/wdi_regression_analysis.dta", replace

display "Regression analysis completed."

