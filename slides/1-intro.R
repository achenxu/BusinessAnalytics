library(ISLR)
library(ggplot2)

summary(Wage)

str(Wage)

ggplot(age, wage, data=Wage)

ggplot(age, wage, data=Wage) + geom_smooth()

ggplot(year, wage, data=Wage)

Wage$Year <- as.factor(Wage$year)
ggplot(Year, wage, data=Wage, geom="boxplot")
#Add some nice colors
ggplot(Year, wage, data=Wage, geom="boxplot", fill=Year) + guides(fill=FALSE)

ggplot(age, wage, data=Wage, col=Year)

ggplot(race, wage, data=Wage, geom="boxplot")

ggplot(education, wage, data=Wage, geom="boxplot")

ggplot(education, wage, data=Wage, geom="boxplot", fill=Year)

ggplot(jobclass, wage, data=Wage, geom="boxplot")
ggplot(Year, wage, data=Wage, geom="boxplot", fill=jobclass)

fit <- lm(wage ~ year + age + education + race + jobclass, data=Wage)

summary(fit)


