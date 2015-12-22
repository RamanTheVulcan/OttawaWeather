library(googleVis)
library(rCharts)
library(dplyr)
library(shiny)

shinyUI(fluidPage(verticalLayout(
  h2("Historical Weather for Ottawa, Canada"),
  
  p("This application creates a google calendar visualization of the historical weather in Ottawa, Canada.  Two possible variables can be visualized: the maximum daily temperature (in deg C), and the amount of snow on the ground (in cm) for the past three calendar years (i.e., 2013 to 2015).  Data was obtained from the Environment Canada website. "),
  
  p("Files used for making this shiny app can be found on GitHub, in github.com/RamanTheVulcan/OttawaWeather"),
  
  selectInput(inputId = "yearSelected", label = "Select the Year of Interest", 
              choices = c(2015, 2014, 2013),
              selected = 2015,
              multiple = FALSE),
  radioButtons(inputId = "tempOrSnow", label = "Climate Variable of Interest",
               choices = c("Daily Maximum Temperature (deg C)" = "maxT",
                           "Snow on the Ground (cm)" = "snow")),
    
  em("You selected a plot of the ", textOutput('textVar', inline = TRUE),
     " variable for year ", textOutput('textYear', inline = TRUE), "."),
    
  htmlOutput("viewCal")
    
)))
