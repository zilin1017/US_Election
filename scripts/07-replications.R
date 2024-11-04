#### Preamble ####
# Purpose: Replicated graphs from... [...UPDATE THIS...]
# Author: Zilin Liu
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


## prediction plot
poll_predictions  <- predictions(poll_model)
poll_predictions %>%mutate(vote=factor(is_vote))%>%
  ggplot(aes(x =log_sample_size , y = estimate, color = vote)) +
  geom_jitter(width = 0.01, height = 0.01, alpha = 0.3) +
  labs(
    x = "sample size",
    y = "Estimated probability voted",
    color = "is voted" ) +
  theme_classic() +
  scale_color_brewer(palette = "Set1") +
  theme(legend.position = "bottom")


g2<-poll_predictions %>%mutate(vote=factor(is_vote))%>%
  ggplot(aes(x =start_date , y = estimate, color = vote)) +
  geom_jitter(width = 0.01, height = 0.01, alpha = 0.3) +
  labs(
    x = "start date",
    y = "Estimated probability voted",
    color = "is voted" ) +
  theme_classic() +
  scale_color_brewer(palette = "Set1") +
  theme(legend.position = "bottom")

poll_predictions %>%mutate(vote=factor(is_vote))%>%
  ggplot(aes(x =transparency_score , y = estimate, color = vote)) +
  geom_jitter(width = 0.01, height = 0.01, alpha = 0.3) +
  labs(
    x = "transparency score",
    y = "Estimated probability voted",
    color = "is voted" ) +
  theme_classic() +
  scale_color_brewer(palette = "Set1") +
  theme(legend.position = "bottom")

poll_predictions %>%mutate(vote=factor(is_vote))%>%
  ggplot(aes(x =state , y = estimate, color = vote)) +
  geom_jitter(width = 0.01, height = 0.01, alpha = 0.3) +
  labs(
    x = "state",
    y = "Estimated probability voted",
    color = "is voted" ) +
  theme_classic() +
  scale_color_brewer(palette = "Set1") +
  theme(legend.position = "bottom")




## Credible intervals for predictors of support for harris
modelplot( poll_model, conf_level = 0.9) +
  labs(x = "90 percent credibility interval")


