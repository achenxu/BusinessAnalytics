library(ISLR)
library(ggplot2)
summary(USArrests)

z <- prcomp(USArrests)
summary(z)