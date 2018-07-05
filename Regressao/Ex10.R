library(foreign)
WAGE1 <- read_dta("Regressao/Aula 9/WAGE1-Kayo.dta")

Ex10 <- lm(formula = wage ~ exper + I(exper ^ 2), data = WAGE1)
summary(Ex10)
