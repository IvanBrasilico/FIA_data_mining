# Iniciar gravação do arquivo de resultados [esse comando grava só os resultados em .txt]
setwd("C:/Users/eduar/Dropbox/2017_DataMiningReceita/Aulas/Exercicios")
sink("_Modulo3_Resultados.txt", append=FALSE, split=TRUE)

#**************************************************************************
# FIA - CURSO DATAMINING PARA RECEITA
# TÓPICO: ANÁLISE DE REGRESSÃO - Módulo 3
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

### EXEMPLO 17 - ÍNDICES DE CRIMINALIDADE

# Definir diretório de trabalho [o usuário define o diretório que lhe convier]
setwd("C:/Users/eduar/Dropbox/2017_DataMiningReceita/Aulas/Exercicios")
  
# Apagar a memória
rm(list=ls())
ls()

# Importar matriz de dados do Stata
library(foreign)
CRIME2 <- read.dta("CRIME2-Kayo.dta")

# Checar se arquivo foi carregado
ls()

# Salvar matriz como arquivo .rda para uso futuro
save(CRIME2,file="CRIME2.rda")

# Visualizar os nomes das variáveis
names(CRIME2)

## Regressão apenas com dados de 1987
Exemplo17 <- lm(crmrte~unem, data=subset(CRIME2,year==87))
summary(Exemplo17)

#--------------------------------------------------------------------------

### EXEMPLO 18 - ÍNDICES DE CRIMINALIDADE COM DADOS AGRUPADOS

## Regressão com os dados agrupados de 1982 e 1987 (pooled)
Exemplo18 <- lm(crmrte~d87+unem, data=CRIME2)
summary(Exemplo18)

# ou Alternativamente...
library(plm)
CRIME2PANEL <- pdata.frame(CRIME2, index = c("area","year"))
Exemplo18B <- plm(crmrte~d87+unem, data=CRIME2PANEL, model = "pooling")
summary(Exemplo18B)

#--------------------------------------------------------------------------

### EXEMPLO 19 - ÍNDICES DE CRIMINALIDADE COM EFEITOS FIXOS (within)
library(plm)
CRIME2PANEL <- pdata.frame(CRIME2, index = c("area","year"))
Exemplo19 <- plm(crmrte~d87+unem, data=CRIME2PANEL, model = "within")
summary(Exemplo19)

#--------------------------------------------------------------------------

### EXEMPLO 20 - DETERMINANTES DO SALÁRIO COM DADOS AGRUPADOS (POOLED)

# Importar matriz de dados do Stata
library(foreign)
WAGEPAN <- read.dta("WAGEPAN-Kayo.dta")

# Visualizar os objetos carregados na memória
ls()

# Visualizar os nomes das variáveis
names(WAGEPAN)

# Visualizar a matriz (6 primeiras linhas)
head(WAGEPAN)

# Salvar matriz como arquivo .rda para uso futuro
save(WAGEPAN,file="WAGEPAN.rda")

# Checar se arquivo .rda foi salvo
dir()

## Regressão com dados agrupados, efeitos aleatórios e efeitos fixos
library(plm)
WAGEPANEL <- pdata.frame(WAGEPAN, index = c("nr","year"))

# Dados agrupados
Exemplo20 <- plm(lwage~educ+black+hisp+exper+expersq+married+union+
                   d81+d82+d83+d84+d85+d86+d87, data=WAGEPANEL, model = "pooling")
summary(Exemplo20)

#--------------------------------------------------------------------------

### EXEMPLO 21 - DETERMINANTES DO SALÁRIO COM EFEITOS ALEATÓRIOS

# efeitos aleatórios
Exemplo21 <- plm(lwage~educ+black+hisp+exper+expersq+married+union+
                   d81+d82+d83+d84+d85+d86+d87, data=WAGEPANEL, model = "random")
summary(Exemplo21)

#--------------------------------------------------------------------------

### EXEMPLO 22 - DETERMINANTES DO SALÁRIO COM EFEITOS FIXOS

# efeitos fixos
Exemplo22 <- plm(lwage~educ+black+hisp+exper+expersq+married+union+
                   d81+d82+d83+d84+d85+d86+d87, data=WAGEPANEL, model = "within")
summary(Exemplo22)

#--------------------------------------------------------------------------

### EXEMPLO 23 E 24 - ESCOLHA ENTRE POLS, EFEITOS ALEATÓRIOS OU EFEITOS FIXOS

# Teste de Breush-Pagan para escolha entre POLS ou efeitos aleatórios
plmtest(Exemplo21, effect = c("individual"), type = c("bp"))

# Teste de Hausman para escolha entre efeitos fixos ou aleatórios
phtest(Exemplo21, Exemplo22)



#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# EXERCÍCIOS
#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

### Exercício E

# Carregar arquivo
load("GRUNFELD.rda")  

# Checar se OBJETO arquivo foi carregado
ls()

## Regressão com dados agrupados, efeitos aleatórios e efeitos fixos
library(plm)
GRUNFELDPANEL <- pdata.frame(Grunfeld, index = c("firm","year"))

# Dados agrupados
ExercicioE1 <- plm(inv~value+capital, data=GRUNFELDPANEL, model = "pooling")
summary(ExercicioE1)

# efeitos aleatórios
ExercicioE2 <- plm(inv~value+capital, data=GRUNFELDPANEL, model = "random")
summary(ExercicioE2)

# efeitos fixos
ExercicioE3 <- plm(inv~value+capital, data=GRUNFELDPANEL, model = "within")
summary(ExercicioE3)

# Teste de Breush-Pagan para escolha entre POLS ou efeitos aleatórios
plmtest(ExercicioE2, effect = c("individual"), type = c("bp"))

# Teste de Hausman para escolha entre efeitos fixos ou aleatórios
phtest(ExercicioE2, ExercicioE3)

### Incluindo variáveis dummy de tempo

# efeitos aleatórios (o termo "factor(...)" exerce o mesmo efeito de se criar várias variáveis dummy)
ExercicioE4 <- plm(inv~value+capital+factor(year), data=GRUNFELDPANEL, model = "random")
summary(ExercicioE4)

# efeitos fixos
ExercicioE5 <- plm(inv~value+capital+factor(year), data=GRUNFELDPANEL, model = "within")
summary(ExercicioE5)

# Teste de Breush-Pagan para escolha entre POLS ou efeitos aleatórios
plmtest(ExercicioE4, effect = c("individual"), type = c("bp"))

# Teste de Hausman para escolha entre efeitos fixos ou aleatórios
phtest(ExercicioE4, ExercicioE5)

#--------------------------------------------------------------------------


# Encerrar gravação do arquivo de resultados
sink()


# Apagar a memória
rm(list=ls())




