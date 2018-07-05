library(foreign)
WAGE1 <- read_dta("Regressao/Aula 9/WAGE1-Kayo.dta")

Ex12 <- lm(formula = wage ~ female, data = WAGE1)
summary(Ex12)
