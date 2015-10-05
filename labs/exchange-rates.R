# ----------------------------
# Get updates
library(lubridate)
library(jsonlite)

# Read in what we have already
rates <- read.csv("data/rates.csv", stringsAsFactors = F)
rates[,1:10]
rates$date <- as.Date(rates$date)

# Look at exchange rates
library(ggplot2)
library(reshape2)
qplot(date, AUD, data=rates, geom="line")
qplot(AUD, NZD, data=rates) + theme(aspect.ratio=1)
r.m <- melt(rates[,c("date","AUD","NZD")], id="date")
r.m$date <- as.Date(r.m$date)
qplot(date, value, data=r.m, geom="line", group=variable, colour=variable, ylab="Rate", xlab="") + 
  theme(legend.position="bottom")
cor(rates$AUD, rates$NZD)

# get individual dates, in a batch
ru <- NULL
dt <- as.Date("2015-09-30")
for (i in 1:6) {
  cat(i,"\n")
  url <- paste("http://openexchangerates.org/api/historical/",dt,".json?app_id=a7586d03ef2049c4a13a12a01c709468", sep="")
  x <- fromJSON(url)
  x <- x$rates
  if (length(x) == 171) 
    x <- x[-c(164,166)]
  ru <- rbind(ru, data.frame(date=dt, x))
  dt <- dt + days(1)
}
rownames(ru) <- ru$date

rates <- rbind(rates, ru)
rates[,1:10]

# get individual dates, after missing some
x <- fromJSON("http://openexchangerates.org/api/historical/2015-09-02.json?app_id=a7586d03ef2049c4a13a12a01c709468")
x <- x$rates
x <- x[-c(164,166)]
rates <- rbind(rates, data.frame(date="2015-09-02", x))
rownames(rates) <- rates$date
rates[,1:10]

# Get today and add
x <- fromJSON("http://openexchangerates.org/api/latest.json?app_id=a7586d03ef2049c4a13a12a01c709468")$rates
x <- x[-c(164,166)]
rates <- rbind(rates, data.frame(date=as.character(today()), x))
rownames(rates)[218] <- as.character(today())
rates[,1:10]
write.csv(rates, file="/Users/dicook/Monash.business/BusinessAnalyticsCourse/data/rates.csv",row.names=FALSE, quote=FALSE)

# PCA
r_s <- rates[,c("AUD", "NZD", "GBP", "EUR","CNY","JPY","ZAR")]
rownames(r_s) <- rates$date
r_pca <- prcomp(r_s, scale=TRUE)
r_pca
plot(r_pca, type="l")

r_s_s <- data.frame(apply(r_s, 2, scale))
r_s_s$date <- rownames(r_s)
r_m <- melt(r_s_s, id="date")
r_m$date <- as.Date(r_m$date)
qplot(date, value, data=r_m, geom="line", group=variable, colour=variable, ylab="Rate", xlab="") + 
  theme(legend.position="bottom")

library(GGally)
ggscatmat(r_s)

# Write the series and the PCs
r_p <- data.frame(r_s, r_pca$x)
write.csv(r_p, file="rates-pca.csv", quote=F)

# Check the autocorrelation

# Functional PCA
library(fda)
