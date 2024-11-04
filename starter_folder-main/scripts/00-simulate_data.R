#### Preamble ####
# Purpose: Simulates a dataset of Australian electoral divisions, including the 
  #state,pollster,support rate, political stage and other relevant data.
# Author: Irene Liu
# Date: 21 October 2024
# Contact: liuzilin.liu@mail.utoronto.ca
# License: MIT
# Pre-requisites: The `tidyverse` package must be installed
# Any other information needed? Make sure you are in the `starter_folder` rproj


#### Workspace setup ####

library(tibble)
library(readr)
set.seed(853)


#### Simulate data ####
possible_answers <- c("Yes", "No", "Undecided")
possible_stages <- c("Primary", "General", "Special")

simulated_data <- tibble(
  poll_id = 1:1000, 
  answer = sample(possible_answers, size = 1000, replace = TRUE),
  pollscore = runif(1000, min = 0, max = 100),  
  sample_size = sample(500:3000, size = 1000, replace = TRUE), 
  pct = runif(1000, min = 40, max = 60), 
  stage = sample(possible_stages, size = 1000, replace = TRUE),
  transparency_score = runif(1000, min = 0, max = 1), 
  numeric_grade = runif(1000, min = 0, max = 100), 
  end_date = sample(seq(as.Date("2024-01-01"), as.Date("2024-11-01"), by = "day"), size = 1000, replace = TRUE),
  ranked_choice_reallocated = sample(c(TRUE, FALSE), size = 1000, replace = TRUE, prob = c(0.1, 0.9))
)


print(head(simulated_data))

#### Save data ####
write_csv(simulated_data, "data/00-simulated_data/simulated_data.csv")
