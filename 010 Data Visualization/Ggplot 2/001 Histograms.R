# Histograms

library(ggplot2)
library(ggplot2movies)

## Example 1
pl <- ggplot(movies,aes(x = rating)) + 
    geom_histogram(binwidth = 0.1, color = 'red', fill = 'pink', alpha = 0.5) + 
    xlab('Movies Rating') +
    ylab("Counts") +
    ggtitle("Movies Rating")

print(pl)

## Example 2

pl2 <- ggplot(movies,aes(x = rating)) + 
    geom_histogram(binwidth = 0.1, aes(fill = ..count..)) + 
    xlab('Movies Rating') +
    ylab("Counts") +
    ggtitle("Movies Rating")

print(pl2)
