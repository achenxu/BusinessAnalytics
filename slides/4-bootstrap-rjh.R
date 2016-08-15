#Expected shortfall (Conditional value at risk): 5%
#Data is Yahoo closing prices from 12 April 1996 to 2 June 2015

yahooclose <- ts(rev(read.csv("../data/yahoo.csv",stringsAsFactors = FALSE)[,4]), start=c(1996,69), freq=252)
plot(yahooclose, ylab="Yahoo Closing Price")

# Calculate log returns
x <- diff(log(yahooclose))
plot(x, ylab="Yahoo Log Return")

# Compute 5th percentile of log returns
q5 <- quantile(x, 0.05)
abline(h=q5, col='blue')

# Compute expected shortfall at 5%
es5 <- mean(x[x <q5 ])

# Bootstrap samples
nb <- 1000
es5b <- numeric(nb)
for(i in 1:nb)
{
  xstar <- sample(x, replace=TRUE)
  q5 <- quantile(xstar, 0.05)
  es5b[i] <- mean(xstar[xstar < q5])
}

#Bootstrap distribution
library(ggplot2)
qplot(es5b, binwidth=0.002) + geom_vline(xintercept=es5, col='blue')
#Confidence interval:
quantile(es5b, prob=c(0.05, 0.975))


########################################################
# When bootstrap fails
########################################################

# Correlation between consecutive returns
n <- length(x)
acf1 <- cor(x[1:(n-1)],x[2:n])

# Bootstrap samples
nb <- 1000
acfb <- numeric(nb)
for(i in 1:nb)
{
  xstar <- sample(x, replace=TRUE)
  acfb[i] <- cor(xstar[1:(n-1)],xstar[2:n])
}

#Bootstrap distribution
library(ggplot2)
qplot(acfb, binwidth=0.002) + geom_vline(xintercept=acf1, col='blue')
#Confidence interval:
quantile(acfb, prob=c(0.05, 0.975))

