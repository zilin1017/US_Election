#### Preamble ####
# Purpose: Downloads and saves the data from fivethirtyeight (https://projects.fivethirtyeight.com/polls/president-general/2024/national/)
# Author: Irene Liu
# Date: 21 October 2024
# Contact: liuzilin.liu@mail.utoronto.ca
# License: MIT
# Pre-requisites: 
#   -Download the raw polling data from https://projects.fivethirtyeight.com/polls/president-general/2024/national/
#   -Install necessary libraries, such as readr and tidyverse.
# Any other information needed? None


#### Workspace setup ####
#install.packages("readr")
#install.packages("tidyverse")
library(tidyverse)
library(readr)


#### Download data ####

poll<-read_csv(here::here("data/01-raw_data/president_polls.csv"))



#### Save data ####

write_csv(poll, "data/01-raw_data/raw_data.csv") 

         
