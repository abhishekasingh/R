# Vector Indexing and Slicing

vector1 <- c(100,200,300,400,500)
vector2 <- c('a','b','c','d','e')

## Single value
vector1[1]
vector1[4]

## Slices of values
### Particular values
vector1[c(2,5)]

### Continues values
vector1[2:4]

## Using name
names(vector1) <- vector2
print(vector1)

print(vector1['b'])

print(vector1[c('d','e')])

## Conditional
my.filter <- vector1 > 300
vector1[my.filter]