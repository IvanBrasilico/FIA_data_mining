## Ex02

#Definir diretório
setwd("D:/Users/25052288840/Downloads/FIA_data_mining/Regressao/Aula 8")

inData <- load("CEOSAL1.rda")

ls()

# Regressão simples
Ex02 <- lm(salary~roe, data=CEOSAL1)
summary(Ex02)

# Plotar gráfico
Graf <- plot(salary~roe, data=CEOSAL1)
abline(Ex02)



