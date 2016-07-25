library(ggplot2)
library(gridExtra)
library(readr)
library(dplyr)

# Reading the data
bds <- read_csv("../data/bds.csv")

system.time(bds <- read_csv("../data/bds.csv"))
system.time(bds <- read.csv("../data/bds.csv"))

# Numerical summaries of all variables
summary(bds)
glimpse(bds)

# Number of observations and variables in the dataset
dim(bds)

# First and last few observations
head(bds)
tail(bds)

bds <- head(bds, 100000)

# Simple plots of each variable
ggplot(data=bds, aes(x=SalePrice)) + geom_histogram(binwidth=1)


# Take logs of SalePrice to reduce skewness
ggplot(data=bds, aes(x=SalePrice)) + geom_histogram(binwidth=.04) +
  scale_x_log10()

ggplot(data=bds, aes(x=YearMade)) + geom_histogram(binwidth=1)

ggplot(data=bds, aes(x=MachineHours)) + geom_histogram(binwidth=10)

ggplot(data=bds, aes(x=MachineHours)) +
  geom_histogram(binwidth=.2) + scale_x_log10()

ggplot(data=bds, aes(x=SaleDate)) + geom_histogram(binwidth=1)

ggplot(data=bds, aes(x=ProductGroup)) + geom_bar()

ggplot(data=bds, aes(x=ProductGroup)) + geom_bar() + coord_flip()

ggplot(data=bds, aes(x=Enclosure)) + geom_bar() + coord_flip()

# Plots of Sale price against each variable

ggplot(data=bds, aes(x=YearMade, y=SalePrice)) + geom_point()
#Add jittering
ggplot(data=bds, aes(x=YearMade, y=SalePrice)) + geom_jitter()

#Add transparency
ggplot(bds, aes(YearMade, SalePrice)) + geom_point(alpha=1/100)
#Plot hexbins
ggplot(bds, aes(YearMade, SalePrice)) + stat_binhex(bins=90)

ggplot(data=bds, aes(x=MachineHours, y=SalePrice)) + geom_point()

ggplot(data=bds, aes(x=MachineHours, y=SalePrice)) + scale_x_log10()

ggplot(data=bds, aes(x=SaleDate, y=SalePrice)) + geom_jitter()

ggplot(data=bds, aes(x=ProductGroup, y=SalePrice)) +
  geom_boxplot() + coord_flip()

ggplot(data=bds, aes(x=Enclosure, y=SalePrice)) + geom_boxplot() + coord_flip()

# Split bds1 data set int training and test sets
nTest <- 50000
testInds <- sample(nrow(bds), nTest)
test <- bds[testInds,]
train <- bds[-testInds,]

View(train)

# Fit regression model
fit = lm(log(SalePrice) ~ log(MachineHours+1) + YearMade + SaleDate + ProductGroup + Enclosure, 
         data = train, na.action=na.exclude)

summary(fit)

train$res <- residuals(fit)
train$fit <- fitted(fit)
ggplot(data=train, aes(x=res)) + geom_histogram(binwidth=.1)

p1 <- ggplot(data=train, aes(x=MachineHours, y=res)) +
  geom_point() + scale_x_log10()

p2 <- ggplot(data=train, aes(x=YearMade, y=res)) + geom_point()
p3 <- ggplot(data=train, aes(x=SaleDate, y=res)) + geom_point()
p4 <- ggplot(data=train, aes(x=ProductGroup, y=res)) + geom_boxplot()
p5 <- ggplot(data=train, aes(x=Enclosure, y=res)) + geom_boxplot()
p6 <- ggplot(data=train, aes(x=fit, y=res)) + geom_point()

marrangeGrob(list(p1,p2,p3,p4,p5,p6), ncol=3, nrow=2, top="Residual plots")


# Prediction
test$fcast <- exp(predict(fit, newdata = test))
errors <- test$fcast-test[,"SalePrice"]
e <- log(test$fcast)-log(test[,"SalePrice"])

ggplot(test, aes(x=fcast, y=e)) + geom_point() + scale_x_log10()

ggplot(data=test, aes(x=SalePrice, y=fcast)) +
  geom_abline(intercept=0, slope=1, col='blue')


# Check for overfitting
# Training data:
mean(train$res^2, na.rm=TRUE)
# Test data:
mean(e^2, na.rm=TRUE)

