# Estimando modelo ARMA
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

# Identificacao da ordem do ARMA
library(forecast)
library(lmtest)
arma.aic <- auto.arima(vw, ic = "aic")
coeftest(arma.aic)
arma.bic <- auto.arima(vw, ic = "bic")
coeftest(arma.bic)