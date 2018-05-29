library(plotly)
library(dplyr)
library(RColorBrewer)

# Test Data: Delete after Complete
df <- read.csv("./data/honeyproduction.csv", stringsAsFactors = FALSE)

# Generate input dataframe for colnames
names_df <- data.frame(c(
  "Number of Colonies",
  "Yield per Colony",
  "Total Production",
  "Price/Pound",
  "Production Value"
),
c(
  "numcol",
  "yieldpercol",
  "totalprod",
  "priceperlb",
  "prodvalue"
),
stringsAsFactors = FALSE
)

colnames(names_df) <- c("actual", "column")

# Support function for cleaning data
clean_data <- function(df, yaxis, chart_type) {
  
  # Calculating yearly avgs, and making new df
  if(chart_type == "bar") {
    df <- df %>%
    select(-state) %>%
    group_by(year) %>%
    summarise_all(mean)
  }
  
  df2 <- df %>% select(year, yaxis)

  colnames(df2) <- c("year", "yax")

  return(df2)
}

# Generating plot - function
national_yearly_prod <- function(df, yaxis_actual, chart_type) {
  # Convert actual axis wording to column wording
  yaxis <- names_df[names_df$actual == yaxis_actual, "column"]

  # Clean data for creating plot
  df <- clean_data(df, yaxis, chart_type)

  # Generating Plotly with bar
  p <- plot_ly(df,
    x = ~ year, y = ~ yax, type = chart_type,
    colors = "Accent", color = ~ year
  ) %>%
    layout(
      title = paste0(
        "National averages for ",
        yaxis_actual, " by year"
      ),
      yaxis = list(title = yaxis_actual)
    )
  p
}

# Test code remove after testing.
#national_yearly_prod(df, "Price/Pound")


# Issues that need resolving:
# 1. Color bar legend needs to be named and categorized.
# 4. Build different charts, and make them interchangable.
