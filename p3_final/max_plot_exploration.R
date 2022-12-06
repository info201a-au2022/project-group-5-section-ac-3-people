# ---
# SETUP
# Setup: Libraries
library("tidyverse")
library("ggplot2")
library("plotly")
library("usmap")
library("leaflet")

# Setup: Data
hospital_locations <- read.csv("../data/us_hospital_locations.csv")
maternal_mort <- read.csv("../data/maternal_mortality_urban_rural.csv")
state_abb <- read.csv("../data/abbr-name-list.csv")
RUCC_codes <- read.csv("../data/ruralurbancodes2013.csv")
maternal_mort_by_state <- read.csv("../data/maternal_mort_state.csv")

# ---
# DATA WRANGLING

# Maternal Mort Test
maternal_mort_tidy <- maternal_mort_by_state %>% 
  left_join(state_abb, by = c("state" = "name")) %>% 
  summarise(
    state,
    abbreviation = 
  )

# Default Map Shape
state_shape <- map_data("state") %>% 
  rename(state = region)

# Total Hospitals per State
num_hospitals <- hospital_locations %>% 
  summarise(NAME, STATE) %>% 
  left_join(state_abb, by = c("STATE" = "abbreviation")) %>% 
  mutate(name = tolower(name))%>% 
  summarise(
    hospital_name = NAME,
    state = name
    ) %>% 
  group_by(state) %>% 
  count(state) %>% 
  summarise(
    state,
    num_hospitals = n
  )

# Total Hospital *Beds* per state
num_beds <- hospital_locations %>% 
  summarise(NAME, STATE, BEDS) %>% 
  mutate_all(funs(str_replace(., "-999", NA_character_))) %>%
  left_join(state_abb, by = c("STATE" = "abbreviation")) %>% 
  mutate(name = tolower(name))%>% 
  summarise(
    hospital_name = NAME,
    beds = as.numeric(BEDS),
    state = name
  ) %>% 
  group_by(state) %>% 
  summarise(
    state,
    total_beds = sum(beds, na.rm = TRUE)
  ) %>% 
  distinct(state, .keep_all = TRUE)

# Number of Total Hospitals and Total Beds per state (for chloropleth map)
hospitals_and_beds_per_state <- state_shape %>% 
  left_join(num_hospitals, by = "state") %>% 
  left_join(num_beds, by = "state")

# Hospital location (long, lat) and number of beds
location_and_beds <- hospital_locations %>% 
  summarise(LONGITUDE, LATITUDE, NAME, STATE, BEDS) %>% 
  mutate_all(funs(str_replace(., "-999", NA_character_))) %>% 
  left_join(state_abb, by = c("STATE" = "abbreviation")) %>% 
  mutate(name = tolower(name))%>% 
  summarise(
    long = as.numeric(LONGITUDE),
    lat = as.numeric(LATITUDE),
    state = name,
    hospital_name = str_to_title(NAME),
    beds = as.numeric(BEDS),
    label = paste(hospital_name, ", Beds: ", beds, sep = ""),
    beds_no_na = replace_na(beds, 50),
    pt_size = log(beds_no_na, 2),
  )

# RUCC Codes with coordinates (DOESNT WORK RN)
rucc_tidy <- RUCC_codes %>% 
  left_join(state_abb, by = c("State" = "abbreviation")) %>% 
  summarise(
    state = tolower(name),
    county = County_Name,
    rucc = RUCC_2013,
    description = Description,
    pop = Population_2010
  )  %>% 
  group_by(state) %>% 
  pivot_wider(names_from = rucc, values_from = rucc)


rucc_coords <- state_shape %>% 
  left_join(rucc_tidy, by = "state") %>% 


# ---
# MAPPING 

# Blank Theme
blank_theme <- theme_bw() +
  theme(
    axis.line = element_blank(),
    axis.text = element_blank(),
    axis.ticks = element_blank(),
    axis.title = element_blank(),
    plot.background = element_blank(),
    panel.grid.minor = element_blank(),
    panel.grid.major = element_blank(),
    panel.border = element_blank()
  )

# Num Hospitals ggplotly map
num_hospitals_map <- ggplotly(ggplot(hospitals_and_beds_per_state) +
  geom_polygon(
    mapping = aes(x = long, y = lat, group = group, fill = num_hospitals),
    color = "white",
    size = .1
    ) +
  coord_map() +
  scale_fill_continuous(low = "white", high = "blue") +
  labs(fill = "Number of Hospitals in State") +
  blank_theme
)
  
num_hospitals_map_ggplotly <- ggplotly(num_hospitals_map)


# Hospital Locations by Number of Beds Leaflet
hospital_locations_leaflet <- leaflet(data = location_and_beds) %>% 
  addProviderTiles("CartoDB.Positron") %>% 
  setView(lng = -122.3321, lat = 47.6062, zoom = 5) %>% 
  addCircleMarkers(
    lat = ~lat,
    lng = ~long,
    radius = ~pt_size,
    stroke = FALSE,
    fill = TRUE,
    fillColor = "blue",
    fillOpacity = .3,
    label = ~label
  )

# RUCC codes prevalence by state (DOESNT WORK RN)
rucc_codes_map <- ggplot(rucc_coords) +
  geom_polygon(
    mapping = aes(x = long, y = lat, group = group, fill = rucc),
    color = "white",
    size = .1
  ) +
  coord_map() +
  labs(fill = "") +
  blank_theme

maternal_mort_by_state_chart_test <- ggplot(maternal_mort_by_state) +
  geom_col(mapping = aes(x = state, y = maternalMortalityRate))




