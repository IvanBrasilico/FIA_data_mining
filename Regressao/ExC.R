library(foreign)
WAGE1 <- read_dta("Regressao/Aula 9/WAGE1-Kayo.dta")

ExC <- lm(formula = log(wage) ~ female * exper + educ + expersq + tenure + tenursq, data = WAGE1)
summary(ExC)
