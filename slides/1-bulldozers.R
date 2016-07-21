library(ggplot2)
library(gridExtra)

# Reading the data
bds <- read.csv("../data/bds.csv")

# Numerical summaries of all variables
summary(bds)

# Number of observations and variables in the dataset
dim(bds)

# First and last few observations
head(bds)
tail(bds)

# Simple plots of each variable
qplot(SalePrice, data=bds, binwidth=1)
# Take logs of SalePrice to reduce skewness
qplot(log(SalePrice), data=bds, binwidth=.04)

qplot(YearMade, data=bds, binwidth=1)

qplot(MachineHours, data=bds, binwidth=10)
qplot(log(MachineHours), data=subset(bds, MachineHours>0), binwidth=.2)

qplot(SaleDate, data=bds, binwidth=1)

qplot(ProductGroup, data=bds)

qplot(ProductGroup, data=bds) + coord_flip()

qplot(Enclosure, data=bds) + coord_flip()

# Plots of Sale price against each variable

qplot(YearMade, SalePrice, data=bds)
#Add jittering
qplot(YearMade, SalePrice, data=bds, position="jitter") # position is deprecated

#Add transparency
ggplot(bds, aes(YearMade, SalePrice)) + geom_point(alpha=1/100)
#Plot hexbins
ggplot(bds, aes(YearMade, SalePrice)) + stat_binhex(bins=90)

qplot(MachineHours, SalePrice, data=bds)
qplot(log(MachineHours), SalePrice, data=subset(bds, MachineHours>0))

qplot(SaleDate, SalePrice, data=bds, position="jitter")

qplot(ProductGroup, SalePrice, data=bds, geom="boxplot") + coord_flip()

qplot(Enclosure, SalePrice, data=bds, geom="boxplot") + coord_flip()

# Split bds1 data set int training and test sets
nTest <- 50000
testInds <- sample(nrow(bds), nTest)
test <- bds[testInds,]
train <- bds[-testInds,]

View(train)

# Fit regression model
fit = lm(log(SalePrice) ~ log(MachineHours+1) +
    YearMade + SaleDate + ProductGroup + Enclosure ,
  data = train, na.action=na.exclude)

summary(fit)

train$res <- residuals(fit)
qplot(train$res, binwidth=.1)

p1 <- qplot(log(MachineHours+1), res, data=train)
p2 <- qplot(YearMade, res, data=train)
p3 <- qplot(SaleDate, res, data=train)
p4 <- qplot(ProductGroup, res, data=train, geom='boxplot')
p5 <- qplot(Enclosure, res, data=train, geom="boxplot")
p6 <- qplot(fitted(fit), res, data=train)

marrangeGrob(list(p1,p2,p3,p4,p5,p6), ncol=3, nrow=2, top="Residual plots")


# Prediction
fcast <- exp(predict(fit, newdata = test))
errors <- fcast-test[,"SalePrice"]
e <- log(fcast)-log(test[,"SalePrice"])

qplot(log(fcast), e)

qplot(SalePrice, fcast, data=test) + geom_abline(intercept=0, slope=1, col='blue')


# Check for overfitting
# Training data:
mean(res^2, na.rm=TRUE)
# Test data:
mean(e^2, na.rm=TRUE)

