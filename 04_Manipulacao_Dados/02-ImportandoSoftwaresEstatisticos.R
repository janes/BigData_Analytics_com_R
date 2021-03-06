# Importacao de outros Softwares Estatisticos

# Instalando o pacote 

install.packages("haven")
library(haven)
# devtools::install_version("haven", force=TRUE,version = "1.1.0")
# devtools::install_github("hadley/haven", force=TRUE)
# devtools::session_info()

# SAS
vendas <- read_sas("http://datascienceacademy.com.br/blog/aluno/RFundamentos/Datasets/Parte4/vendas.sas7bdat")
?read_sas
class(vendas)
print(vendas)
str(vendas)

# Stata
df_stata <- read_dta("http://datascienceacademy.com.br/blog/aluno/RFundamentos/Datasets/Parte4/mov.dta")
class(df_stata)
str(df_stata)

# convert values in Date column to dates
df_stata$Date <- as.Date(as_factor(df_stata$Date))
str(df_stata)
plot(df_stata)

# Pacote Foreign
install.packages("foreign")
library(foreign)

# Stata
florida <- read.dta("http://datascienceacademy.com.br/blog/aluno/RFundamentos/Datasets/Parte4/florida.dta")
tail(florida)
class(florida)

# SPSS
# http://cw.routledge.com/textbooks/9780415372985/resources/datasets.asp

dados <- read.spss("http://datascienceacademy.com.br/blog/aluno/RFundamentos/Datasets/Parte4/international.sav")
class(dados)
head(dados)
df <- data.frame(dados)
head(df)
df

# Criando um boxplot
boxplot(df$gdp)


# Se voc� estiver familiari zado com estat�stica, voc� vai ter ouvido falar de Correla��o. 
# � uma medida para avaliar a depend�ncia linear entre duas vari�veis. 
# Ela pode variar entre -1 e 1; 
# Se pr�ximo de 1, significa que h� uma forte associa��o positiva entre as vari�veis. 
# Se pr�ximo de -1, existe uma forte associa��o negativa: 
# Quando a correla��o entre duas vari�veis � 0, essas vari�veis s�o possivelmente independentes: 
# Ou seja, n�o h� nenhuma associa��o entre X e Y.

# coeficiente de Correlacao. Indica uma associa��o negativa entre GDP e alfabetiza��o feminina
cor(df$gdp, df$f_illit)

# **** Importante ****
# Correla��o n�o implica causalidade
# A correla��o, isto �, a liga��o entre dois eventos, n�o implica 
# necessariamente uma rela��o de causalidade, ou seja, que um dos 
# eventos tenha causado a ocorr�ncia do outro. A correla��o pode 
# no entanto indicar poss�veis causas ou �reas para um estudo mais 
# aprofundado, ou por outras palavras, a correla��o pode ser uma 
# pista.