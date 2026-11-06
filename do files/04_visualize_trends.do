clear all 
set more off

*1. Set project directory
*2. Load cleaned data
use "data\data_clean.dta", clear

* 3. Keep research period
keep if inrange(year, 2000, 2024)

* 4. Convert indicators to numeric analysis variables
foreach v in gdppcgr lifeexp elec secenrol {

    capture confirm string variable `v'

    if !_rc {
        generate double `v'_num = real(trim(`v'))
    }
    else {
        generate double `v'_num = `v'
    }
}

* 5. Confirm country-year uniqueness
isid iso3 year

* 6. Create an output folder if it does not exist
capture mkdir "outputs"


* GRAPH 1: GDP per capita growth
twoway ///
	(connected gdppcgr_num year if iso3 == "AFG", sort) ///
	(connected gdppcgr_num year if iso3 == "BGD", sort) ///
	(connected gdppcgr_num year if iso3 == "BTN", sort) ///
	(connected gdppcgr_num year if iso3 == "IND", sort) ///
	(connected gdppcgr_num year if iso3 == "LKA", sort) ///
	(connected gdppcgr_num year if iso3 == "MDV", sort) ///
	(connected gdppcgr_num year if iso3 == "NPL", sort) ///
	(connected gdppcgr_num year if iso3 == "PAK", sort), ///
	title("GDP per Capita Growth in South Asia, 2000 - 2024") ///
	subtitle("Annual percentage growth") ///
	xtitle("Year") ///
	xsize(12) ///
	ytitle("GDP per capita growth (%)") ///
	xlabel(2000(2)2024) ///
	yline(0, lpattern(dash)) ///
	legend(order(1 "Afghanistan" 2 "Bangladesh" 3 "Bhutan" 4 "India" ///
		5 "Sri Lanka" 6 "Maldives" 7 "Nepal" 8 "Pakistan") ///
		rows(2) size(small)) ///
	graphregion(color(white))
	
graph export "outputs/gdppc_growth_trend.png", replace width(2400)

* GRAPH 2: Life Expectancy
twoway ///
    (connected lifeexp_num year if iso3 == "AFG", sort) ///
    (connected lifeexp_num year if iso3 == "BGD", sort) ///
    (connected lifeexp_num year if iso3 == "BTN", sort) ///
    (connected lifeexp_num year if iso3 == "IND", sort) ///
    (connected lifeexp_num year if iso3 == "LKA", sort) ///
    (connected lifeexp_num year if iso3 == "MDV", sort) ///
    (connected lifeexp_num year if iso3 == "NPL", sort) ///
    (connected lifeexp_num year if iso3 == "PAK", sort), ///
    title("Life Expectancy in South Asia, 2000-2024") ///
    xtitle("Year") ///
	xsize(12) ///
    ytitle("Life expectancy at birth (years)") ///
    xlabel(2000(2)2024) ///
    legend(order(1 "Afghanistan" 2 "Bangladesh" ///
                 3 "Bhutan" 4 "India" ///
                 5 "Sri Lanka" 6 "Maldives" ///
                 7 "Nepal" 8 "Pakistan") ///
           rows(2) size(small)) ///
    graphregion(color(white))

graph export "outputs/life_expectancy_trend.png", replace width(2400)

* GRAPH 3: Access to electricity
twoway ///
    (connected elec_num year if iso3 == "AFG", sort) ///
    (connected elec_num year if iso3 == "BGD", sort) ///
    (connected elec_num year if iso3 == "BTN", sort) ///
    (connected elec_num year if iso3 == "IND", sort) ///
    (connected elec_num year if iso3 == "LKA", sort) ///
    (connected elec_num year if iso3 == "MDV", sort) ///
    (connected elec_num year if iso3 == "NPL", sort) ///
    (connected elec_num year if iso3 == "PAK", sort), ///
    title("Access to Electricity in South Asia, 2000-2024") ///
    xtitle("Year") ///
	xsize(12) ///
    ytitle("Population with access (%)") ///
    xlabel(2000(2)2024) ///
    ylabel(0(20)100) ///
    legend(order(1 "Afghanistan" 2 "Bangladesh" ///
                 3 "Bhutan" 4 "India" ///
                 5 "Sri Lanka" 6 "Maldives" ///
                 7 "Nepal" 8 "Pakistan") ///
           rows(2) size(small)) ///
    graphregion(color(white))

graph export "outputs/electricity_access_trend.png", replace width(2400)

* GRAPH 4: Secondary School Enrollment
twoway ///
    (connected secenrol_num year if iso3 == "AFG", sort) ///
    (connected secenrol_num year if iso3 == "BGD", sort) ///
    (connected secenrol_num year if iso3 == "BTN", sort) ///
    (connected secenrol_num year if iso3 == "IND", sort) ///
    (connected secenrol_num year if iso3 == "LKA", sort) ///
    (connected secenrol_num year if iso3 == "MDV", sort) ///
    (connected secenrol_num year if iso3 == "NPL", sort) ///
    (connected secenrol_num year if iso3 == "PAK", sort), ///
    title("Secondary School Enrollment in South Asia, 2000-2024") ///
    subtitle("Gross enrollment ratio") ///
    xtitle("Year") ///
	xsize(12) ///
    ytitle("Gross enrollment ratio (%)") ///
    xlabel(2000(2)2024) ///
    legend(order(1 "Afghanistan" 2 "Bangladesh" ///
                 3 "Bhutan" 4 "India" ///
                 5 "Sri Lanka" 6 "Maldives" ///
                 7 "Nepal" 8 "Pakistan") ///
           rows(2) size(small)) ///
    graphregion(color(white))

graph export "outputs/secondary_enrollment_trend.png", replace width(2400)

display "Check the outputs folder for the PNG files."


	
	


