library(ISLR)
library(splines)

fit <- lm(wage ~ ns(year,df=5) + ns(age,df=5) + education, data=Wage)

fit2 <- lm(wage ~ year + ns(age,df=5) + education, data=Wage)

anova(fit,fit2)

library(gam)
plot.gam(fit2)

library(ggplot2)
qplot(age, wage, data = Wage) + 
  geom_smooth()

qplot(age, wage, data = Wage) + geom_smooth() + facet_wrap(~ education)

qplot(age, wage, data = Wage) + geom_smooth() + facet_wrap(~ year)


# Conditioning with a numerical variable

qplot(horsepower, mpg, data=Auto) + geom_smooth()

qplot(horsepower, mpg, data=Auto) + geom_smooth() + facet_wrap(~ cylinders)

Auto$cut <- cut(Auto$year, breaks=3)
qplot(horsepower, mpg, data=Auto) + geom_smooth() + facet_wrap(~ cut)

Auto$cut <- cut(Auto$displacement, breaks=3)
qplot(horsepower, mpg, data=Auto) + geom_smooth() + facet_wrap(~ cut)

Auto$cut <- cut(Auto$weight, breaks=3)
qplot(horsepower, mpg, data=Auto) + geom_smooth() + facet_wrap(~ cut)

Auto$cut <- cut(Auto$acceleration, breaks=3)
qplot(horsepower, mpg, data=Auto) + geom_smooth() + facet_wrap(~ cut)

