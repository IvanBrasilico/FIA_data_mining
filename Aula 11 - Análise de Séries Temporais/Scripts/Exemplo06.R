# Estimacao do modelo sazonal
# Coca-Cola EPS

# Definindo diretorio de trabalho
setwd("~/Dropbox/Classes/Other/FIA/Séries Temporais (Receita Federal)/Data")

# Carregando arquivo
data <- read.table("q-ko-earns8309.txt", header = TRUE)
head(data)
dim(data)

# Selecionando variaveis
ko.earn <- data["value"]
head(ko.earn)

# Declarando time series
ko.earn <- ts(ko.earn, frequency = 4, start = c(1983, 1))

# Aplicando log no EPS
log.eps <- log(ko.earn)
class(log.eps)

# Diferenca sazonal
diff4.log.eps <- diff(diff.log.eps, 4)

# Estimacao
library(lmtest)
sarima <- arima(log.eps, order=c(0,1,1),
                seasonal=list(order=c(0,1,1), period=4))
coeftest(sarima)

# Alternativamente
sarima2 <- arima(diff4.log.eps, order=c(0,0,1), 
                 include.mean = FALSE,
                 seasonal=list(order=c(0,0,1), period=4))
coeftest(sarima2)

# Investigacao dos residuos do modelo
sar.res <- resid(sarima)
library(portes)
LjungBox(sar.res, lags = c(4,8,12,16,20), order = 2)

# Caso queira encontrar o melhor modelo
library(forecast)
auto.arima(diff4.log.eps, ic = "aic")
auto.arima(diff4.log.eps, ic = "bic")
