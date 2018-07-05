## ExA

#Definir diretório
setwd("D:/Users/25052288840/Downloads/FIA_data_mining/Regressao/Aula 8")

inData <- load("CEOSAL1.rda")
ls()

# Regressão simples
ExA <- lm(lsalary~lsales + roe + finance + consprod + utility, data=CEOSAL1)
summary(ExA)

CEOSAL1$fitExA <- fitted(ExA)
CEOSAL1$resExA <- resid(ExA)

library("car")

linearHypothesis(ExA, c("utility"))
# diferença -28% - estatisticamente significante

linearHypothesis(ExA, c("finance = consprod"))
# diferença aproximada 2% (0,180-0,157) - não estaticamente significante


