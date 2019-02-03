# Analisando o resultado atraves de graficos
# ... cont do script 07

compFrame <- result_previsto_v2 # outFrame

# Usando o dplyr para filtrar linhas com classificação incorreta
require(dplyr)
creditTest <- cbind(dados_test, scored = compFrame[, 2])
creditTest <- creditTest %>% filter(CreditStatus != scored)

# Plot dos residuos para os niveis de cada fator
require(ggplot2)

colNames <- c("CheckingAcctStat", "Duration_f", "Purpose",
              "CreditHistory", "SavingsBonds", "Employment",
              "CreditAmount_f", "Employment")

lapply(colNames, function(x) {
  if (is.factor(creditTest[, x])) {
    ggplot(creditTest, aes_string(x)) +
      geom_bar() +
      facet_grid(. ~ CreditStatus) + 
      ggtitle(paste("Numero de creditos ruim/bom por ", x))
  }})

# Plot dos residuos condicionados nas variaveis CreditStatus vs CheckingAccStat
lapply(colNames, function(x) {
  if (is.factor(creditTest[, x]) & x != "CheckingAcctStat") {
    ggplot(creditTest, aes(CheckingAcctStat)) +
      geom_bar() +
      facet_grid(paste(x, " ~ CreditStatus")) +
      ggtitle(paste("Numero de creditos Bom/ruim por CheckingAcctStat e ", x))
  }}
  )














