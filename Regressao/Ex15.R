library(foreign)
WAGE1 <- read_dta("Regressao/Aula 9/WAGE1-Kayo.dta")

Ex15 <- lm(formula = log(wage) ~ female * married + educ + exper + expersq + tenure + tenursq, data = WAGE1)
summary(Ex15)
