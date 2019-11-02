# Logistic Regression

# Import Library
library(ggplot2)
library(ggthemes)

# 1. Import dataset

df.train <- read.csv('dataset/titanic_train.csv')
df.test <- read.csv('dataset/titanic_test.csv')

head(df.train)
head(df.test)

# 2. Exploratory Data Analysis

## Missing Values
### Check for missing values in dataframe
sapply(df.train, function(x) sum(is.na(x)))

library('Amelia')
missmap(df.train, main = 'Missing Map', col = c('yellow','black'), legend = FALSE)


pl <- ggplot(df.train, aes(Survived)) +
    geom_bar()
print(pl)

pl <- ggplot(df.train, aes(Pclass)) +
    geom_bar(aes(fill = factor(Pclass)))
print(pl)

pl <- ggplot(df.train, aes(Sex)) +
    geom_bar(aes(fill = factor(Sex)))
print(pl)

pl <- ggplot(df.train, aes(Age)) +
    geom_histogram(bins = 20, color = "red", fill = 'pink', alpha = 0.5)
print(pl)


pl <- ggplot(df.train, aes(SibSp)) +
    geom_bar()
print(pl)


pl <- ggplot(df.train, aes(Fare)) +
    geom_histogram(bins = 20, color = "red", fill = 'pink', alpha = 0.5)
print(pl)

## Boxplot
pl <- ggplot(df.train, aes(x = Pclass , y = Age )) +
    geom_boxplot(aes(group = Pclass, fill = factor(Pclass)), alpha = 0.4) +
    scale_y_continuous(breaks = seq(min(0), max(80), by = 2)) +
    theme_bw()
print(pl)

## Imputation of Age based on class

impute_age <- function(age, class){
    out <- age
    
    for(i in 1:length(age)){
        if(is.na(age[i])){
            if(class[i] == 1){
                out[i] <- 37
            }else if(class[i] == 2){
                out[i] <- 29
            }else{
                out[i] <- 24
            }
        }
    }
    
    return (out)
}

fixed.ages <- impute_age(df.train$Age, df.train$Pclass)

df.train$Age <- fixed.ages

# Fit the model
library(dplyr)

df.train <- df.train %>% 
    select(-PassengerId, -Name, -Ticket, -Cabin)
    
df.train$Survived <- factor(df.train$Survived)
df.train$Pclass <- factor(df.train$Pclass)
df.train$SibSp <- factor(df.train$SibSp)
df.train$Parch <- factor(df.train$Parch)

str(df.train)

# Split the data
library(caTools)
set.seed(101)

split <- sample.split(df.train$Survived, SplitRatio = 0.7)
final.train <- subset(df.train, split == TRUE)
final.test <- subset(df.train, split == FALSE)

log.model.all <- glm(formula = Survived ~ .,
                 family = binomial(link = 'logit'),
                 data = final.train)
summary(log.model.all)

log.model.sat <- glm(formula = Survived ~ Pclass + Sex + Age + SibSp + Parch,
                 family = binomial(link = 'logit'),
                 data = final.train)
summary(log.model.sat)

# Predict
## Full Model
fitted.probability.all <- predict(log.model.all, final.test, type = 'response')
fitted.result.all <- ifelse(fitted.probability.all > 0.5, 1, 0)

misClassError.all <- mean(fitted.result.all != final.test$Survived)
print(1 - misClassError.all)

## Saturated Model
fitted.probability.sat <- predict(log.model.sat, final.test, type = 'response')
fitted.result.sat <- ifelse(fitted.probability.sat > 0.5, 1, 0)

misClassError.sat <- mean(fitted.result.sat != final.test$Survived)
print(1 - misClassError.sat)

# Confusion Matrix

## Full Model
table(final.test$Survived,fitted.probability.all > 0.50)

## Saturated Model
table(final.test$Survived,fitted.probability.sat > 0.50)