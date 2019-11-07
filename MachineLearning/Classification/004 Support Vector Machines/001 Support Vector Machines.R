# Support Vector Machines

#install.packages('e1071')
library(ISLR)
library(e1071)

# Import dataset
df <- iris
head(df)
str(df)
levels(df$Species)

# Split the data
library(caTools)
set.seed(101)

split <- sample.split(df$Species, SplitRatio = 0.7)
final.train <- subset(df, split == TRUE)
final.test <- subset(df, split == FALSE)

# Fit a model
model <- svm(Species ~ ., 
             data = final.train)
summary(model)

pred.values <- predict(model, final.test[1:4])
table(pred.values, final.test[,5])

# Tune the model
tune.results <- tune(svm, train.x = final.train[1:4], 
                     train.y = final.train[,5],
                     kernel = 'radial',
                     ranges = list(cost = c(0.5, 1, 1, 10), gamma = c(0.5, 1, 2)))
summary(tune.results)

# best parameters:
# cost gamma
# 0.5   0.5
tuned.model <- svm(Species ~ ., 
                   data = final.train,
                   kernel = 'radial',
                   cost = 0.5,
                   gamma = 0.5)

summary(tuned.model)

tuned.model.pred.values <- predict(tuned.model, final.test[1:4])
table(tuned.model.pred.values, final.test[,5])