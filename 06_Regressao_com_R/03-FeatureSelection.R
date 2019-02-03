# Feature Selection
# ... cont do script 02

dim(bikes)
any(is.na(bikes))

# Criando um modelo para identificar os atributos com maior importancia para o modelo preditivo
require(randomForest)

# Avaliando a importanci de todas as variaveis
modelo <- randomForest(cnt ~ .,
                       data = bikes,
                       ntree = 100,
                       nodesize = 10,
                       importance = TRUE)

# Removendo variaveis colineares
modelo <- randomForest(cnt ~ . - count
                       - mnth
                       - hr
                       - workingday
                       - isWorking
                       - dayWeek
                       - xforHr
                       - workTime
                       - holiday
                       - windspeed
                       - monthCount
                       - weathersit,
                       data = bikes,
                       ntree = 100,
                       nodesize = 10,
                       importance = TRUE)

# Plotando as variaveis por grau de importancia
varImpPlot(modelo)

#Granvando o resultado
df_saida <- bikes[, c("cnt", rownames(modelo$importance))]
df_saida
