library(shiny)
library(shinythemes)

# maternal mortality by state bar chart 
introduction <- tabPanel(
  "introduction",
  titlePanel("Introduction"), 
  p("Intro paragraoh HERE!")
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
      plotlyOutput("num_hospitals_map"),
      p("Description HERE!")
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
      leafletOutput("leaflet"),
      p("Description HERE!")
    )
  )
)

maternal_mort_main <- tabPanel(
  "Maternal Mortality by State",
  align = "center",
  plotlyOutput("maternal_mort", width = "100%", height = "auto"),
  sliderInput(
    inputId = "mort_input",
    label = "Choose the rate for the states you want to be displayed",
    min = 4,
    max = 59,
    value = 59
  ), 
  p("Description HERE!")
    )

summary <- tabPanel(
  "summary",
  titlePanel("Key Takeaways:"), 
  p("paragraoh HERE!")
)

report <- tabPanel(
  "report",
  titlePanel("Report Page"), 
  p("paragraoh HERE!")
)

ui <- navbarPage(
  theme = shinytheme("sandstone"),
  "P3 Final",
  introduction,
  hospital_chloropleth,
  location_leaflet,
  maternal_mort_main, 
  summary, 
  report
)