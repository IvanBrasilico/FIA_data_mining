setwd('D:/Users/25052288840/Downloads/FIA_data_mining/Aula 13 - Análise discriminante')

library(readxl)
creditscore <-read_excel('creditscore.xls.xlsx')

par(mfrow=c(1,3))
boxplot(renda~atraso,
        data=creditscore, main="renda nos grupos", col=rainbow(2))
boxplot(estudo~atraso,
        data=creditscore, main="estudo nos grupos", col=rainbow(2))
boxplot(creditos~atraso,
        data=creditscore, main="creditos nos grupos", col=rainbow(2))
par(mfrow=c(1,1))

library(psych)
describe(creditscore)
describeBy(creditscore, creditscore$atraso)

library(car)
qqPlot(creditscore$renda, groups=creditscore$atraso)
qqPlot(creditscore$estudo, groups=creditscore$atraso)
qqPlot(creditscore$creditos, groups=creditscore$atraso)


aov.res<-aov(renda~atraso, data=creditscore)
summary(aov.res)
aov.res<-aov(estudo~atraso, data=creditscore)
summary(aov.res)
aov.res<-aov(creditos~atraso, data=creditscore)
summary(aov.res)

t.test(var.equal=TRUE, renda~atraso, data=creditscore)
t.test(var.equal=FALSE, estudo~atraso, data=creditscore)
t.test(var.equal=TRUE, creditos~atraso, data=creditscore)


# 1
library(MASS)
result.lda1<-lda(atraso~., data=creditscore)
print(result.lda1)
# Z = -0.00143 * renda -0.009 * estudo +0.7664 * creditos
plot(result.lda1)

# 2 
library(klaR)
greedy.wilks(atraso~., data=creditscore, niveau=0.99)
greedy.wilks(atraso~., data=creditscore)
result.lda2<-lda(atraso~renda+creditos, data=creditscore)
print(result.lda2)
# Z = -0.00144 * renda + 0.7614 * creditos
plot(result.lda2)

# 3 
library(biotools)
boxM(creditscore[,2:4],creditscore$atraso)
help(boxM)
# 4
creditordem<-creditscore[order(creditscore$atraso),]
credits<-creditordem[creditordem$atraso=="S",]
creditn<-creditordem[creditordem$atraso=="N",]
library(nortest)
lillie.test(credits$renda)
lillie.test(creditn$renda)

lillie.test(credits$estudo)
lillie.test(creditn$estudo)

lillie.test(credits$creditos)
lillie.test(creditn$creditos)

