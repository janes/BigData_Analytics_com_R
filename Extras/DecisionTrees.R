# Decision Trees

# Obs: Caso tenha problemas com a acentua��o, consulte este link:
# https://support.rstudio.com/hc/en-us/articles/200532197-Character-Encoding

# Configurando o diret�rio de trabalho
# Coloque entre aspas o diret�rio de trabalho que voc� est� usando no seu computador
# N�o use diret�rios com espa�o no nome
setwd("Z:/Dropbox/DSA/BigDataAnalytics-R-Azure/Cap08/Bonus")
getwd()

# # Existem diversos pacotes para arvores de recisao em R. Usaremos aqui o rpart.
install.packages('rpart')
library(rpart)

# Vamos utilizar um dataset que eh disponibilizado junto com o pacote rpart
str(kyphosis)
head(kyphosis)

# Usamos a funcao rpart para criar a arvore de decisao
arvore <- rpart(Kyphosis ~ ., method = "class", data = kyphosis)
class(arvore)
arvore

# Para examinar o resultado de uma arvore de decisao, existem diversas funcoes
printcp(arvore)

# Visualizando a arvore (execute uma funcao para o plot e outra para o texto no plot)
# Utilize o zoom para visualizar melhor o grafico
plot(arvore, uniform = TRUE, main = "Arvore de Descisao em R")
text(arvore, use.n = TRUE, all = TRUE)

# Este outro pacote faz a visualizaco ficar mais legivel
install.packages("rpart.plot")
library(rpart.plot)
prp(arvore)