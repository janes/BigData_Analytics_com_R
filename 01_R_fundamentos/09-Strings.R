# String
texto <- "Isso � uma string!"
texto

x = as.character(3.14)
x
class(x)

# Concatenando strings
nome = "Aline"; sobrenome = "Assun��o"
paste(nome, sobrenome)
cat(nome,sobrenome)
nome_completo = paste(nome, sobrenome)

# Formatando a sa�da
sprintf("%s estuda python e R na DSA h� %d anos.",nome_completo, 2)


# Extraindo partes da string
texto <- "Isso � uma nova string!"
substr(texto, start = 12, stop = 17)
?substr

# Contando o n�mero de caracteres
nchar(texto)

# Alterando a capitaliza��o
tolower("Histogramas e Elementos de Dados")
toupper("Histogramas e Elementos de Dados")

# Usando sringr

library(stringr)

# Dividindo uma string em caracteres
strsplit("Histogramas e Elementos de Dados", NULL)
?strsplit

# Dividindo uma string em caracteres com um separador (espa�o, por exemplo)
strsplit("Histogramas e Elementos de Dados", " ")

# Trabalhando com strings
string1 <- c("Esta � a primeira parte da minha string e ser� a primeira parte do meu vetor",
             "Aqui a minha string continua, mas ser� transformada no segundo vetor")
string1

string2 <- c("Precisamos testar outras strings - !@#$%�%�$",
             "An�lise de Dados em R")
string2

# Adicionando 2 strings
str_c(c(string1, string2), sep = "")

# Podemos contar quantas vezes o caracter aparece no texto
str_count(string2, "s")

# Localiza a primeira e �ltima posi��o em que o caracter aparece na string
str_locate_all(string2, "s")

# Substituir a primeira ocorr�ncia de um caracter
str_replace(string2, "\\s", "")

#Substitui todas as ocorr�ncias de um caracter
str_replace_all(string2, "\\s", "")

# Detectando padr�es nas strings
string1 <- "23 mai 2000"
string2 <- "1 mai 2000"
padrao <- "mai 20"
grepl(pattern = padrao, x = string1)
padrao <- "mai20"
grepl(pattern = padrao, x = string1)

# Importante arquivo txt
# http://www.gutenberg.org/cache/epub/100/pg100.txt
library(stringr)
arquivo <- read.csv("data/dframe.csv")

str(arquivo)
head(arquivo)
tail(arquivo)

?str_count
str_count(arquivo$ID, "7")
str_locate_all(arquivo$ID, "7")

# Criando fun�es para manipular strings
strtail <- function(s, n=1){
  if(n<0)
    substring(s, 1-n)
  else
    substring(s,nchar(s)-n+1)
}

strtail("String de teste", 6)