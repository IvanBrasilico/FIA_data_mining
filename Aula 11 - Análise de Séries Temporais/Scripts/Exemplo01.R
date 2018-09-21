# Exemplo 1
# Taxa de fertilidade

# Definindo diretorio de trabalho
setwd("~/Dropbox/Classes/Other/FIA/Séries Temporais (Receita Federal)/Data")

# Carregando arquivo
load("fertil3.RData")

# Visualizando parte dos dados
head(data)
class(data)

# Selecionando variaveis
newdata <- data[c("gfr", "pe", "pill")]
head(newdata)

# Declarando time series
fertil3 <- ts(newdata, frequency = 1, start = 1913)
class(fertil3)

# Plot
plot(fertil3, main = "Time Series Plots")

# Estimacao
library(dynlm)
reg1 <- dynlm(diff(gfr) ~ diff(pe) + lag(diff(pe),-1) + 
                lag(diff(pe),-2) + pill, fertil3)
summary(reg1)

# Adequacao do modelo
reg1.res <- resid(reg1)
acf(reg1.res, main = "ACF dos resíduos")
