## ExB

#Definir diretório
setwd("D:/Users/25052288840/Downloads/FIA_data_mining/Regressao/Aula 8")

ENDIV1 <- read.table("ENDIV1.csv", header=TRUE, sep=",")
ls()

# Regressão simples
ExB <- lm(endiv1 ~ roa, data=ENDIV1)
summary(ExB)

# Regressão simples
ExB2 <- lm(endiv1 ~ roa + mb + lntam, data=ENDIV1)
summary(ExB2)

# Regressão simples
ExB3 <- lm(mb ~ lucrat2, data=ENDIV1)
summary(ExB3)

# Regressão simples
ExB4 <- lm(mb ~ lucrat2 + endiv1 + lntam, data=ENDIV1)
summary(ExB4)


