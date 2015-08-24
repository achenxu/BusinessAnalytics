# Lab 5

library(MASS)

n <- nrow(Boston)
r <- cor(Boston$medv, Boston$rm)

# Fisher interval
cor.test(Boston$medv, Boston$rm)

z <- 0.5*log((1+r)/(1-r))
zint <- z + 1.96/sqrt(n-3)*c(-1,1)
rint <- (exp(2*zint)-1)/(exp(2*zint)+1)

# Bootstrap interval
B <- 1000
rb <- numeric(B)
for(i in 1:B)
{
  bootstrapdata <- Boston[sample(n, replace=TRUE),]
  rb[i] <- cor(bootstrapdata$medv, bootstrapdata$rm)
}
quantile(rb, prob=c(0.025,0.975))

# Function
bootstrap.cor.int <- function(x, y, level=0.95, B=1000)
{
  n <- length(x)
  rb <- numeric(B)
  for(i in 1:B)
  {
    j <- sample(n, replace=TRUE)
    rb[i] <- cor(x[j],y[j])
  }
  alpha = 1-level
  return(quantile(rb, prob=c(alpha/2, 1-alpha/2)))
}

bootstrap.cor.int(Boston$medv,Boston$rm,B=10000)

