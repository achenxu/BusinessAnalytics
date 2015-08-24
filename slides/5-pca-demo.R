library(GGally)
library(ggplot2)
library(ggbiplot) #only on github


men <- read.csv("../data/trackrecords.txt")
rownames(men) <- men[,1]
men <- men[,-1]
summary(men)


ggscatmat(men)

# Compute PCs using built-in function
z <- prcomp(men, scale=TRUE)

#Compute via covariance:
X <- scale(men)
C <- t(X) %*% X
z1 <- eigen(C)
pc.cv <- X %*% z1$vectors

# Compute via svd
z2 <- svd(X)
pc.svd <- X %*% z2$v

qplot(PC1,PC2,data=as.data.frame(z$x))

qplot(PC1,PC2,data=as.data.frame(z$x)) +
  geom_text(label=rownames(men), col='blue',
            hjust=.5, vjust=1.5, size=3)

summary(z)
ggscreeplot(z)
ggbiplot(z)


## EXAMPLE 2
library(ISLR)
summary(USArrests)

ggscatmat(USArrests)
z <- prcomp(USArrests, scale=TRUE)
summary(z)
z
qplot(PC1,PC2, data=as.data.frame(z$x))
qplot(PC1,PC2,data=as.data.frame(z$x)) +
  geom_text(label=rownames(USArrests), col='blue',
            hjust=.5, vjust=1.5, size=3)

ggscreeplot(z)
ggbiplot(z)
