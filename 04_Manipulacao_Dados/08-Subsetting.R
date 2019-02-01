# Subsetting

# Muitas das técnicas abaixo podem ser realizadas com a aplicação das funções:
# subset(), merge(), plyr::arrange()
# Mas conhecer estas notações é fundamental para compreeder como gerar subconjuntos de dados

## Vetores
x <- c(6.2, 8.1, 5.5, 2.9)
x[]
x

# indices positivos - elementos em posições especificas
x[3]
x[c(1,3)]
x[c(1,1)]
x[order(x)]

# indices negativos - ignora elementos em posicoes especificas
x[-3]
x[-c(1, 3)]
x[-c(1, 4)]

# vetor logico para gerar subsetting
x[c(TRUE, FALSE)]
x[c(TRUE, FALSE, TRUE, FALSE)]

# Vetor de caracteres
y <-  setNames(x, letters[1:4])
y
y[c("d", "c", "a")]
y[c("a", "a", "a")]

## Matrizes
mat <- matrix(1:9, nrow = 3)
colnames(mat) <- c("A", "B", "C")
mat
mat[1:2, ]
mat[1:2, 2:3]


# funcao outer() permite que uma matriz se comporte como vetores individuais
?outer
vals <- outer(1:5, 1:5, FUN = "paste", sep = ",")
vals
vals[c(4, 15)]

# Dataframes

df <- data.frame(x = 1:3, y = 3:1, z = letters[1:3])
df
df$x
df[df$x ==2, ]
df[c(1,3), ]
df[c("x", "z")]
df[, c("x", "z")]
str(df["x"])
str(df[, "x"])

# removendo colunas de dataframes
df <- data.frame(x = 1:3, y = 3:1, z = letters[1:3])
df
# realmente apaga a coluna no df
df$z <- NULL
df
# outra forma (apenas não retorna o dado)
df <- data.frame(x = 1:3, y = 3:1, z = letters[1:3])
df[setdiff(names(df), "z")]

# operadores [], [[]] e $
a <- list(x = 1, y = 2)
a
a[1]
a[[1]]
a[["x"]]

b <- list(a = list(b = list(c = list(d = 1))))
b
b[[c("a", "b", "c", "d")]]
b[["a"]][["b"]][["c"]][["d"]]

# x$y é equivalente a x[["y", exact = FALSE]]
var <- "cyl"
# tentando retornar a coluna var, não é possivel
mtcars$var
# busca os itens que tem este indice - ok
mtcars[[var]]

x <- list(abc = 1)
x$a
# não existe
x[["a"]]

# subsetting e atribuição (modificando)
x <- 1:5
x
x[c(1:2)] <- 2:3
x
x[-1] <- 4:1
x

# Isso é subsetting
head(mtcars)
mtcars[] <- lapply(mtcars, as.integer)
head(mtcars)

# Isso não é subsetting
mtcars <- lapply(mtcars, as.integer)
head(mtcars)

# Lookup tables ()
x <- c("m", "f", "u", "f", "f", "m", "m")
lookup <- c(m = "Male", f = "Female", u = NA)
lookup[x]
unname(lookup[x])

# usando operadores lógicos
x1 <- 1:10 %% 2 == 0
x1
which(x1)
x2 <- which(x1)
x2
y1 <- 1:10 %% 5 == 0
y2 <- which(y1)
y2
# elementos comuns
intersect(x2, y2)
# and
x1 & y1
# união
union(x2, y2)
# elementos que não são comuns entre os dois
setdiff(x2, y2)





