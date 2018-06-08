
Cervejas <- read.table("D:/Users/25052288840/Downloads/exemplo6_aula2.csv", header=TRUE, sep=";", 
  na.strings="NA", dec=",", strip.white=TRUE)
str(Cervejas)
Cervejas$beer <- as.character(Cervejas$beer)
str(Cervejas)
scatterplotMatrix(~alcohol+calories+cost+sodium, reg.line=FALSE, smooth=FALSE, 
  spread=FALSE, span=0.5, ellipse=TRUE, levels=c(.5, .9), id.n=0, diagonal = 'boxplot', 
  data=Cervejas)
windows()
Boxplot( ~ alcohol, data=Cervejas, id.method="y")
Boxplot( ~ cost, data=Cervejas, id.method="y")
with(Cervejas, Hist(alcohol, scale="frequency", breaks="Sturges", col="darkgray"))
Cervejas <- local({
  .Z <- scale(Cervejas[,c("alcohol","calories","cost","sodium")])
  within(Cervejas, {
    Z.sodium <- .Z[,4]
    Z.cost <- .Z[,3]
    Z.calories <- .Z[,2]
    Z.alcohol <- .Z[,1] 
  })
})

with(Cervejas, Hist(Z.alcohol, scale="frequency", breaks="Sturges", col="darkgray"))
biplot(princomp(Cervejas[12:15]))
Cervejas[12:15]
princomp(x= Cervejas[12:15])$loadings
heatmap(as.matrix(Cervejas[12:15]))


windows()
hc1_single <- hclust(dist(model.matrix(~-1 + Z.alcohol+Z.calories+Z.cost+Z.sodium, 
  Cervejas)) , method= "single")
plot(hc1_single, main= "Cluster Dendrogram for Solution hc1_single", xlab= 
  "Observation Number in Data Set Cervejas", sub="Method=single; Distance=euclidian")
windows()
hc1_complete <- hclust(dist(model.matrix(~-1 + Z.alcohol+Z.calories+Z.cost+Z.sodium, 
  Cervejas)) , method= "complete")
plot(hc1_complete, main= "Cluster Dendrogram for Solution hc1_complete", xlab= 
  "Observation Number in Data Set Cervejas", sub="Method=complete; Distance=euclidian")
windows()
hc1_average <- hclust(dist(model.matrix(~-1 + Z.alcohol+Z.calories+Z.cost+Z.sodium, 
  Cervejas)) , method= "average")
plot(hc1_average, main= "Cluster Dendrogram for Solution hc1_average", xlab= 
  "Observation Number in Data Set Cervejas", sub="Method=average; Distance=euclidian")
windows()
hc1_centroid <- hclust(dist(model.matrix(~-1 + Z.alcohol+Z.calories+Z.cost+Z.sodium, 
  Cervejas)) , method= "centroid")
plot(hc1_centroid, main= "Cluster Dendrogram for Solution hc1_centroid", xlab= 
  "Observation Number in Data Set Cervejas", sub="Method=centroid; Distance=euclidian")
windows()
hc1_median <- hclust(dist(model.matrix(~-1 + Z.alcohol+Z.calories+Z.cost+Z.sodium, 
  Cervejas)) , method= "median")
plot(hc1_median, main= "Cluster Dendrogram for Solution hc1_median", xlab= 
  "Observation Number in Data Set Cervejas", sub="Method=median; Distance=euclidian")
windows()
hc1_ward <- hclust(dist(model.matrix(~-1 + Z.alcohol+Z.calories+Z.cost+Z.sodium, 
  Cervejas)) , method= "ward")
plot(hc1_ward, main= "Cluster Dendrogram for Solution hc1_ward", xlab= 
  "Observation Number in Data Set Cervejas", sub="Method=ward; Distance=euclidian")

windows()
library(dendextend)
tanglegram(hc1_ward, hc1_average)
dend_w <- as.dendrogram (hc1_ward)
dend_s <- as.dendrogram (hc1_single)
tanglegram(dend_s, dend_w)

dend_a <- as.dendrogram(hc1_average)
dend_cent <- as.dendrogram(hc1_centroid)
tanglegram(dend_cent, dend_a)

dend_c <- as.dendrogram(hc1_complete)
tanglegram(dend_c, dend_w)

tanglegram(untangle(dend_s, dend_w))
tanglegram(untangle(dend_cent, dend_a))

cophenetic(hc1_single)

coph_single <- cophenetic(hc1_single)
coph_complete <- cophenetic(hc1_complete)
coph_ward <- cophenetic(hc1_ward)

cor(coph_single, coph_ward)
cor(coph_single, coph_complete)
cor(coph_ward, coph_complete)

dend_list <- dendlist("Single"=dend_s, "Complete"=dend_c, "Average"=dend_a, "Centroids"=dend_cent, "Ward"=dend_w)

round(cor.dendlist(dend_list), 2)

library(corrplot)
corrplot(cor.dendlist(dend_list), "pie", "lower")



coph_single <- cophenetic(hc1_single)
coph_complete <- cophenetic(hc1_complete)
coph_ward <- cophenetic(hc1_ward)
coph_average <- cophenetic(hc1_average)
coph_centroids <- cophenetic(hc1_centroid)

exemplo6 = Cervejas
cor(coph_single, dist(exemplo6[12:15]))
cor(coph_ward, dist(exemplo6[12:15]))
cor(coph_complete, dist(exemplo6[12:15]))
cor(coph_average, dist(exemplo6[12:15]))
cor(coph_centroids, dist(exemplo6[12:15]))

plot(hc1_ward, main= "Cluster Dendrogram for Solution hc1_ward", xlab= 
  "Observation Number in Data Set Cervejas", sub="Method=ward; Distance=euclidian")
windows()
plot(hc1_average, main= "Cluster Dendrogram for Solution hc1_average", xlab= 
  "Observation Number in Data Set Cervejas", sub="Method=average; Distance=euclidian")

library(factoextra)
fviz_nbclust(exemplo6[12:15], FUN = hcut, method = "wss", hc_method="ward.D2")
windows()
fviz_nbclust(exemplo6[12:15], FUN = hcut, method = "wss", hc_method="average")

plot(hc1_average, main= "Cluster Dendrogram for Solution hc1_average", 
xlab= "Obs Nbr in DataSet exemplo6", sub="Method=average; Distance=euclidian", 
labels=exemplo6$beer)
windows()
plot(hc1_ward, main= "Cluster Dendrogram for Solution hc1_ward", 
xlab= "Obs Nbr in DataSet exemplo6", sub="Method=average; Distance=euclidian", 
labels=exemplo6$beer)




