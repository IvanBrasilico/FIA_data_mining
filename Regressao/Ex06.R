library(foreign)
HPRICE1 <- read_dta("Regressao/Aula 9/HPRICE1-Kayo.dta")

Ex06 <- lm(formula = price ~ lotsize + sqrft + bdrms, data = HPRICE1)
summary(Ex06)
library(lmtest)
bptest(Ex06)

