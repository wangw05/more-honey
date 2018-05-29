library(shiny)
library(ggplot2)
library(dplyr)
library(plotly)
source("scripts/state_yearly_prod.R")
source("scripts/national_yearly_prod.R")

honeyproduction <-
  read.csv("./data/honeyproduction.csv", stringsAsFactors = FALSE)

#

shinyServer(function(input, output) {
  output$table <- renderTable({
    yearFilter <-
      subset(honeyproduction, honeyproduction$year == input$selectedYear)
  })

  output$state_yearly_prod <- renderPlotly({
    return(state_prod(honeyproduction, input$state_input, input$prod))
  })
  
  output$national_yearly_prod <- renderPlotly({
    return(national_yearly_prod(honeyproduction, input$col_input, input$chart_type))
  })
})
