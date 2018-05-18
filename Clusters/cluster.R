exemplo1 <- read.table("D:/Users/25052288840/Downloads/FIA_data_mining/Clusters/exemplo1.csv", header=TRUE, sep=";", na.strings="NA", dec=",", strip.white=TRUE, stringsAsFactors=FALSE)
str(exemplo1)
scatterplot(V2~V1, regLine=FALSE, smooth=FALSE, boxplots=FALSE, xlab="Lealdade à loja", ylab="Lealdade à marca", cex=2.5, 
  data=exemplo1)
dist(exemplo1[2:3], method="euclidean")
HClust.1 <- hclust(dist(model.matrix(~-1 + V1+V2, exemplo1)) , method= "single")
plot(HClust.1, main= "Cluster Dendrogram for Solution HClust.1", xlab= 
  "Observation Number in Data Set exemplo1", 
  sub="Method=single; Distance=euclidian")
dendro1 <- as.dendrogram(HClust.1)
plot(dendro1, main= "Cluster Dendrogram for Solution hc1", xlab= "Observation Number in Data Set exemplo1", sub="Method=single; Distance=euclidian")
rect.hclust(HClust.1, k=3)
summary(as.factor(cutree(HClust.1, k = 2))) # Cluster Sizes
by(model.matrix(~-1 + V1 + V2, exemplo1), as.factor(cutree(HClust.1, k = 2)), 
  colMeans) # Cluster Centroids
biplot(princomp(model.matrix(~-1 + V1 + V2, exemplo1)),xlabs = as.character(cutree(HClust.1, k = 2)))

summary(as.factor(cutree(HClust.1, k = 2))) # Cluster Sizes
by(model.matrix(~-1 + V1 + V2, exemplo1), as.factor(cutree(HClust.1, k = 2)), 
  colMeans) # Cluster Centroids
biplot(princomp(model.matrix(~-1 + V1 + V2, exemplo1)), xlabs = 
  as.character(cutree(HClust.1, k = 2)))
summary(as.factor(cutree(HClust.1, k = 3))) # Cluster Sizes
by(model.matrix(~-1 + V1 + V2, exemplo1), as.factor(cutree(HClust.1, k = 3)), 
  colMeans) # Cluster Centroids
biplot(princomp(model.matrix(~-1 + V1 + V2, exemplo1)), xlabs = 
  as.character(cutree(HClust.1, k = 3)))
exemplo1$cluster1 <- assignCluster(model.matrix(~-1 + V1 + V2, exemplo1), 
  exemplo1, cutree(HClust.1, k = 3))
library(abind, pos=16)
library(e1071, pos=17)
numSummary(exemplo1[,c("Idade", "V1", "V2"), drop=FALSE], 
  groups=exemplo1$cluster1, statistics=c("mean", "sd", "IQR", "quantiles"), 
  quantiles=c(0,.25,.5,.75,1))
Boxplot(Idade~cluster1, data=exemplo1, id=list(method="y"))
library(mvtnorm, pos=18)
library(survival, pos=18)
library(MASS, pos=18)
library(TH.data, pos=18)
library(multcomp, pos=18)
AnovaModel.1 <- aov(Idade ~ cluster1, data=exemplo1)
summary(AnovaModel.1)
with(exemplo1, numSummary(Idade, groups=cluster1, statistics=c("mean", "sd")))
local({
  .Pairs <- glht(AnovaModel.1, linfct = mcp(cluster1 = "Tukey"))
  print(summary(.Pairs)) # pairwise tests
  print(confint(.Pairs)) # confidence intervals
  print(cld(.Pairs)) # compact letter display
  old.oma <- par(oma=c(0,5,0,0))
  plot(confint(.Pairs))
  par(old.oma)
})
oneway.test(Idade ~ cluster1, data=exemplo1) # Welch test
scatterplot(V2~V1, regLine=FALSE, smooth=FALSE, boxplots=FALSE, xlab="Lealdade à loja", ylab="Lealdade à marca", cex=2.5, data=exemplo1)
scatterplot(V2~V1 | cluster1, regLine=FALSE, smooth=FALSE, boxplots=FALSE, xlab="Lealdade à loja", ylab="Lealdade à marca", cex=2.5, by.groups=TRUE, data=exemplo1, col=c('black', 'red', 'blue'))
centroides1<- aggregate(cbind(V1, V2) ~ cluster1, data=exemplo1, FUN=mean)
points(centroides1$V1, centroides1$V2, pch=20)
exemplo2 <- 
  read.table("D:/Users/25052288840/Downloads/FIA_data_mining/Clusters/exemplo2.csv",
   header=TRUE, sep=";", na.strings="NA", dec=",", strip.white=TRUE)
