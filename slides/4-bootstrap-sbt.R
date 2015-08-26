rm(list = ls())
library(ggplot2)
set.seed(1986)

n <- 10000

# Data generated from normal distribution  
mu <- 4
sigma <- 2
data_normal <- rnorm(n, mean = mu, sd = sigma)
qplot(data_normal) 


b.theta <- function(data, B, s) {
  thetas_hat <- NULL
  for(b in seq(B)){
    bootstrap_sample <- sample(data, replace = T)
    theta_hat <- s(bootstrap_sample)
    thetas_hat <- c(thetas_hat, theta_hat)
  }
  std.err <- sd(thetas_hat)
  list(std.err = std.err, thetas_hat = thetas_hat)
}

#### Better function ####
# b.theta <- function(data, B, s) {
#  bootstrap_samples <- lapply(seq(B), function(i) sample(data, replace=T))
#  thetas_hat <- sapply(bootstrap_samples, s)
#  std.err <- sd(thetas_hat)
# list(std.err = std.err, thetas_hat = thetas_hat)
# }

B <- 100

# Standard errors for sample mean
b.obj <- b.theta(data_normal, B, mean)
boot_std.err <- b.obj$std.err
theo_std.err <- sigma / sqrt(n)
c(theo_std.err, boot_std.err)
qplot(b.obj$thetas_hat) + geom_vline(xintercept = mean(data_normal), col='blue') +
  geom_vline(xintercept = mu, col='red')




# Data generated from a more complex distribution
occurence <- rbinom(n, 1, prob = 0.7) 
intensity <- rgamma(n, shape = 2, scale = 2)
data_complex <- occurence*intensity
qplot(data_complex) 

# Standard errors for sample median
b.obj <- b.theta(data_complex, B, median)
boot_std.err <- b.obj$std.err
print(boot_std.err)
qplot(b.obj$thetas_hat) + geom_vline(xintercept = median(data_complex), col='blue')

