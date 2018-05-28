library(shiny)
library(ggplot2)
library(dplyr)

honeyproduction <- read.csv('./data/honeyproduction.csv', stringsAsFactors = FALSE)

# 

shinyServer(function(input, output) {
  output$table <- renderTable({
    yearFilter <- subset(honeyproduction, honeyproduction$year == input$selectedYear)
  })
    
  output$interactive_plot <- renderPlot({
    if (input$state_select == "all") {
      df <- group_by(honeyproduction, year) %>%
        summarise(yearly_prod = sum(totalprod))
      chart <- ggplot(
        data = df,
        aes(x = year, y = yearly_prod)
      ) + geom_line(stat = "identity")
    } else {
      df <- filter(honeyproduction, state == input$state_select)
      chart <- ggplot(
        data = df,
        
        aes(x = year, y = totalprod)
      ) + geom_line(stat = "identity")
    }
    
    chart
  })
  
})