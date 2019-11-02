# 2 Variable Plotting

library(ggplot2)
library(ggplot2movies)

# Example 1
pl <- ggplot(movies,aes(x = year, y = rating)) +
    geom_bin2d() +
    scale_fill_gradient(low = 'blue', high = 'red') +
    xlab("Year") +
    ylab("Rating") +
    ggtitle("Heatmap")

print(pl)

# Example 2: Bin Size
pl2 <- ggplot(movies,aes(x = year, y = rating)) +
    geom_bin2d(binwidth = c(3,1)) +
    scale_fill_gradient(low = 'blue', high = 'red') +
    xlab("Year") +
    ylab("Rating") +
    ggtitle("Heatmap: Bin Size")

print(pl2)

# Example 2: Hex Plot
pl3 <- ggplot(movies,aes(x = year, y = rating)) +
    geom_hex() +
    scale_fill_gradient(low = 'blue', high = 'red') +
    xlab("Year") +
    ylab("Rating") +
    ggtitle("Hex Plot")

print(pl3)

# Example 2: Density Plot
pl4 <- ggplot(movies,aes(x = year, y = rating)) +
    geom_density2d() +
    xlab("Year") +
    ylab("Rating") +
    ggtitle("Density Plot")

print(pl4)