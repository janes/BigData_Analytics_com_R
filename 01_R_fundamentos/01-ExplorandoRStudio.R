# Explorando o RStudio

# Obs: Caso tenha problemas com a acentuação, consulte este link:
# https://support.rstudio.com/hc/en-us/articles/200532197-Character-Encoding

# Configurando o diretório de trabalho
# Coloque entre aspas o diretório de trabalho que está sendo usando no seu computador
# Não use diretórios com espaço no nome
setwd("C:/Projetos/Git_Projetos/BD_Analytics_com_R/01_R_fundamentos")
getwd()


# Nome dos Contributors
contributors()


# Licença 
license()


# Informações sobre a sessão
sessionInfo()


# Imprimir na tela
print('R - Uma das principais ferramentas do Cientista de Dados')


# Criar gráficos
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


# Visualizando o diretório de trabalho
getwd()


# Se souber o nome da função
help(mean)
?mean


# Para buscar mais opções sobre uma função, use o pacote SOS
install.packages("sos")
library(sos)
findFn("fread")


# Se não souber o nome da função 
help.search('randomForest')
help.search('matplot')
??matplot
RSiteSearch('matplot')
example('matplot')


# Sair
q()