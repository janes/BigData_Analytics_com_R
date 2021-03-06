# Fatores

vec1<- c("Macho", "Femea", "Femea", "Macho", "Macho")
vec1
fac_vec1 <- factor(vec1)
fac_vec1
class(vec1)
class(fac_vec1)

# Vari�veis categ�ricas nominais
# N�o existe uma ordem impl�cita
animais <- c("Zebra", "Pantera", "Rinoceronte", "Macaco", "Tigre")
animais
class(animais)
fac_animais <- factor(animais)
fac_animais
class(fac_animais)
levels(fac_animais)

# Vari�veis categ�ricas ordinais
# Possuem uma ordem natural
grad <- c("Mestrado", "Doutorado", "Bacharelado", "Mestrado", "Mestrado")
grad
fac_grad <- factor(grad, order = TRUE, levels = c("Doutorado", "Mestrado", "Bacharelado"))
fac_grad
levels(fac_grad)

# Sumarizar os dados fornece uma vis�o geral sobre o conte�do das vari�veis
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

# Fatores N�o-Ordenados
set1 <- c("AA", "B", "BA", "CC", "CA", "AA", "BA", "CC", "CC")
set1
# Transformando os dados. R apenas cria os n�veis (n�o significa que exista uma hierarquia)
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

# Vari�veis do tipo fator
str(df)

# N�veis dos fatores
# Internamente, o R armazena valores inteiros e faz um mapeamento para as strings (em ordem alfab�tica)
# e agrupa as estat�sticas por n�veis. Agora, se fizermos sumariza��o de estat�sticas, � poss�vel visualizar 
# a contabiliza��o de  para cada categoria
levels(df$Etnia)
summary(df$Etnia)

# Plot
# Agora se fizermos um plot, temos um boxplot para estas vari�veis categ�ricas
plot(df$Idade~df$Etnia, xlab = 'Etnia', ylab = 'Idade', main = 'Idade por Etnia')

# Regrass�o
summary(lm(Idade~Etnia, data = df))

# Convertendo uma coluna em vari�vel categ�rica. Isso criar� um fator n�o-ordenado
df
str(df)
df$Estado_Civil.cat <- factor(df$Estado_Civil, labels = c("Solteiro", "Casado", "Divorciado"))
df
str(df)

# Compreendendo a ordem dos fatores

# N�veis dos fatores
# Internamente, o R armazena valores inteiros e faz um mapeamento para as strings (em ordem alfab�tica)
# e agrupa as estat�sticas por n�veis.

# Criando vetores
vec1 <- c(1001, 1002, 1003, 1004, 1005)
vec2 <- c(0,1,1,0,2)
vec3 <- c("Verde", "Laranja", "Azul", "Laranja", "Verde")

# Unindo os vetores em um dataframe
df <- data.frame(vec1, vec2, vec3)
df

# Verificando que o R categorizou a �ltima coluna como fator
str(df)

# Verificando os n�veis do fator. Perceba que os n�veis est�o categorizados em ordem alfab�tica
levels(df$vec3)

# criando uma outra coluna e atribuindo labels
df$cat1 <- factor(df$vec3, labels = c("cor2", "cor1", "cor3"))
df

# Internamente, os fatores s�o registrados como inteiros, mas a ordena��o segue a ordem alfab�tica das strings
str(df)

# Veja como foi feita a atribui��o:
# Azul = cor2
# Laranja = cor1
# Verde = cor3
# Ou seja, os vetores com os labels, seguiram a ordem alfab�tica dos n�veis classificados pelo R

# Criando uma outra coluna e atribuindo labels
# Ao aplicarmos a fun��o factor() a coluna vec2, internamente o R classificou em ordem alfab�tica
# e quando atribu�mos os labels, foi feita a associa��o.
df$cat2 <- factor(df$vec2, labels = c("Divorciado", "Casado", "Solteiro"))
df
str(df)
levels(df$cat2)