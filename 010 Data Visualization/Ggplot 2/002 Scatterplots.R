# Scatterplots

library(ggplot2)

df <- mtcars
head(df)

# Example 1
pl1 <- ggplot(data = df, aes(x = wt, y = mpg))+
    geom_point(alpha = 0.5) +
    xlab('Weight') +
    ylab("MPG") +
    ggtitle("Weight vs MPG")

print(pl1)

pl2 <- ggplot(data = df, aes(x = wt, y = mpg))+
    geom_point(aes(size = hp), alpha = 0.5) +
    xlab('Weight') +
    ylab("MPG") +
    ggtitle("Weight vs MPG")

print(pl2)

# Example 2: Shape
pl3 <- ggplot(df,aes(x = wt, y=mpg))+
    geom_point(aes( shape = factor(cyl)), size = 5, alpha = 0.5) +
    xlab('Weight') +
    ylab("MPG") +
    ggtitle("Weight vs MPG")

print(pl3)

# Example 3 : Color

pl4 <- ggplot(df,aes(x = wt, y=mpg))+
    geom_point(aes(shape = factor(cyl), color = hp), size = 5) +
    scale_color_gradient(low = 'blue', high = 'red') +
    xlab('Weight') +
    ylab("MPG") +
    ggtitle("Weight vs MPG")

print(pl4)

pl5 <- ggplot(df,aes(x = wt, y = mpg))+
    geom_point(aes(shape = factor(cyl), color = factor(cyl)), size = 5) +
    xlab('Weight') +
    ylab("MPG") +
    ggtitle("Weight vs MPG")

print(pl5)