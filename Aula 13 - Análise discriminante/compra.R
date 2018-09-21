# install.packages('readxl')
library(readxl)
setwd('D:/Users/25052288840/Downloads/FIA_data_mining/Aula 13 - Análise discriminante')
compra_xls <-read_excel('compra.xls.xlsx')

par(mfrow=c(1,3))
boxplot(durabilid~compra,
        data=compra_xls, main="durabilidade nos grupos", col=rainbow(2))
boxplot(desempenh~compra,
        data=compra_xls, main="desempenho nos grupos", col=rainbow(2))
boxplot(estilo~compra,
        data=compra_xls, main="estilo nos grupos", col=rainbow(2))
par(mfrow=c(1,1))

# install.packages('psych')
library(psych)
describe(compra_xls)

describeBy(compra_xls, compra_xls$compra)

var.test( durabilid~compra, data=compra_xls)
var.test( desempenh~compra, data=compra_xls)
var.test( estilo~compra, data=compra_xls)

t.test(var.equal=TRUE, durabilid~compra, data=compra_xls)
t.test(var.equal=FALSE, durabilid~compra, data=compra_xls)

t.test(var.equal=TRUE, desempenh~compra, data=compra_xls)

t.test(var.equal=TRUE, estilo~compra, data=compra_xls)
aov.res<-aov(durabilid~compra, data=compra_xls)
summary(aov.res)
aov.res<-aov(desempenh~compra, data=compra_xls)
summary(aov.res)
aov.res<-aov(estilo~compra, data=compra_xls)
summary(aov.res)

library(MASS)
result.lda<-lda(compra~., data=compra_xls)
predict(result.lda)

comprapredic<-read.csv("comprapredic.csv", header=TRUE, sep=";")
y_ = predict(result.lda, comprapredic)

print(y_)

install.packages('klaR')
library(klaR)
greedy.wilks(compra~., data=compra_xls, niveau=0.99)
greedy.wilks(compra~., data=compra_xls)

lda(compra~durabilid+desempenh, data=compra_xls)


lda(compra~durabilid, data=compra_xls)

plot(lda(compra~durabilid+desempenh, data=compra_xls))

# install.packages('car')
library(car)
qqPlot(compra_xls$durabilid, groups=compra_xls$compra)
qqPlot(compra_xls$desempenh, groups=compra_xls$compra)
qqPlot(compra_xls$estilo, groups=compra_xls$compra)


compraordem<-compra_xls[order(compra_xls$compra),]
compranao<-compraordem[compraordem$compra=="nao",]
comprasim<-compraordem[compraordem$compra=="sim",]

install.packages('nortest')
library(nortest)
lillie.test(compranao$durabilid)
shapiro.test(compranao$durabilid)
lillie.test(comprasim$durabilid)
shapiro.test(comprasim$durabilid)
lillie.test(compranao$desempenh)
shapiro.test(compranao$desempenh)
lillie.test(comprasim$desempenh)
shapiro.test(comprasim$desempenh)


install.packages('biotools')
library(biotools)
boxM(compra_xls[,2:4], compra_xls$compra)
