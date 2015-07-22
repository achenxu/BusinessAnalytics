library(ISLR)

summary(Wage)

str(Wage)

plot(Wage)

plot(wage ~ age, data=Wage)
scatter.smooth(Wage$age, Wage$wage, pch=19, col='gray', cex=0.5)

plot(wage ~ year, data=Wage)
boxplot(wage ~ year, data=Wage)

plot(wage ~ education, data=Wage)

plot(wage ~ jobclass, data=Wage)

fit <- lm(wage ~ year + age + education + race + jobclass, data=Wage)
summary(fit)


