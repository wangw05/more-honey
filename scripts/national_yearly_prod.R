library(plotly)
library(dplyr)
library(RColorBrewer)

# Test Data: Delete after Complete
df <- read.csv("./data/honeyproduction.csv", stringsAsFactors = FALSE)

# Support function for cleaning data
clean_data <- function(df, yaxis) {
  # Calculating yearly avgs, and making new df
  tbl <- df %>% select(-state)%>% group_by(year) %>% summarise_all(mean)
  df2 <- tbl %>% select(year, yaxis)
  
  colnames(df2) <- c("year", "yax")
  
  return(df2)
}

# Generating plot - function
national_yearly_prod <- function(df, yaxis) {
  df <- clean_data(df, yaxis)
  
  # Generating Plotly with bar
  p <- plot_ly(df, x = ~year, y = ~yax, type = "bar", colors = "Accent", color = ~year) %>% 
               layout(title = paste0("National averages for ", yaxis, " by year"))
  print(p)
}

national_yearly_prod(df, "numcol")

# Issues that need resolving: 
# 1. Color bar legend needs to be named and categorized.
# 2. Chart title needs to be more specific
# 3. Y axis label needs to be more specific
# 4. Build different charts, and make them interchangable.
