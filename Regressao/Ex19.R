setwd("D:/Users/25052288840/Downloads/FIA_data_mining/Regressao/")

# install.packages("plm")
library(plm)
load("Aula 10/CRIME2.rda")


CRIME2PANEL = pdata.frame(CRIME2, index = c("area", "year"))
Ex19 <- plm(formula = crmrte ~ d87 + unem, data= CRIME2PANEL, model= "within")
summary(Ex19)
