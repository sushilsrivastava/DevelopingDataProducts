#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  output$countryControls <- renderUI({
    GDP_Data2 <- read.csv('GDP.csv',header = TRUE)
    countries<-colnames(GDP_Data2)[2:8]
    checkboxGroupInput("country","Choose Countries",countries,colnames(GDP_Data2)[3:5])
  })
  
  
  output$distPlot <- renderPlotly({
    library(plotly)
    GDP_Data2 <- read.csv('GDP.csv',header = TRUE)
    min_year<-input$year[1]
    max_year<-input$year[2]
    GDP_Data2<-GDP_Data2[(GDP_Data2$Year>=min_year) & (GDP_Data2$Year<=max_year) ,]
    
    validate(need(input$country, 'Please select at least one Country!'))
    p<-plot_ly(data=GDP_Data2,x=~Year,y=GDP_Data2[,colnames(GDP_Data2)== input$country[1]],type = "scatter",mode="lines",name =input$country[1])
    
    i<-2
    while(i<=length(input$country))
    {
      p<-add_lines(p,x=~Year,y=GDP_Data2[,colnames(GDP_Data2)== input$country[i]],type = "scatter",mode="lines",name = input$country[i])
      i<-i+1
    }
    p
  })
  
})
