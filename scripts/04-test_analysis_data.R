#### Preamble ####
# Purpose: Tests the structure and validity of the America 2024 presidential polls dataset
# Author: Zilin Liu
# Date: 21 October 2024
# Contact: liuzilin.liu@mail.utoronto.ca
# License: MIT
# Pre-requisites:
# - Install needed package `tidyverse` , `dplyr` and `readr`.
# - 03-clean_data.R must have been run
# Any other information needed? Make sure you are in the `US_Election` rproj



#### Workspace setup ####
library(tidyverse)
library(dplyr)
library(readr)

#load data
poll_data <- read_csv("data/02-analysis_data/analysis_data.csv")

# 1. Count the number of NA in each column
missing_values_count <- colSums(is.na(poll_data))
print(missing_values_count)

# 2. Use IQR method to detect abnormal values in' pct' column.
first_quartile <- quantile(poll_data$pct, 0.25, na.rm = TRUE)
third_quartile <- quantile(poll_data$pct, 0.75, na.rm = TRUE)
interquartile_range <- third_quartile - first_quartile
outliers_detected <- any(poll_data$pct < (first_quartile - 1.5 * interquartile_range) | 
                           poll_data$pct > (third_quartile + 1.5 * interquartile_range))

if (outliers_detected) {
  print("There are outliers that support percentages.")
} else {
  print("No outliers of support percentage was found.")
}

# 3. Verify that all values in the'log simple size' column are greater than 0.
valid_log_sample_size <- all(poll_data$log_sample_size >0, na.rm = TRUE)
if (valid_log_sample_size) {
  print("All log_sample_size greater than  0.")
} else {
  print("There is an invalid log_sample_size (less than 0).")
}

# 3. Verify that all values in the' transparency_score' column are greater than 0.
numeric_transparency_score <- all(sapply(poll_data$transparency_score, is.numeric), na.rm = TRUE)
if (numeric_transparency_score) {
  print("All transparency_score are numerical.")
} else {
  print("Not all transparency_score are numeric.")
}

