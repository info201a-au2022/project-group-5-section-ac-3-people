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

ui <- navbarPage(
  theme = shinytheme("sandstone"),
  "Healthcare Access in USA",
  introduction,
  hospital_chloropleth,
  location_leaflet,
  maternal_mort_main, 
  summary, 
  report
)

