# Explorando o RStudio

# Obs: Caso tenha problemas com a acentua��o, consulte este link:
# https://support.rstudio.com/hc/en-us/articles/200532197-Character-Encoding

# Configurando o diret�rio de trabalho
# Coloque entre aspas o diret�rio de trabalho que est� sendo usando no seu computador
# N�o use diret�rios com espa�o no nome
setwd("C:/Projetos/Git_Projetos/BD_Analytics_com_R/01_R_fundamentos")
getwd()


# Nome dos Contributors
contributors()


# Licen�a 
license()


# Informa��es sobre a sess�o
sessionInfo()


# Imprimir na tela
print('R - Uma das principais ferramentas do Cientista de Dados')


# Criar gr�ficos
plot(1:30)


# Instalar pacotes
install.packages('randomForest')
install.packages('ggplot2')
install.packages("dplyr")
install.packages("devtools")


# Carregar o pacote
library(ggplot2)


# Descarregar o pacote
detach(package:ggplot2)


# Visualizando o diret�rio de trabalho
getwd()


# Se souber o nome da fun��o
help(mean)
?mean


# Para buscar mais op��es sobre uma fun��o, use o pacote SOS
install.packages("sos")
library(sos)
findFn("fread")


# Se n�o souber o nome da fun��o 
help.search('randomForest')
help.search('matplot')
??matplot
RSiteSearch('matplot')
example('matplot')


# Sair
q()