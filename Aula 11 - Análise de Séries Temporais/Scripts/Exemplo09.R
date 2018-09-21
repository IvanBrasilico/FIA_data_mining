# Volatidade da Intel
# ARCH

# Definindo diretorio de trabalho
setwd("D:/Users/25052288840/Downloads/FIA_data_mining/Aula 11 - Análise de Séries Temporais/Data")

# Carregando arquivo
data <- read.table("m-intcsp7309.txt", header = TRUE)
head(data)
dim(data)

# Selecionando variaveis
intel <- data$intc
head(intel)

# Declarando time series
intel <- ts(intel, frequency = 12, start = c(1973, 1))

# Plots
#install.packages("TSA")
library(TSA)
par(mfrow=c(1,2))
plot(intel, main = "Retornos da Intel", ylab = "Retorno")
acf(intel, main = "ACF dos Retornos")
par(mfrow=c(1,1))

# Ljung-Box
#install.packages("portes")
library(portes)
LjungBox(intel, lags = c(3,6,9,12), order = 0)

# Selecao de modelo ARMA
#install.packages("forecast")
library(forecast)
auto.arima(intel, ic = "bic", max.P = 0, max.Q = 0)

# Modelo ARMA(0,0)
arma.intel <- arima(intel, order = c(0,0,0), method = "ML")
resid <- resid(arma.intel)

# Teste de efeitos ARCH
#install.packages("aTSA")
library(aTSA)
arch.test(arma.intel)

# Estimacao
pacf(resid^2, main = "PACF do quadrado dos resíduos")
install.packages("rugarch")
library(rugarch)
arch4 <- ugarchspec(
  variance.model = list(model = "sGARCH", garchOrder = c(4,0)),
  mean.model = list(armaOrder=c(0,0), include.mean=TRUE),
  distribution.model = "norm")
arch4.fit <- ugarchfit(spec = arch4, data = intel)
arch4.fit

arch1 <- ugarchspec(
  variance.model = list(model = "sGARCH", garchOrder = c(1,0)),
  mean.model = list(armaOrder=c(0,0), include.mean=TRUE),
  distribution.model = "norm")
arch1.fit <- ugarchfit(spec = arch1, data = intel)
arch1.fit

# Volatilidade estimada
vol.arch1 <- sigma(arch1.fit)
plot(vol.arch1)

# Forecast passos a frente
ugarchforecast(arch1.fit, n.ahead = 6)
plot(ugarchforecast(arch1.fit, n.ahead = 6), which = 3)

