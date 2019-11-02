# Coordinates

library(ggplot2)

# Add limit
pl <- ggplot(mpg,aes(x = displ, y = hwy)) +
    geom_point() +
    coord_cartesian(xlim = c(1,4),ylim = c(15,30)) +
    xlab("Display") +
    ylab("Highway") +
    ggtitle("Add Limits")

print(pl)


# Change aspect
pl2 <- ggplot(mpg,aes(x = displ, y = hwy)) +
    geom_point() +
    coord_fixed(ratio = 1/3) +xlab("Year") +
    xlab("Display") +
    ylab("Highway") +
    ggtitle("Change Aspect")

print(pl2)

# Faceting
## Note: Column by comes first
pl1 <- ggplot(mpg,aes(x = displ, y = hwy)) +
    geom_point() +
    facet_grid(. ~ cyl) +
    xlab("Display") +
    ylab("Highway") +
    ggtitle("Column by Cyl")


print(pl1)


pl2 <- ggplot(mpg,aes(x = displ, y = hwy)) +
    geom_point() +
    facet_grid(cyl ~ .) +
    xlab("Display") +
    ylab("Highway") +
    ggtitle("Rows by Cyl")

print(pl2)

pl3 <- ggplot(mpg,aes(x = displ, y = hwy)) +
    geom_point() +
    facet_grid(cyl ~ drv) +
    xlab("Display") +
    ylab("Highway") +
    ggtitle("Column by Drive / Row by Cylinder")

print(pl3)

pl4 <- ggplot(mpg,aes(x = displ, y = hwy)) +
    geom_point() +
    facet_grid(drv ~ cyl) +
    xlab("Display") +
    ylab("Highway") +
    ggtitle("Column by Cylinder / Row by Drive")

print(pl4)