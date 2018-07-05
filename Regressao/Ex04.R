## Ex04

#Definir diretório
setwd("D:/Users/25052288840/Downloads/FIA_data_mining/Regressao/Aula 8")

df04 <- read.table("twoyear.csv", header=TRUE, sep=",")

ls()

# Regressão simples
Ex04 <- lm(lwage~ jc + univ + exper, data=df04)
summary(Ex04)

# Plotar gráfico
#Graf <- plot(lwage~ jc + univ + exper, data=df04)
#abline(Ex04)
linearHypothesis(Ex04, c("jc = univ"))
