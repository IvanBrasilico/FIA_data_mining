# Iniciar gravação do arquivo de resultados [esse comando grava só os resultados em .txt]
setwd("C:/Users/eduar/Dropbox/_Comercial/FIA - projetos/[d] Cursos/2017_DataMiningReceita/Aulas/Exercicios")
sink("_Modulo2_Resultados.txt", append=FALSE, split=TRUE)

#**************************************************************************
# FIA - CURSO DATAMINING PARA RECEITA
# TÓPICO: ANÁLISE DE REGRESSÃO - Módulo 2
# SCRIPTS EM R
# DOCENTE: Prof. Dr. Eduardo K. Kayo
#**************************************************************************

#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# ALGUMAS DICAS PARA FORMATAR AS TABELAS DE RESULTADO
# 1. Usar o pacote "stargazer" ensinado neste módulo (para texto, html e Latex)
# 2. Abrir arquivo de resultados .txt no Excel e formatar como desejar
#    - usar o comando "sink" (vide linha 3) para gravar os resultados em txt
#    - Mudar "Região e idioma" para "Inglês EUA" no Painel de Controle do Windows
#    - Abrir o software Excel
#    - Carregar o arquivo de resultados .txt a partir do Excel
#          - "opção": Largura Fixa
#          - "Origem do arquivo": "Windows (ANSI)" ou outro adequado
#          - Clique "Avançar"
#          - Definir os delimitadores na régua de "Visualização dos dados"
#          - Clique em "Concluir"
#          - Uma vez baixado o arquivo, formate a vontade
#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# EXEMPLOS DE AULA
#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

### EXEMPLO 6 - PREÇOS DE IMÓVEIS

# Definir diretório de trabalho [o usuário define o diretório que lhe convier]
setwd("C:/Users/eduar/Dropbox/2017_DataMiningReceita/Aulas/Exercicios")

# Apagar a memória
rm(list=ls())
ls()

# Carregar base de outro tipo de software (stata)
library(foreign)
HPRICE1 <- read.dta("HPRICE1-Kayo.dta")

# Checar se arquivo foi carregado
ls()

# Regressão principal
Exemplo06 <- lm(price ~ lotsize + sqrft + bdrms, data=HPRICE1)
summary(Exemplo06)

# Teste Breusch-Pagan para Heteroscedasticidade (default: resíduos studentizados) 
library(lmtest)
bptest(Exemplo06)

# Pacote stargazer: uma forma mais bonita para a tabela
library(stargazer)
stargazer(Exemplo06, type="text", title="Análise de regressão", dep.var.labels=c("Preços"), covariate.labels=c("Tamanho do terreno","Área construída","Quartos"))

#--------------------------------------------------------------------------

### EXEMPLO 7 - PREÇOS DE IMÓVEIS com regressão em log

# Modificando a forma funcional (com log) para reduzir heteroscedasticidade
Exemplo07 <- lm(log(price)~log(lotsize)+log(sqrft)+bdrms, data=HPRICE1)
summary(Exemplo07)

library(stargazer)
stargazer(Exemplo07, type="text", title="Análise de regressão", dep.var.labels=c("log(Preços)"), covariate.labels=c("log(Tamanho do terreno)","log(Área construída)","Quartos"))

# Teste de Breusch-Pagan  
library(lmtest)
bptest(Exemplo07)

#--------------------------------------------------------------------------

### EXEMPLO 8 - PREÇOS DE IMÓVEIS COM ERROS ROBUSTOS À HETEROSCEDASTICIDADE
Exemplo08 <- lm(price ~ lotsize + sqrft + bdrms, data=HPRICE1)
summary(Exemplo08)
library(sandwich)
library(lmtest)
coeftest(Exemplo08, vcov=vcovHC(Exemplo08,type="HC0")) 

Exemplo08b <- coeftest(Exemplo08, vcov=vcovHC(Exemplo08,type="HC0")) 
summary(Exemplo08b)

library(stargazer)
stargazer(Exemplo06, Exemplo08b, type="text", title="Análise de regressão", dep.var.labels=c("Preços","Erros robustos"), covariate.labels=c("Tamanho do terreno","Área construída","Quartos"))

#--------------------------------------------------------------------------

### EXEMPLO 9 - VARIÁVEIS EM LOGARITMO NATURAL (LN)

# Definir diretório de trabalho [o usuário define o diretório que lhe convier]
setwd("C:/Users/eduar/Dropbox/2017_DataMiningReceita/Aulas/Exercicios")

# Importar matriz de dados do Stata
library(foreign)
HPRICE2 <- read.dta("HPRICE2-Kayo.dta")

# Regressão
Exemplo09 <- lm(log(price) ~ log(nox) + rooms, data=HPRICE2)
summary(Exemplo09)

library(stargazer)
stargazer(Exemplo09, type="text", title="Análise de regressão", dep.var.labels=c("log(Preços)"), covariate.labels=c("log(poluição)","Cômodos"))

#--------------------------------------------------------------------------

### EXEMPLO 10 - REGRESSÃO QUADRÁTICA

# Definir diretório de trabalho [o usuário define o diretório que lhe convier]
setwd("C:/Users/eduar/Dropbox/2017_DataMiningReceita/Aulas/Exercicios")

# Apagar a memória
rm(list=ls())
ls()

# Importar matriz de dados do Stata
library(foreign)
WAGE1 <- read.dta("WAGE1-Kayo.dta")

# Regressão quadrática
Exemplo10 <- lm(wage~exper+I(exper^2), data=WAGE1)
summary(Exemplo10)

# Regressão quadrática alternativa (criação de variável quadrática antecipadamente)
WAGE1$exp_2 <- WAGE1$exper * WAGE1$exper

