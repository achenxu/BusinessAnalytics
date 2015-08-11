library(ISLR)
library(splines)

fit <- lm(wage ~ ns(year,df=5) + ns(age,df=5) + education, data=Wage)

fit2 <- lm(wage ~ year + ns(age,df=5) + education, data=Wage)

anova(fit,fit2)

library(gam)
plot.gam(fit2)

library(ggplot2)
qplot(age, wage, data = Wage) + geom_smooth()

qplot(age, wage, data = Wage) + geom_smooth() + facet_wrap(~ education)

qplot(age, wage, data = Wage) + geom_smooth() + facet_wrap(~ year)

qplot(age, wage, data = Wage) + geom_smooth() + facet_wrap(~ education + year)



