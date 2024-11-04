#### Preamble ####
# Purpose: Cleans the raw polling data for the 2024 US presidential election.
# Author: Zilin Liu
# Date: 21 October 2024
# Contact: liuzilin.liu@mail.utoronto.ca
# License: MIT
# Pre-requisites: Install necessary libraries.
# Any other information needed? Make sure 02-download_data.R must have been run

#### Workspace setup ####
library(tidyverse)
library(ggplot2)
library(modelsummary)
library(rstanarm)
library(collapse)
library(arrow)

#### Clean data ####

## load data
poll<-read.csv(file = "data/01-raw_data/raw_data.csv")

## Data cleaning and processing
poll1<-select(poll ,candidate_name, pct ,state,numeric_grade,start_date,transparency_score,sample_size)%>%
  mutate(vote=ifelse(pct>=50,"yes","no"))%>%
  mutate(start_date = as.Date(start_date, format = "%m/%d/%y"))%>%
  mutate(log_sample_size=log(sample_size))%>%
  filter(candidate_name=="Donald Trump" )%>%
  filter(numeric_grade>=2.5 &  start_date >= as.Date("2024-07-01"))

# Format of state and remove the missing value
poll2 <- poll1 %>%
  mutate(state = str_replace(state, " CD-\\d+", ""))%>%
  filter(state!="" & log_sample_size!="")%>%
  filter(state %in% c("Georgia","Michigan","Pennsylvania","Arizona","North Carolina","Wisconsin","Texas","Florida"))


## Save data
write.csv(poll2,"data/02-analysis_data/analysis_data.csv")

