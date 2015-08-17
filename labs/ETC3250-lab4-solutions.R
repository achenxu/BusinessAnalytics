CV <- function(object)
{
  cv <- mean((residuals(object)/(1 - hatvalues(object)))^2, na.rm = TRUE)
  return(cv)
}

myCV <- function(formula, data)
{
  n <- nrow(data)
  e <- numeric(n)
  responsevar <- as.character(formula(fit))[2]
  for(i in 1:n)
  {
    fit <- lm(formula, data=data[-i,])
    pred <- predict(fit, newdata=data[i,])
    e[i] <- data[i,responsevar] - pred
  }
  return(mean(e^2))
}



kCV <- function(formula, data, k=nrow(data))
{
  # Number of rows
  n <- nrow(data)
  # Shuffle data
  data <- data[sample(1:n),]
  e <- numeric(n)
  responsevar <- as.character(formula(fit))[2]
  # Set up folds. p=fold size
  if(k < 2 | k > n)
    stop("Invalid fold size")
  p <- trunc(n/k)
  for(i in 1:k)
  {
    fold <- (1:p)+(i-1)*p
    fit <- lm(formula, data=data[-fold,])
    pred <- predict(fit, newdata=data[fold,])
    e[fold] <- data[fold,responsevar] - pred
  }
  return(mean(e^2))
}


library(MASS)
fit <- lm(medv ~ zn + crim + nox, data=Boston)
CV(fit)
myCV(medv ~ zn + crim + nox, data=Boston)

kCV(medv ~ zn + crim + nox, data=Boston, k=nrow(Boston))
