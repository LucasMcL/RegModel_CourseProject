## This script includes code used in my exploratory analysis of the mtcars dataset

library(ggplot2)
library(dplyr)
library(GGally)
library(kobe)
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

# fit1 <- lm(mpg ~ am, data = mtcars) # Shows that manual cars, considering all else the same, have 7.245 better mpg
# # 95% CI that difference lies between summary(fit1)$coefficients[2, 1] +c(-1, 1) * summary(fit1)$coefficients[2, 2]
# fit2 <- update(fit1, mpg ~ am + disp)
# fit3 <- update(fit1, mpg ~ am + disp + hp)
# fit4 <- update(fit1, mpg ~ am + disp + hp + wt)
# fit5 <- update(fit1, mpg ~ am + disp + hp + wt + drat)
# anova(fit1, fit2, fit3, fit4, fit5)

# Graphs showing characteristics of Automatic and Manual cars
p1 <- ggplot(mtcars, aes(x = am, y = wt)) + geom_boxplot() + ggtitle("Transmission and Weight")
p2 <- ggplot(mtcars, aes(x = am, y = drat)) + geom_boxplot() + ggtitle("Transmission and Rear Axle Ratio")
p3 <- ggplot(mtcars, aes(x = am, y = disp)) + geom_boxplot() + ggtitle("Transmission and Engine Volume")
p4 <- ggplot(mtcars, aes(x = am, y = gear)) + geom_boxplot() + ggtitle("Transmission and Number of Forward Gears")
multiplot(p1, p2, p3, p4, cols = 2)

g <- ggplot(mtcars, aes(x = wt, y = mpg, color = am))
g + geom_point() + geom_smooth(method = "lm") + ggtitle("Car Weight and MPG") + 
  xlab("Weight (1000s of lbs)") + ylab("MPG")

fit1 <- lm(mpg ~ am, data = mtcars)
fit2 <- lm(mpg ~ ., data = mtcars)
fit3 <- lm(mpg ~ am + wt + am * wt, data = mtcars)
summary(fit1)$coefficients
summary(fit2)$coefficients
summary(fit3)$coefficients

fit1.df <- data.frame(residuals = resid(fit1), fitted = predict(fit1))
g <- ggplot(fit1.df, aes(x = fitted, y = resid))
g + geom_point() + geom_abline(intercept = 0, slope = 0)
