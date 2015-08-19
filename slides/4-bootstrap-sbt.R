rm(list = ls())
library(ggplot2)
set.seed(1986)

b.theta <- function(data, B, s = mean) {
  bootstrap_samples <- lapply(1:B, function(i) sample(data, replace=T))
  thetas <- sapply(bootstrap_samples, s)
  std.err <- sd(thetas)
  list(bootstrap_samples = bootstrap_samples, thetas = thetas, std.err = std.err)   
}

n <- 10000
B <- 100

# Normal distribution 
mu <- 4
sigma <- 2
data <- rnorm(n, mean = mu, sd = sigma)
qplot(data) 

b.obj <- b.theta(data, B)
boot_std.err <- b.obj$std.err
theo_std.err <- sigma / sqrt(n)
print(paste(theo_std.err, " - ", boot_std.err, sep = ""))

qplot(b.obj$thetas) + geom_vline(xintercept = mean(data), col='blue') +
  geom_vline(xintercept = mu, col='red')


# More complex distribution
occurence <- rbinom(n, 1, prob = 0.7) 
intensity <- rgamma(n, shape = 2, scale = 2)
data <- occurence*intensity
qplot(data) 

b.obj <- b.theta(data, B, median)
boot_std.err <- b.obj$std.err
print(boot_std.err)

qplot(b.obj$thetas) + geom_vline(xintercept = median(data), col='blue')

