# Clustering com K-Means

# Obs: Caso tenha problemas com a acentua��o, consulte este link:
# https://support.rstudio.com/hc/en-us/articles/200532197-Character-Encoding

# Configurando o diret�rio de trabalho
# Coloque entre aspas o diret�rio de trabalho que voc� est� usando no seu computador
# N�o use diret�rios com espa�o no nome
setwd("C:/Projetos/R/MachineLearning")
getwd()


# Usaremos o dataset iris neste exemplo
# O dataset iris possui observa��es de 3 especies de flores (Iris setosa, Iris virginica e Iris versocolor)
# Para cada flor, 4 medidas sao usadas: 
# comprimento (length) e largura (width) do caule (sepal) e comprimento e largura da petala (petal)
library(datasets)
head(iris)

# Analise exploratoria utilizando ggplot2
library(ggplot2)

# Veja que os dados claramente possui grupos com caracteristicas similares
ggplot(iris, aes(Petal.Length, Petal.Width, color = Species)) + geom_point(size = 3)

# Agora usaremos o K-Means para tentar agrupar os dados em clusters
set.seed(101)
help("kmeans")

# Neste caso, ja sabemos quantos grupos (clusters) existem em nossos dados (3)
# Perceba que o dataset iris possui 5 colunas, mas estamos usando as 4 primeiras
irisCluster <- kmeans(iris[, 1:4], 3, nstart = 20)
irisCluster

# Obtendo informa��o sobre os clusters
# Foram criandos 3 clusters: cluster 1, 2 e 3
# Perceba que apesar o algoritmo ter feito a divisao dos dados em clusters, houve problema em dividir alguns dos dados, 
# que apesar de terem caracteristicas diferentes, ficaram no mesmo cluster
table(irisCluster$cluster, iris$Species)
irisCluster


# Visualizando os clusters
install.packages("cluster")
library(cluster)
help("clusplot")

# plot
clusplot(iris, irisCluster$cluster, color = TRUE, shade = TRUE, labels = 0, lines = 0)








