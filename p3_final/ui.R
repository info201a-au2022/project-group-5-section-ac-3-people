library(shiny)
library(shinythemes)

# maternal mortality by state bar chart 
introduction <- tabPanel(
  "introduction",
  titlePanel("Why is understanding healthcare access important?"), 
  p("The following data visualizations encapsulate the ongoing crisis of limited
    healthcare access in the United States. Our group was interested in investigating
    where hospital access is more accessible based on hospital population and number
    of hospital beds available. Additionally, we decided to look into maternal mortality
    as a proxy for our research on hospital accessibility. For context, maternal mortality
    is defined as death while pregnant or within 42 days of the end of pregnancy from
    causes related to the pregnancy or its management. Maternal mortality typically arises from
    health problems of the woman, but can almost always be resolved by being seen by the appropriate
    healthcare provider and receiving adequate care. As easy as that seems, that is not the case in
    our society. There is not ample care being provided in the United States, especially for pregnant women.
    This can be seen by the low number of hospital beds that are in some parts of the country.")
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
      p("In this chloropleth map, users can choose to display the number of hospital
        beds or the number of hospitals per state. A darker color indicates a higher
        number of beds or hospitals in that state and a lighter color indicates a
        lower number of beds or hospitals in that state. Based on the map,
        viewers can conclude that living in certain parts of the United States
        comes with limited healthcare access. For example, someone living in Texas 
        will have more healthcare options than someone living in Wyoming.")
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
      p("In this dot distribution map, users can use the sliding input bar to
        display hospitals in the U.S. that have the selected number of hospital beds.
        Hovering over the dots will display the hospital name and the number of beds.
        This map gives users a better understanding of what parts of the U.S. are denser
        in terms of hospital bed amount. When 900 beds is selected, it is clear that the
        Southeast and the West Coast have the ability to care for more patients due to a
        higher bed count. Alternatively, when the slider is to the far right, there are
        very few hospitals that would have the option to care for a higher number of patients.")
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
  p("This bar chart displays the maternal mortality rate per state. Users may
    use the sliding input bar to display states that have at least the chosen
    rate. Hovering over the bars will display the state name and its maternal
    mortality rate. An observation that can be made from this graph is that
    Louisiana has the highest maternal mortality rate of all the states. When
    using this information in conjunction with the other graphs, it is seen that
    Louisiana also has a low number of hospital beds available. This suggests that
    states with less healthcare access will result in more women dying due to pregnancy
    or childbirth.")
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

