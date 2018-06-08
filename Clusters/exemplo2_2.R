
exemplo2 <- read.table("D:/Users/25052288840/Downloads/exemplo2_aula2.csv", 
  header=TRUE, sep=";", na.strings="NA", dec=",", strip.white=TRUE)
scatterplot(y~x, reg.line=FALSE, smooth=FALSE, spread=FALSE, id.method='mahal', id.n = 
  12, boxplots=FALSE, span=0.5, ellipse=FALSE, levels=c(.5, .9), data=exemplo2)
cx <- c(1,1.8,2.5)
cy <- c(2,1,1.5)
cols1 <- c("red","orange","purple")
points(cx,cy,col=cols1,pch=3,cex=2,lwd=2)
text(cx + 0.05, cy + 0.05, labels = as.character(1:3), col=cols1)

distTmp <- matrix(NA,nrow=3,ncol=12)
distTmp[1,] <- (x-cx[1])^2 + (y-cy[1])^2
distTmp[2,] <- (x-cx[2])^2 + (y-cy[2])^2
distTmp[3,] <- (x-cx[3])^2 + (y-cy[3])^2
newClust <- apply(distTmp,2,which.min)
points(x,y,pch=19,cex=2,col=cols1[newClust])

.cluster <-  KMeans(model.matrix(~-1 + x + y, exemplo2), centers = 3, iter.max = 10, num.seeds = 10)
.cluster$size # Cluster Sizes
.cluster$centers # Cluster Centroids
.cluster$withinss # Within Cluster Sum of Squares
.cluster$tot.withinss # Total Within Sum of Squares
.cluster$betweenss # Between Cluster Sum of Squares
biplot(princomp(model.matrix(~-1 + x + y, exemplo2)), xlabs = as.character(.cluster$cluster))
exemplo2$KMeans_3 <- assignCluster(model.matrix(~-1 + x + y, exemplo2), exemplo2, .cluster$cluster)
remove(.cluster)


km_ex2 = KMeans(model.matrix(~-1 + x + y, exemplo2), centers = 3, iter.max = 10, num.seeds = 10)
str(km_ex2)
km_ex2$cluster

scatterplot(y~x | KMeans_3, reg.line=FALSE, smooth=FALSE, spread=FALSE, id.method='mahal', id.n = 12, 
  boxplots=FALSE, span=0.5, ellipse=TRUE, levels=c(.5, .9), by.groups=TRUE, data=exemplo2)

library(cluster)
clusplot(exemplo2, km_ex2$cluster)

library(factoextra)
fviz_cluster(km_ex2, data = exemplo2, ellipse.type = "euclid", star.plot = TRUE, repel = TRUE, ggtheme = theme_minimal())

fviz_cluster(km_ex2, data = exemplo2)

exemplo2$KMeans_3 <- as.numeric(exemplo2$KMeans_3)

