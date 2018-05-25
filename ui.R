library(shiny)
library(plotly)
library(shinythemes)
shinyUI(navbarPage(
  theme = shinytheme("sandstone"),
  "Honey Production in the U.S.",
  # intro page
  tabPanel(
    "About",
    headerPanel(
     h1("About", align = "center")
    ),
    br(),
    br(),
    br(),
    br(),
    mainPanel(
      p("In this project, we have utilized the dataset from", 
        url <- a("Honey Production in the USA", href = "https://www.kaggle.com/jessicali9530/honey-production/data]"), ".", 
        "This dataset shows honey production numbers and prices by state from 1998 to 2012. 
        The data was collected by the", strong("National Agricultural Statistics Service (NASS) of the U.S. Department of Agriculture"), 
        "and we accessed it using", url <- a("kaggle.com", href = "https://www.kaggle.com/"), "."
        ),
      p("Our possible audiences are bee", strong("farmers"),", ", strong("researchers"), ", ", strong("people who work in the honey industry"), 
        ", ", "and anyone who might be affected by the rapid decline in honeybee population in 2006, 
        which had lasting effects on the honey industry to this day. 
        Our target audience is stores and parties that buy honey from the honey farmers 
        and then resell it as this data will be most useful for them."
        ),
      p("The", strong("\"Table\""), "page will provide users the ability to find and view the data we used from 1998 to 2012."),
      width = 12
    ),
    headerPanel(
      h1("Our Team", align = "center")
    ),
    mainPanel(
      br(),
      img(src= 'group-photo.png'),
      style="margin-left:180px"
    )
  ),
  
  
  
  
  
  tabPanel(
    "Interactive Plot"
  ),
  tabPanel(
    "Analysis"
  ),
  tabPanel(
    "Table",
    titlePanel("Download Data"),
    sidebarLayout(
      sidebarPanel(  
        selectInput("selectedYear", label = "Year:", choices = honeyproduction$year)
       # downloadButton("downloadData", "Download")
      ),
      
      mainPanel(
        tableOutput("table")
    )
  )
)))
