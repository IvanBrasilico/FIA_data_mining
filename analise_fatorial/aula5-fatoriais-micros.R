#==========================================================================================================
# Programa de Análise Fatorial
# Prof Dra Maria Aparecida Gouvea
#==========================================================================================================


#==========================================================================================================
# O comando "install.packages" do R é utilizado para instalar os pacotes: corrplot, FactoMineR, 
# factoextra, psych, nFactors. Este comando deve ser executado apenas na primeira vez em que se estiver instalando estes
# pacotes no computador aonde será executado o estudo de Análise Fatorial. Depois que os pacotes já tiverem
# sido instalados, basta colocar na frente do comando "install.packages" o carater de comentários # .
#==========================================================================================================


#--- Pacote utilizado para Calcular e plotar a Matriz de Correlação ---
#install.packages("corrplot",dep=TRUE)

#--- Pacote utilizado para Execução da Análise Fatorial Exploratória ---
#install.packages("psych", dep=TRUE)
#install.packages("nFactors", dep=TRUE)
#install.packages("FactoMineR", dep=TRUE)
#install.packages("factoextra", dep=TRUE)


#==========================================================================================================
# Comandos para carregar os pacotes que foram instalados anteriormente
#==========================================================================================================

library(corrplot)
library(psych)
library(nFactors)
library(FactoMineR)
library(factoextra)


#==========================================================================================================
# Colocando o Endereço do Diretório de onde o arquivo com os Dados sera lidos
#==========================================================================================================

setwd("D:\\Users\\25052288840\\Downloads")


#===========================================================================================================
# Lendo Arquivo de Dados
#===========================================================================================================

Dados1 <- data.frame(read.csv2("Micros.csv", head=T, sep=";", dec=","))
Dadosfinal <- Dados1[,2:7]

Dadosfinal
#===========================================================================================================
# Matriz de Correlação das Varíaveis
#===========================================================================================================

Matcorrelação <- cor(Dadosfinal)
print(Matcorrelação,digit=3)

#===========================================================================================================
# Rodando o KMO (Todas Variáveis) e MSA (Para cada variável- Diagonal da Matriz AntiImagem)
#===========================================================================================================

KMO(Matcorrelação)

#===========================================================================================================
# Calculando a Matriz de Correlação dos Dados - (A primeira coluna, que é ID dos dados, não será utilizada) 
#===========================================================================================================

#--- Escolhendo o Número de Autovalores( Por exemplo: AutoValores > 1)
teste.pca <- PCA(Dadosfinal, scale.unit = TRUE , ncp = ncol(Dadosfinal) , graph = FALSE)
teste.pca$eig
barplot(teste.pca$eig[,1],main="Eigenvalues",names.arg=1:nrow(teste.pca$eig))

#---- Determinando o número de fatores ( AutorValor > 1)
numerodefatores = sum(teste.pca$eig[,1] > 1)
print(numerodefatores)

#--- Rodando Com o Numero de Fatores Escolhidos Auto Valor> 1)
teste.pca <- PCA(Dadosfinal, scale.unit = TRUE , ncp = numerodefatores , graph = TRUE)
teste.pca$eig
fviz_eig(teste.pca, addlabels = TRUE)

#---- Comunalidade ----
Comunalidade <- teste.pca$var$cos2[,1]+teste.pca$var$cos2[,2]
print(Comunalidade,digit=3)

#--- Coordenada Sem Rotação
teste.pca$var$coord


# --- Utilizou-se VARIMAX com  Método de Rotação dos Fatores ---
Fitvarimax <- principal(Matcorrelação, nfactors=numerodefatores, n.obs = nrow(Dadosfinal),  rotate="varimax", method =regression)
print(Fitvarimax, cutoff=0, digits=3)

#---- Escores ----
ScoreBruto <- as.matrix(Dadosfinal) %*% as.matrix(Fitvarimax$loadings[,1:2])
ScoreNormalizado <- scale(ScoreBruto)
ScoreNormalizado
sort(ScoreNormalizado[,1])
order(ScoreNormalizado[,1])
sort(ScoreNormalizado[,2], decreasing = TRUE)
order(ScoreNormalizado[,2], decreasing = TRUE)



ScoreNormalizado


#===============================================================================================================
# FIM
#===============================================================================================================
