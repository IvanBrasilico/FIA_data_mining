## Ex01

#Definir diretório
setwd("D:/Users/25052288840/Downloads/FIA_data_mining/Regressao/Aula 8")

SalMensal <- read.table("SalMensal.csv", header=TRUE, sep=",")

ls()

# Regressão simples
Ex01 <- lm(sal~man, data=SalMensal)
summary(Ex01)

# Plotar gráfico
Graf <- plot(sal~man, data=SalMensal)
abline(Ex01)
