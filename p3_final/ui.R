library(shiny)

# maternal mortality by state bar chart 
introduction <- tabPanel(
  "introduction",
  titlePanel("Introduction")
)
  
hospital_chloropleth <- tabPanel(
  "Hospitals Per State",
  sidebarLayout(
    sidebarPanel(
      # Num Hospitals Input
      selectInput(
        inputId = "num_hospitals_input",
        label = "Choose Hospital Size Variable",
        choices = c("Hospitals", "Beds"),
        selected = "num_hospitals"
      ),
    ),
    mainPanel(
      h3("Map of State Total Hospitals or Hospital Beds"),
      plotlyOutput("num_hospitals_map")
    )
  )
)

location_leaflet <- tabPanel(
  "Hospital Locations",
  sidebarLayout(
    sidebarPanel(
      # Leaflet Input
      sliderInput(
        inputId = "leaflet_input",
        label = "Select Hospital Size (Beds)",
        min = 0,
        max = 1592,
        value = 2
      ),
    ),
    mainPanel(
      h3("Name, Location, and Number of Beds of US Hospitals"),
      leafletOutput("leaflet")
      
    )
  )
)

page_three <- tabPanel(
  "Page Three",
  sidebarLayout(
    sidebarPanel(
      # Maternal Mort Chart Input
      sliderInput(
        inputId = "maternalMortalityRate",
        label = "Choose the rate for the states you want to be displayed",
        min = 0,
        max = 60,
        value = 30
      ),
    ),
    mainPanel(
      h3("Some Title Or Something"),
      p()
    )
  )
)

ui <- navbarPage(
  "P3 Final",
  introduction,
  hospital_chloropleth,
  location_leaflet,
  page_three
)