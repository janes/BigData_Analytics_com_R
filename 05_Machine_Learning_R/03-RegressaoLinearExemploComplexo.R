# Regress�o Linear Exemplo Complexo


# Regress�o Linear
# https://archive.ics.uci.edu/ml/datasets/Student+Performance
# Dataset com dados de estudantes
# Vamos prever a nota final (grade) dos alunos

# Carregando o dataset
df <- read.csv2('http://datascienceacademy.com.br/blog/aluno/RFundamentos/Datasets/ML/estudantes.csv')

# Explorando os dados
head(df)
summary(df)
str(df)
any(is.na(df)) # se existe valores NA

install.packages("ggplot2")
install.packages("ggthemes")
install.packages("dplyr")
library(ggplot2)
library(ggthemes)
library(dplyr)

# Obtendo apenas as colunas numericas
colunas_numericas <- sapply(df, is.numeric)
colunas_numericas

# Filtrando as colunas numericas para correlacao
data_cor <- cor(df[,colunas_numericas])
data_cor
head(data_cor)

# Pacotes para visualizar a analise de corretacao
install.packages('corrgram')
install.packages('corrplot')
library(corrplot)
library(corrgram)

# Criando um corrplot
corrplot(data_cor, method = 'color')

# Criando um corrgram
corrgram(df)
corrgram(df, order = TRUE, lower.panel = panel.shade,
         upper.panel = panel.pie, text.panel = panel.txt)

# Criando um histograma
ggplot(df, aes(x = G3)) +
  geom_histogram(bins = 20, alpha = 0.5, fill = 'blue') +
  theme_minimal()

# Treinando e interpretando o modelo
install.packages('caTools')
library(caTools)

# Criando as amostras de forma randomica
set.seed(101)
?sample.split
amostra <- sample.split(df$age, SplitRatio = 0.70)

# ***** Treinamos nosso modelo nos dados de treino *****
# *****   Fazemos as predi��es nos dados de teste  *****

# Criando dados de treino - 70% dos dados
treino = subset(df, amostra == TRUE)

# Criando dados de teste - 30% dos dados
teste = subset(df, amostra == FALSE)

# Gerando o modelo (Usando todos os atributos)
modelo_v1 <- lm(G3 ~ ., treino)
modelo_v2 <- lm(G3 ~ G2 + G1, treino)
modelo_v3 <- lm(G3 ~ absences, treino)
modelo_v4 <- lm(G3 ~ Medu, treino)

# Interpretando o modelo
summary(modelo_v1)
summary(modelo_v2)
summary(modelo_v3)
summary(modelo_v4)

# par(mfrow = c(2,2))
# plot(modelo_v3)

# ****************************************************
# *** Estas informa��es abaixo � que far�o de voc� ***
# *** um verdadeiro conhecedor de Machine Learning ***
# ****************************************************

# Res�duos
# Diferen�a entre os valores observados de uma vari�vel e seus valores previstos
# Seus res�duos devem se parecer com uma distribui��o normal, o que indica
# que a m�dia entre os valores previstos e os valores observados � pr�ximo de 0 (o que � bom)

# Coeficiente - Intercept - a (alfa)
# Valor de a na equa��o de regress�o

# Coeficiente - G2 - b (beta)
# Neste caso, o valor de G2 representa o valor de b na equa��o de regress�o

# Erro Padr�o
# Medida de variabilidade na estimativa do coeficiente a (alfa). O ideal � que este valor 
# seja menor que o valor do coeficiente, mas nem sempre isso ir� ocorrer.

# Asteriscos 
# Os asteriscos representam os n�veis de signific�ncia de acordo com o p-value.
# Quanto mais estrelas, maior a signific�ncia.
# Aten��o --> Muitos astericos indicam que � improv�vel que n�o exista relacionamento entre as vari�veis.

# Valor t
# Define se coeficiente da vari�vel � significativo ou n�o para o modelo. 
# Ele � usado para calcular o p-value e os n�veis de signific�ncia.

# p-value
# O p-value representa a probabilidade que a vari�vel n�o seja relevante. 
# Deve ser o menor valor poss�vel. Se este valor for realmente pequeno, o R ir� mostrar o valor como nota��o cient�fica

# Signific�ncia
# S�o aquelas legendas pr�ximas as suas vari�veis
# Espa�o em branco - ruim
# Pontos - razo�vel
# Asteriscos - bom
# Muitos asteriscos - muito bom

# Residual Standar Error
# Este valor representa o desvio padr�o dos res�duos

# Degrees of Freedom
# � a diferen�a entre o n�mero de observa��es na amostra de treinamento e o n�mero de vari�veis no seu modelo

# R-squared
# Ajuda a avaliar o n�vel de precis�o do nosso modelo. Quanto maior, melhor, sendo 1 o valor ideal.

# F-statistics
# � o teste F do modelo. Esse teste obt�m os par�metros do nosso modelo e compara com um modelo que tenha menos par�metros
# Em teoria, um modelo com mais par�metros tem um desempenho melhor. Se o seu modelo com mais par�metros N�O tiver perfomance
# melhor que um modelo com menos par�metros, o valor do p-value ser� bem alto. Se o modelo com mais par�metros tem performance
# meljor que um modelo com menos par�metros, o valor do p-value ser� mais baixo.

# Lembre que correla��o n�o implica causalidade


# Visualizando o Modelo e Fazendo Previs�es

# Obtendo os residuos
res <- residuals(modelo_v1)

# Convertendo o objeto para um dataframe
res <- as.data.frame(res)
head(res)

# Histograma dos residuos
ggplot(res, aes(res)) +
  geom_histogram(fill = 'blue', alpha = 0.5, binwidth = 1)

# Plot do Modelo
# plot(modelo_v1)

# Fazendo as predi��es
modelo_v1 <- lm(G3 ~ ., treino)
prevendo_G3 <- predict(modelo_v1, teste)
prevendo_G3

# Visualizando os valores previstos e observados
resultados <- cbind(prevendo_G3, teste$G3)
colnames(resultados) <- c("Previsto", "Real")
resultados <- as.data.frame(resultados)
resultados
min(resultados)

# Tratando os valores negativos
trata_zero <- function(x){
  if(x< 0){
    return(0)
  } else{
    return(x)
  }
}

# Aplicando a fun��o para tratar valores negativos em nossa previs�o
resultados$Previsto <- sapply(resultados$Previsto, trata_zero)
resultados$Previsto
resultados
min(resultados)

# Calculando o erro medio
# Quao distantes seus valores previstos est�o dos valores observados
# MSE
mse <- mean((resultados$Real - resultados$Previsto)^2)
print(mse)


#RMSE
rmse <- mse ^ 0.5
rmse

# Calculando R Squared
SSE = sum((resultados$Previsto - resultados$Real)^2)
SST = sum((mean(df$G3)-resultados$Real)^2)


# R-Squared
# Ajuda a avaliar o nivel de precisao do nosso modelo. 
# Quanto maior, melhor, sendo 1 o valor ideal
R2 = 1- (SSE / SST)
R2








