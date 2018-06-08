exemplo_3 <- read.table("D:/Users/25052288840/Downloads/exemplo3_aula2.csv", header=TRUE, sep=";", 
  na.strings="NA", dec=",", strip.white=TRUE)

.cluster <-  KMeans(model.matrix(~-1 + x + y, exemplo_2), centers = 8, iter.max = 10, num.seeds = 10)
.cluster$size # Cluster Sizes
.cluster$centers # Cluster Centroids
.cluster$withinss # Within Cluster Sum of Squares
.cluster$tot.withinss # Total Within Sum of Squares
.cluster$betweenss # Between Cluster Sum of Squares
biplot(princomp(model.matrix(~-1 + x + y, exemplo_2)), xlabs = as.character(.cluster$cluster))
exemplo_2$KMeans_8 <- assignCluster(model.matrix(~-1 + x + y, exemplo_2), exemplo_2, .cluster$cluster)
remove(.cluster)
.cluster <-  KMeans(model.matrix(~-1 + x + y, exemplo_2), centers = 9, iter.max = 10, 
  num.seeds = 10)
.cluster$size # Cluster Sizes
.cluster$centers # Cluster Centroids
.cluster$withinss # Within Cluster Sum of Squares
.cluster$tot.withinss # Total Within Sum of Squares
.cluster$betweenss # Between Cluster Sum of Squares
biplot(princomp(model.matrix(~-1 + x + y, exemplo_2)), xlabs = 
  as.character(.cluster$cluster))
exemplo_2$KMeans_9 <- assignCluster(model.matrix(~-1 + x + y, exemplo_2), exemplo_2, 
  .cluster$cluster)
remove(.cluster)
.cluster <-  KMeans(model.matrix(~-1 + x + y, exemplo_2), centers = 10, iter.max = 10, 
  num.seeds = 10)
.cluster$size # Cluster Sizes
.cluster$centers # Cluster Centroids
.cluster$withinss # Within Cluster Sum of Squares
.cluster$tot.withinss # Total Within Sum of Squares
.cluster$betweenss # Between Cluster Sum of Squares
biplot(princomp(model.matrix(~-1 + x + y, exemplo_2)), xlabs = 
  as.character(.cluster$cluster))
exemplo_2$KMeans_10 <- assignCluster(model.matrix(~-1 + x + y, exemplo_2), exemplo_2, 
  .cluster$cluster)
remove(.cluster)
scatterplot(y~x | KMeans_8, reg.line=FALSE, smooth=FALSE, spread=FALSE, boxplots=FALSE, 
  span=0.5, ellipse=FALSE, levels=c(.5, .9), by.groups=TRUE, data=exemplo_2)
windows()
scatterplot(y~x | KMeans_9, reg.line=FALSE, smooth=FALSE, spread=FALSE, boxplots=FALSE, 
  span=0.5, ellipse=FALSE, levels=c(.5, .9), by.groups=TRUE, data=exemplo_2)

windows()
scatterplot(y~x | KMeans_10, reg.line=FALSE, smooth=FALSE, spread=FALSE, boxplots=FALSE, 
  span=0.5, ellipse=FALSE, levels=c(.5, .9), by.groups=TRUE, data=exemplo_2)

fviz_nbclust(exemplo_2[1:2], FUN = kmeans, method = "wss", k.max=15)

km_ex3 <-  KMeans(model.matrix(~-1 + x + y, exemplo_3), centers = 10, iter.max = 10, num.seeds = 10)
str(km_ex3)
fviz_cluster(km_ex3, data = exemplo_3[1:2], ellipse.type = "euclid", star.plot = TRUE, repel = TRUE, ggtheme = theme_minimal())



exemplo3 <- read.table("D:/Users/25052288840/Downloads/exemplo3_aula2.csv", header=TRUE, sep=";", 
  na.strings="NA", dec=",", strip.white=TRUE)
exemplo3_subset1 <- subset(exemplo3, subset=y < 250 & x < 250)
.cluster <-  KMeans(model.matrix(~-1 + x + y, exemplo3_subset1), centers = 8, iter.max = 10, 
  num.seeds = 10)
exemplo3_subset1$KMeans <- assignCluster(model.matrix(~-1 + x + y, exemplo3_subset1), 
  exemplo3_subset1, .cluster$cluster)
remove(.cluster)
scatterplot(y~x | KMeans, reg.line=FALSE, smooth=FALSE, spread=FALSE, boxplots=FALSE, 
  span=0.5, ellipse=TRUE, levels=c(.5, .9), by.groups=TRUE, data=exemplo3_subset1)


exemplo3_subset2 <- subset(exemplo3, subset=y >= 250 & x >= 250)
.cluster <-  KMeans(model.matrix(~-1 + x + y, exemplo3_subset2), centers = 4, iter.max = 10, 
  num.seeds = 10)
exemplo3_subset2$KMeans <- assignCluster(model.matrix(~-1 + x + y, exemplo3_subset2), 
  exemplo3_subset2, .cluster$cluster)
remove(.cluster)
scatterplot(y~x | KMeans, reg.line=FALSE, smooth=FALSE, spread=FALSE, boxplots=FALSE, 
  span=0.5, ellipse=TRUE, levels=c(.5, .9), by.groups=TRUE, data=exemplo3_subset2)

