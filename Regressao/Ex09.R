library(foreign)
HPRICE2 <- read_dta("Regressao/Aula 9/HPRICE2-Kayo.dta")

Ex09 <- lm(formula = log(price) ~ log(nox) + rooms, data = HPRICE2)
summary(Ex09)
