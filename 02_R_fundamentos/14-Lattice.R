# Lattice

# O pacote Lattice � um sistema de visualiza��o de dados 
# de alto n�vel poderoso e elegante, com �nfase em dados 
# multivariados. 

# Na cria��o de gr�ficos, condi��es e agrupamentos s�o 2 conceitos
# importantes, que nos permitem compreender mais facilmente
# os dados que temos em m�os. O conceito por tr�s do Lattice
# � agrupar os dados e criar visualiza��oes de forma que fique 
# mais f�cil a busca por padr�es


install.packages("lattice")
library(lattice)

xyplot(data = iris, groups = Species, Sepal.Length ~ Petal.Length)

# ScatterPlot
splom(trees)

?Titanic

barchart(Class ~ Freq | Sex + Age, data = as.data.frame(Titanic),
         groups = Survived, stack = T, layout = c(4, 1),
         auto.Key = list(title = "Dados Titanic", columns = 2))

barchart(Class ~ Freq | Sex + Age, data = as.data.frame(Titanic),
         groups = Survived, stack = T, layout = c(4, 1),
         auto.Key = list(title = "Dados Titanic", columns = 2, 
                         ))

x = equal.count(rivers)
x

PentalLength <- equal.count(iris$Petal.Length, 4)
PentalLength

xyplot(Sepal.Length~Sepal.Width | PentalLength, data = iris)

xyplot(Sepal.Length~Sepal.Width | PentalLength, data = iris,
       panel = function(...) {
         panel.grid(h = -1, v = -1, col.line = "skyblue")
         panel.xyplot(...)
       })

xyplot(Sepal.Length~Sepal.Width | PentalLength, data = iris,
       panel = function(x, y, ...) {
         panel.xyplot(x, y, ...)
         mylm <- lm(y~x)
         panel.abline(mylm)
       })

histogram(~Sepal.Length | Species, xlab = "", data = iris, layout = c(3, 1),
          type = "density", main = "Lattice Histogram", sub = "Iris Dataset, Sepal Length")


qqmath(Sepal.Length~Sepal.Width | PentalLength, data = iris, distribution = qunif)

# boxplot
bwplot(Species~Sepal.Length, data = iris)

# ViolinPlot
bwplot(Species~Sepal.Length, data = iris, panel = panel.violin)

par(mfrow = c(1, 3))

cyls <- split(mtcars, mtcars$cyl)
for (ii in 1:length(cyls)) {
  tmpdf <- cyls[[ii]]
  sname <- names(cyls)[ii]
  plot(tmpdf$wt, tmpdf$mpg, 
       main = paste("MPG vs Wt",sname,"Cyl"),
       ylim = c(0,40), xlab = "Wt / 1,000",
       ylab = "MPG", pch=19, col="blue")
  grid()
}













