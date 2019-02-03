### Feature Selection
# ... cont do script 02

# Modelo randomForest para criar um plot de importancia das variaveis
library(randomForest)
modelo <- randomForest(CreditStatus ~ .
                       - Duration
                       - Age
                       - CreditAmount
                       - ForeignWorker
                       - NumberDependents
                       - Telephone
                       - ExistingCreditsAtBank
                       - PresentResidenceTime
                       - Job
                       - Housing
                       - SexAndStatus
                       - InstallmentRatePecnt
                       - OtherDetorsGuarantors
                       - Age_f
                       - OtherInstalments,
                       data = Credit,
                       ntree = 100,
                       nodesize = 10,
                       importance = T)
  
varImpPlot(modelo)

outFrame <- serList(list(credit.model = modelo))
  
outFrame

