# Alunos: Ivan da Silva Brasílico e Sandro José Lins
# Turma: 1
# Curso: Data Mining RFB

# Definindo diretorio de trabalho
setwd("D:/Users/25052288840/Downloads/FIA_data_mining/Aula 11 - Análise de Séries Temporais/Data")

# Carregando arquivo
data <- read.table("Data.csv", header = TRUE, sep=',')
head(data)
dim(data)

# Declarando time series
vale <- ts(data$VALE3, frequency = 12, start = c(2001, 1))
petr <- ts(data$PETR4, frequency = 12, start = c(2001, 1))
ibov <- ts(data$IBOV, frequency = 12, start = c(2001, 1))




# Identificacao da ordem do ARMA
library(forecast)
library(lmtest)
arma.aicvale <- auto.arima(vale, ic = "aic")
arma.aicvale
coeftest(arma.aicvale)
arma.aicpetr <- auto.arima(petr, ic = "aic", approx=FALSE)
arma.aicpetr
coeftest(arma.aicpetr)
arma.aicibov <- auto.arima(ibov, ic = "aic")
arma.aicibov
coeftest(arma.aicibov)
arma.bicpetr <- auto.arima(petr, ic = "bic", max.P = 0, max.Q = 0)
arma.bicpetr


arma.petr <- arima(petr, order = c(1,0,1), method = "ML")
resid.petr <- resid(arma.petr)

arma.vale <- arima(vale, order = c(0,0,0), method = "ML")
resid.vale <- resid(arma.vale)

arma.ibov <- arima(ibov, order = c(2,0,0), method = "ML")
resid.ibov <- resid(arma.ibov)


library(aTSA)
arch.test(arma.petr)
arch.test(arma.vale)
arch.test(arma.ibov)


# Calculando garch
garch.vale <- ugarchspec(
  variance.model = list(model = "sGARCH", garchOrder = c(1,1)),
  mean.model = list(armaOrder=c(0,0), include.mean=TRUE),
  distribution.model = "norm")
garchvale.fit <- ugarchfit(spec = garch.vale, data = vale)
garchvale.fit

garch.petr <- ugarchspec(
  variance.model = list(model = "sGARCH", garchOrder = c(1,1)),
  mean.model = list(armaOrder=c(1,1), include.mean=TRUE),
  distribution.model = "norm")
garchpetr.fit <- ugarchfit(spec = garch.petr, data = petr)
garchpetr.fit

garch.ibov <- ugarchspec(
  variance.model = list(model = "sGARCH", garchOrder = c(1,1)),
  mean.model = list(armaOrder=c(2,0), include.mean=TRUE),
  distribution.model = "norm")
garchibov.fit <- ugarchfit(spec = garch.ibov, data = ibov)
garchibov.fit

# Volatilidade estimada
vol.garchvale <- sigma(garchvale.fit)
vol.garchpetr <- sigma(garchpetr.fit)
vol.garchibov <- sigma(garchibov.fit)

par(mfrow=c(1,3))
plot(vol.garchvale)
plot(vol.garchpetr)
plot(vol.garchibov)


##################################
# 2
##################################

data.valores <-data[c(2,3,4)]
data.ts <- ts(data.valores, frequency = 12, start = c(2001, 1))

# Ordem do VAR
library(MTS)
VARorder(data.ts, output = TRUE)

# Estimacao VAR(5)
library(vars)
var1 <- VAR(data.ts, p = 1)
summary(var1)

# Analise dos residuos
resid <- resid(var1)
library(MTS)
mq(resid, lag = 12, adj = 20)

##################################
# 3
##################################

causality(var1, cause = "PETR4")
causality(var1, cause = "VALE3")
causality(var1, cause = "IBOV")

# Pela hipótese de causalidade de Granger, não é possível rejeitar H0 na
# relação entre IBOV e PETR4 e VALE3
# Portanto, pelo teste Granger, há causalidade IBOV -> PETR4, VALE3
# No outros casos (PETR4 -> VALE5 IBOV,  VALE5 -> PETR4 IBOV), é possível rejeitar
# a hipótese de causalidade de Granger