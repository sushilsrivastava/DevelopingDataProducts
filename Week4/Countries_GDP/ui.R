#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(plotly)
shinyUI(fluidPage(
  
  # Application title
  titlePanel("GDP data of Counrties"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      helpText("Please select the years for which you want to see the GDP of selected countries: "),
      sliderInput("year", "",min = 1960, max = 2017, value = c(1960, 2017)),
      helpText("Please choose countries for which you want to see the GDP data: "),
      uiOutput("countryControls")
    ),
    
    mainPanel(
      
      plotlyOutput("distPlot")
    )
  )
))