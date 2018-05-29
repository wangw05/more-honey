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
clean_data <- function(df, yaxis) {
  # Calculating yearly avgs, and making new df
  tbl <- df %>%
    select(-state) %>%
    group_by(year) %>%
    summarise_all(mean)
  df2 <- tbl %>% select(year, yaxis)

  colnames(df2) <- c("year", "yax")

  return(df2)
}

# Generating plot - function
national_yearly_prod <- function(df, yaxis_actual) {
  # Convert actual axis wording to column wording
  yaxis <- names_df[names_df$actual == yaxis_actual, "column"]

  df <- clean_data(df, yaxis)

  # Generating Plotly with bar
  p <- plot_ly(df,
    x = ~ year, y = ~ yax, type = "bar",
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

# Issues that need resolving:
# 1. Color bar legend needs to be named and categorized.
# 3. Y axis label needs to be more specific
# 4. Build different charts, and make them interchangable.
