setwd('D:/Users/25052288840/Downloads/FIA_data_mining/Aula 15 - Regressão Logística')
dados <- read.csv('RF-Sonegacao.csv')
head(dados)
summary(dados)
sapply(dados, sd)

logit.03 <- glm(Y ~ X1 + X2 + X3 + X4 + X5 + X6, data=dados,
                family = "binomial"(link="logit"))
summary(logit.03)

x_test = dados[,3:8]
y_test = dados[,2]
glm.probs <- predict(logit.03, type = "response")
glm.pred <- ifelse(glm.probs > 0.5, 1, 0)

mean(glm.pred == y_test)
table(glm.pred, y_test)

install.packages("pscl")
library(pscl)
pR2(logit.03)
