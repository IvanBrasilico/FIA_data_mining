# Iniciar grava??o do arquivo de resultados [esse comando grava s? os resultados em .txt]
#setwd("C:/Users/eduar/Dropbox/2017_DataMiningReceita/Aulas/ExercicioConsolidado")
setwd("D:/Users/25052288840/Downloads/FIA_data_mining/Regressao/")
sink("_ExercicioConsolidado-v01.txt", append=FALSE, split=TRUE)

#****************************************************************************
# FIA - CURSO DATAMINING PARA RECEITA
# T?PICO: AN?LISE DE REGRESS?O
# SCRIPTS EM R - EXERC?CIO CONSOLIDADO
# DOCENTE: Prof. Dr. Eduardo K. Kayo
#****************************************************************************

#****************************************************************************************************************
#****************************************************************************************************************
# ENUNCIADO DO EXERC?CIO CONSOLIDADO:
#
# Usando a base de dados disponibilizada (INVEST.dta), seu objetivo ? 
# analisar a rela??o entre o fluxo de caixa gerado pelas empresas e os seus 
# investimentos (o chamado investment-cash flow sensitivity). Essa base 
# de dados traz dados econ?mico-financeiros de empresas do setor de 
# produtos qu?micos (sic code 28) dos EUA no per?odo de 2001 a 2007.
#
# An?lises solicitadas:
# 
# 1) Carregar a matriz de dados INVEST.dta (? uma matriz no formato do software Stata; vide Parte II)
#
# 2) Calcular algumas vari?veis (criar novas colunas na matriz de dados; vide Parte I): 
#    - Investmento (invest) = disp?ndios com capital (capex) dividido pelo ativo total (ttasset)
#    - Q de Tobin (tobinq) = valor de mercado total da empresa (mktval + debt) dividido pelo ativo total (ttasset)
#    - Fluxo de caixa (cashfl): fluxo de caixa gerado no per?odo (cashflow3) dividido pelo ativo total (ttasset)
#    - Tangibilidade (tang): ativo fixo (ppe) dividido pelo ativo total (ttasset)
#    - Tamanho da empresa (size): logaritmo natural do ativo total (ttasset)
#    - Intera??o entre fluxo de caixa e tangibilidade (cash_tang): cashfl * tang
#
# 3) Gerar estat?sticas descritivas (vide Parte I)
#    - As estat?sticas mostrar?o alguns valores extremos sugerindo que devemos tomar algumas medidas
#      para "limpar" a matriz de dados
#
# 4) Fazer uma filtragem dos dados
#    - Criar um novo objeto (INVEST2) com uma sub-amostra de observa??es com Q de Tobin MENOR que 10,
#      excluindo as observa??es com poss?veis erros de medida nessa vari?vel.
#    - gerar novas estat?sticas descritivas para a nova matriz filtrada
#
# 5) Rodar uma regress?o m?ltipla por MQO com a matriz original (INVEST)
#    - A vari?vel dependente ? Investmento (invest)
#    - As vari?veis explicativas s?o: 
#      . Q de Tobin (tobinq)
#      . Fluxo de caixa (cashfl)
#      . Tangibilidade (tang)
#      . Intera??o entre fluxo de caixa e tangibilidade (cash_tang)
#      . Vari?veis dummy de ano
#
# 6) Rodar uma regress?o m?ltipla por MQO com a matriz sem outliers de Q de Tobin (INVEST2)
#    - As vari?veis s?o as mesmas
#
# 7) Testar a exist?ncia de heteroscedasticidade na regress?o do item 6
# 
# 8) Rodar a regress?o do item 6 com erros robustos ? heteroscedasticidade
#
# 9) Usando o pacote Stargazer, construir uma tabela mais "public?vel"
#    - Comparar tr?s modelos: amostra total, sem outliers de Q de Tobin e com erros robustos
#
# 10) Usando o pacote "plm", rodar regress?es com dados agrupados, efeitos aleat?rios e efeitos fixos
#     - Usar o Stargazer para construir uma tabela comparativa entre as tr?s regress?es
#
# 11) Rodar regress?es com dados agrupados, efeitos aleat?rios e efeitos fixos
#     - Usar o Stargazer para construir uma tabela comparativa entre as tr?s regress?es
#****************************************************************************************************************
#****************************************************************************************************************


#--------------------------------------------------------------------------
# SOLU??O DO EXERC?CIO CONSOLIDADO

# Defini??o do diret?rio de trabalho
setwd("D:/Users/25052288840/Downloads/FIA_data_mining/Regressao/")

# Apagar a mem?ria
rm(list=ls())
ls()

# 1) Carregamento da matriz de dados do Stata
# Se o formato dos arquivo forem diferentes, outros meios devem ser usados:
# - se o arquivo for do pr?prio R o comando ?: load("INVEST.rda")
# - se o arquivo for em formato CSV: NomeDoObjeto <- read.table("INVEST.csv", header=TRUE, sep=",")
# - o pacote "library" e o comando abaixo abre o arquivo em outros formatos (ex.: Stata, SAS, etc)

library(foreign)
INVEST <- read.dta("Aula 10/ExercicioConsolidado/INVEST.dta")

#--------------------------------------------------------------------------

# 2) C?lculo preliminar das vari?veis

# Vari?vel "Investimento"
INVEST$invest <- INVEST$capex/INVEST$ttasset

# Vari?vel "q de Tobin" ou "Oportunidades de Investimento"
INVEST$tobinq <- (INVEST$mktval+INVEST$debt)/INVEST$ttasset

# Vari?vel "Fluxo de caixa"
INVEST$cashfl <- INVEST$cashflow3/INVEST$ttasset

