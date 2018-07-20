setwd("D:/Users/25052288840/Downloads/FIA_data_mining/Regressao/")
load("Aula 10/WAGEPAN.rda")

WAGEPANEL = pdata.frame(WAGEPAN, index=c("nr", "year"))

Ex22 <- plm(formula = lwage~educ+black+hisp+exper+expersq+married+union+
              d81+d82+d83+d84+d85+d86+d87, data=WAGEPANEL, model = "within")
summary(Ex22)


Ex21 <- plm(formula = lwage~educ+black+hisp+exper+expersq+married+union+
              d81+d82+d83+d84+d85+d86+d87, data=WAGEPANEL, model = "random")
summary(Ex21)

plmtest(Ex21, effect = c("individual"), type = c("bp"))

phtest(Ex21, Ex22)
help(phtest)
