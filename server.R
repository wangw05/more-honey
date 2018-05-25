library(shiny)
library(ggplot2)

honeyproduction <- read.csv('./data/honeyproduction.csv', stringsAsFactors = FALSE)


# 

shinyServer(function(input, output) {
  output$table <- renderTable({
    yearFilter <- subset(honeyproduction, honeyproduction$year == input$selectedYear)
  })
  
})


