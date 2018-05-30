library(shiny)
library(plotly)
library(shinythemes)
library(dplyr)
library(graphics)

honeyproduction <-
  read.csv("./data/honeyproduction.csv", stringsAsFactors = FALSE)

shinyUI(navbarPage(
  theme = shinytheme("cosmo"),
  "Honey Production in the U.S.",
  # intro page
  includeCSS("custom.css"),

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
      p(
        "In this project, we have utilized the dataset from",
        url <- a("Honey Production in the USA", href = "https://www.kaggle.com/jessicali9530/honey-production/data"), ".",
        "This dataset shows honey production numbers and prices by state from 1998 to 2012. 
          The data was collected by the", strong("National Agricultural Statistics Service (NASS) of the U.S. Department of Agriculture"),
        "and we accessed it using", url <- a("kaggle.com", href = "https://www.kaggle.com/"), "."
      ),
      p(
        "Our possible audiences are bee", strong("farmers"), ", ", strong("researchers"), ", ", strong("people who work in the honey industry"),
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
      img(src = "group-photo.png"),
      style = "margin-left:180px"
    )
  ),

  tabPanel(
    "Interactive Plot",
    div(
      class = "myContent",
      sidebarLayout(
        sidebarPanel(
          selectInput("state_input",
            label = h3("State"),
            choices = distinct(honeyproduction, state)
          ),
          selectInput("prod",
            label = h3("Included Lines"),
            choices = list(
              "Total Production" = "totalprod",
              "Production Value" = "price",
              "Both" = "all"
            )
          )
        ),
        mainPanel(
          plotlyOutput("state_yearly_prod")
        )
      )
    )
  ),

  tabPanel(
    "Interactive Plot 2",
    div(
      class = "myContent",
      sidebarLayout(
        sidebarPanel(
          selectInput("col_input",
            label = h3("Variable"),
            # ISS: need to change this name.
            choices = list(
              "Number of Colonies",
              "Yield per Colony",
              "Total Production",
              "Price/Pound",
              "Production Value"
            )
          ),
          radioButtons(
            inputId = "chart_type",
            label = "Plot Type",
            choices = c(
              "Barplot" = "bar",
              "Boxplot" = "box",
              "Quantile" = "quant",
              "Violin" = "violin"
            )
          )
        ),
        mainPanel(
          plotlyOutput("national_yearly_prod")
        )
      )
    )
  ),

  tabPanel(
    "Analysis",
    headerPanel(
      h1("Introduction and Data Analysis", align = "center")
    ),
    mainPanel(
      p("This dataset a visualized way to understand the trend of US honey production throughout years."),
      p("In Interactive 1, users is able to select and see the Total Production and Production Value of each state. From the oberservation, we found that 
        the Total Production is decreasing while the Production Value is increasing from 1998 to 2012 in general. The following is the comparion of Total Production 
        and Production Value in Florida."),
      img(width = 1000, height = 500, src = "honey-production-FL.png", style = "margin-left:180px"),
      p("In Interactive Plot 2, we take the average number of each variable from every state,
        provided 5 national average variables related to honey production- Number of Colonies, Yield per Colony, Total Production, 
        Price/ Pound, and Production Value."),
      p("According to the observation, there is not too much change for the nuumber of colonies through the years."),
      img(width = 1000, height = 500, src = "number-of-colonies.png", style = "margin-left:180px"),
      p("The yield per colony has slightly decreased."),
      img(width = 1000, height = 500, src = "yield-colony.png", style = "margin-left:180px"),
      p("Compare to the decrease of yield per colony, the average total production has a greater decreasing especially from 
        1998 to 2002. But the average total production is relatively constant after 2002."),
      img(width = 1000, height = 500, src = "total-production.png", style = "margin-left:180px"),
      p("The Price per Pound and Production Value have been increased a lot from 1998 to 2012, and reach the peaks in 2012."),
      img(width = 1000, height = 500, src = "price-pound.png", style = "margin-left:180px"),
      img(width = 1000, height = 500, src = "production-value.png", style = "margin-left:180px"),
      width = 12
    )
  ),
  tabPanel(
    "Table",
    div(
      class = "myContent",
      titlePanel("Download Data"),
      sidebarLayout(
        sidebarPanel(
          selectInput("selectedYear", label = "Year:", choices = honeyproduction$year)
          # downloadButton("downloadData", "Download")
        ),

        mainPanel(
          dataTableOutput("table")
        )
      )
    )
  )
))
