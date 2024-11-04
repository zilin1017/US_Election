#### Preamble ####
# Purpose: Models Donald Trump's support rate in the 2024 U.S. Presidential Election 
#          using Bayesian time-series analysis.
# Author: Irene Liu
# Date: 21 October 2024
# Contact: liuzilin.liu@mail.utoronto.ca
# License: MIT
# Pre-requisites: Install necessary libraries.
# Any other information needed? None


#### Workspace setup ####
library(tidyverse)
library(ggplot2)
library(modelsummary)
library(rstanarm)
library(collapse)
library(arrow)
library(marginaleffects)

#### Read data ####
analysis_data <- read_csv("data/02-analysis_data/analysis_data.csv")


logit_data<-analysis_data%>%
  mutate(is_vote=factor(ifelse(vote=="yes",1,0)))%>%
  mutate(start_date=as.numeric(start_date))



### Model data ####
## Bayesian logistic model 
poll_model <-stan_glm(
  is_vote ~state+ start_date+log_sample_size+transparency_score,data = logit_data,
  family = binomial(link = "logit"),
  prior = normal(location = 0, scale = 2.5, autoscale = TRUE),
  prior_intercept = 
    normal(location = 0, scale = 2.5, autoscale = TRUE))


modelsummary(list("Donald Trump" = poll_model),statistic = "mad")

saveRDS(
  poll_model,
  file = "models/poll_model.rds")


##Create prediction data
pre_date=c("2024-11-05")
prediction_data <- data.frame(
  state = unique(logit_data$state),
  start_date =as.numeric(as.Date(pre_date)),
  log_sample_size = mean(logit_data$log_sample_size),
  transparency_score = mean(logit_data$transparency_score)
)

# # Use models to make predictions
predicted_support <- predictions(poll_model, newdata = prediction_data)
predicted_support 
# Calculate the average forecast support rate of each state.
pred_result <- mean(predicted_support$estimate)
print(pred_result)

