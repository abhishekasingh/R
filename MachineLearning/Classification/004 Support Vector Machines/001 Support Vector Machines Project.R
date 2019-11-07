# Support Vector Machines Project

library(ggplot2)
library(dplyr)
library(tidyverse)
library(e1071)

# Import dataset
df.loan <- read.csv('loan_data.csv')
head(df.loan)
str(df.loan)

# Convert into factor
df.loan$credit.policy <- factor(df.loan$credit.policy)
df.loan$inq.last.6mths <- factor(df.loan$inq.last.6mths)
df.loan$delinq.2yrs <- factor(df.loan$delinq.2yrs)
df.loan$pub.rec <- factor(df.loan$pub.rec)
df.loan$not.fully.paid <- factor(df.loan$not.fully.paid)

# EDA
plt <- ggplot(df.loan, aes(x = fico)) +
    geom_histogram(aes(fill = not.fully.paid), color = 'black', bins = 40, alpha = 0.5) +
    scale_fill_manual(values = c('green', 'red'))
print(plt)

plt2 <- ggplot(df.loan, aes(x = factor(purpose))) +
    geom_bar(aes(fill = not.fully.paid), position = 'dodge') +
    theme_bw()
print(plt2)

plt3 <- ggplot(df.loan, aes(x = int.rate, y = fico)) +
    geom_point(aes(color = not.fully.paid), size = 2)
print(plt3)

# Split the data
library(caTools)
set.seed(101)

split <- sample.split(df.loan$not.fully.paid, SplitRatio = 0.7)
final.train <- subset(df.loan, split == TRUE)
final.test <- subset(df.loan, split == FALSE)

# Fit a model
library(e1071)
model <- svm(not.fully.paid ~ ., 
             data = final.train)
summary(model)

# Predict the values
predicted.values <- predict(model, final.test[1:13])
table(predicted.values, final.test$not.fully.paid)

# Tune the model

tune.results <- tune(svm, train.x = not.fully.paid ~.,
                     data = final.train,
                     kernel = 'radial',
                     ranges = list(cost = c(100,200), 
                                   gamma = c(0.1)))
summary(tune.results)

## best parameters:
# cost gamma
# 100   0.1

tuned.model <- svm(not.fully.paid ~ ., 
                   data = final.train,
                   kernel = 'radial',
                   cost = 100,
                   gamma = 0.1)

summary(tuned.model)

tuned.model.pred.values <- predict(tuned.model, final.test[1:13])
table(tuned.model.pred.values, final.test$not.fully.paid)