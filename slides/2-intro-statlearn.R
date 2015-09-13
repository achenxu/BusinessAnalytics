rm(list = ls())
library(MASS)
source("nicefigs.R")


savepdf("../figures/statlearn", width=16,height=11 * 0.5)
par(mfrow = c(1, 3))

x <- seq(10, 22, by = 0.1)
y <- 2*x + rnorm(x, sd = 4)

plot(x,y, xlab = expression(X[1]), ylab = "Y")




N <- 100
mu_1 <- c(-2, 0.5)
Sigma_1 <- matrix(c(.2,0,0,.02),2,2)
x1 <- mvrnorm(n = N, mu = mu_1, Sigma_1)

mu_2 <- c(0.25, 1)
Sigma_2 <- matrix(c(.15,0,0,.01),2,2)
x2 <- mvrnorm(n = N, mu = mu_2, Sigma_2)

mu_3 <- c(2, 0.35)
Sigma_3 <- matrix(c(.2,0,0,.02),2,2)
x3 <- mvrnorm(n = N, mu = mu_3, Sigma_3)

plot(rbind(x1, x2, x3), xlab = expression(X[1]), ylab = expression(X[2]), col = rep(c("red", "green", "blue"), each = N))


plot(rbind(x1, x2, x3), xlab = expression(X[1]), ylab = expression(X[2]))


dev.off()