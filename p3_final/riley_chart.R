# Page Set-UP
library(tidyverse)
library(ggplot2)
library(plotly)
hospital_locations <- read.csv("../data/us_hospital_locations.csv")
maternal_mort <- read.csv("../data/maternal_mortality_urban_rural.csv")
state_abb <- read.csv("../data/abbr-name-list.csv")
rucc_codes <- read.csv("../data/ruralurbancodes2013.csv")

# Data wrangling time
state_shape <- map_data("state")

location_and_beds <- hospital_locations %>% 
  summarize(X, Y, NAME, STATE, BEDS) %>% 
  left_join(state_abb, by = c("STATE"= "abbreviation")) %>% 
  mutate(name = tolower(name)) %>% 
  mutate_all(funs(str_replace(., "-999", NA_character_))) %>% 
  summarize(
    long = X,
    lat = Y,
    hospital_name = NAME,
    abbr = STATE,
    beds = as.numeric(BEDS),
    state = name
  )

num_hospitals <- hospital_locations %>% 
  summarize(NAME, STATE, BEDS) %>% 
  left_join(state_abb, by = c("STATE"= "abbreviation")) %>% 
  mutate(name = tolower(name)) %>% 
  summarize(
    hospital_name = NAME,
    abbr = STATE,
    beds = BEDS,
    state = name
  ) %>% 
  group_by(state) %>% 
  count(state) %>% 
  summarize(
    state,
    num_hospitals = n
  )

hospital_beds <- state_shape %>% 
  left_join(location_and_beds, by = c("region" = "state")) %>% 
  left_join(num_hospitals, by = c("region" = "state"))

blank_theme <- theme_bw() +
  theme(
    axis.line = element_blank(),
    axis.text = element_blank(),
    axis.ticks = element_blank(),
    axis.title = element_blank(),
    plot.background = element_blank(),
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank(),
    panel.border = element_blank()
  )

# Num hospitals plotly map
num_hospitals_map <- ggplot(hospital_beds) +
  geom_polygon(
    mapping = aes(x = long.x, y = lat.x, group = group, fill = num_hospitals),
    color = "white",
    size = .1
  ) +
  coord_map() +
  scale_fill_continuous(low = "white", high = "blue") +
  labs(fill = "Number of Hospitals Per State") +
  blank_theme
  
ggplotly_num_hospitals_map <- ggplotly(num_hospitals_map)


# Maternal mortality per state chart 
maternal_mort_by_state_chart <- plot_ly(
  data = maternal_mort_by_state, # data frame to show
  x = ~state,
  y = ~maternalMortalityRate,
  type = "bar",
  alpha = .7
) %>%
  layout(
    title = "Maternal Mortality Rate by State",
    xaxis = list(title = "State"),
    yaxis = list(title = "Maternal Mortality Rate")
  )

# server function for real thingy
output$maternal_mort <- renderPlotly({
  maternal_mort_by_state_chart <- plot_ly(
    data = maternal_mort_by_state,
    x = ~state,
    y = ~maternalMortalityRate,
    type = "bar",
    alpha = .7,
    color= "red"
  ) %>%
    layout(
      title = "Maternal Mortality Rate by State",
      xaxis = list(title = "State"),
      yaxis = list(title = "Maternal Mortality Rate")
    )
  return(maternal_mort_by_state_chart)
})

# ui function for real thingy
maternal_mort_main <- tabPanel(
  "Maternal Mortality by State",
  sidebarLayout(
    sidebarPanel(
      ui <- fluidPage(
        sliderInput(
          inputId = "maternalMortalityRate",
          label = "Choose the rate for the states you want to be displayed",
          min = 0,
          max = 60,
          value = 30
        ),
      ),
      mainPanel(
        h3("..."),
        plotlyOutput("maternal_mort")
      )
    )
  )
)