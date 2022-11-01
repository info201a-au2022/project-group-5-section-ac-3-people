### Code Name: Health-Disparities

# Working Title: Exploration of Disparities in Healthcare Access in the USA by Race and Location
### Anushka Damidi (damidia@uw.edu), Riley Mintz (rimintz@uw.edu) & Max Stewart (mzs11@uw.edu)
INFO-201: Technical Foundations of Informatics - The Information School - University of Washington, Autumn 2022

# Abstract
Our project focuses on the disparities in maternal death and access to healthcare among women from various ethnicities. This project will shed light on the many ways that women of color are marginalized in the healthcare system and the improvements that can be made to address this issue. To address this, we plan to analyze data regarding maternal death rates among different ethnicities of women. 

### Keywords:
POC, Minorities , Healthcare Access, Maternal Mortality, Race, Hospital Locations

---

# Introduction
We are interested in looking into healthcare access and outcome by a couple metrics. We will look into disparities in maternal mortality by race, as well as by location type. We will also  look into hospital access by location. We would also be interested in looking into healthcare outcomes more broadly by race, although this data is difficult to find. Broadly, our project investigates which people in the USA have access to healthcare, and to favorable healthcare outcomes. 

## Problem Domain
- **Project Framing:** Mostly TBD at the moment, we will look into how location and race are tied to healthcare quality (using maternal mortality as a proxy, at least for now), and what areas of the US have access to hospitals. 
- **Human Values:** All people deserve access to quality healthcare, but this right is often denied. Black and Indigenous mothers (and other birthing parents of color) face much higher rates of maternal mortality than white mothers. People living in some areas of the US also face a lack of access to healthcare, often compounded by other health risk factors.(https://www.cdc.gov/reproductivehealth/maternal-mortality/pregnancy-mortality-surveillance-system.htm)
- **Stakeholders:** Indirect stakeholders include anyone who needs medical attention living in the US, and direct stakeholders include those hospitals and medical institutions that have access to this data about healthcare inequity, and yet so often continue giving sub-par care to some people. 
- **Possible Harms:** Depending on the data we find, some groups (especially racial groups who may be categorized poorly in data sets) may be represented in ways they do not prefer. 
- **Possible Benefits:** Showing the racial groups and physical communities that recieve lackluster medical care may expose these inequities and encourage people (hospitals? The US govenment? Concerned citizens?) to make changes in our healthcare system.

## Research Questions
- *Who has access to hospitals in the United States?* Lack of hospital access can be a compounding factor leading to worse health outcomes, especially when low-income communities both lack healthcare access and are subject to compounding health risk factors, such as pollution and poverty.
- *How does race affect the mortality rates of pregnant women in healthcare?* Data has shown that women of color are receive less attentive care when compared to white women in the healthcare clinic, especially in the labor and delivery setting. *What factors come into play here?*
- *How does location (broadly speaking: rural, suburban, urban, etc) affect the mortality rates of pregnant women in healthcare?* Why is maternal mortality higher in some areas, do they lack hospitals or have to drive a long way to get to one? Who is living in those areas?

## The Dataset
So far, we have found 3 datasets that cover the following topics: Hospitals by location in US, maternal mortality by race, and maternal mortality by type of location (urban, rural, etc.). These datasets will give us an idea of how healthcare access and outcomes, specifically maternal mortality, are related to racial category and to location in the US. We would be open to adding more datasets to our project as it develops and a need for additional data is found, for example, racial demographics of particular areas in the US (available on the Census website).

|   | Hospital Locations  | Maternal Mortality (Race)  | Maternal Mortality (Location)  | 
| --- | --- | --- | --- |
| Num. Rows  | 7596  | 1  | 1  |
| Num. Columns  | 34  | 7  | 6  |

- Hospital Locations is the file [us_hospital_locations.csv](https://www.kaggle.com/datasets/andrewmvd/us-hospital-locations)
- Maternal Mortality (Race) is the file [pregnancy_related_mortality_ratio_by_race_ethnicity__2016_2018.csv](https://www.cdc.gov/reproductivehealth/maternal-mortality/pregnancy-mortality-surveillance-system.htm)
- Maternal Mortality (Location) is the file [pregnancy_related_mortality_ratio_by_urban_rural_classifications__2016_2018.csv](https://www.cdc.gov/reproductivehealth/maternal-mortality/pregnancy-mortality-surveillance-system.htm)

The hospital locations dataset is from Kaggle, a website for learning data science where people can upload datasets. *The website is currently displaying an error when I go to the source page for this dataset (or any other dataset), so I will add info about the contributer if I am able.* The two small pregnancy-related datasets are from the Center for Disease Control (CDC), a US government website. These datasets were created with data from the National Vital Statistics System (NVSS), using data for only 2016-2018. We may end up using more data from the dataset this source pulled from. 

## Expected Implications
Assuming our research questions are answered, the possible implications for technologists, designers, and policymakers are using this data to improve the medical experiences for people of color and better understand the limitations that emerge for people of color in healthcare. In recent years, this has become more of a wider discussed issue, but there is still major moves to be made. Hospitals can use this data and the web app we will create to make healthcare experiences impartial for all people regardless of their background, including but not limited to, ethnicity, gender, sexuality, economic status, or residence. Additionally, understanding where hospitals are located and who is able to access them increases the likelihood of making medical care equitable for all people. If hospitals and medical care was more attainable for people with low-income, there would be less fatalities and other negative consequences that are created when there is a gap in quality of healthcare. 

## Limitations
One limitation is that areas with poverty and poor healthcare might not have proper records and data regarding maternal deaths which can skew the overall data and show incorrect information regarding the disparity between the races in healthcare. Another limitation is that we are only focusing on maternal mortality, which is a specific area in healthcare. Therefore, this will only show the lack of proper healthcare in this area, and the disparity might be larger in other specialties of healthcare. 

## Acknowledgements
We would like to acknowledge our TA for helping us throughout this project. We would also like to acknowledge our classmates for sharing their ideas. 

## References

https://www.kaggle.com/datasets/andrewmvd/us-hospital-locations

https://data.census.gov/cedsci/table

https://www.cdc.gov/nchs/data/hestat/maternal-mortality-2021/maternal-mortality-2021.htm#anchor_1559670130302

https://demo.datacenter.cmqcc.org/hospitals/1/reports/race_ethnicity 

https://www.cdc.gov/reproductivehealth/maternal-mortality/pregnancy-mortality-surveillance-system.htm

https://wonder.cdc.gov/natality-current.html


## Appendix A: Questions
No questions at the moment!
