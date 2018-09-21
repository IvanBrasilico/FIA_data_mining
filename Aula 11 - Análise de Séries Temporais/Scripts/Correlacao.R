# Correlacao e autocorrelacao
# IBM e S&P500

# Definindo diretorio de trabalho
setwd("~/Dropbox/Classes/Other/FIA/Séries Temporais (Receita Federal)/Data")

# Carregando arquivo
data <- read.table("m-ibmsp6709.txt", header = TRUE)
head(data)
class(data)

# Diagrama de dispersao
plot(ibm~sp, data, ylab = "Retornos da IBM", xlab = "Retornos do S&P 500",
     main = "Diagrama de dispersão")

# Selecionando variaveis
sp <- data["sp"]
ibm <- data["ibm"]

# Declarando time series
sp <- ts(sp, frequency = 12, start = c(1967, 1))
ibm <- ts(ibm, frequency = 12, start = c(1967, 1))
class(sp)

# Plots
par(mfrow=c(1,2))
acf(sp, main = "ACF S&P 500")
acf(ibm, main = "ACF IBM")
par(mfrow=c(1,1))
