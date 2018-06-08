# Testar significância estatística 
# Pg. 69 - Apostila

exemplo5 <- read.table("D:/Users/25052288840/Downloads/exemplo5_aula2.csv", header=TRUE, sep=";", 
  na.strings="NA", dec=",", strip.white=TRUE)
HClust.1 <- hclust(dist(model.matrix(~-1 + x1+x2+x3+x4+x5+x6+x7, exemplo5)) , method= 
  "ward")
plot(HClust.1, main= "Cluster Dendrogram for Solution HClust.1", xlab= 
  "Observation Number in Data Set exemplo5", sub="Method=ward; Distance=euclidian")
summary(as.factor(cutree(HClust.1, k = 2))) # Cluster Sizes
by(model.matrix(~-1 + x1 + x2 + x3 + x4 + x5 + x6 + x7, exemplo5), 
  as.factor(cutree(HClust.1, k = 2)), colMeans) # Cluster Centroids
biplot(princomp(model.matrix(~-1 + x1 + x2 + x3 + x4 + x5 + x6 + x7, exemplo5)), xlabs 
  = as.character(cutree(HClust.1, k = 2)))
summary(as.factor(cutree(HClust.1, k = 4))) # Cluster Sizes
by(model.matrix(~-1 + x1 + x2 + x3 + x4 + x5 + x6 + x7, exemplo5), 
  as.factor(cutree(HClust.1, k = 4)), colMeans) # Cluster Centroids
biplot(princomp(model.matrix(~-1 + x1 + x2 + x3 + x4 + x5 + x6 + x7, exemplo5)), xlabs 
  = as.character(cutree(HClust.1, k = 4)))
exemplo5$hclus.label2 <- assignCluster(model.matrix(~-1 + x1 + x2 + x3 + x4 + x5 + x6 + x7, exemplo5), exemplo5, cutree(HClust.1, k = 2))
Boxplot(exemplo5[exemplo5$hclus.label2==1, 1:7], main="Cluster1")
windows()
Boxplot(exemplo5[exemplo5$hclus.label2==2, 1:7], main="Cluster2")
clusplot(exemplo5[1:7], cutree(hc5_ward, k=2))

library(mvtnorm, pos=16)
library(survival, pos=16)
library(MASS, pos=16)
library(TH.data, pos=16)
library(multcomp, pos=16)
library(abind, pos=21)
AnovaModel.1 <- aov(x1 ~ hclus.label2, data=exemplo5)
summary(AnovaModel.1)
with(exemplo5, numSummary(x1, groups=hclus.label2, statistics=c("mean", "sd")))

