# Script para checar as colunas do dataset

# Configurando o diretorio
getwd()
setwd("C:/Projetos/Git_Projetos/BD_Analytics_com_R/07_Classificacao_com_R")

# Carrega o dataset antes da transformacao
df <- read.csv("data/credito.csv")
head(df)
str(df)

# Nome das variaveis
# CheckingAcctStat, Duration, CreditHistory, Purpose, CreditAmount, 
# SavingsBonds, Employment, InstallmentRatePecnt, SexAndStatus, 
# OtherDetorsGuarantors, PresentResidenceTime, Property, Age, 
# OtherInstallments, Housing, ExistingCreditsAtBank, Job, 
# NumberDependents, Telephone, ForeignWorker, CreditStatus