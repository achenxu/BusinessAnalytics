# Q1
(100+2)/3
5*10^2
1/0
0/0
(0i-9)^(1/2)
sqrt(2*max(-10,0.2,4.5))+100
x <- sqrt(2*max(-10,0.2,4.5))+100
x
log(100)
log(100,base=10)


# Q2
y=4
y <- 4
4 -> y
4
y



# Q3
X <- matrix(c(3,4,5,2),nrow=2,ncol=2)
dim(X)
t(X)       # Transpose
Xinv <- solve (X)
X %*% Xinv  # Matrix Multiplication

A <- matrix(rnorm(200), nrow=5, ncol=40) 
B <- A %*% t(A)
dim(B)
diag(B) # Diagonal elements
eigen(B)
svd(A)$d^2 
eigen(B)$values


M <- matrix(c(7,3,3,-1),nrow=2,ncol=2)
M
eigen(M)

# Q4
help(mean)
?mean


# Q5
x <- c(0:10,50)
xm <- mean(x)
c (xm,mean(x,trim=0.10))



# Q6
library(ggplot2)
x <- c(0:10,50)
y <- c(rep("yes",7),rep("no",5))
df <- data.frame(x=x, y=y)
df
qplot (x, data=df)
qplot (x, data=df, binwidth=5)
qplot (y, x, data=df, geom="boxplot", xlab="")
qplot (factor(0), x, data=df, geom="boxplot", xlab="")



# Q8
# rnorm generates random numbers from N(0,1)
# 200 random numbers from N(0,1)
qplot (rnorm(200))
qplot (factor(2), rnorm(200), geom="boxplot", xlab="")


# Q9 Data sets from ISLR packages
install.packages("ISLR")
library(ISLR)



# Q10
help(OJ)
dim(OJ)
head(OJ)
tail(OJ)
str(OJ) # Structure of object
colnames(OJ) # name of variables
View(OJ)
summary(OJ)
OJ[,"PriceCH"]  # Show col "Price CH"
OJ[c(2:5,10),"PriceCH"]     # Price CH of Particular observation



# Q12 Tabulating Variables
table(OJ$StoreID)
table(Purchase=OJ$Purchase,Special=OJ$SpecialCH)


# Q13 Summary
summary(OJ)


# Q14 Read file into R
pisa <- read.csv("~/Desktop/UNITS/ETC 3250/data/PISA-oz.csv", stringsAsFactors=FALSE)


# Q15  Check data
dim(pisa)
colnames(pisa)
str(pisa) 
head(pisa)


# Create a subset 
pisa$ST04Q01=="Male"
?subset

s1 <- subset(pisa,ST04Q01=="Female") # use "==" to make comparison
s2 <- subset(pisa,ST04Q01!="Female")

male <- table(subset(pisa, ST04Q01=="Male")$ST03Q01)/monthdays


# Q22
mynumbers <- 5:12


# Q23
typeof(mynumbers)
is.numeric(mynumbers)
is.vector(mynumbers)
length(mynumbers)


# Q24
mytext <- c("hello", "class")
length(mytext)
mylogic <- c(TRUE, FALSE, TRUE, TRUE)
gender <- factor(c("male", "female", "female", "female", "male"))
levels(gender)
summary(gender)


######################################################################################
# Create data frame and Output it
# write.csv(yourOwnDataFrame,file = "prediction.csv",row.names = FALSE, quote=FALSE)


x1 <- 1:15
x2 <- c(rep(TRUE,10),FALSE,TRUE, FALSE, TRUE, TRUE)
x3 <- c(rep("Female",10),rep("Male",5))
df <- data.frame(ID=x1, Logic=x2, Gender=x3)
View(df)
write.csv(df,file = "Lab1MyData.csv",row.names = FALSE, quote=FALSE) # output data frame
getwd() # check directory to find your output file
Lab1MyData <- read.csv("~/Desktop/Lab1MyData.csv") # try to input it into R

