\# South Asia Development Analysis



\## Overview



This project examines the relationship between economic growth and human development across South Asian countries from 2000 to 2024.



\*\*Research question:\*\*



Has economic growth been associated with improvements in human development across South Asian countries since 2000?



The analysis uses World Bank World Development Indicators (WDI) data and Stata to explore relationships between GDP per capita growth and selected human development indicators.



\## Countries Covered



\- Afghanistan

\- Bangladesh

\- Bhutan

\- India

\- Maldives

\- Nepal

\- Pakistan

\- Sri Lanka



\## Data and Variables



The project uses the following World Development Indicators:



| Variable | Description | WDI Indicator |

|---|---|---|

| `gdppcgr` | GDP per capita growth (annual %) | `NY.GDP.PCAP.KD.ZG` |

| `lifeexp` | Life expectancy at birth (years) | `SP.DYN.LE00.IN` |

| `elec` | Access to electricity (% of population) | `EG.ELC.ACCS.ZS` |

| `secenrol` | Gross secondary school enrollment (%) | `SE.SEC.ENRR` |



\*\*Data source:\*\* \[World Bank – World Development Indicators](https://databank.worldbank.org/source/world-development-indicators)



\## Methodology



The project uses Stata for data cleaning, exploratory data analysis, visualization, and regression analysis.



The regression analysis examines the association between GDP per capita growth and three human development outcomes:



1\. Life expectancy

2\. Access to electricity

3\. Gross secondary school enrollment



Three model specifications are estimated:



\- \*\*Pooled OLS:\*\* Estimates the relationship across all country-year observations.

\- \*\*Country fixed effects:\*\* Controls for time-invariant differences between countries.

\- \*\*Country and year fixed effects:\*\* Controls for country-specific characteristics that do not change over time and common year-specific shocks.



Robust or country-clustered standard errors are used, depending on the model specification.



\## Key Findings



Across the nine estimated regressions, GDP per capita growth was not statistically significant at the 5% level.



The analysis uses up to 199 observations for life expectancy and electricity access, and 163 observations for secondary school enrollment.



These findings should be interpreted cautiously. The dataset contains only eight countries, making conventional country-clustered statistical inference less reliable. The regressions identify associations, not causal effects.



\## Repository Structure



```text

South Asia Development Analysis/

├── data/

│   ├── wdi\_raw.csv

│   └── wdi\_analysis.dta

├── do-files/

│   ├── 01\_data\_cleaning.do

│   ├── 02\_descriptive\_analysis.do

│   ├── 03\_visualizations.do

│   ├── 04\_relationship\_analysis.do

│   ├── 06\_regression\_analysis.do

│   └── 07\_lagged\_analysis.do

├── outputs/

│   ├── graphs

│   ├── 06\_regression\_results.log

│   └── wdi\_regression\_analysis.dta

├── README.md

└── .gitignore

```



\*Note: The filenames above are the intended project structure. Adjust them to match the files actually included in the repository.\*



\## How to Run the Project



1\. Clone or download this repository.

2\. Open Stata.

3\. Set the working directory to the repository's root folder.

4\. Run the relevant `.do` files from the `do-files/` directory.



For example:



```stata

cd "path/to/South Asia Development Analysis"

do "do-files/01\_data\_cleaning.do"

```



The project uses relative file paths so that it can be run from different computers without modifying the source code.



\## Limitations



\- The analysis covers only eight South Asian countries.

\- Missing observations reduce the sample size for some indicators.

\- Country-clustered standard errors can be unreliable with so few country clusters.

\- The observational design does not establish causality.

\- GDP per capita growth may not capture broader dimensions of economic development or the distribution of economic gains.



\## Tools



\- Stata

\- Microsoft Excel / CSV

\- World Bank World Development Indicators



