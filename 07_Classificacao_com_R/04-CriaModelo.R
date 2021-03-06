# Criando um modelo preditivo no R
# ... cont do script 03

# Criar um modelo de classificacao baseado em randomForest
library(randomForest)

# Cross Tabulation
?table
table(Credit$CreditStatus)

# Funcao para gerar dados de treino e dados de teste
splitData <- function(dataframe, seed = NULL) {
  if (!is.null(seed)) set.seed(seed)
  index <- 1:nrow(dataframe)
  trainindex <- sample(index, trunc(length(index) / 2))
  trainset <- dataframe[trainindex, ]
  testset <- dataframe[-trainindex, ]
  list(trainset = trainset, testset = testset)
}

# Gerando dados de treino e de teste
splits <- splitData(Credit, seed = 808)

# Separando os dados
dados_treino <- splits$trainset
dados_test <- splits$testset

# Verificando o numeto de linhas
nrow(dados_treino)
nrow(dados_test)

# Construindo o modelo
modelo <- randomForest( CreditStatus ~ CheckingAcctStat
                        + Duration_f
                        + Purpose
                        + CreditHistory
                        + SavingsBonds
                        + Employment
                        + CreditAmount_f,
                        data = dados_treino,
                        ntree = 100,
                        nodesize = 10)

# Imprimindo o resultado
print(modelo)














