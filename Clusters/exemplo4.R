
exemplo4 <- read.table("D:/Users/25052288840/Downloads/FIA_data_mining/Clusters/exemplo4.csv", 
  header=TRUE, sep=";", na.strings="NA", dec=",", strip.white=TRUE)
exemplo4 <- 
  read.table("D:/Users/25052288840/Downloads/FIA_data_mining/Clusters/exemplo4.csv", 
  header=TRUE, sep=";", na.strings="NA", dec=".", strip.white=TRUE)
scatterplotMatrix(~X1+X2+X3+X4+X5, reg.line=FALSE, smooth=FALSE, spread=FALSE, span=0.5,
   ellipse=FALSE, levels=c(.5, .9), id.n=0, diagonal = 'boxplot', data=exemplo4)
dist(exemplo4[2:6])
cluster4 <- hclust(dist(model.matrix(~-1 + X1+X2+X3+X4+X5, exemplo4)) , method= 
  "single")
plot(cluster4, main= "Cluster Dendrogram for Solution cluster4", xlab= 
  "Observation Number in Data Set exemplo4", sub="Method=single; Distance=euclidian")
summary(as.factor(cutree(cluster4, k = 2))) # Cluster Sizes
by(model.matrix(~-1 + X1 + X2 + X3 + X4 + X5, exemplo4), as.factor(cutree(cluster4, k = 
  2)), colMeans) # Cluster Centroids
biplot(princomp(model.matrix(~-1 + X1 + X2 + X3 + X4 + X5, exemplo4)), xlabs = 
  as.character(cutree(cluster4, k = 2)))
local({
  .PC <- princomp(~X1+X2+X3+X4+X5, cor=TRUE, data=exemplo4)
  cat("\nComponent loadings:\n")
  print(unclass(loadings(.PC)))
  cat("\nComponent variances:\n")
  print(.PC$sd^2)
  cat("\n")
  print(summary(.PC))
})

local({
  .PC <- princomp(~X1+X2+X3+X4+X5, cor=TRUE, data=exemplo4)
  cat("\nComponent loadings:\n")
  print(unclass(loadings(.PC)))
  cat("\nComponent variances:\n")
  print(.PC$sd^2)
  cat("\n")
  print(summary(.PC))
  screeplot(.PC)
  exemplo4 <<- within(exemplo4, {
    PC3 <- .PC$scores[,3]
    PC2 <- .PC$scores[,2]
    PC1 <- .PC$scores[,1]
  })
})
library(rgl, pos=16)
library(nlme, pos=17)
library(mgcv, pos=17)
scatter3d(PC1~X1+X2, data=exemplo4, surface=FALSE, residuals=TRUE, 
  bg="white", axis.scales=TRUE, grid=TRUE, ellipsoid=FALSE)
scatter3d(PC2~X3+X4, data=exemplo4, surface=FALSE, residuals=TRUE, 
  bg="white", axis.scales=TRUE, grid=TRUE, ellipsoid=FALSE)
scatter3d(PC1~X4+X5, data=exemplo4, surface=FALSE, residuals=TRUE, 
  bg="white", axis.scales=TRUE, grid=TRUE, ellipsoid=FALSE)
HClust.2 <- hclust(dist(model.matrix(~-1 + PC1+PC2+PC3, exemplo4)) , 
  method= "average")
plot(HClust.2, main= "Cluster Dendrogram for Solution HClust.2", xlab= 
  "Observation Number in Data Set exemplo4", 
  sub="Method=average; Distance=euclidian")
HClust.3 <- hclust(dist(model.matrix(~-1 + PC1+PC2+PC3, exemplo4), method= 
  "manhattan") , method= "average")
plot(HClust.3, main= "Cluster Dendrogram for Solution HClust.3", xlab= 
  "Observation Number in Data Set exemplo4", 
  sub="Method=average; Distance=city-block")
HClust.4 <- hclust(dist(model.matrix(~-1 + PC1+PC2+PC3, exemplo4))^2 , 
  method= "median")
plot(HClust.4, main= "Cluster Dendrogram for Solution HClust.4", xlab= 
  "Observation Number in Data Set exemplo4", 
  sub="Method=median; Distance=squared-euclidian")
exemplo4 <- local({
  .Z <- scale(exemplo4[,c("X1","X2","X3","X4","X5")])
  within(exemplo4, {
    Z.X5 <- .Z[,5]
    Z.X4 <- .Z[,4]
    Z.X3 <- .Z[,3]
    Z.X2 <- .Z[,2]
    Z.X1 <- .Z[,1] 
  })
})
HClust.5 <- hclust(dist(model.matrix(~-1 + Z.X1+Z.X2+Z.X3+Z.X4+Z.X5, 
  exemplo4)) , method= "single")
plot(HClust.5, main= "Cluster Dendrogram for Solution HClust.5", xlab= 
  "Observation Number in Data Set exemplo4", 
  sub="Method=single; Distance=euclidian")
HClust.6 <- hclust(dist(model.matrix(~-1 + Z.X1+Z.X2+Z.X3+Z.X4+Z.X5, 
  exemplo4)) , method= "single")
plot(HClust.6, main= "Cluster Dendrogram for Solution HClust.6", xlab= 
  "Observation Number in Data Set exemplo4", 
  sub="Method=single; Distance=euclidian")
HClust.7 <- hclust(dist(model.matrix(~-1 + Z.X1+Z.X2+Z.X3+Z.X4+Z.X5, 
  exemplo4)) , method= "complete")
plot(HClust.7, main= "Cluster Dendrogram for Solution HClust.7", xlab= 
  "Observation Number in Data Set exemplo4", 
  sub="Method=complete; Distance=euclidian")

