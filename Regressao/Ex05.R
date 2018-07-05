## Ex05

#Definir diretório
setwd("D:/Users/25052288840/Downloads/FIA_data_mining/Regressao/Aula 8")

df05 <- read.table("MLB1.csv", header=TRUE, sep=",")

ls()

# Regressão simples
Ex05 <- lm(lsalary ~ years + gamesyr + bavg + hrunsyr + rbisyr, data=df05)
summary(Ex05)

# Plotar gráfico
#Graf <- plot(lwage~ jc + univ + exper, data=df03)
#abline(Ex04)
linearHypothesis(Ex05, c("bavg + hrunsyr + rbisyr = 0"))

# Regressão conjunta
Ex05 <- lm(lsalary ~ years + gamesyr + bavg*hrunsyr*rbisyr, data=df05)
summary(Ex05)

Ex05 <- lm(lsalary ~ years + gamesyr * bavg * hrunsyr * rbisyr, data=df05)
summary(Ex05)

Ex05 <- lm(lsalary ~ years + gamesyr + bavg:hrunsyr:rbisyr, data=df05)
summary(Ex05)

