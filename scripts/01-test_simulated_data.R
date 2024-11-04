#### Preamble ####
# Purpose: Tests the structure and validity of the simulated 2024 American 
  #electoral divisions dataset.
# Author: Zilin Liu
# Date: 21 October 2024
# Contact: liuzilin.liu@mail.utoronto.ca
# License: MIT
# Pre-requisites: 
  # - The `tidyverse` package must be installed and loaded
  # - 00-simulate_data.R must have been run
# Any other information needed? Make sure you are in the `starter_folder` rproj


#### Workspace setup ####

# Load the necessary libraries
library(dplyr)
library(readr)
library(ggplot2)

# load data
data <- read.csv(here::here("data/00-simulated_data/simulated_data.csv"))

# Define a function to perform data quality check.
check_data_quality <- function(data, column) {
  # Check NA value
  na_count <- sum(is.na(data[[column]]))
  cat(sprintf("Column '%s' has %d NA values.\n", column, na_count))
  
  # Check for outliers (for numeric columns only)
  if (is.numeric(data[[column]]) && !is.logical(data[[column]])) {
    Q1 <- quantile(data[[column]], 0.25, na.rm = TRUE)
    Q3 <- quantile(data[[column]], 0.75, na.rm = TRUE)
    IQR_value <- Q3 - Q1
    lower_bound <- Q1 - 1.5 * IQR_value
    upper_bound <- Q3 + 1.5 * IQR_value
    outliers <- data[[column]] < lower_bound | data[[column]] > upper_bound
    outlier_count <- sum(outliers, na.rm = TRUE)
    cat(sprintf("Column '%s' has %d outliers.\n", column, outlier_count))
    
    # Draw a box plot
    p <- ggplot(data, aes(x = 1, y = column)) +
      geom_boxplot() +
      theme_minimal() +
      labs(title = paste0("Boxplot for ", column), x = "", y = column)
    print(p)
  }
  
  # Check the range of values (only for columns such as sample size)
  if (column == "sample_size") {
    negative_values <- any(data[[column]] <= 0, na.rm = TRUE)
    if (negative_values) {
      cat("Warning: There are non-positive values in 'sample_size'.\n")
    } else {
      cat("All 'sample_size' values are positive.\n")
    }
  }
  
  # Check data type consistency
  is_numeric <- all(sapply(data[[column]], is.numeric), na.rm = TRUE)
  if (!is_numeric) {
    cat("Warning: Not all values in '", column, "' are numeric.\n", sep="")
  } else {
    cat("All values in '", column, "' are numeric.\n", sep="")
  }
}

# Check data quality for specific columns
columns_to_check <- c("pct", "sample_size")
for (col in columns_to_check) {
  check_data_quality(data, col)
}

