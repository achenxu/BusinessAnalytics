library(GGally)
library(ggplot2)
library(ggbiplot)
source("../slides/nicefigs.R")


men <- read.csv("trackrecords.txt")
rownames(men) <- men[,1]
men <- men[,-1]
summary(men)

savepdf("../figures/trackpairs",width=30,height=20)
ggpairs(men)
endpdf()

z <- prcomp(men, scale=TRUE)
z


savepdf("../figures/track1")
qplot(PC1,PC2,data=as.data.frame(z$x))
endpdf()

savepdf("../figures/track2")
qplot(PC1,PC2,data=as.data.frame(z$x)) +
  geom_text(label=rownames(men), hjust=.5, vjust=1.5, size=2,
            col="blue")
endpdf()

savepdf("../figures/trackscree")
ggscreeplot(z)
endpdf()

savepdf("../figures/trackbiplot")
ggbiplot(z)
endpdf()

