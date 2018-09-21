# Volatidade da Intel
# GARCH

# Definindo diretorio de trabalho
setwd("~/Dropbox/Classes/Other/FIA/Séries Temporais (Receita Federal)/Data")

# Carregando arquivo
data <- read.table("m-intcsp7309.txt", header = TRUE)
head(data)
dim(data)

# Selecionando variaveis
intel <- data$intc
head(intel)

# Declarando time series
intel <- ts(intel, frequency = 12, start = c(1973, 1))

# Estimacao
garch11 <- ugarchspec(
  variance.model = list(model = "sGARCH", garchOrder = c(1,1)),
  mean.model = list(armaOrder=c(0,0), include.mean=TRUE),
  distribution.model = "norm")
garch11.fit <- ugarchfit(spec = garch11, data = intel)
garch11.fit

# Volatilidade estimada
vol.garch11 <- sigma(garch11.fit)
plot(vol.garch11)

# Forecast passos a frente
ugarchforecast(garch11.fit, n.ahead = 6)
plot(ugarchforecast(garch11.fit, n.ahead = 6), which = 3)
