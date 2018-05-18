
exemplo3 <- read.table("D:/Users/25052288840/Downloads/FIA_data_mining/Clusters/exemplo3.csv", 
  header=TRUE, sep=",", na.strings="NA", dec=",", strip.white=TRUE)
HClust.1 <- hclust(dist(model.matrix(~-1 + x+y, exemplo3)) , method= "ward")
plot(HClust.1, main= "Cluster Dendrogram for Solution HClust.1", xlab= 
  "Observation Number in Data Set exemplo3", sub="Method=ward; Distance=euclidian")
summary(as.factor(cutree(HClust.1, k = 9))) # Cluster Sizes
by(model.matrix(~-1 + x + y, exemplo3), as.factor(cutree(HClust.1, k = 9)), colMeans) 
  # Cluster Centroids
biplot(princomp(model.matrix(~-1 + x + y, exemplo3)), xlabs = 
  as.character(cutree(HClust.1, k = 9)))
exemplo3$ward9 <- assignCluster(model.matrix(~-1 + x + y, exemplo3), exemplo3, 
  cutree(HClust.1, k = 9))
scatterplot(y~x | ward9, reg.line=FALSE, smooth=FALSE, spread=FALSE, boxplots=FALSE, 
  span=0.5, ellipse=TRUE, levels=c(.5, .9), by.groups=TRUE, data=exemplo3)
HClust.2 <- hclust(dist(model.matrix(~-1 + x+y, exemplo3)) , method= "single")
plot(HClust.2, main= "Cluster Dendrogram for Solution HClust.2", xlab= 
  "Observation Number in Data Set exemplo3", sub="Method=single; Distance=euclidian")
exemplo3$single9 <- assignCluster(model.matrix(~-1 + x + y, exemplo3), exemplo3, 
  cutree(HClust.2, k = 9))
HClust.3 <- hclust(dist(model.matrix(~-1 + x+y, exemplo3)) , method= "complete")
plot(HClust.3, main= "Cluster Dendrogram for Solution HClust.3", xlab= 
  "Observation Number in Data Set exemplo3", sub="Method=complete; Distance=euclidian")
exemplo3$complete9 <- assignCluster(model.matrix(~-1 + x + y, exemplo3), exemplo3, 
  cutree(HClust.3, k = 9))
scatterplot(y~x | single9, reg.line=FALSE, smooth=FALSE, spread=FALSE, 
  id.method='mahal', id.n = 10, boxplots=FALSE, span=0.5, ellipse=TRUE, levels=c(.5, .9), 
  by.groups=TRUE, data=exemplo3)
scatterplot(y~x | complete9, reg.line=FALSE, smooth=FALSE, spread=FALSE, boxplots=FALSE,
   span=0.5, ellipse=TRUE, levels=c(.5, .9), by.groups=TRUE, data=exemplo3)
scatterplot(y~x | complete9, reg.line=FALSE, smooth=FALSE, spread=FALSE, boxplots=FALSE,
   span=0.5, ellipse=TRUE, levels=c(.5, .9), by.groups=TRUE, data=exemplo3)
scatterplot(y~x | single9, reg.line=FALSE, smooth=FALSE, spread=FALSE, boxplots=FALSE, 
  span=0.5, ellipse=TRUE, levels=c(.5, .9), by.groups=TRUE, data=exemplo3)
scatterplot(y~x | ward9, reg.line=FALSE, smooth=FALSE, spread=FALSE, boxplots=FALSE, 
  span=0.5, ellipse=TRUE, levels=c(.5, .9), by.groups=TRUE, data=exemplo3)


dist(model.matrix(~-1 + x+y, exemplo3))
