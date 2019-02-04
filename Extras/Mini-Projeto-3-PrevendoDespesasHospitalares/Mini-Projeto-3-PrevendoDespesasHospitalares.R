# Prevendo Despesas Hospitalares

# Conferindo o diretorio
getwd()

# Para esta análise, vamos usar um conjunto de dados simulando despesas médicas hipotéticas 
# para um conjunto de pacientes espalhados por 4 regiões do Brasil.
# Esse dataset possui 1.338 observações e 7 variáveis.

## Etapa 1 - Coletando os dados
despesas <- read.csv("despesas.csv")
View(despesas)


## Etapa 2 - Explorando e preparando os dados
# Visualidando as variaveis
str(despesas)

# Medias de tendencia central da variavel gastos
summary(despesas$gastos)

# Construindo um histrograma
hist(despesas$gastos, main = "Histograma", xlab = "Gastos")

# Tabela de contigencia das regioes
table(despesas$regiao)

# Explorando relacionamento entre as variaveis: Matriz de correlação
cor(despesas[c("idade", "bmi", "filhos", "gastos")])

# Nenhuma das correlações na matriz são consideradas fortes, mas existem algumas associações interessantes. 
# Por exemplo, a idade e o bmi (IMC) parecem ter uma correlação positiva fraca, o que significa que 
# com o aumento da idade, a massa corporal tende a aumentar. Há também uma correlação positiva 
# moderada entre a idade e os gastos, além do número de filhos e os gastos. Estas associações implicam 
# que, à media que idade, massa corporal e número de filhos aumenta, o custo esperado do seguro saúde sobe. 

# Visualizando relacionamento entre as variaveis: Scatterplot
# Perceba que não existe um claro relacionamento entre as variaveis
pairs(despesas[c("idade", "bmi", "filhos", "gastos")])

# Scatterplot Matrix
install.packages("psych")
library(psych)

# Este grafico fornece mais informações sobre o relacionamento entre as variaveis
pairs.panels(despesas[c("idade", "bmi", "filhos", "gastos")])


## Etapa 3 - Treinando o modelo
modelo <- lm(gastos ~ idade + filhos + bmi + sexo + fumante + regiao, data = despesas)

# Similar ao item anterior
modelo <- lm(gastos ~ ., data = despesas)

# Visualizando os coeficientes
modelo

# Prevendo despesas medicas
previsao <- predict(modelo)
class(previsao)
head(previsao)


## Etapa 4 - Avaliando a performance do modelo
# Mais detalhes sobre o modelo
summary(modelo)


## Etapa 5 - Otimizando a performance do modelo
# Adicionando uma variavel com o dobro do valor das idades
despesas$idade2 <- despesas$idade ^ 2

# Adicionando um indicador para BMI >= 30
despesas$bmi30 <- ifelse(despesas$bmi >= 30, 1, 0)

# Criando o modelo final
modelo_v2 <- lm(gastos ~ idade + idade2 + filhos + bmi + sexo + fumante + regiao, data = despesas)

summary(modelo_v2)




