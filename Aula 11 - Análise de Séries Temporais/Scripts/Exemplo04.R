# Estimando modelo MA
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
ma9 <- arima(vw, order = c(0,0,9))
coeftest(ma9)
ma139 <- arima(vw, order = c(0,0,9), 
               fixed=c(NA,0,NA,0,0,0,0,0,NA,NA))
coeftest(ma139)

# Estimacao de residuos
res.ma9 <- resid(ma9)
res.ma139 <- resid(ma139)

# Plots
library(TSA)
par(mfrow=c(1,2))
acf(res.ma9, main = "ACF Model MA(9)")
acf(res.ma139, main = "ACF Model MA(1,3,9)")
par(mfrow=c(1,1))

# Teste de residuos
library(portes)
LjungBox(res.ma9, lags = c(10,14,18,22,26), order = 9)
LjungBox(res.ma139, lags = c(4,8,12,16,20), order = 3)

