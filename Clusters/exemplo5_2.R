exemplo5 <- read.table("D:/Users/25052288840/Downloads/exemplo5_aula2.csv", header=TRUE, 
  sep=";", na.strings="NA", dec=",", strip.white=TRUE)
scatterplotMatrix(~x1+x2+x3+x4+x5+x6+x7, reg.line=FALSE, smooth=FALSE, spread=FALSE, span=0.5,
   ellipse=TRUE, levels=c(.5, .9), id.n=10, diagonal = 'boxplot', data=exemplo5)
library(abind, pos=16)
library(e1071, pos=17)
numSummary(exemplo5[,c("x1", "x2", "x3", "x4", "x5", "x6", "x7"), drop=FALSE], 
  statistics=c("mean", "sd", "quantiles", "skewness", "kurtosis"), quantiles=c(0,.25,.5,
  .75,1), type="2")


windows()
heatmap(as.matrix(exemplo5[1:7]), scale="none")

hcex5c <- hclust(dist(exemplo5[1:7]), method="complete")
ord <- order(cutree(hcex5c, k = 9))
dij <- dist(dist(exemplo5[1:7]))
windows()
image(as.matrix(dij)[ord, ord], main = "Matriz de Dissimilaridades – exemplo5")

library(factoextra)
fviz_dist(dist(exemplo5[1:7]), show_labels = FALSE) + labs(title = "Dissimilarity Matrix")
library(clustertend)

1-hopkins(exemplo5[1:7],n=nrow(exemplo5)*0.2)$H

library(factoextra)
1-get_clust_tendency(exemplo5[1:7], n = nrow(exemplo5)*0.2)$hopkins_stat

hc5_ward <- hclust(dist(exemplo5[1:7]), method="ward.D2")
hc5_average <- hclust(dist(exemplo5[1:7]), method="average")
hc5_centroid <- hclust(dist(exemplo5[1:7]), method="centroid")

coph_ward <- cophenetic(hc5_ward)
coph_average <- cophenetic(hc5_average)
coph_centroid <- cophenetic(hc5_centroid)

cor(coph_ward, dist(exemplo5[1:7]))
cor(coph_average, dist(exemplo5[1:7]))
cor(coph_centroid, dist(exemplo5[1:7]))


plot(hc5_ward, main= "Cluster Dendrogram for Solution hc5_ward", 
   xlab= "Observation Number in Data Set exemplo5", sub="Method=ward; Distance=euclidian")

fviz_nbclust(exemplo5[1:6], FUN = hcut, method = "wss", hc_method="ward.D2", k.max=6)

plot(hc5_ward)
rect.hclust(hc5_ward, k=4)
windows()
plot(hc5_ward)
rect.hclust(hc5_ward, k=2)

