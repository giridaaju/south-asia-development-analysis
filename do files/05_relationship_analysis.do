clear all
set more off

use "data\data_clean.dta", clear

* Restrict analysis to 2000-2024
keep if inrange(year, 2000, 2024)

* Create numeric versions of the indicators
capture drop gdppcgr_num lifeexp_num elec_num secenrol_num

foreach v in gdppcgr lifeexp elec secenrol {
    capture confirm string variable `v'

    if !_rc {
        generate double `v'_num = real(trim(`v'))
    }
    else {
        generate double `v'_num = `v'
    }
}

* GRAPH 1: GDP per capita growth and life expectancy
twoway ///
    (scatter lifeexp_num gdppcgr_num), ///
    title("Economic Growth and Life Expectancy") ///
    subtitle("South Asia, 2000-2024") ///
    xtitle("GDP per capita growth (%)") ///
    ytitle("Life expectancy at birth (years)") ///
    graphregion(color(white))

graph export "outputs/growth_vs_lifeexp.png", replace width(2400)


* GRAPH 2: GDP per capita growth and Access to electricity
twoway ///
    (scatter elec_num gdppcgr_num), ///
    title("Economic Growth and Electricity Access") ///
    subtitle("South Asia, 2000-2024") ///
    xtitle("GDP per capita growth (%)") ///
    ytitle("Population with access to electricity (%)") ///
    graphregion(color(white))

graph export "outputs/growth_vs_electricity.png", replace width(2400)

* GRAPH 3: GDP per capita and Secondary school enrollment
twoway ///
    (scatter secenrol_num gdppcgr_num), ///
    title("Economic Growth and Secondary School Enrollment") ///
    subtitle("South Asia, 2000-2024") ///
    xtitle("GDP per capita growth (%)") ///
    ytitle("Gross secondary enrollment ratio (%)") ///
    graphregion(color(white))

graph export "outputs/growth_vs_enrollment.png", replace width(2400)

pwcorr gdppcgr_num lifeexp_num elec_num secenrol_num, ///
	obs sig star(.05)
pwcorr gdppcgr_num lifeexp_num, obs sig
pwcorr gdppcgr_num elec_num, obs sig
pwcorr gdppcgr_num secenrol_num, obs sig

display "Relationship analysis completed successfully."

	

