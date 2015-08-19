
# Standard error of the sample mean (with normality assumption)
# Standard error of the sample mean (WITHOUT normality assumption)

n <- 1000
mymean <- 4
mysd <- 2
myx <- rnorm(n, mean = mymean, sd = mysd)

B <- 100
allu <- numeric(B)
for(b in seq(B)) {
  x <- sample(myx, size = n, replace = TRUE) 
  allu[b] <- mean(x)
}

se_bootstrap <- sd(allu)
se_theo <- mysd / sqrt(n)

print(paste(se_bootstrap, " - ", se_theo, sep = ""))

library(ggplot2)
qplot(allu) + geom_vline(xintercept=mean(myx), col='blue') +
  geom_vline(xintercept=mymean, col='red')

# Standard error of the sample median (with normality assumption)

# Standard error of the sample median (WITHOUT normality assumption)



store <- rep(NA, 100000)
for(i in seq(100000)){
  store[i] <- sum(sample(1:100, replace = TRUE) == 4) >0
}
print(mean(store))
