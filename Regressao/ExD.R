library(foreign)
ENDIV1 <- read.csv("Regressao/Aula 8/ENDIV1.csv")

ExD <- lm(formula = mb ~ endiv1 + lucrat2 + I(endiv1 ^ 2),  data = ENDIV1)
summary(ExD)
