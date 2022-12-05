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
num_hospitals_map <- ggplot(hospitals_and_beds_per_state) +
  geom_polygon(
    mapping = aes(x = long, y = lat, group = group, fill = num_hospitals),
    color = "white",
    size = .1
    ) +
  coord_map() +
  scale_fill_continuous(low = "white", high = "blue") +
  labs(fill = "Number of Hospitals in State") +
  blank_theme
  
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