scatterplot(x~y, regLine=FALSE, smooth=FALSE, boxplots=FALSE, cex=2.5, data=exemplo2)
dist(exemplo2[1:2], method="euclidean")

cluster2 <- hclust(dist(model.matrix(~-1 + x+y, exemplo2)) , method= "complete")
plot(cluster2, main= "Cluster Dendrogram for Solution cluster2", xlab= 
  "Observation Number in Data Set exemplo2", 
  sub="Method=complete; Distance=euclidian")
dendro2 <- as.dendrogram(cluster2)
plot(dendro2, main= "Cluster Dendrogram for Solution 2", xlab= "Observation Number in Data Set exemplo2", sub="Method=complete; Distance=euclidian")
rect.hclust(cluster2, k=4)

summary(as.factor(cutree(cluster2, k = 4))) # Cluster Sizes
by(model.matrix(~-1 + x + y, exemplo2), as.factor(cutree(cluster2, k = 4)), 
  colMeans) # Cluster Centroids
biplot(princomp(model.matrix(~-1 + x + y, exemplo2)),xlabs = as.character(cutree(cluster2, k = 4)))

scatterplot(x~y | cluster2, regLine=FALSE, smooth=FALSE, boxplots=FALSE,cex=2.5, by.groups=TRUE, data=exemplo2)


exemplo2$cluster2 <- assignCluster(model.matrix(~-1 + x + y, exemplo2), exemplo2, cutree(cluster2, k = 4))

centroides2<- aggregate(cbind(x, y) ~ cluster2, data=exemplo2, FUN=mean)
points(centroides2$x, centroides2$y)

centroides2


scatterplot(y~x, regLine=FALSE, smooth=FALSE, boxplots=FALSE, 
  ellipse=list(levels=c(.5, .9)), data=exemplo2)
scatterplot(y~x, regLine=FALSE, smooth=FALSE, boxplots=FALSE, 
  ellipse=list(levels=c(.5, .9)), data=exemplo2)
scatterplot(y~x | cluster2, regLine=FALSE, smooth=FALSE, boxplots=FALSE, 
  ellipse=list(levels=c(.5, .9)), by.groups=TRUE, data=exemplo2)
exemplo3 <- 
  read.table("D:/Users/25052288840/Downloads/FIA_data_mining/Clusters/exemplo3.csv",
   header=TRUE, sep=",", na.strings="NA", dec=",", strip.white=TRUE)
exemplo3 <- 
  read.table("D:/Users/25052288840/Downloads/FIA_data_mining/Clusters/exemplo3.csv",
   header=TRUE, sep="", na.strings="NA", dec=".", strip.white=TRUE)
exemplo3 <- 
  read.table("D:/Users/25052288840/Downloads/FIA_data_mining/Clusters/exemplo3.csv",
   header=TRUE, sep=",", na.strings="NA", dec=",", strip.white=TRUE)
scatterplot(y~x, regLine=FALSE, smooth=FALSE, boxplots=FALSE, cex=2, 
  data=exemplo3)


cluster3 <- hclust(dist(model.matrix(~-1 + x+y, exemplo3)) , method= "complete")
plot(cluster3, main= "Cluster Dendrogram for Solution cluster3", xlab= 
  "Observation Number in Data Set exemplo3", 
  sub="Method=complete; Distance=euclidian")
dendro3 <- as.dendrogram(cluster3)
plot(dendro3, main= "Cluster Dendrogram for Solution 3", xlab= "Observation Number in Data Set exemplo3", sub="Method=complete; Distance=euclidian")
rect.hclust(cluster3, k=9)

summary(as.factor(cutree(cluster3, k = 9))) # Cluster Sizes
by(model.matrix(~-1 + x + y, exemplo3), as.factor(cutree(cluster3, k = 9)), colMeans) # Cluster Centroids
exemplo3$cluster3 <- assignCluster(model.matrix(~-1 + x + y, exemplo3), exemplo3, cutree(cluster3, k = 9))

scatterplot(y~x, regLine=FALSE, smooth=FALSE, boxplots=FALSE, cex=2, 
  data=exemplo3)
scatterplot(y~x | cluster3, regLine=FALSE, smooth=FALSE, boxplots=FALSE, 
  ellipse=list(levels=c(.5, .9)), by.groups=TRUE, data=exemplo3)


summary(as.factor(cutree(cluster3, k = 9))) # Cluster Sizes
by(model.matrix(~-1 + x + y, exemplo3), as.factor(cutree(cluster3, k = 9)), 
  colMeans) # Cluster Centroids
biplot(princomp(model.matrix(~-1 + x + y, exemplo3)), xlabs = 
  as.character(cutree(cluster3, k = 9)))


scatterplot(y~x | cluster3, regLine=FALSE, smooth=FALSE, boxplots=FALSE, 
  by.groups=TRUE, data=exemplo3)

