library(foreign)
WAGE1 <- read_dta("Regressao/Aula 9/WAGE1-Kayo.dta")

Ex13 <- lm(formula = wage ~ female + educ + exper + tenure, data = WAGE1)
summary(Ex13)
