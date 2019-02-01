# Fatores

vec1<- c("Macho", "Femea", "Femea", "Macho", "Macho")
vec1
fac_vec1 <- factor(vec1)
fac_vec1
class(vec1)
class(fac_vec1)

# Variáveis categóricas nominais
# Não existe uma ordem implícita
animais <- c("Zebra", "Pantera", "Rinoceronte", "Macaco", "Tigre")
animais
class(animais)
fac_animais <- factor(animais)
fac_animais
class(fac_animais)
levels(fac_animais)

# Variáveis categóricas ordinais
# Possuem uma ordem natural
grad <- c("Mestrado", "Doutorado", "Bacharelado", "Mestrado", "Mestrado")
grad
fac_grad <- factor(grad, order = TRUE, levels = c("Doutorado", "Mestrado", "Bacharelado"))
fac_grad
levels(fac_grad)

# Sumarizar os dados fornece uma visão geral sobre o conteúdo das variáveis
summary(fac_grad)
summary(grad)

vec2 <- c("M", "F", "F", "M", "M", "M", "F", "F", "M", "M", "M", "F", "F", "M", "M")
vec2
fac_vec2 <- factor(vec2)
fac_vec2
levels(fac_vec2) <- c("Femea", "Macho")
fac_vec2
summary(fac_vec2)
summary(vec2)

# Mais exemplos
data = c(1,2,2,3,1,2,3,3,1,2,3,3,1)
fdata <- factor(data)
fdata
rdata <- factor(data, labels = c("I","II","III"))
rdata

# Fatores Não-Ordenados
set1 <- c("AA", "B", "BA", "CC", "CA", "AA", "BA", "CC", "CC")
set1
# Transformando os dados. R apenas cria os níveis (não significa que exista uma hierarquia)
f_set1 <- factor(set1)
f_set1
class(f_set1)
is.ordered(f_set1)

# Fatores Ordenados
ord_set1 <- factor(set1,
                   levels = c("CA", "BA", "AA", "CC", "B"),
                   ordered = TRUE)
ord_set1
is.ordered(ord_set1)
as.numeric(ord_set1)
table(ord_set1)

# Fatores e dataframes
df <- read.csv2("data/etnias.csv", sep = ',')
df

# Variáveis do tipo fator
str(df)

# Níveis dos fatores
# Internamente, o R armazena valores inteiros e faz um mapeamento para as strings (em ordem alfabética)
# e agrupa as estatísticas por níveis. Agora, se fizermos sumarização de estatísticas, é possível visualizar 
# a contabilização de  para cada categoria
levels(df$Etnia)
summary(df$Etnia)

# Plot
# Agora se fizermos um plot, temos um boxplot para estas variáveis categóricas
plot(df$Idade~df$Etnia, xlab = 'Etnia', ylab = 'Idade', main = 'Idade por Etnia')

# Regrassão
summary(lm(Idade~Etnia, data = df))

# Convertendo uma coluna em variável categórica. Isso criará um fator não-ordenado
df
str(df)
df$Estado_Civil.cat <- factor(df$Estado_Civil, labels = c("Solteiro", "Casado", "Divorciado"))
df
str(df)

# Compreendendo a ordem dos fatores

# Níveis dos fatores
# Internamente, o R armazena valores inteiros e faz um mapeamento para as strings (em ordem alfabética)
# e agrupa as estatísticas por níveis.

# Criando vetores
vec1 <- c(1001, 1002, 1003, 1004, 1005)
vec2 <- c(0,1,1,0,2)
vec3 <- c("Verde", "Laranja", "Azul", "Laranja", "Verde")

# Unindo os vetores em um dataframe
df <- data.frame(vec1, vec2, vec3)
df

# Verificando que o R categorizou a última coluna como fator
str(df)

# Verificando os níveis do fator. Perceba que os níveis estão categorizados em ordem alfabética
levels(df$vec3)

# criando uma outra coluna e atribuindo labels
df$cat1 <- factor(df$vec3, labels = c("cor2", "cor1", "cor3"))
df

# Internamente, os fatores são registrados como inteiros, mas a ordenação segue a ordem alfabética das strings
str(df)

# Veja como foi feita a atribuição:
# Azul = cor2
# Laranja = cor1
# Verde = cor3
# Ou seja, os vetores com os labels, seguiram a ordem alfabética dos níveis classificados pelo R

# Criando uma outra coluna e atribuindo labels
# Ao aplicarmos a função factor() a coluna vec2, internamente o R classificou em ordem alfabética
# e quando atribuímos os labels, foi feita a associação.
df$cat2 <- factor(df$vec2, labels = c("Divorciado", "Casado", "Solteiro"))
df
str(df)
levels(df$cat2)