library(foreign)
HPRICE1 <- read_dta("Regressao/Aula 9/HPRICE1-Kayo.dta")

Ex08 <- lm(formula = price ~ lotsize + sqrft + bdrms, data = HPRICE1)
summary(Ex08)
library(sandwich)
library(lmtest)
Ex08b = coeftest(Ex08, vcov=vcovHC(Ex08, type="HC0"))
install.packages(c("stargazer"))
library(stargazer)
stargazer(Ex06, Ex08b, type="text", title="Análise de Regressão", 
          covariate.labels = c("Terreno", "Área construída", "Quartos"))
