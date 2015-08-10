# CREDIT SCORES

library(ggplot2)
library(GGally)
library(gridExtra)
library(fpp)

ggpairs(credit[,-(4:5)])

creditlog <- data.frame(score=credit$score, log.savings=log(credit$savings+1), log.income=log(credit$income+1), log.address=log(credit$time.address+1), log.employed=log(credit$time.employed+1), fte=credit$fte,single=credit$single)

ggpairs(creditlog[,1:5])

fit <- lm(score ~ log.savings + log.income + log.address + log.employed, data=creditlog)
summary(fit)


qplot(fitted(fit),creditlog[,"score"], ylab="Score",xlab="Predicted score")

p1 <- qplot(creditlog$log.savings,residuals(fit),xlab="log(savings)")
p2 <- qplot(creditlog$log.income,residuals(fit),xlab="log(income)")
p3 <- qplot(creditlog$log.address,residuals(fit),xlab="log(address)")
p4 <- qplot(creditlog$log.employed,residuals(fit),xlab="log(employed)")
marrangeGrob(list(p1,p2,p3,p4),ncol=2,nrow=2)


qplot(fitted(fit), residuals(fit),
     xlab="Predicted scores", ylab="Residuals")

qplot(residuals(fit),
     xlab="Residuals", main="Histogram of residuals")
