# Decision Trees and Random Forests

# install.packages('rpart')
# install.packages('rpart.plot')
library(rpart)
library(rpart.plot)

# 1. Import datasets
df <- kyphosis
head(df)

# Fit the Decision Trees Model
tree <- rpart(formula = Kyphosis ~.,
              method = 'class',
              data = kyphosis)

# Examinin Results

## 1. Display cp table
printcp(tree)

## Plot
plot(tree,uniform = T, main = 'Kyphosis Tree')
text(tree, use.n = T,all = T)

## Plot using rpart.plot
prp(tree)

#################
# Random Forest #
#################

#install.packages('randomForest')
library(randomForest)
rf.model <- randomForest(Kyphosis ~. ,
                         data = kyphosis)
print(rf.model)

summary(rf.model$predicted)

print(rf.model$ntree)