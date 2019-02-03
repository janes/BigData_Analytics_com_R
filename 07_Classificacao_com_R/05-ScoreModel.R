# Fazendo previsoes
# ... cont do script 04

# Previsoes com o modelo de classificação baseado em randomForest
require(randomForest)
options(warn = -1)

# Gerando previsoes nos dados de teste
result_previsto <- data.frame(actual = Credit$CreditStatus,
                              previsto = predict(modelo,
                                                 newdata = dados_test))

# Visualizando o resultado
head(result_previsto)