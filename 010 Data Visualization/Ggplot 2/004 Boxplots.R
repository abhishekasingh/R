# Boxplots

library(ggplot2)

df <- mtcars
head(df)

# Example 1
# X axies must be a categorial value
pl1 <- ggplot(df,aes(x = factor(cyl), y = mpg)) +
    geom_boxplot() +
    xlab("Cyl") +
    ylab("mpg") +
    ggtitle("Boxplot: Cyl vs Mpg") +
    theme_bw()

print(pl1)

# Example 2: Flip the axies
pl2 <- ggplot(df,aes(x = factor(cyl), y = mpg)) +
    geom_boxplot() +
    coord_flip() +
    xlab("Cyl") +
    ylab("mpg") +
    ggtitle("Boxplot: Mpg vs Cyl") +
    theme_bw()

print(pl2)

# Example 2: Color
pl3 <- ggplot(df,aes(x = factor(cyl), y = mpg)) +
    geom_boxplot(color = 'red', fill = 'pink', alpha = 0.5) +
    xlab("Cyl") +
    ylab("mpg") +
    ggtitle("Boxplot: Mpg vs Cyl") +
    theme_bw()

print(pl3)

pl4 <- ggplot(df,aes(x = factor(cyl), y = mpg)) +
    geom_boxplot(aes(fill = factor(cyl))) +
    xlab("Cyl") +
    ylab("mpg") +
    ggtitle("Boxplot: Mpg vs Cyl") +
    theme_bw()

print(pl4)