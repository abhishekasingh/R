# Logistic Regression Project

# Import Library
library(ggplot2)
library(dplyr)

# 1. Import dataset

adult.data <- read.csv('dataset/adult_sal.csv')
head(adult.data)
str(adult.data)

adult.data <- adult.data %>% 
    select(-X)

str(adult.data)
summary(str(adult.data))
# 2. Exploratory Data Analysis

# Data Cleaning
## Combine employee type
table(adult.data$type_employer)

jobgroups <- function(job){
    job <- as.character(job)
    if(job == "Never-worked" | job == 'Without-pay'){
        return('unemployed')
    }else if(job == "State-gov" | job == 'Local-gov'){
        return('SL-gov')
        
    }else if(job == "Self-emp-inc" | job == 'Self-emp-not-inc'){
        return('self-emp')
    }else{
        return(job)
    }
}

adult.data$type_employer <- sapply(adult.data$type_employer,jobgroups)

print(table(adult.data$type_employer))

## Martial Status
table(adult.data$marital)

maritalgroups <- function(marital){
    marital <- as.character(marital)
    if(marital == "Divorced" | marital == 'Separated' | marital == 'Widowed'){
        return('Not-Married')
    }else if(marital == "Never-married"){
        return(marital)
    }else{
        return('Married')
    }
}

adult.data$marital <- sapply(adult.data$marital,maritalgroups)


## Hour Per Week
hourgroups <- function(hour){
    if(hour > 40){
        return('> 40')
    }else if(hour < 40){
        return('< 40')
    }else if(hour == 40){
        return('40')
    }
    
}
adult.data$hr_per_week <- sapply(adult.data$hr_per_week,hourgroups)
table(adult.data$hr_per_week)

## Countries
Asia <- c('China','Hong','India','Iran','Cambodia','Japan', 'Laos' ,
          'Philippines' ,'Vietnam' ,'Taiwan', 'Thailand')

North.America <- c('Canada','United-States','Puerto-Rico' )

Europe <- c('England' ,'France', 'Germany' ,'Greece','Holand-Netherlands','Hungary',
            'Ireland','Italy','Poland','Portugal','Scotland','Yugoslavia')

Latin.and.South.America <- c('Columbia','Cuba','Dominican-Republic','Ecuador',
                             'El-Salvador','Guatemala','Haiti','Honduras',
                             'Mexico','Nicaragua','Outlying-US(Guam-USVI-etc)','Peru',
                             'Jamaica','Trinadad&Tobago')
Other <- c('South')

countrygroups <- function(ctry){
    if (ctry %in% Asia){
        return('Asia')
    }else if (ctry %in% North.America){
        return('North.America')
    }else if (ctry %in% Europe){
        return('Europe')
    }else if (ctry %in% Latin.and.South.America){
        return('Latin.and.South.America')
    }else{
        return('Other')      
    }
}

adult.data$country <- sapply(adult.data$country,countrygroups)
table(adult.data$country)

adult.data$type_employer <- factor(adult.data$type_employer)
adult.data$marital <- factor(adult.data$marital)
adult.data$country <- factor(adult.data$country)
adult.data$hr_per_week <- factor(adult.data$hr_per_week)

str(adult.data)


# Missing Values
### Check for missing values in dataframe
sapply(adult.data, function(x) sum(is.na(x)))

library('Amelia')
adult.data[adult.data == '?'] <- NA
table(adult.data$type_employer)

adult.data$type_employer <- factor(adult.data$type_employer)
adult.data$marital <- factor(adult.data$marital)
adult.data$country <- factor(adult.data$country)
adult.data$hr_per_week <- factor(adult.data$hr_per_week)

print(table(adult.data$type_employer))

## Drop missing data
missmap(adult.data,y.at=c(1),y.labels = c(''),col=c('yellow','black'))

adult.data <- na.omit(adult.data)

missmap(adult.data, y.at = c(1), col = c('yellow','black'), y.labels = c(' '))

str(adult.data)

pl <- ggplot(adult.data,aes(age)) + 
    geom_histogram(aes(fill=income),color='black',binwidth=1) + 
    theme_bw()
print(pl)

pl <- ggplot(adult.data,aes(hr_per_week)) + 
    geom_bar(fill = 'pink', color = 'red') + 
    theme_bw()
print(pl)

# Rename country to region
adult.data <- rename(adult.data, region = country)

pl <- ggplot(adult.data,aes(region)) + 
    geom_bar(aes(fill = income), color = 'black') + 
    theme_bw()
print(pl)

# Fit a Logistic Regression Model

head(adult.data)
str(adult.data)

# Split the data
library(caTools)
set.seed(101) 

sample <- sample.split(adult.data$income, SplitRatio = 0.70)

train.data = subset(adult.data, sample == TRUE)
test.data = subset(adult.data, sample == FALSE)

# Evaluate the model
model = glm(income ~ ., family = binomial(logit), data = train.data)
summary(model)

new.step.model <- step(model)
summary(new.step.model)

test.data$predicted.income <- predict(model,newdata = test.data,type = 'response')

table(test.data$income, test.data$predicted.income > 0.50)

# Accuracy
acc <- (6373 + 1407) /(6373 + 547 + 888 + 1407)
print(acc)