# KNN - Classification

#install.packages('ISLR')
library(ISLR)
library(dplyr)

# 1. Import dataset
df <- Caravan


# 2. Check if any na values in the dataset
any(is.na(df))

# 3. Check variance in the dataset

var(df[,1])
var(df[,2])

# 4. Standardized the values

purchase <- df %>% 
    select(Purchase)

std.df <- df %>% 
    select(-Purchase) %>% 
    scale()

# 5. Split the dataset
## Test data
test.index <- 1:1000
test.data <- std.df[test.index,]
test.purchase <- purchase[test.index,]

## Train data
train.data <- std.df[-test.index,]
train.purchase <- purchase[-test.index,]

# 6. Fit the model
library(class)
set.seed(101)

predicted.purchase <- knn(train.data,
                          test.data,
                          train.purchase,
                          k = 1)
summary(predicted.purchase)

missclass.error <- mean(test.purchase != predicted.purchase)
missclass.error

# 7. Choose a K value
predicted.purchase <- NULL
error.rate <- NULL

for(i in 1:20){
    set.seed(101)
    predicted.purchase <- knn(train.data,
                              test.data,
                              train.purchase,
                              k = i)
    error.rate[i] <- mean(test.purchase != predicted.purchase)
}

print(error.rate)

## 8. Visualize K Elbow Method
library(ggplot2)

k.values <- 1:20

error.df <- data.frame(error.rate,k.values)

pl <- ggplot(error.df,aes(x = k.values, y = error.rate)) +
    geom_point()+
    geom_line(lty = 'dotted', color = 'red')

print(pl)