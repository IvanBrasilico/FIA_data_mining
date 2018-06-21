## Ex03

#Definir diretório
setwd("D:/Users/25052288840/Downloads/FIA_data_mining/Regressao/Aula 8")

F1 <- read.table("F1.csv", header=TRUE, sep=",")

ls()

# Regressão simples
Ex03 <- lm(points~rain_mm + training, data=F1)
summary(Ex03)

# Plotar gráfico
Graf <- plot(points~rain_mm + training, data=F1)
abline(Ex03)
