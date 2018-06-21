# Iniciar gravação do arquivo de resultados [esse comando grava só os resultados em .txt]
setwd("C:/Users/eduar/Dropbox/_Comercial/FIA - projetos/[d] Cursos/2017_DataMiningReceita/Aulas/Exercicios")
sink("_Modulo1_Resultados.txt", append=FALSE, split=TRUE)

#**************************************************************************
# FIA - CURSO DATAMINING PARA RECEITA
# TÓPICO: ANÁLISE DE REGRESSÃO - Módulo 1
# SCRIPTS EM R
# DOCENTE: Prof. Dr. Eduardo K. Kayo
#**************************************************************************

#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# ALGUMAS DICAS:
# - o símbolo # é utilizado no início da linha de um texto, não de comando.
# - para visualizar a matriz inteira, você pode usar o Rcomander ou 
#   simplesmente digitar o nome do arquivo no console do R.
# - os exemplos e exercícios são enunciados nos slides das respectivas
#   aulas; acompanhe os slides concentuais e desenvolva os exercícios
#   usando os scripts desses arquivos.
# - comandos e recursos adicionais podem ser encontrados em fóruns de dis-
#   cussão na internet.
#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# EXEMPLOS DE AULA
#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

### EXEMPLO 1 - FAZENDO O SCRIPT BÁSICO DE UMA REGRESSÃO

# 1. Definir diretório de trabalho [o usuário define o diretório que lhe convier]
setwd("C:/Users/eduar/Dropbox/_Comercial/FIA - projetos/[d] Cursos/2017_DataMiningReceita/Aulas/Exercicios")

# 2. Carregar arquivo .CSV
SalMensal <- read.table("SalMensal.csv", header=TRUE, sep=",")

# 3. Checar se arquivo foi carregado
ls()

# 4. Sempre que você quiser ver sua base de dados, basta digitar o nome do arquivo:
SalMensal

# 5. Regressão simples
Exemplo01 <- lm(sal~man, data=SalMensal)
summary(Exemplo01)

# 6. Plotar gráfico salário x homem
Graf <- plot(sal~man, data=SalMensal)
abline(Exemplo01)

# 7. Apagar a memória [quando as análises se encerrarem; comando opcional]
rm(list=ls())

#--------------------------------------------------------------------------

### EXEMPLO 2 - O SALÁRIO DO CEO

# 1. Definir diretório de trabalho [o usuário define o diretório que lhe convier]
setwd("C:/Users/eduar/Dropbox/_Comercial/FIA - projetos/[d] Cursos/2017_DataMiningReceita/Aulas/Exercicios")

# 2. Carregar arquivo
load("CEOSAL1.rda")  

# 3. Checar se arquivo foi carregado
ls()

# 4. Regressão simples
Exemplo02 <- lm(salary~roe, data=CEOSAL1)
summary(Exemplo02)

# 5. Plotar gráfico salário x roe
Graf <- plot(salary~roe, data=CEOSAL1)
abline(Exemplo02)

# 6. Gravar valores estimados e resíduos como novas variáveis aleatórias
CEOSAL1$fit <- fitted(Exemplo02)
CEOSAL1$res <- resid(Exemplo02)

# 7. visualizar a matriz (6 primeiras linhas)
head(CEOSAL1)

#--------------------------------------------------------------------------

### EXEMPLO 3 - FÓRMULA 1

# 1. Definir diretório de trabalho [o usuário define o diretório que lhe convier]
setwd("C:/Users/eduar/Dropbox/_Comercial/FIA - projetos/[d] Cursos/2017_DataMiningReceita/Aulas/Exercicios")

# 2. Carregar arquivo .CSV
F1 <- read.table("F1.csv", header=TRUE, sep=",")

# 3. Salvando matriz como arquivo .rda para uso futuro
save(F1,file="F1.rda")

# 4. Checar se arquivo foi carregado
ls()

# 5. Visualizar os nomes das variáveis
names(F1)

# 6. Rodando a regressão simples
Exemplo03a <- lm(points~rain_mm, data=F1)
summary(Exemplo03a)

# 7. Rodando a regressão múltipla
Exemplo03b <- lm(points ~ rain_mm + training, data=F1)
summary(Exemplo03b)

# 8. Matriz de correlações
library(Rcmdr)
rcorr.adjust(F1[,c("rain_mm","training")], type="pearson")

#--------------------------------------------------------------------------

### EXEMPLO 4 - Tipos de escolaridade e salários

# Providência preliminar
# - Instalação do pacote "car", caso você ainda não tenha instalado

