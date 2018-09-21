# Estacionariedade
# S&P500

# Definindo diretorio de trabalho
setwd("~/Dropbox/Classes/Other/FIA/Séries Temporais (Receita Federal)/Data")

# Carregando arquivo
data <- read.csv("sp500.csv", header = TRUE)
head(data)
class(data)

# Selecionando variaveis
sp500 <- data[c("Adj.Close")]
head(sp500)

# Declarando time series
sp500 <- ts(sp500, frequency = 12, start = c(1950, 1))
class(sp500)

# Plots
par(mfrow=c(1,2))
plot(sp500, main = "S&P 500 Monthly Index", ylab = "index")
plot(diff(log(sp500)), main = "S&P 500 Monthly Returns", ylab = "log-return")
abline(h=0)
par(mfrow=c(1,1))

# Carregando arquivo
data <- read.table("q-ko-earns8309.txt", header = TRUE)
head(data)
dim(data)

# Selecionando variaveis
ko.earn <- data["value"]
head(ko.earn)

# Declarando time series
ko.earn <- ts(ko.earn, frequency = 4, start = c(1983, 1))
plot(ko.earn, main="EPS of Coca Cola: 1983-2009", ylab = "EPS")
points(ko.earn, pch= c('1','2','3','4'), cex = 0.75)
