setwd("D:\\Users\\25052288840\\Downloads\\FIA_data_mining\\Aula 18 - Árvores de Decisão")
# install.packages("arules")
library(arules)
groceries <- read.transactions("groceries.csv", sep = ",")
groceries
str(groceries)
groceries@itemInfo
inspect(head(groceries))
groceries@data[1:35, 1:35]
summary(groceries)
itemFrequency(groceries)
itemFrequency(groceries[, 1:3])
itemFrequencyPlot(groceries, support = 0.1)
itemFrequencyPlot(groceries, support = 0.05)
itemFrequencyPlot(groceries, topN = 20)
itemFrequencyPlot(groceries, topN = 100)
itemFrequencyPlot(groceries, support = 0.05,
                  cex.names=0.8, xlim = c(0,0.3), type = "relative", horiz =
                    TRUE, col = "dark red", las = 1, xlab = paste("Proportion of
Market Baskets Containing Item", "\n(Item Relative
Frequency or Support)"))
image(groceries[1:50])
image(groceries[1:500])
image(sample(groceries, 100))
apriori(groceries)
groceryrules <- apriori(
  groceries,
  parameter = list(support =.006, confidence = 0.25, minlen = 2)
  )
inspect(groceryrules)
inspect(groceryrules[1:3])
# install.packages("arulesViz")
library(arulesViz)
plot(groceryrules, method="two-key plot",
     cex=0.8)
library(RColorBrewer)
plot(groceryrules, control=list(jitter=2, col = rev(brewer.pal(9,
     "Greens")[4:9])), shading = "lift", cex=0.8)
plot(groceryrules,control=list(
  jitter=2,
  col=rev(brewer.pal(9, "Greens")[4:9])),
  measure = c("support", "lift"), shading = "confidence", cex=0.8,
  interactive = TRUE)
