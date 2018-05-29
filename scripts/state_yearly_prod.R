library(plotly)
library(dplyr)
# Defining helper methods

add_prod <- function(plot, df) {
  plot <- add_trace(plot, x = ~ year, y = ~ totalprod,
                    type = "scatter", mode = "lines",
                    name = "Total Production (lbs)")
  plot
}

add_stock <- function(plot, df) {
  plot <- add_trace(plot, x = ~ year, y = ~ stocks,
                    type = "scatter", mode = "lines",
                    name = "Stocks (lbs)")
  plot
}

# Function to return state yearly honey production
state_prod <- function(df, sta, prod) {
  # Filtering data to only one state
  df <- df %>% filter(state == sta)

  # Generate empty Plotly
  p <- plot_ly(df, type = "scatter", mode = "lines") %>%
    layout(
      xaxis = list(title = "Year"), yaxis = list(title = "Count"),
      title = paste0("Honey Production by year in ", sta)
    )

  # Filtering data for prod, stock, or both
  if (prod == "all") {
    df <- df %>% select(state, totalprod, stocks, year)
    p <- add_prod(p, df)
    p <- add_stock(p, df)
  } else if (prod == "stock") {
    df <- df %>% select(state, stocks, year)
    p <- add_stock(p, df)
  } else {
    df <- df %>% select(state, totalprod, year)
    p <- add_prod(p, df)
  }

  p
}
