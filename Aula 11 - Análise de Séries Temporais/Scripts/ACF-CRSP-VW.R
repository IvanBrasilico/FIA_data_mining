# PACF, AIC and BIC
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

# Plot
library(TSA)
acf(vw, main = "ACF Value-Weighted CRSP")
