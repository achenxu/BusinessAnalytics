library(ISLR)
library(ggplot2)

summary(Wage)

str(Wage)

qplot(age, wage, data=Wage)

qplot(age, wage, data=Wage) + geom_smooth()

qplot(year, wage, data=Wage)

Wage$Year <- as.factor(Wage$year)
qplot(Year, wage, data=Wage, geom="boxplot")
#Add some nice colors
qplot(Year, wage, data=Wage, geom="boxplot", fill=Year) + guides(fill=FALSE)

qplot(age, wage, data=Wage, col=Year)

qplot(race, wage, data=Wage, geom="boxplot")

qplot(education, wage, data=Wage, geom="boxplot")

qplot(education, wage, data=Wage, geom="boxplot", fill=Year)

qplot(jobclass, wage, data=Wage, geom="boxplot")
qplot(Year, wage, data=Wage, geom="boxplot", fill=jobclass)

fit <- lm(wage ~ year + age + education + race + jobclass, data=Wage)

summary(fit)


