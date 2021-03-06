# Remodelando os dados com Reshape

# Pivot (transposta da matriz)
mtcars
t(mtcars)

# Reshape
head(iris)
str(iris)
library(lattice)

# Distribuindo os dados verticalmente (long)
iris_modif <- reshape(iris,
                      varying = 1:4,
                      v.names = "Medidas",
                      timevar = "Dimensoes",
                      times = names(iris)[1:4],
                      idvar = "ID",
                      direction = "long")

head(iris_modif)
iris_modif

bwplot(Medidas ~ Species | Dimensoes, data = iris_modif)

iris_modif_sp <- reshape(iris,
                         varying = list(c(1,3), c(2,4)),
                         v.names = c("Comprimento", "Largura"),
                         timevar = "Partes",
                         times = c("Sepal", "Petal"),
                         idvar = "ID",
                         direction = "long")
head(iris_modif_sp)
head(iris)

xyplot(Comprimento ~ Largura | Species, groups = Partes,
       data = iris_modif_sp, auto.key = list(space = "right"))

xyplot(Comprimento ~ Largura | Species, groups = Species,
       data = iris_modif_sp, auto.key = list(space = "right"))


# Reshape2
install.packages("reshape2")
library(reshape2)

# Criando um dataframe
df = data.frame(nome = c("Zico", "Pele"),
                chuteira = c(40, 42),
                idade = c(34, NA),
                peso = c(93, NA),
                altura = c(175, 178))
df

# "Derretendo" o dataframe - Fun��o melt()
df_wide = melt(df, id = c("nome", "chuteira"))
df_wide

# Removendo NA
df_wide = melt(df, id = c("nome", "chuteira"), na.rm = TRUE)
df_wide

# "Esticando" o dataframe
dcast(df_wide, formula = chuteira + nome ~ variable)
dcast(df_wide, formula = nome + chuteira ~ variable)
dcast(df_wide, formula = nome ~ variable)
dcast(df_wide, formula = ... ~ variable)

# aplicando o reshape2
names(airquality) <- tolower(names(airquality))
head(airquality)
dim(airquality)

# Fun��o melt() - wide
?melt
df_wide <- melt(airquality)
class(df_wide)
df_wide
head(df_wide)
tail(df_wide)
dim(df_wide)

# inserindo mais duas variaveis
df_wide <- melt(airquality, id.vars = c("month", "day"))
head(df_wide)

df_wide <- melt(airquality, id.vars = c("month", "day"))
df_long <- dcast(df_wide, month + day ~ variable)
head(df_long)
head(airquality)
