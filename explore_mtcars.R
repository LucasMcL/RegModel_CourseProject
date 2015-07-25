## This script includes code used in my exploratory analysis of the mtcars dataset

library(ggplot2)
library(dplyr)
library(GGally)
data(mtcars)
old.mtcars <- mtcars

mtcars <- mtcars %>% mutate(cyl = as.factor(as.character(cyl)), 
                          vs = factor(vs, labels = c("V-engine", "Straight engine")), 
                          am = factor(am, labels = c("Automatic", "Manual")))

ggpairs(mtcars, color = "am")

#Plot showing MPG difference in automatic and manual cars
g <- ggplot(mtcars, aes(x = am, y = mpg))
g + geom_boxplot() + xlab("Transmission") + ylab("MPG") +
  ggtitle("Fuel Efficiency of Automatic and Manual Cars")

cor(old.mtcars)["am", ] # High cor with drat (rear axle ratio), wt, and gear
cor(old.mtcars)["mpg", ] # High cor with cyl, disp, hp, drat, wt

