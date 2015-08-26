library(readr)

spl <- read_csv("project/springleaf_train.csv")
dim(spl)
spl[1,]
table(spl$target)

# Ok, bad, missings I think are coded as all sorts of things
# NA but also 99999#