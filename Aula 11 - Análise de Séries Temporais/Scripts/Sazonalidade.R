# Sazonalidade
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
plot(ko.earn, main="EPS of Coca Cola: 1983-2009", ylab = "EPS")
points(ko.earn, pch= c('1','2','3','4'), cex = 0.75)

# Aplicando log no EPS
log.eps <- log(ko.earn)
class(log.eps)

# Plot
plot(log.eps, main="log(EPS) of Coca Cola: 1983-2009", ylab = "log(EPS)")
points(log.eps, pch= c('1','2','3','4'), cex = 0.75)

# Plot comparativo
par(mfrow=c(1,2))
plot(ko.earn, ylab = "EPS")
points(ko.earn, pch= c('1','2','3','4'), cex = 0.75)
plot(log.eps, ylab = "log(EPS)")
points(log.eps, pch= c('1','2','3','4'), cex = 0.75)
par(mfrow=c(1,1))
mtext("Coca Cola Earnings: 1983-2009", side = 3, line = 1)

# ACF plot
acf(log.eps, main = "ACF de log(EPS) da Coca-Cola")

# Time plot da primeira diferenca
diff.log.eps <- diff(log.eps)
plot(diff.log.eps, main = "Primeira diferença de log(EPS) da Coca-Cola",
     ylab = expression(paste(Delta,"log(EPS)")))
points(diff.log.eps, pch= c('2','3','4','1'), cex = 0.75)

# ACF da primeira diferenca
acf(diff.log.eps, main = expression(paste("ACF de ", Delta, "log(EPS)")))

# Diferenca sazonal
diff4.log.eps <- diff(diff.log.eps, 4)
plot(diff4.log.eps, ylab = expression(paste(Delta[4],"[",Delta,"log(EPS)]")),
     main = "Time plot da diferença sazonal\n da primeira diferença de log(EPS) da Coca-Cola")
points(diff4.log.eps, pch= c('2','3','4','1'), cex = 0.75)

# ACF da diferenca sazonal
acf(diff4.log.eps, main = "ACF da diferença sazonal\n da primeira diferença de log(EPS) da Coca-Cola")
