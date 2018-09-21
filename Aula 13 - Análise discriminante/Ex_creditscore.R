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


credit <-read.csv("CREDITSCORE.csv", header=TRUE, sep=";")
par(mfrow=c(1,3))
boxplot(ESTUDO~STATUS, credit, main="ESTUDO NOS GRUPOS",
        col=rainbow(2))
boxplot(RENDA~STATUS, credit, main="RENDA NOS GRUPOS", col=rainbow(2))
boxplot(TEMPREG~STATUS, credit, main="TEMPO NO EMPREGO NOS GRUPOS",
        col=rainbow(2))
par(mfrow=c(1,1))

library(psych)
describeBy(credit, credit$STATUS)

library(car)
qqPlot(credit$RENDA, groups=credit$STATUS)
qqPlot(credit$TEMPREG, groups=credit$STATUS)
qqPlot(credit$ESTUDO, groups=credit$STATUS)

creditordem<-credit[order(credit$STATUS),]
creditzero<-creditordem[creditordem$STATUS==0,]
creditum<-creditordem[creditordem$STATUS==1,]
Library(nortest)
lillie.test(creditzero$RENDA)
lillie.test(creditum$RENDA)
ad.test(creditzero$RENDA)
ad.test(creditum$RENDA)

lillie.test(creditzero$TEMPREG)
lillie.test(creditum$TEMPREG)
ad.test(creditzero$TEMPREG)
ad.test(creditum$TEMPREG)

lillie.test(creditzero$ESTUDO)
lillie.test(creditum$ESTUDO)
ad.test(creditzero$ESTUDO)
ad.test(creditum$ESTUDO)

library(biotools)
boxM(credit[,2:4],credit$STATUS)

Library(klaR)
greedy.wilks(STATUS~., credit, niveau=.99)

greedy.wilks(STATUS~., credit)


creditstepwise <- lda(STATUS~RENDA + TEMPREG, credit)
plot(creditstepwise)


scores<-predict(creditstepwise)
scoresdiscrimin<-as.data.frame(scores)

par(mfrow=c(1,1))
boxplot(LD1~class, scoresdiscrimin, main= "SCORES DISCRIMINANTES NOS GRUPOS",
         col=rainbow(2))

install.packages('PredPsych')
library(PredPsych)
LinearDA(credit, 1, cvType="holdout", cvFraction = 0.75)

credit2 <- credit[c("STATUS", "RENDA", "TEMPREG")]
LinearDA(credit2, 1, cvType="holdout", cvFraction = 0.75)