Exemplo10b <- lm(wage ~ exper + exp_2, data=WAGE1)
summary(Exemplo10b)

stargazer(Exemplo10, type="text", title="Análise de regressão quadrática", dep.var.labels=c("Wage"), covariate.labels=c("Experiência","Exper. ao quadrado"))

# Gráfico da regressão quadrática

wagehat <- predict(Exemplo10)

plot(sort(WAGE1$exper),wagehat[order(WAGE1$exper)],type='l',col='red', xlab="Experience", ylab="Wage")

#--------------------------------------------------------------------------

### EXEMPLO 11 - OUTRA REGRESSÃO QUADRÁTICA???

# Definir diretório de trabalho [o usuário define o diretório que lhe convier]
setwd("C:/Users/eduar/Dropbox/2017_DataMiningReceita/Aulas/Exercicios")

# Apagar a memória
rm(list=ls())
ls()

# Importar matriz de dados do Stata
library(foreign)
HPRICE2 <- read.dta("HPRICE2-Kayo.dta")

# Regressão
Exemplo11 <- lm(log(price)~log(nox)+log(dist)+rooms+I(rooms^2)+stratio, data=HPRICE2)
summary(Exemplo11)

library(stargazer)
stargazer(Exemplo11, type="text", title="Análise de regressão", dep.var.labels=c("log(Preços)"), covariate.labels=c("log(poluição)","log(Distância centro)","Cômodos","Cômodos ao quadrado","Prop.estud/prof"))

# Gráfico da regressão quadrática
Exemplo11b <- lm(log(price)~rooms+I(rooms^2), data=HPRICE2)

pricehat <- predict(Exemplo11b)

plot(sort(HPRICE2$rooms),pricehat[order(HPRICE2$rooms)],type='l',col='red', xlab="Cômodos", ylab="log(Preço)")

#--------------------------------------------------------------------------

### EXEMPLO 12 - VARIÁVEIS BINÁRIAS

# Alterar diretório de trabalho
setwd("C:/Users/eduar/Dropbox/2017_DataMiningReceita/Aulas/Exercicios")

# Apagar a memória
rm(list=ls())
ls()

# Importar matriz de dados do Stata
library(foreign)
WAGE1 <- read.dta("WAGE1-Kayo.dta")

# Regressão simples com variável dummy (FEMALE = 1)
Exemplo12 <- lm(wage~female, data=WAGE1)
summary(Exemplo12)

#--------------------------------------------------------------------------

### EXEMPLO 13 - VARIÁVEIS BINÁRIAS COM VARIÁVEIS DE CONTROLE

# Regressão com variável dummy (FEMALE = 1) e variáveis de controle
Exemplo13 <- lm(wage~female+educ+exper+tenure, data=WAGE1)
summary(Exemplo13)

# Testantdo heteroscedasticidade
library(lmtest)
bptest(Exemplo13)

# Aplicando os erros robusto à heteroscedasticidade
library(sandwich)
library(lmtest)
coeftest(Exemplo13, vcov=vcovHC(Exemplo13,type="HC0")) 

#--------------------------------------------------------------------------

### EXEMPLO 14 - LOG NA VARIÁVEL DEPENDENTE E DUMMYS COMO INDEPENDENTE

# Regressão com variável dummy (FEMALE = 1) e variáveis de controle
Exemplo14 <- lm(log(wage)~female+educ+exper+expersq+tenure+tenursq, data=WAGE1)
summary(Exemplo14)

#--------------------------------------------------------------------------

### EXEMPLO 15 - VARIÁVEIS DE INTERAÇÃO ENTRE VARIÁVEIS DUMMY

# Alterar diretório de trabalho
setwd("C:/Users/eduar/Dropbox/2017_DataMiningReceita/Aulas/Exercicios")

# Apagar a memória
rm(list=ls())
ls()

# Importar matriz de dados do Stata
library(foreign)
WAGE1 <- read.dta("WAGE1-Kayo.dta")

# Regressão com variável dummy (FEMALE = 1), estado civil e variáveis de controle
Exemplo15 <- lm(log(wage)~female*married+educ+exper+expersq+tenure+tenursq, data=WAGE1)
summary(Exemplo15)

#--------------------------------------------------------------------------

### EXEMPLO 16 - VARIÁVEIS DE INTERAÇÃO ENTRE VARIÁVEIS DUMMY E MÉTRICAS

# Regressão com com interação entre female e educ
Exemplo16 <- lm(log(wage)~female*educ+exper+expersq+tenure+tenursq, data=WAGE1)
summary(Exemplo16)

#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# EXERCÍCIOS
#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

### Exercício C

# Alterar diretório de trabalho
setwd("C:/Users/eduar/Dropbox/2017_DataMiningReceita/Aulas/Exercicios")

# Apagar a memória
rm(list=ls())
ls()

# Carregando o arquivo
WAGE1 <- read.dta("WAGE1-Kayo.dta")

# Regressão
ExercicioC <- lm(log(wage)~female*exper+educ+expersq+tenure+tenursq, data=WAGE1)
summary(ExercicioC)

#--------------------------------------------------------------------------

### Exercício D

# Alterar diretório de trabalho
setwd("C:/Users/eduar/Dropbox/2017_DataMiningReceita/Aulas/Exercicios")

# Apagar a memória
rm(list=ls())
ls()

# Carregando o arquivo
ENDIV1 <- read.table("ENDIV1.csv", header=TRUE, sep=",")

# Regressão
ExercicioD <- lm(mb ~ endiv1 + I(endiv1^2) + lucrat2, data=ENDIV1)
summary(ExercicioD)

#--------------------------------------------------------------------------

# Encerrar gravação do arquivo de resultados
sink()


# Apagar a memória
rm(list=ls())




