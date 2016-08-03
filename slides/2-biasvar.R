library(ggplot2)
library(splines)

trainx <- runif(100,1,100)
trainy <- trainx/50 + sin(trainx/5) + rnorm(100)
train <- data.frame(x=trainx,y=trainy)

testx <- runif(10000,1,100)
testy <- testx/50 + sin(testx/5) + rnorm(10000)
test <- data.frame(x=testx, y=testy)

p <- qplot(x, y, data=train) +
  geom_line(aes(x, x/50 + sin(x/5)), data=train,
            col='red', size=2)

p

fit <- lm(y ~ ns(x, df=12), data=train)
p + geom_line(aes(x, y), data=data.frame(x=trainx, y=fitted(fit)),
              col='blue')


# MSE on training and test sets
trainingMSE <- testMSE <- numeric(50)
for(i in 1:50)
{
  fit <- lm(y ~ ns(x, df=i), data=train)
  trainingMSE[i] <- mean((train$y - fitted(fit))^2)
  testMSE[i] <- mean((test$y - predict(fit,newdata=test))^2)
}

qplot(degree, trainingMSE, geom="line",
     data=data.frame(degree=1:50, trainingMSE, testMSE)) +
  geom_line(aes(degree, testMSE), col='blue')
