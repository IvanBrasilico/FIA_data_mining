exemplo6 <- read.table("D:/Users/25052288840/Downloads/FIA_data_mining/Clusters/exemplo6.csv", 
  header=TRUE, sep=";", na.strings="NA", dec=",", strip.white=TRUE)
str(exemplo6)
exemplo6 <- read.table("D:/Users/25052288840/Downloads/FIA_data_mining/Clusters/exemplo6.csv", 
  header=TRUE, sep=";", na.strings="NA", dec=",", strip.white=TRUE, stringsAsFactors=FALSE)
str(exemplo6)
exemplo6$beer <- as.character(exemplo6$beer)
str(exemplo6)
HClust.1 <- hclust(dist(model.matrix(~-1 + alcohol+calories+cost+sodium, exemplo6)) , 
  method= "ward")
plot(HClust.1, main= "Cluster Dendrogram for Solution HClust.1", xlab= 
  "Observation Number in Data Set exemplo6", sub="Method=ward; Distance=euclidian",
labels=exemplo6$beer)

dendro1 <- as.dendrogram(HClust.1)
plot(dendro1, main= "Cluster Dendrogram for Solution hc1", xlab= "Observation Number in Data Set exemplo1", sub="Method=ward; Distance=euclidian")
rect.hclust(HClust.1, k=5)




