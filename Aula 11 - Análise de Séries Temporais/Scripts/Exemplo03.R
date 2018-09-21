# Estimando modelo AR
# Value-weighted CRSP

# Definindo diretorio de trabalho
setwd("~/Dropbox/Classes/Other/FIA/Séries Temporais (Receita Federal)/Data")

# Carregando arquivo
data <- read.table("m-ibm3dx2609.txt", header = TRUE)
head(data)
class(data)

# Selecionando variaveis
vw <- data$vw
vw <- ts(vw, frequency = 12, start = c(1926, 1))
class(vw)

# Estimacao
library(lmtest)
ar1 <- arima(vw, order = c(1,0,0))
coeftest(ar1)
ar3 <- arima(vw, order = c(3,0,0))
coeftest(ar3)
ar6 <- arima(vw, order = c(6,0,0))
coeftest(ar6)

# Estimacao de residuos
res.ar1 <- resid(ar1)
res.ar3 <- resid(ar3)
res.ar6 <- resid(ar6)

# Plots
library(TSA)
par(mfrow=c(1,3))
acf(res.ar1, main = "ACF Model AR(1)")
acf(res.ar3, main = "ACF Model AR(3)")
acf(res.ar6, main = "ACF Model AR(6)")
par(mfrow=c(1,1))

# Teste de residuos
library(portes)
LjungBox(res.ar1, lags = c(4,8,12,16), order = 1)
LjungBox(res.ar3, lags = c(4,8,12,16), order = 3)
LjungBox(res.ar6, lags = c(8,12,16,20), order = 6)
