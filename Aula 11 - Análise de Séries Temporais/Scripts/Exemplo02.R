# Exemplo 2
# Teste de autocorrelacao

# Definindo diretorio de trabalho
setwd("~/Dropbox/Classes/Other/FIA/Séries Temporais (Receita Federal)/Data")

# Carregando arquivo
data <- read.table("m-ibmsp6709.txt", header = TRUE)
head(data)
class(data)

# Box-Piearce and Ljung-Box tests
ibm <- data$ibm
library(portes)
BoxPierce(ibm, lags = c(4,8,12))
LjungBox(ibm, lags = c(4,8,12))

