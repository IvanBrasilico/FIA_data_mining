# Teste de raiz unitaria
# GDP USA

# Definindo diretorio de trabalho
setwd("~/Dropbox/Classes/Other/FIA/Séries Temporais (Receita Federal)/Data")

# Carregando arquivo
data <- read.table("q-gdp4708.txt", header = TRUE)
head(data)
dim(data)

# Selecionando variaveis
gdp <- data$gdp
head(gdp)

# Declarando time series
gdp <- ts(gdp, frequency = 4, start = c(1947, 1))

# Plots
par(mfrow=c(2,2))
plot(log(gdp), main = expression(paste("log(GDP)")))
plot(diff(log(gdp),1), main = expression(paste(Delta,"log(GDP)")))
acf(log(gdp), main = expression(paste("ACF log(GDP)")))
pacf(diff(log(gdp),1), main = expression(paste("PACF ", Delta,"log(GDP)")))
par(mfrow=c(1,1))

# Teste ADF
ar(diff(log(gdp),1), method = "mle")
library(fUnitRoots)
adfTest(log(gdp), lags = 10, type=c("c"))

# Teste ADF
ar(diff(log(gdp),2), method = "mle")
adfTest(diff(log(gdp),1), lags = 10, type=c("c"))
