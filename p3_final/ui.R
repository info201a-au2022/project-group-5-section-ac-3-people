library("shiny")
library("shinythemes")
library("plotly")
library("leaflet")

# maternal mortality by state bar chart 
introduction <- tabPanel(
  "Introduction",
  titlePanel("Why is Understanding Healthcare Access Important?"),
  p(strong("Riley Mintz (rimintz@uw.edu) and Max Stewart (mzs11@uw.edu)"),
  p(""),
  p("The data visualizations on this website encapsulate the ongoing crisis of limited
    healthcare access in the United States. Our group is interested in investigating
    where hospital access is greater based on both number of hospitals in a state, and number
    of hospital beds available."),
  p("Additionally, we decided to look into maternal mortality
    as a proxy for healthcare outcome in each state. For context, maternal mortality
    is defined as death while pregnant or within 42 days of the end of pregnancy from
    causes related to the pregnancy or its management. Maternal mortality typically arises from
    health problems of the woman, but can almost always be resolved by being seen by an appropriate
    healthcare provider and receiving adequate care. As easy as that seems, that is not the case in
    our country. There is not ample care being provided in the United States, especially for pregnant women;
    This can be seen by the low number of hospital beds in some parts of the country."),
  p("With this website, we aimed to engage viewers and inform them of the healthcare disparities that
    appear where few hospitals can be found, especially when the amount of people those hospitals can service is few.
    Some of the questions we are asking are:"),
  tags$ul(strong(
    tags$li("What areas in the United States have the fewest hospitals, or lowest overall hospital capacity?"), 
    tags$li("How does a state's hospital capacity compare to its population?"),
    tags$li("Do states with fewer hospitals suffer worse healthcare outcomes, particularly maternal mortality?"), 
  )), 
  p("All three of these main questions can be investigated using the
    interactive data visualizations and attached links on our website. The data we chose to analyze was
    from a dataset that provided the names, locations, and number of beds of hospitals in the U.S., as well
    as a dataset that provides maternal mortality for each state. The key findings of our investigation are:
    finding easy healthcare access is more attainable for people who live in more populated areas, and limited 
    healthcare leads to an increase of maternal mortality."),
  p(""),
  tags$figure(
    align = "center",
    tags$img(
      src = "intro_img.jpg",
      alt = "healthcare workers mural"
    )
  ),
  p("")
)
)
  
hospital_chloropleth <- tabPanel(
  "Hospitals Per State",
  sidebarLayout(
    sidebarPanel(
      # Num Hospitals Input
      selectInput(
        inputId = "num_hospitals_input",
        label = "Choose Hospital Size Variable",
        choices = c("Hospitals", "Hospital.Beds", "Beds.Per.Capita", "Population"),
        selected = "Hospitals"
      ),
    ),
    mainPanel(
      h3("Distribution:"),
      plotlyOutput("num_hospitals_map"),
      p(""),
      p("In this chloropleth map, users can choose to display the number of hospitals, hospital beds, beds per person (Beds.Per.Capita), or the state population as of 2020. A darker color indicates a higher
        number of the selected value in that state, and a lighter color indicates a
        lower number. Based on the map,
        viewers can conclude that living in certain parts of the United States
        comes with limited healthcare access. For example, someone living in Texas 
        will have more hospital options than someone living in Wyoming.")
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
      p(""),
      p("In this dot distribution map, users can use the slider to filter which hospitals are shown by the minimum number of beds.
        Hovering over the dots will display the hospital name and the number of beds it has. Dragging or scrolling allows the user to look at different areas.
        This map gives users a better understanding of what parts of the U.S. have larger capacity hospitals, and the overall distribution of hospitals.
        When 900 beds is selected, it is clear that the
        Southeast and the West Coast have the ability to care for more patients due to a
        higher bed count. Alternatively, when the slider is to the far right, there are
        very few hospitals that would have the option to care for a higher number of patients. 
        This can become an issue, for example, when many people need to be hospitalized due to an infectious disease.
        Please note that hospitals that did not provide a bed count are displayed at the size of a 50 bed hospital, 
        about half the mean hospital size, but display the bed count as NA upon mouseover")
    )
  )
)

maternal_mort_main <- tabPanel(
  "Maternal Mortality by State",
  align = "center",
  plotlyOutput("maternal_mort", width = "100%", height = "auto"),
  sliderInput(
    inputId = "mort_input",
    label = "Minimum Maternal Mortality Rate to be Displayed",
    min = 4,
    max = 59,
    value = 59
  ), 
  p(""),
  p("This bar chart displays the maternal mortality rate per state in deaths per 100,000 pregnancies. Users may
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
  "Summary",
  titlePanel("Summary"), 
  p("looking at the distribution of hospitals, we've seen that states near the coasts tend to have more hospitals, but when we compare beds per person in each state we see that most areas have a comparable amount of hospital beds proportionate to their population. The exception for this is the Southwest United States near the Four-Corners Region, which has relatively few hospitals as well as few hospital beds per person."),
  p("Here is a chart summarising the hospitals per capita (number of hospitals per 100,000 people) and maternal mortality rate (number of deaths per 100,000 pregnancies)"),
  plotOutput("summary_bar"),
  p("This chart shows that states with more hospitals per capita tend to have relatively few maternal mortalities compared to other states, but just having more hospitals per capita isn't necessarily an indicator of particularly low maternal mortality."),
  plotOutput("mort_map"),
  p("You can see by comparing this distribution map to the distribution maps of hospitals, hospital beds, and hospitals per capita that the maternal mortality rate seems to somewhat independant of the number of hospitals in a state, and more correlated with the part of the USA it's in, with the South and Midwest having higher maternal mortality rates than, for example, the West Coast"), 
  h4("Key Takeaways:"),
  tags$ul(
    tags$li("Most states have a number of available hospital beds relatively proportionate to their population, although states in the West and particularly Southwest have few compared to other areas."),
    tags$li("Just looking at the number of beds in a state doesn't give you enough information about the access people living in that state have to healthcare, you must also consider how they are distributed throughout the state, and therefore how difficult it is to get to the nearest hospital. This is a reason that even when there are a relatively high number of hospital beds per person, people in a state may feel that accessing hospitals is very difficult."),
    tags$li("Having more hospitals in a state isn't very correlated to having particularly low maternal mortality. It seems much more dependant on what area of the United States you live in. This means other factors such as distance from hospitals, access to insurance, poverty, and social stigma may be driving high maternal mortality outcomes in states with relatively many hospitals.")
  )
)

report <- tabPanel(
  "Report Page",
  titlePanel("Report Page"), 
  h3("Healthcare Access in USA"),
  p(strong("codename: health-disparities")),
  p(em("Riley Mintz (rimintz@uw.edu) and Max Stewart (mzs11@uw.edu)")),
  p("Autumn 2022"), 
  h4("Abstract"),
    p("We explored the relationship between the number of hospitals and rate of maternal mortality in a state. We found that states with more hospitals per capita didn't necessarily have lower rates of maternal mortality. We did find that maternal mortality is more highly correlated with the region of the United States a state is in, implying factors other than hospital access such as social stigma are driving these numbers."),
  em("Keywords: healthcare, hospitals, healthcare access, hospital access"),
  h4("Introduction"),
    p("Our website aims to investigate the healthcare disparities that lie in where and who can access hospitals. While most of our website deals with where hospitals are located in the United States and the number of people that can be seen in each, we take into account a healthcare issue that is impacted by the accessibility of hospitals - maternal mortality. Pregnant women that can't be seen by the appropriate provider or receive enough medical care during their pregnancy often increase the maternal mortality rate for that state. With the interactive data visualizations that we provide on our website, people can learn about how hospitals are distributed and can gain insight into how difficult it would be to get timely medical care if you didn't live in the parts of the country where hospitals are abundant. We chose to focus on the accessibility that the current hospital population in the United States provides people."),
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
    tags$li(a("Maternal Mortality Rate by State 2022: ", href = "https://worldpopulationreview.com/state-rankings/maternal-mortality-rate-by-state"), "We used this dataset to graph the maternal mortality for each state. Value is in deaths per 100,000 births. Data from USA TODAY"),
    tags$li(a("List of State Abbreviations: ", href = "https://worldpopulationreview.com/states/state-abbreviations"), "We simply used this to match state abbreviations to their full state names. Data from World Population Review."),
    tags$li(a("Census Table DP05: ", href = "https://data.census.gov/table?q=population&t=Population+Total&g=0100000US$0400000&y=2020&tid=DECENNIALPL2020.P1&tp=true"), "2020 Population Estimates by state. Data from U.S Census Bureu.")
  ),
  h4("Report"),
  p(strong("Findings: "), "Our group was grateful for the opportunity that we have had
  to learn more about the disparities that arise with the unbalanced distribution of hospitals 
  across the United States. While it was already common knowledge to us that the United States
  healthcare system is corrupted, we learned just how unevenly spread out our hospitals are.
  Our first research question was looking into what areas in the United States have the fewest hospitals 
  or lowest overall hospital capacity. By using the 'Map of State Total Hospitals or Hospital Beds' map 
  and 'Name, Location, and Number of Beds of US Hospitals' map, we can see that the regions that have the 
  lowest number of hospitals are states in the middle of the United States like Wyoming, Utah, and Nebraska. 
  This is due to the population being more spread out in states such as these. Regardless of how the population 
  is spread, all people should have easy access to hospitals and not be forced to travel hours to be seen by a 
  professional. Our second research question was how a state's hospital capacity compares to its population. 
  Based on our findings and research, states with a lower population almost always have a smaller number of hospitals 
  and hospital beds available to patients. While fiscally it makes sense to have fewer hospitals where there are 
  fewer people, this forces the people of that state to make literal road trips for medical visits whereas people 
  in places such as California or Texas might just have to walk a few blocks to see a medical professional. 
  In a perfect world (and hopefully in the upcoming future), more medical facilities become available for those 
  who live in less populated places. Our third research question is looking into if states with fewer hospitals suffer 
  worse healthcare outcomes, particularly maternal mortality. Our charts present the finding that it is often the 
  case that hospitals with fewer hospital beds available suffer from higher rates of maternal mortality, but not 
  necessarily higher than states with fewer hospitals. Maternal Mortality seemed more correlated to region of the country."), 
  p(strong("Discussion: "), "We had expected to find that states with smaller populations had fewer hospitals, fewer hospital beds,
    and worse health outcomes like higher maternal mortality than states with larger populations. We did find that states with higher populations
    tended to have more total hospitals and beds, but the beds per capita was actually higher in states with smaller populations. Despite this, 
    our research showed that residents of rural states with smaller populations tended to struggle to find healthcare. We suspect this is because
    despite the relative number of beds per person being equal or higher to the rest of the country, hospitals are located in only a few
    parts of states with small populations, causing people to have to travel long distances to recieve care. We looked into maternal mortality's correlation
    with hospitals per capita and found that maternal mortality is not very strongly correlated to this, but does seem correlated to what region of 
    the United States you are in, with Midwestern and Southern states having higher rates. This seems to imply other factors, perhaps social
    stigma or access to health insurance, are what is driving these high numbers. This analysis was limited in only looking into maternal mortality, and we would
    be interested in seeing how other health outcomes correlate with this hospital distribution data."), 
  p(strong("Conclusion: "), "After going through our datasets and looking through our data visualizations, our conclusion 
  is that the current healthcare distribution in the United States is only beneficial if you happen to live in more 
  metropolitan areas. For people who live in the middle of the United States, hospitals are sparse, and although the 
  total capacity of all hospitals in a state tends to fall in line with the state's population, people in less populated 
  states must travel long distances to access care. Knowing this, it is apparent that simply physically accessing healthcare 
  is very stressful for the people living there. On top of having to drive hours to get to the nearest hospital, those 
  potential patients will need to take into account that everyone in the surrounding region will also be driving to that 
  hospital to be seen, and at the same time more rural states tend to have fewer doctors. The state of our medical system needs 
  to be improved heavily and we believe that one of the first steps to this is building new medical facilities to serve local 
  communities in the areas of the U.S. that lack them, and ensuring doctors are incentivised to stay working there. 
  In regards to the maternal mortality issue that is forever prominent in our country, we believe that the lack of medical 
  facilities in certain parts of the United States is a strong contributor to why this problem is still prevalent, 
  but it is heavily compounded by social stigma in certain areas. Using an educated guess, we can assume that this is due to the 
    high number of hospitals and bed availability that can be seen in our graphs. For the United States to take better care of its 
    people, we need to start by allowing all people to have equal medical care access regardless of their location, race, age, sex, 
    or socioeconomic background."),
  h4("Acknowledgements"), 
  p("We would like to shout out Anushka Damidi who helped us in the early development of this project!"), 
  h4("References"), 
  tags$ul(
    tags$li("https://www.pewresearch.org/fact-tank/2018/12/12/how-far-americans-live-from-the-closest-hospital-differs-by-community-type/"),
    tags$li("https://www.cdc.gov/reproductivehealth/maternal-mortality/pregnancy-mortality-surveillance-system.htm"),
    tags$li("https://www.npr.org/sections/health-shots/2019/05/21/725118232/the-struggle-to-hire-and-keep-doctors-in-rural-areas-means-patients-go-without-c"), 
    tags$li("https://www.kaggle.com/datasets/andrewmvd/us-hospital-locations"),
    tags$li("https://worldpopulationreview.com/state-rankings/maternal-mortality-rate-by-state"),
    tags$li("https://worldpopulationreview.com/states/state-abbreviations"),
    tags$li("https://data.census.gov/table?q=population&t=Population+Total&g=0100000US$0400000&y=2020&tid=DECENNIALPL2020.P1&tp=true")
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

