# Vetor Autorregressivo
# IBM e SP500

# Definindo diretorio de trabalho
setwd("~/Dropbox/Classes/Other/FIA/Séries Temporais (Receita Federal)/Data")

# Carregando arquivo
data <- read.table("m-ibm3dx2608.txt", header = TRUE)
head(data)
dim(data)

# Selecionando variaveis
data <- data[,c(2,5)]
head(data)

# Declarando time series
data <- ts(data, frequency = 12, start = c(1926, 1))

# Determinacao da ordem do VAR
library(MTS)
VARorder(data, output = TRUE)
detach(package:MTS)

# Estimacao VAR(5)
library(vars)
var5 <- VAR(data, p = 5)
summary(var5)

# Analise dos residuos
resid <- resid(var5)
library(MTS)
mq(resid, lag = 12, adj = 20)

# Causalidade de Granger
causality(var5, cause = "ibmrtn")
causality(var5, cause = "sprtn")
