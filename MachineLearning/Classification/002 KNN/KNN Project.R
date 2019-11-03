# KNN Project

# 1. Import Library
library(ISLR)
library(dplyr)

# 2. Import dataset
df <- iris
head(df)
str(df)

# 3. Check if any na values in the dataset
any(is.na(df))

# 4. Standardized the values
std.feature <- df %>% 
    select(1:4) %>% 
    scale()

print(var(std.feature))
print(var(std.feature[,1]))

final.data <- cbind(std.feature, df[5])

str(final.data)

# 5. Split the dataset
set.seed(101)
library(caTools)


sample <- sample.split(final.data$Species, SplitRatio = 0.7)

train.data <- subset(final.data, sample == T)
test.data <- subset(final.data, sample == F)

# 6. Fit the model
library(class)

predicted.species <- knn(train.data[1:4],
                          test.data[1:4],
                          train.data$Species,
                          k = 1)
print(predicted.species)
table(predicted.species)

# 7. Misclassification Rate
missclass.error <- mean(test.data$Species != predicted.species)
missclass.error

# 8. Choose a K value
predicted.species <- NULL
error.rate <- NULL

for(i in 1:10){
    set.seed(101)
    predicted.species <- knn(train.data[1:4],
                             test.data[1:4],
                             train.data$Species,
                             k = i)
    error.rate[i] <- mean(test.data$Species != predicted.species)
}

print(error.rate)

## 9. Visualize K Elbow Method
library(ggplot2)

k.values <- 1:10

error.df <- data.frame(error.rate,k.values)
error.df

pl <- ggplot(error.df,aes(x = k.values, y = error.rate)) +
    geom_point() +
    geom_line(lty = 'dotted', color = 'red', size = 1)

print(pl)