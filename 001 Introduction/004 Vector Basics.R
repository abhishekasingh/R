# Vector Basics
## Same datatypes
## R will convert all the vectors into same class

a <- c(1,2,3,4,5)
print(a)
class(a)

b <- c("Hello","World")
print(b)
class(b)

c <- c(T, F, 20, 20.5, "Sunday")
print(c)
class(c)

## Name vector - Assigning name to vector
temp <- c (72,71,68,73,69)
days <- c("Mon","Tue","Wed","Thr","Fri")
names(temp) <- days
temp
temp['Mon']