report <- tabPanel(
  "report",
  titlePanel("Report Page"), 
  h3("Healthcare Access in USA"),
  strong("codename: health-disparities"),
  em("Riley Mintz (rimintz@uw.edu) and Max Stewart (mzs11@uw.edu)"),
  p("Autumn 2022"), 
  h4("Abstract"),
  p(""),
  em("Keywords: healthcare, hospitals, healthcare access, hospital access"), 
  h4("Problem Domain"),
  strong("Project Framing:"), 
  p("As Seattleites, we live in an area with plenty of hospitals. Despite this, you or someone you know has likely experienced long wait times, not being seen due to insurance problems, or other issues accessing healthcare. Imagine how much worse this would be", a("if you had to drive hours to reach the nearest hospital.", href = "https://www.pewresearch.org/fact-tank/2018/12/12/how-far-americans-live-from-the-closest-hospital-differs-by-community-type/"), "In this project, we are exploring hospital access based on the number of hospitals and their capacity (in beds) in each state, the hospital beds per capita, the locations of these hospitals, and each state's negative healthcare outcomes in terms of maternal mortality (and how this correlated to that state's total hospitals)"), 
  strong("Human Values:"), 
  p("We believe that all people deserve access to quality healthcare. We are particularly concerned in this project with the", a("high rates of maternal mortality faced by some groups in the United States, particularly racial minorities and people living in rural areas.", href = "https://www.cdc.gov/reproductivehealth/maternal-mortality/pregnancy-mortality-surveillance-system.htm"), "We hope our charts will allow people to compare hospital access and maternal mortality in any given state to other factors, such as that state's minority populations or amount of rural areas to gain insight into how these trends correlate."), 
  strong("Stakeholders:"), 
  p("Everyone is a stakeholder when it comes to public health. Particularly, people living in areas with limited access to hospitals are indirect stakeholders as they are at risk for more negative health outcomes.", a("Doctors and the Hospitals that hire them are also stakeholders; doctors deserve to be fairly compensated for their expertise, but hospitals in rural areas are often unable or unwilling to offer competitive wages, leading to a lack of medical professionals in those areas.", href = "https://www.cdc.gov/reproductivehealth/maternal-mortality/pregnancy-mortality-surveillance-system.htm"), "This compounds the lack of healthcare."), 
  strong("Possible Harms:"), 
  p("We are only taking into account geographic and the most general population information in this project. This means that health disparities due to race are not being addressed: The healthcare deficits we found in some areas may be greatly heightened by a patient's race, or other features like their socioeconomic status. We also only used one metric of healthcare outcome, while maternal mortality is important, healthcare outcomes may be very different for other issues, such as cancer, infectious diseases, or lifelong conditions like asthma. Additionally, our datasets may not provide complete information about all hospitals."), 
  strong("Possible Benefits:"), 
  p("We hope this website allows anyone who is interested to see the distribution of hospitals in the United States. We hope this information allows people to look into other relative healthcare outcomes in their state, and be able to compare that to states with more or fewer hospitals. We think this could raise awareness of the issue of healthcare access in the United States."), 
  h4("Research Questions"), 
  tags$ul(
    tags$li(strong("What areas in the United States have the fewest hospitals, or lowest overall hospital capacity?"), "Having a small total number of hospitals means some people have to travel great distances to access healthcare. Furthermore, having low capacity in those hospitals can result in very limited access to care, particularly during events like a pandemic."), 
    tags$li(strong("How does a state's hospital capacity compare to it's population?"), "States with fewer hospitals or fewer hospital beds may have limited facilities because of a low population... or they may not, leaving many people with difficulty accessing healthcare."), 
    tags$li(strong("Do states with fewer hospitals suffer worse healthcare outcomes, particularly maternal mortality?"), "Maternal mortality is an indicator of healthcare access and quality. States with higher maternal mortality may have hospitals that are difficult to get to, or provide poor care. We are interested in seeing a correlation between hospital number and this healthcare outcome.")
  ),
  h4("The Dataset"), 
  p("We are using 2 primary datasets and two supplementary datasets, linked below:"),
  tags$ul(
    tags$li(a("US Hospital Locations: ", href = "https://www.kaggle.com/datasets/andrewmvd/us-hospital-locations"), "This dataset provides the names, locations, and number of beds of hospitals in the USA. We used this information to answer questions about hospital density across states, build a map, and find the number of hospital beds compared to the population of a state. Data is from The U.S. Department of Homeland Security."),
    tags$li(a("Maternal Mortality Rate by State 2022: ", href = "https://worldpopulationreview.com/state-rankings/maternal-mortality-rate-by-state"), "We used this dataset to graph the maternal mortality for each state. Data from USA TODAY"),
    tags$li(a("List of State Abbreviations: ", href = "https://worldpopulationreview.com/states/state-abbreviations"), "We simply used this to match state abbreviations to their full state names. Data from World Population Review."),
    tags$li(a("Rural-Urban Continuum Codes: ", href = "https://www.ers.usda.gov/data-products/rural-urban-continuum-codes.aspx"), "We intended to explore healthcare outcomes by RUCC code, but were unable to complete that analysis in the given time. We also used this population data as a rough estimate of population for determining hospitals per capita in state. Data from U.S. Department of Agriculture.")
  ),
  h4("Report"),
  p(strong("Findings: "), ""), 
  p(strong("Discussion: "), ""), 
  p(strong("Conclusion: "), ""),
  h4("Acknowledgements"), 
  p(""), 
  h4("References"), 
  tags$ul(
    tags$li(""),
    tags$li(""),
    tags$li("")
  )
)

