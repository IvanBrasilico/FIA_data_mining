
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

