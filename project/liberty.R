liberty <- read.csv("project/liberty_train.csv")
dim(liberty)
liberty[1,]

table(liberty$Hazard) # Very skewed response variable, AND NO ZEROs

length(table(liberty$Id)) # Unique IDs

library(ggplot2)
qplot(T1_V17, Hazard, data=liberty, geom=c("point", "smooth"), method="lm")
qplot(T2_V15, Hazard, data=liberty, geom=c("point", "smooth"), method="lm")

library(randomForest)
liberty.rf <- randomForest(Hazard~., data=liberty, ntree=5)

library(rpart)
liberty.rp <- rpart(Hazard~., data=liberty)
