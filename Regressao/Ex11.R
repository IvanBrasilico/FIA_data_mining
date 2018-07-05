library(foreign)
HPRICE2 <- read_dta("Regressao/Aula 9/HPRICE2-Kayo.dta")

Ex11 <- lm(formula = log(price) ~ log(nox) + log(dist) + rooms + I(rooms ^ 2) + stratio, data = HPRICE2)
summary(Ex11)
