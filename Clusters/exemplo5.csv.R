
exemplo5 <- read.table("D:/Users/25052288840/Downloads/FIA_data_mining/Clusters/exemplo5.csv", 
  header=TRUE, sep=";", na.strings="NA", dec=".", strip.white=TRUE)
exemplo5 <- read.table("D:/Users/25052288840/Downloads/FIA_data_mining/Clusters/exemplo5.csv", 
  header=TRUE, sep=";", na.strings="NA", dec=",", strip.white=TRUE)
scatterplotMatrix(~x1+x2+x3+x4+x5+x6+x7, reg.line=FALSE, smooth=FALSE, spread=FALSE, 
  span=0.5, ellipse=FALSE, levels=c(.5, .9), id.n=0, diagonal = 'boxplot', data=exemplo5)
vif(lm(x8 ~x1+x2+x3+x4+x5+x6+x7, data=exemplo5))
vif(lm(x8 ~x1+x2+x3+x4+x6+x7, data=exemplo5))

HClust.1 <- hclust(dist(model.matrix(~-1 + x1+x2+x3+x4+x5+x6+x7, exemplo5)) , method= 
  "ward")
plot(HClust.1, main= "Cluster Dendrogram for Solution HClust.1", xlab= 
  "Observation Number in Data Set exemplo5", sub="Method=ward; Distance=euclidian")
summary(as.factor(cutree(HClust.1, k = 4))) # Cluster Sizes
by(model.matrix(~-1 + x1 + x2 + x3 + x4 + x5 + x6 + x7, exemplo5), 
  as.factor(cutree(HClust.1, k = 4)), colMeans) # Cluster Centroids
biplot(princomp(model.matrix(~-1 + x1 + x2 + x3 + x4 + x5 + x6 + x7, exemplo5)), 
  xlabs = as.character(cutree(HClust.1, k = 4)))

