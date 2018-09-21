setwd('D:/Users/25052288840/Downloads/FIA_data_mining/Aula 14 - Regressão Logística')
dados <- read.csv('RF-Admissao.csv')
head(dados)
summary(dados)
sapply(dados, sd)
# install.packages('aod')
library(aod)
xtabs(~admit + rank, data=dados)

logit.01 <- glm(admit ~ gre + gpa + rank, data=dados,
                family = "binomial"(link="logit"))
summary(logit.01)

dados$rankF <- factor(dados$rank)
logit.02 <- glm(admit ~ gre + gpa + rankF, data=dados,
                family = "binomial"(link="logit"))
summary(logit.02)

x_test = c(dados[,3:4], dados[,6])
y_test = dados[,2]
glm.probs <- predict(logit.02, type = "response")
glm.pred <- ifelse(glm.probs > 0.5, 1, 0)

# install.packages('caret')
library(caret)
mean(glm.pred == y_test)

# install.packages("lmtest")
library(lmtest)
lrtest(logit.01, logit.02)