# Vari?vel "Tangibilidade"
INVEST$tang <- INVEST$ppe/INVEST$ttasset

# Vari?vel "Tamanho" ou "Log do ativo"
INVEST$size <- log(INVEST$ttasset)

# Vari?vel de intera??o "Fluxo de Caixa x Tangibilidade"
INVEST$cash_tang <- INVEST$cashfl * INVEST$tang

#--------------------------------------------------------------------------

# 3) Estat?stica descritiva

# Visualizar os nomes das vari?veis
names(INVEST)

# Estat?stica descritiva das vari?veis calculadas
summary (INVEST[,c("invest","tobinq","cashfl","tang", "size")])

#--------------------------------------------------------------------------

# 4) Filtragem de dados (Q de Tobin < 10)
INVEST2 <- subset(INVEST,tobinq<10)

# Estat?stica descritiva das vari?veis calculadas (para subamostra de Q < 10)
summary (INVEST2[,c("invest","tobinq","cashfl","tang", "size")])

#--------------------------------------------------------------------------

# 5) Regress?o m?ltipla por MQO (ou POLS) com a matriz original

MQ1 <- lm(invest ~ tobinq + cashfl + tang + cash_tang + factor(year), data=INVEST)
summary(MQ1)

#--------------------------------------------------------------------------

# 6) Regress?o m?ltipla por MQO (ou POLS) com a matriz sem outliers de Q de Tobin

MQ2 <- lm(invest ~ tobinq + cashfl + tang + cash_tang + factor(year), data=INVEST2)
summary(MQ2)

#--------------------------------------------------------------------------

# 7) Teste Breusch-Pagan para Heteroscedasticidade

library(lmtest)
bptest(MQ2)

#--------------------------------------------------------------------------

# 8) Regress?o com erros robustos ? heteroscedasticidade
# Nota: essa forma de estimar o erro robusto ? um pouco diferente da descrita na aula anterior

library(sandwich)
robusto <- vcovHC(MQ2, type = "HC")
errorobusto <- sqrt(diag(robusto))

#--------------------------------------------------------------------------

# 9) Constru??o de tabela public?vel

# Pacote stargazer: uma forma mais bonita para a tabela
library(stargazer)

stargazer(MQ1, MQ2, MQ2, type="text", title="An?lise de regress?o por MQO", 
          se=list(NULL, errorobusto), column.labels = c("MQO amostra total", "MQO amostra parcial", "Erros robustos"),
          dep.var.labels=c("Investimento"), covariate.labels=c("Q de Tobin","Fluxo de Caixa","Tangibilidade", "Fluxo de caixa x Tangibilidade"))

#--------------------------------------------------------------------------

# 10) Regress?o com dados agrupados, efeitos aleat?rios e efeitos fixos sem corre??o para heteroscedasticidade

library(plm)
INVEST2PANEL <- pdata.frame(INVEST2, index = c("firmid","year"))

# Dados agrupados
POLS1 <- plm(invest ~ tobinq + cashfl + tang + cash_tang + factor(year), data=INVEST2PANEL, model = "pooling")
summary(POLS1)

# efeitos aleat?rios
RANDOM1 <- plm(invest ~ tobinq + cashfl + tang + cash_tang + factor(year), data=INVEST2PANEL, model = "random")
summary(RANDOM1)

# efeitos fixos
FIXED1 <- plm(invest ~ tobinq + cashfl + tang + cash_tang + factor(year), data=INVEST2PANEL, model = "within")
summary(FIXED1)

# Teste de Breush-Pagan para escolha entre POLS ou efeitos aleat?rios
plmtest(RANDOM1, effect = c("individual"), type = c("bp"))

# Teste de Hausman para escolha entre efeitos fixos ou aleat?rios
phtest(RANDOM1, FIXED1)

# Organizando a tabela de regress?es com os erros-padr?o originais

library(stargazer)

stargazer(POLS1, RANDOM1, FIXED1, type="text", 
          title="An?lises de dados agrupados, efeitos aleat?rios e efeitos fixos", 
          dep.var.labels=c("Investimento"), column.labels= c("POLS", "Efeitos Aleat?rios", "Efeitos Fixos"),
          covariate.labels=c("Q de Tobin","Fluxo de Caixa","Tangibilidade", "Fluxo de caixa x Tangibilidade"))

#--------------------------------------------------------------------------

# 11) Regress?o com dados agrupados, efeitos aleat?rios e efeitos fixos com erros robustos ? heteroscedasticidade

library(sandwich)

POLS2 <- vcovHC(POLS1, type = "HC0")
pols2.er <- sqrt(diag(POLS2))

RANDOM2 <- vcovHC(RANDOM1, type = "HC0")
random2.er <- sqrt(diag(RANDOM2))

FIXED2 <- vcovHC(FIXED1, type = "HC0")
fixed2.er <- sqrt(diag(FIXED2))

# Organizando a tabela de regress?es com os erros-padr?o originais

library(stargazer)

stargazer(POLS1, RANDOM1, FIXED1, type="text", se=list(pols2.er, random2.er, fixed2.er),
          title="An?lises de dados agrupados, efeitos aleat?rios e efeitos fixos com erros robustos ? heteroscedasticidade", 
          dep.var.labels=c("Investimento"), column.labels= c("POLS", "Efeitos Aleat?rios", "Efeitos Fixos"),
          covariate.labels=c("Q de Tobin","Fluxo de Caixa","Tangibilidade", "Fluxo de caixa x Tangibilidade"))



#--------------------------------------------------------------------------

# Encerrar grava??o do arquivo de resultados
sink()

# Apagar a mem?ria
rm(list=ls())




