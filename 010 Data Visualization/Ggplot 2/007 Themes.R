# Themes
library(ggplot2)
library(ggthemes)

# Two ways:
# 1. set the theme
# 2.use individually in the plot

theme_set(theme_minimal())

pl <- ggplot(mtcars,aes(x = wt, y = mpg)) +
    geom_point() +
    theme_grey()

print(pl)