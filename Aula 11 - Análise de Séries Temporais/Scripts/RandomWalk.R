# Simulacao de series com raiz unitaria

# Passeio aleatorio
set.seed(1)
n <- 500
a <- rnorm(n-1)
p0 <- 10
p <- NULL
for(i in 2:n){
  p[1] <- p0
  p[i] <- p[i-1] + a[i]
}
plot(p, type = "l", main = "Passeio aleatório")
mtext(expression(paste(p[t]," = ",p[t-1]," + ",a[t])))
plot(diff(p,1), type = "l", ylab = expression(paste(Delta,"p")),
     , main = "Diferença do passeio aleatório")

# Passeio aleatorio com drift
set.seed(1)
n <- 500
mu <- 0.1
a <- rnorm(n-1)
p0 <- 10
p <- NULL
for(i in 2:n){
  p[1] <- p0 + mu
  p[i] <- p[i-1] + a[i] + mu
}
pad <- plot(p, type = "l", main = "Passeio aleatório com drift")
mtext(expression(paste(p[t]," = ",mu, " + ", p[t-1]," + ",a[t])))
plot(diff(p,1), type = "l", ylab = expression(paste(Delta,"p")),
     , main = "Diferença do passeio aleatório com drift")

# Passeio aleatorio com tendencia
set.seed(1)
n <- 500
b0 <- 10
b1 <- 0.025
a <- rnorm(n)
p <- NULL
for(i in 2:n){
  p[i] <- b0 + b1 * (i-1) + a[i]
}
pat <- plot(p, type = "l", main = "Passeio aleatório com tendência")
mtext(expression(paste(p[t]," = ",beta[0]," + ",beta[1],"t + ",a[t])))
plot(diff(p,1), type = "l", ylab = expression(paste(Delta,"p")),
     , main = "Diferença do passeio aleatório com tendência")

