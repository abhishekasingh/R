# Barplots

library(ggplot2)
df <- mpg

# Example 1
# Simple Bar
pl1 <-  ggplot(df, aes(x = class))+
    geom_bar( color = 'grey', fill = "#cecece", alpha = 0.5) +
    xlab('Class') +
    ylab("Counts") +
    ggtitle("Example: Simple Bar")
print(pl1)


# Example 2
# Stack Bar
pl2 <-  ggplot(df, aes(x = class))+
    geom_bar(aes(fill = drv), color = 'grey', alpha = 0.7) +
    xlab('Class') +
    ylab("Counts") +
    ggtitle("Example: Stack Bar")

print(pl2)


# Example 3
# Percentage Stack Bar
pl3 <-  ggplot(df, aes(x = class))+
    geom_bar(aes(fill = drv), position = "fill", color = 'grey', alpha = 0.7) +
    xlab('Class') +
    ylab("Counts") +
    ggtitle("Example: Percentage Stack Bar")
print(pl3)


# Example 4
# Side Bar
pl4 <-  ggplot(df, aes(x = class))+
    geom_bar(aes(fill = drv), position = "dodge", color = 'grey', alpha = 0.7) +
    xlab('Class') +
    ylab("Counts") +
    ggtitle("Example: Side Bar")
print(pl4)