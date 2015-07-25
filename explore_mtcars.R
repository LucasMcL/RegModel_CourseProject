## This script includes code used in my exploratory analysis of the mtcars dataset

library(ggplot2)
library(dplyr)
library(GGally)
data(mtcars)

mtcars <- mtcars %>% mutate(cyl = as.factor(as.character(cyl)), 
                          vs = factor(vs, labels = c("V-engine", "Straight engine")), 
                          am = factor(am, labels = c("Automatic", "Manual")))

pairs(mtcars)
ggpairs(mtcars[, 1:5], color = "cyl")
cor(mtcars)[1, ]