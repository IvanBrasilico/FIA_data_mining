library(foreign)
HPRICE1 <- read_dta("Regressao/Aula 9/HPRICE1-Kayo.dta")

Ex07 <- lm(formula = log(price) ~ log(lotsize) + log(sqrft) + bdrms, data = HPRICE1)
summary(Ex07)
library(lmtest)
bptest(Ex07)

