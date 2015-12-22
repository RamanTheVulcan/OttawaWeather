library(googleVis)
library(rCharts)
library(dplyr)
library(shiny)

# Reading the data downloaded from the Environment Canada website
ott.2013 <- read.table("data/eng-daily-01012013-12312013.csv",
                       header = TRUE, skip = 25, sep = ",", 
                       strip.white = TRUE, stringsAsFactors = FALSE)
ott.2014 <- read.table("data/eng-daily-01012014-12312014.csv",
                       header = TRUE, skip = 25, sep = ",", 
                       strip.white = TRUE, stringsAsFactors = FALSE)
ott.2015 <- read.table("data/eng-daily-01012015-12312015.csv",
                       header = TRUE, skip = 25, sep = ",", 
                       strip.white = TRUE, stringsAsFactors = FALSE)
ott.2013$Date.Time <- as.Date(ott.2013$Date.Time)
ott.2014$Date.Time <- as.Date(ott.2014$Date.Time)
ott.2015$Date.Time <- as.Date(ott.2015$Date.Time)


shinyServer(
  function(input, output) {
    output$textYear <- renderText({input$yearSelected})
    
    retempOrSnow <- reactive({
      if (input$tempOrSnow == "maxT")
        "Daily Maximum Temperature (deg C)"
      else
        "Snow on the Ground (cm)"
      })      
    output$textVar <- renderText({ retempOrSnow() })

    datasetInputYear <- reactive({
      switch(input$yearSelected,
             "2013" = ott.2013,
             "2014" = ott.2014,
             "2015" = ott.2015)
    })
    
    datasetInputVar <- reactive({
      switch(input$tempOrSnow,
             "maxT" = "Max.Temp...C.",
             "snow" = "Snow.on.Grnd..cm.")
    })
    
    output$viewCal <- renderGvis({
      gvisCalendar(data = datasetInputYear(), datevar = "Date.Time", numvar = datasetInputVar(),
                   options = list(width = 1000, height = 500))
    })
    
  }
)