# 1. Definir diretório de trabalho [o usuário define o diretório que lhe convier]
setwd("C:/Users/eduar/Dropbox/_Comercial/FIA - projetos/[d] Cursos/2017_DataMiningReceita/Aulas/Exercicios")

# 2. Carregar arquivo .CSV
twoyear <- read.table("twoyear.csv", header=TRUE, sep=",")

# 3. Checar se arquivo foi carregado
ls()

# 4. Visualizar os nomes das variáveis
names(twoyear)

# 5. Rodando a regressão 
Exemplo04 <- lm(lwage ~ jc + univ + exper, data=twoyear)
summary(Exemplo04)

# 6. Carregando o pacote "car"
library("car")

# 7. Testando diferença entre coeficientes
linearHypothesis(Exemplo04, c("jc = univ"))

#--------------------------------------------------------------------------

### EXEMPLO 5 - Determinantes dos salários dos jogadores de baseball

# 1. Definir diretório de trabalho [o usuário define o diretório que lhe convier]
setwd("C:/Users/eduar/Dropbox/_Comercial/FIA - projetos/[d] Cursos/2017_DataMiningReceita/Aulas/Exercicios")

# 2. Carregar arquivo .CSV
MLB1 <- read.table("MLB1.csv", header=TRUE, sep=",")

# 3. Checar se arquivo foi carregado
ls()

# 4. Visualizar os nomes das variáveis
names(MLB1)

# 5. Rodando a regressão 
Exemplo05 <- lm(lsalary ~ years + gamesyr + bavg + hrunsyr + rbisyr, data=MLB1)
summary(Exemplo05)

# 6. Carregando o pacote "car"
library("car")

# 7. Testando se coeficientes em conjunto são significantes
linearHypothesis(Exemplo05, c("bavg + hrunsyr + rbisyr = 0"))

#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# EXERCÍCIOS
#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


### Exercício A

# 1. Definir diretório de trabalho [o usuário define o diretório que lhe convier]
setwd("C:/Users/eduar/Dropbox/_Comercial/FIA - projetos/[d] Cursos/2017_DataMiningReceita/Aulas/Exercicios")

# 2. Carregar arquivo
load("CEOSAL1.rda")  

# 3. Checar se arquivo foi carregado
ls()

# 4. Visualizar os nomes das variáveis
names(CEOSAL1)

# 5. Regressão simples
ExercicioA <- lm(lsalary ~ lsales + roe + finance + consprod + utility, data=CEOSAL1)
summary(ExercicioA)

# 7. Gravar valores estimados e resíduos como novas variáveis aleatórias
CEOSAL1$fitExA <- fitted(ExercicioA)
CEOSAL1$resExA <- resid(ExercicioA)

# 8. visualizar a matriz (6 primeiras linhas)
head(CEOSAL1)

# 9. Carregando o pacote "car"
library("car")

# 10. Testando a diferença entre os salários dos CEOs de produtos de consumo x financeiro
linearHypothesis(ExercicioA, c("finance = consprod"))

#--------------------------------------------------------------------------

### Exercício B. 

# 1. Definir diretório de trabalho [o usuário define o diretório que lhe convier]
setwd("C:/Users/eduar/Dropbox/_Comercial/FIA - projetos/[d] Cursos/2017_DataMiningReceita/Aulas/Exercicios")

# 2. Carregar arquivo .CSV
ENDIV1 <- read.table("ENDIV1.csv", header=TRUE, sep=",")

# 3. Checar se arquivo foi carregado
ls()

# 4. Visualizar os nomes das variáveis
names(ENDIV1)

# 5. Visualizar a matriz (6 primeiras linhas)
head(ENDIV1)

# 6. Algumas estatísticas descritivas posteriormente exploraremos mais essas informações
summary (ENDIV1[,c("endiv1","roa","mb","lntam")])

# 7. Matriz de correlação (carregar package Rcmdr)
library(Rcmdr)
rcorr.adjust(ENDIV1[,c("endiv1","roa","mb","lntam")], type="pearson")

# 8. Regressões com variável dependente = endiv1
ExercicioB1 <- lm(endiv1 ~ roa, data=ENDIV1)
summary(ExercicioB1)

ExercicioB2 <- lm(endiv1 ~ roa + mb + lntam, data=ENDIV1)
summary(ExercicioB2)

# 9. Regressões com variável dependente = mb
ExercicioB3 <- lm(mb ~ lucrat2, data=ENDIV1)
summary(ExercicioB3)

ExercicioB4 <- lm(mb ~ lucrat2 + endiv1 + lntam, data=ENDIV1)
summary(ExercicioB4)

#**************************************************************************

# Encerrar gravação do arquivo de resultados
sink()
