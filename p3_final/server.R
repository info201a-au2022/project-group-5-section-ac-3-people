source("../p3_final/ui.R")
library("shiny")
library("tidyverse")
library("ggplot2")
library("leaflet")
library("plotly")

# Setup: Data
hospital_locations <- read.csv("../data/us_hospital_locations.csv")
state_abb <- read.csv("../data/abbr-name-list.csv")
maternal_mort_by_state <- read.csv("../data/maternal_mort_state.csv")
pop2020 <- read.csv("../data/2020-pop.csv")

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
    Hospitals = n
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
    Hospital.Beds = sum(beds, na.rm = TRUE)
  ) %>% 
  distinct(state, .keep_all = TRUE)

# 2020 Population Tidying
pop2020_tidy <- pop2020%>% 
  mutate_all(funs(str_squish(.))) %>% 
  summarise(
    state = tolower(Label..Grouping.),
    pop = Total.
  ) %>% 
  mutate(pop = gsub(",", "", pop)) %>%  
  filter(pop != "") %>% 
  summarise(
    state, 
    Population = as.numeric(pop)
  )

# Number of Total Hospitals and Total Beds per state (for chloropleth map)
hospitals_and_beds_per_state <- state_shape %>% 
  left_join(num_hospitals, by = "state") %>% 
  left_join(num_beds, by = "state") %>% 
  left_join(pop2020_tidy, by = "state") %>% 
  mutate(Beds.Per.Capita = (Hospital.Beds / Population))

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

# Summary Chart Dataframe
maternal_mort_tidy <- maternal_mort_by_state %>% 
  summarise(
    state = tolower(state),
    rate = maternalMortalityRate
  )

summary_table <- num_hospitals %>% 
  left_join(maternal_mort_tidy, by = "state") %>% 
  left_join(pop2020_tidy, by = "state") %>% 
  summarise(
    state = toupper(state),
    Maternal_Mortality = rate,
    Hospitals_Per_Capita = (Hospitals / Population) * 100000
  ) %>% 
  pivot_longer(
    cols = c("Maternal_Mortality", "Hospitals_Per_Capita"),
    names_to = "names",
    values_to = "values"
  ) %>% 
  filter(state != is.na(NA))

# Maternal Mort Map
mat_mort_map <- state_shape %>% 
  left_join(maternal_mort_tidy, by = "state")


# Blank Theme
blank_theme <- theme_bw() +
  theme(
    axis.line = element_blank(),
    axis.text = element_blank(),
    axis.ticks = element_blank(),
    axis.title = element_blank(),
    panel.grid.minor = element_blank(),
    panel.grid.major = element_blank(),
    panel.border = element_blank()
  )

# ---
# SERVER FUNCTION

server <- function(input, output) {
  
  output$num_hospitals_map <- renderPlotly({
    
    ggplot <- ggplot(hospitals_and_beds_per_state) +
    geom_polygon(
      mapping = aes(x = long, y = lat, group = group, fill = .data[[input$num_hospitals_input]]),
      color = "black",
      size = .1
    ) +
    coord_map() +
    scale_fill_continuous(low = "white", high = "#3CE1E9") +
    labs(
      fill = paste(input$num_hospitals_input, "in State", sep = " "), 
      title = paste("Map of", input$num_hospitals_input, "In United States", sep = " ")
        ) +
    blank_theme
    
    plotly <- ggplotly(ggplot)
    
    return(plotly)
  })
  
  output$leaflet <- renderLeaflet({
    
    data <- location_and_beds %>% 
      filter(beds >= input$leaflet_input)
    
    hospital_locations_leaflet <- leaflet(data = data) %>% 
      addProviderTiles("CartoDB.Positron") %>% 
      setView(lng = -122.3321, lat = 47.6062, zoom = 5) %>% 
      addCircleMarkers(
        lat = ~lat,
        lng = ~long,
        radius = ~pt_size,
        stroke = FALSE,
        fill = TRUE,
        fillColor = "#3CE1E9",
        fillOpacity = .3,
        label = ~label
      )
    
    return(hospital_locations_leaflet)
  })
  
  output$maternal_mort <- renderPlotly({
    
    data <- maternal_mort_by_state %>% 
      filter(maternalMortalityRate <= input$mort_input)
    
    maternal_mort_by_state_chart <- plot_ly(
      data = data,
      x = ~state,
      y = ~maternalMortalityRate,
      type = "bar",
      alpha = .7
    ) %>%
      layout(
        title = "Maternal Mortality Rate by State",
        xaxis = list(title = "State"),
        yaxis = list(title = "Maternal Mortalities per 100,000")
      )
    
    return(maternal_mort_by_state_chart)
  })
  
  output$summary_bar <- renderPlot({
    
    summary_ggplot <- ggplot(data = summary_table) +
      geom_col(mapping = aes(x = state, y = values, fill = names), position = "dodge") +
      scale_fill_discrete(
        name = "Legend", 
        breaks = c("Hospitals_Per_Capita", "Maternal_Mortality"), 
        labels = c("Hospitals per Capita (per 100,000)", "Maternal Mortality (per 100,000)")) +
      theme(axis.text.x = element_text(angle = 270)) + 
      labs(
        title = "In Summary: Overview of Relative Values", 
        y = ""
      )
    
    return(summary_ggplot)
  })
  
  output$mort_map <- renderPlot({
    
    ggplot <- ggplot(mat_mort_map) +
      geom_polygon(
        mapping = aes(x = long, y = lat, group = group, fill = rate),
        color = "black",
        size = .1
      ) +
      coord_map() +
      scale_fill_continuous(low = "white", high = "#3CE1E9") +
      labs(
        fill = "Maternal Mortality per 100,000", 
        title = "Maternal Mortality by State"
      ) +
      blank_theme
    
    return(ggplot)
  })
  
}

