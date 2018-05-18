
exemplo5 <- read.table("D:/Users/25052288840/Downloads/FIA_data_mining/Clusters/exemplo5.csv", 
  header=TRUE, sep=";", na.strings="NA", dec=".", strip.white=TRUE)
exemplo5 <- read.table("D:/Users/25052288840/Downloads/FIA_data_mining/Clusters/exemplo5.csv", 
  header=TRUE, sep=";", na.strings="NA", dec=",", strip.white=TRUE)
scatterplotMatrix(~x1+x2+x3+x4+x5+x6+x7, reg.line=FALSE, smooth=FALSE, spread=FALSE, 
  span=0.5, ellipse=FALSE, levels=c(.5, .9), id.n=0, diagonal = 'boxplot', data=exemplo5)

