# Exercício 1 - Crie uma função que receba e vetores como parâmetro, 
# converta-os em um dataframe e imprima
exercicio1 <- function(x, y){
  print(data.frame(cbind(x, y)))
}

Vetor1 <- c(7:10)
vetor2 <- c("A", "B", "C", "D")

resultEx1 <- exercicio1(Vetor1, vetor2)
class(resultEx1)



# Exercício 2 - Crie uma matriz com 4 linhas e 4 colunas preenchida com 
# números inteiros e calcule a media de cada linha
matriz <- matrix(c(1:16), nrow = 4, ncol = 4)
matriz
mean(matriz)
apply(matriz,1,mean) # linha
apply(matriz,2,mean) # Coluna


# Exercício 3 - Considere o dataframe abaixo. Calcule a media por disciplina
escola <- data.frame(Aluno = c('Alan', 'Alice', 'Alana', 'Aline', 'Alex', 'Ajay'),
                     Matematica = c(90, 80, 85, 87, 56, 79),
                     Geografia = c(100, 78, 86, 90, 98, 67),
                     Quimica = c(76, 56, 89, 90, 100, 87))
escola
apply(escola[, c(2,3,4)], 2, mean)
# Obs: Se você tentar calcular a média de apenas uma disciplina, assim, vai receber uma mensagem de erro:
apply(escola$Matematica,2,mean)

# Isso acontece porque o interpretador do R tenta usar um vetor de qualquer dimensão, 
# enquanto apply espera que o objeto tenha algumas dimensões. 
# Você pode evitar a coerção, adicionando drop = F ao seu comando, ou seja:
apply(escola[, c(2), drop=F], 2, mean)


# Exercício 4 - Cria uma lista com 3 elementos, todos numericos e calcule a soma de todos os elementos da lista
lista <- list(15, 20, 25)
class(lista)
do.call(sum, lista)


# Exercício 5 - Transforme a lista anterior um vetor
vetor <- unlist(lista)
class(vetor)
typeof(vetor)

# Exercício 6 - Considere a string abaixo. Substitua a palavra textos por frases
str <- c("Expressoes", "regulares", "em linguagem R",
         "permitem a busca de padroes", "e exploracao de textos",
         "podemos buscar padroes em digitos",
         "como por exemplo",
         "10992451280")
gsub("textos", "frases", str)



# Exercício 7 - Usando o dataset mtcars, crie um gráfico com ggplot do tipo scatter plot.
# Use as colunas disp e mpg nos eixos x e y respectivamente
library(ggplot2)
ggplot(mtcars, aes(x = disp, y = mpg)) +   geom_point()