#### Preamble ####
# Purpose: Models Trump's vote rate exceeds 50% and the relationship between the States 
#   And the relationship between transparency and pct.
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
library(knitr)

#### Read data ####
trump <- read_csv("data/02-analysis_data//analysis_data.csv")


## Analytic data set

## show the data
trump[1:10,] %>%select("pct","state","start_date","transparency_score","vote" ,"log_sample_size")%>%
  kable(
    col.names = c("pct","state","start_date","transparency_score","vote" ,"log_sample_size"),
    digits = 0,
    format.args = list(big.mark = ","),
    booktabs = TRUE
  )


## Visual analysis
## Trump's vote rate exceeds 50% and the relationship between the States.
trump%>%
  ggplot(aes(x = state, fill =candidate_name)) +
  stat_count(position = "dodge") +
  facet_wrap(facets = vars(vote)) +
  theme_minimal() +
  labs(title="Figure 1 Bar chart of Trump's Eight-state support rate",
       x = "State",
       y = "Number of respondents",
       fill = "Voted for") +
  coord_flip() +
  scale_fill_brewer(palette = "Set1") +
  theme(legend.position = "bottom")


## The relationship between transparency and pct

# Plot the regression line for log(Sample Size) vs pct

p1<-trump%>%filter(state=="Arizona"| state=="Florida")%>%ggplot( aes(x = start_date, y = pct,colour = state )) +
  geom_line(size = 1) +
  geom_point(size = 2) +
  labs(title = "Predicted Support Percentage Over Time", 
       x = "Date", y = "Predicted Support Percentage (%)") +
  scale_x_date(limits = c(as.Date("2024-07-01"), as.Date("2024-11-05"))) +
  theme_minimal() + 
  theme(plot.title = element_text(hjust = 0.5))  # Center the title


p2<-trump%>%filter(state=="Georgia"| state=="Michigan")%>%ggplot( aes(x = start_date, y = pct,colour = state )) +
  geom_line(size = 1) +
  geom_point(size = 2) +
  labs(title = "Predicted Support Percentage Over Time", 
       x = "Date", y = "Predicted Support Percentage (%)") +
  scale_x_date(limits = c(as.Date("2024-07-01"), as.Date("2024-11-05"))) +
  theme_minimal() + 
  theme(plot.title = element_text(hjust = 0.5))  # Center the title


p3<-trump%>%filter(state=="Texas"| state=="North Carolina")%>%ggplot( aes(x = start_date, y = pct,colour = state )) +
  geom_line(size = 1) +
  geom_point(size = 2) +
  labs(title = "Predicted Support Percentage Over Time", 
       x = "Date", y = "Predicted Support Percentage (%)") +
  scale_x_date(limits = c(as.Date("2024-07-01"), as.Date("2024-11-05"))) +
  theme_minimal() + 
  theme(plot.title = element_text(hjust = 0.5))  # Center the title

p4<-trump%>%filter(state=="Pennsylvania"| state=="Wisconsin")%>%
  ggplot( aes(x = start_date, y = pct,colour = state )) +
  geom_line(size = 1) +
  geom_point(size = 2) +
  labs(title = "Predicted Support Percentage Over Time", 
       x = "Date", y = "Predicted Support Percentage (%)") +
  scale_x_date(limits = c(as.Date("2024-07-01"), as.Date("2024-11-05"))) +
  theme_minimal() + 
  theme(plot.title = element_text(hjust = 0.5))  # Center the title

cowplot::plot_grid(p1,p2,p3,ncol = 2)

