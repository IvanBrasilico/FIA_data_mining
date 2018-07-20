setwd("D:/Users/25052288840/Downloads/FIA_data_mining/Regressao/")
load("Aula 10/GRUNFELD.rda")
library(plm)

ExE1 <- lm(formula=inv~value+capital, data=Grunfeld)
summary(ExE1)

GRUNFELDPANEL = pdata.frame(Grunfeld, index=c("firm", "year"))

ExE2 <- plm(formula=inv~value+capital, data=GRUNFELDPANEL, model = "within")
summary(ExE2)

ExE3 <- plm(formula=inv~value+capital, data=GRUNFELDPANEL, model = "random")
summary(ExE3)

plmtest(ExE2, effect = c("individual"), type = c("bp"))

phtest(ExE2, ExE3)

# efeitos aleat?rios (o termo "factor(...)" exerce o mesmo efeito de se criar v?rias vari?veis dummy)
ExE4 <- plm(inv~value+capital+factor(year), data=GRUNFELDPANEL, model = "random")
summary(ExE4)

# efeitos fixos
ExE5 <- plm(inv~value+capital+factor(year), data=GRUNFELDPANEL, model = "within")
summary(ExE5)

# Teste de Breush-Pagan para escolha entre POLS ou efeitos aleat?rios
plmtest(ExE4, effect = c("individual"), type = c("bp"))

# Teste de Hausman para escolha entre efeitos fixos ou aleat?rios
phtest(ExE4, ExE5)
