getwd()  # to check workfile directory

install.packages("rmarkdown")  # install if you couldn't find the packages
install.packages("Rcpp")
install.packages("read_r")

library(Rcpp) # run library when you want to use particular function in that library
library(readr)

help(mean) 
?mean

c(1, 3, 3, 4, 8, 8, 6, 7)
summary(c(1, 3, 3, 4, 8, 8, 6, 7))
l <- c(1,"2") #### Create Vector or List
typeof(l)




############### Operations
set.seed(1000) # To make sure you always get the same values
x <- rnorm(6) # Generate 6 random values ~N
x             # x is a vector 
sum(x)
sum(x + 10)

x
x[1]   # to get 1st element in x  
x[c(1,4)]  # 1 way to get 1st and 4th elements in x  
x[c(T, F, T, T, F, F)]  # another way to get elements in x  

# Create a list that contains 4 objects
x <- list( a = 10, b = c(1, "2"), c=c(T,F,F,T,F),d=c(0.1,0.2,0.25) )
x
x$a   # Get "a" 
x[["a"]] 
x["a"]
x$b[1]  # Get 1st element in "b" 
x$c[c(3,4)]        # Get 3rd and 4th element in "c" 


############# Examining ‘structure’
str(x)


############# Missing Values
x <- c(50, 12, NA, 20) 
mean(x)
mean(x, na.rm=TRUE) #  NA values should be removed before the computation 


############# Counting Categories / Tabulate the data
table(c(1, 2, 3, 1, 2, 8, 1, 4, 2))
table(c(T,T,T,F,F,T,F,F,T))

# length # unique
?length
?unique
y <- c(1:10,7,7,5,8,8)
y
length(y) # count the total number of elements (include repeated)
unique(y) # ignore repeated values 
length(unique(y))


############# Functions
average <- function(x)
{
  return(sum(x)/length(x)) 
}

y1 <- c(1,2,3,4,5,6) 
average(y1)
y2 <- c(1, 9, 4, 4, 0, 1, 15) 
average(y2)


############# Getting data
library(dplyr)
data(economics, package = "ggplot2") # data frames are essentially a list of vectors 
glimpse(economics)

library(gapminder)
glimpse(gapminder)

library(readr)
ped <- read_csv("http://dicook.github.io/Statistical_Thinking/data/Pedestrian_Counts.csv") 
glimpse(ped)


d1 <- readRDS("~/Downloads/student_sub.rds")
