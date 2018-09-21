# Realizando previsoes
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
length(log.eps)

# Pegando as 100 primeiras obs
y <- log.eps[1:100]
model.fore <- arima(y, order=c(0,1,1),
                    seasonal=list(order=c(0,1,1),period=4))
model.fore

# Previsao
pred.model <- predict(model.fore, 7)
pred.model
names(pred.model)

# Plot
pred <- pred.model$pred
se <- pred.model$se
pred <- c(rep(NA, 20), pred)
se <- c(rep(NA, 20), se)
plot(ko.earn[81:107], type = "l", ylim = c(0.4, 1.3),
     main = "Previsão do EPS da Coca-Cola",
     ylab = "Lucro por ação")
lines(exp(pred), pch = 19, type = "b", lty = 2)
lines(exp(pred+2*se), lty = 1, col = "darkgray")
lines(exp(pred-2*se), lty = 1, col = "darkgray")
