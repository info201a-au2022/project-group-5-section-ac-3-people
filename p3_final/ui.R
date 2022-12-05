library(shiny)

# maternal mortality by state bar chart 
ui <- fluidPage(
  sliderInput(
    inputId = "maternalMortalityRate",
    label = "Choose the rate for the states you want to be displayed",
    min = 0,
    max = 60,
    value = 30
  )
)

