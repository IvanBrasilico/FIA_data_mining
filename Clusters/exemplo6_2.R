
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
hc1_ward <- hclust(dist(model.matrix(~-1 + Z.alcohol+Z.calories+Z.cost+Z.sodium, 
  Cervejas)) , method= "centroid")
plot(hc1_ward, main= "Cluster Dendrogram for Solution hc1_ward", xlab= 
  "Observation Number in Data Set Cervejas", sub="Method=centroid; Distance=euclidian")
windows()
hc1_median <- hclust(dist(model.matrix(~-1 + Z.alcohol+Z.calories+Z.cost+Z.sodium, 
  Cervejas)) , method= "median")
plot(hc1_median, main= "Cluster Dendrogram for Solution hc1_median", xlab= 
  "Observation Number in Data Set Cervejas", sub="Method=median; Distance=euclidian")