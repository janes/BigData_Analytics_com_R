# Avalia Risco de Credito

# Verificando o diretorio
getwd()

# Carregando o dataset em um dataframe
credit_df <- read.csv("credit_dataset.csv", header = TRUE, sep = ",")
head(credit_df)

# Convertendo as variaveis para o tipo fator (categoricas)
to_factors <- function(df, variables){
  for (variable in variables){
    df[[variable]] <- as.factor(df[[variable]])
  }
  return(df)
}

# Normalizacao
scale_features <- function(df, variables){
  for (variable in variables){
    df[[variable]] <- scale(df[[variable]], center = T, scale = T)
  }
  return(df)
}

# Normalizando as variaveis
numeric_vars <- c("credit.duration.months", "age", "credit.amount")
credit_df <- scale_features(credit_df, numeric_vars)

# Variaveis do tipo fator
categorical_vars <- c('credit.rating', 'account.balance', 'previous.credit.payment.status',
                      'credit.purpose', 'savings', 'employment.duration', 'installment.rate',
                      'marital.status', 'guarantor', 'residence.duration', 'current.assets',
                      'other.credits', 'apartment.type', 'bank.credits', 'occupation', 
                      'dependents', 'telephone', 'foreign.worker')

credit_df <- to_factors(df = credit_df, variables = categorical_vars)

# Dividindo os dados em treino e teste - 60:40 ratio
indexes <- sample(1:nrow(credit_df), size = 0.6 * nrow(credit_df))
train_data < credit_df[indexes, ]
teste_data < credit_df[-indexes, ]

# Feature Selection
install.packages("caret")
install.packages("randomForest")
library(caret)
library(randomForest)

# Função para selecao de variaveis
run.feature.selection <- function(num.iters = 20, feature.vars, class.var){
  set.seed(10)
  variable.sizes <- 1:10
  control <- rfeControl(functions = rfFuncs, method = "cv",
                        verbose = FALSE, returnResamp = "all",
                        number = num.iters)
  results.rfe <- rfe(x = feature.vars, y = class.var,
                     sizes = variable.sizes,
                     rfeControl = control)
  return(results.rfe)
}

# Executando a funcao
rfe.results <- run.feature.selection(feature.vars = train_data[,-1], class.var = train_data[,1])

# Visualizando os resultados
rfe.results
carImp(rfe.results)

# Criando e avaliando o modelo
library(caret)
library(ROCR)

# Biblioteca de utilitarios para construcao de graficos
source("plot_utils.R")

# Separate feature and class variables
test.feature.vars <- teste_data[,-1]
test.class.var <- teste_data[,1]

# Construindo um modelo de regrssão logistica
formula.int <- "credit.rating ~ ."
formula.int <- as.formula(formula.int)
lr.model <- glm(formula = formula.int, data = train_data, family = "binomial")

# Visualizando o modelo
summary(lr.model)

# Testando o modelo nos dados de teste
lr.predictions <- predict(lr.model, test_data, type = "response")
lr.predictions <- round(lr.predictions)

# Avaliando o modelo
confusionMatrix(table(data = lr.predictions, reference = test.class.var), positive = '1')

# Feature selection
formula <- "credit.rating ~ ."
formula <- as.formula(formula)
control <- trainControl(method = "repeatedcv", number = 10, repeats = 2)
model <- train(formula, data = train_data, method = "glm", trControl = control)
importance < varImp(model, scale = FALSE)
plot(importance())

# Construindo o modelo com as variaveis selecionadas
formula.new <- "credit.rating ~ account.balance + credit.purpose + previous.credit.payment.status + savings + credit.duration.months"
formula.new <- as.formula(formula.new)
lr.model.new <- glm(formula = formula.new, data = train_data, family = "binomial")

# Visualizando o modelo
summary(lr.model.new)

# Testando o modelo nos dados de teste
lr.predictions.new <- predict(lr.predictions.new, teste_data, type = "response")
lr.predictions.new <- round(lr.predictions.new)

# Avaliando o modelo
confusionMatrix(table(data = lr.predictions.new, reference = test.class.var), positive = '1')

# Avaliando a performance do modelo

# Criando curvas ROC

lr.model.best <- model
lr.predictions.values <- predict(lr.model.best, test.feature.vars, type = "response")
predictions <- prediction(lr.predictions.values, test.class.var)
par(mfrow = c(1,2))
plot.roc.curve(predictions, title.text = "Curva ROC")
plot.pr.curve(predictions, title.text = "Curva Precision/Recall")




















































