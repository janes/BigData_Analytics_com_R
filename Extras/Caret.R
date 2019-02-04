# Caret

# Configurando o diretorio de trabalho
setwd("C:/Projetos/R/MachineLearning")
getwd()

# Instalando os pacotes
install.packages("caret")
install.packages("randomForest")

# Carregando os pacotes
library(caret)
library(datasets)
options(warn = -1)

# Usando o dataset mtcars
data(mtcars)

# Funcao do caret para divisao dos dados
?createDataPartition
split <- createDataPartition(y = mtcars$mpg, p = 0.7, list = FALSE)

# Criando dados de treino e de teste
dados_treino <- mtcars[split,]
dados_teste <- mtcars[-split,]

# Treinando o modelo
?train
names(getModelInfo())

# Regressao Linear
modelolm <- train(mpg ~ ., data = dados_treino, method = "lm")

# Regressao logistica
modelolm2 <- train(mpg ~ ., data = dados_treino, method = "glm")

# Random forest
modelolm3 <- train(mpg ~ ., data = dados_treino, method = "rf")

# Resumo do modelo
summary(modelolm)
summary(modelolm2)
summary(modelolm3)

# Ajustando o modelo
?expand.grid
?trainControl

controle1 <- trainControl(method = "cv", number = 10)
modelolm_v2 <- train(mpg ~ ., data = mtcars, method = "lm",
                     trControl = controle1, metric = "Rsquared")

# Resumo do modelo
summary(modelolm_v2)

# Coletando os resultados
residuals <- resid(modelolm)

# Previsoes
?predict
predictedValues <- predict(modelolm)
plot(dados_treino$mpg, predictedValues)

# Mostrando a importancia das variaveis para a criacao do modelo
?varImp
varImp(modelolm)

# plot
plot(varImp(modelolm))