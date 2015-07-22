# Adjust graphics to allow horizontal barcharts and boxplots
par(mar=c(4,9,2,1))

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
hist(bds[,"SalePrice"], breaks="FD")

hist(bds[,"YearMade"], breaks="FD")

hist(bds[,"MachineHours"], breaks="FD")
j <- (bds[,"MachineHours"] > 0)
hist(log(bds[j,"MachineHours"]), breaks="FD")

hist(bds[,"SaleDate"])

plot(~ProductGroup, horiz=TRUE, las=1, data=bds)

plot(~Enclosure, horiz=TRUE, las=1, data=bds)

# Plots of Sale price against each variable

plot(SalePrice ~ YearMade, data=bds, pch=".")
#Add jittering
plot(SalePrice ~ jitter(YearMade), data=bds, pch=".")

plot(SalePrice ~ MachineHours, data=bds, pch=".")
plot(SalePrice ~ log(MachineHours), data=bds[j,], pch=".")

plot(SalePrice ~ jitter(SaleDate), data=bds, pch=".")

plot(SalePrice ~ ProductGroup, data=bds,
     horizontal=TRUE, las=1, xlab="")

plot(SalePrice ~ Enclosure, data=bds,
     horizontal=TRUE, las=1, xlab="")

# Take logs of SalePrice to reduce skewness
hist(log(bds[,"SalePrice"]))

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

res <- residuals(fit)
hist(res)

par(mfrow=c(2,3))
plot(res ~ log(MachineHours+1), pch=".", data=train)
plot(res ~ YearMade, pch=".", data=train)
plot(res ~ SaleDate, pch=".", data=train)
plot(res ~ ProductGroup, pch=".", data=train)
plot(res ~ Enclosure, pch=".", data=train)
plot(res ~ fitted(fit), pch=".", data=train)


# Prediction
fcast <- exp(predict(fit, newdata = test))
errors <- fcast-test[,"SalePrice"]
e <- log(fcast)-log(test[,"SalePrice"])

plot(log(fcast),e,pch=".")
abline(h=0)

plot(test[,"SalePrice"],fcast,pch=".")
abline(0,1)

# Check for overfitting
# Training data:
mean(res^2, na.rm=TRUE)
# Test data:
mean(e^2, na.rm=TRUE)

