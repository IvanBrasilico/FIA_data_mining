setwd("D:\\Users\\25052288840\\Downloads\\FIA_data_mining\\Aula 18 - Árvores de Decisão")

credit <- read.csv("credit.csv")
str(credit)
summary(credit)
table(credit$checking_balance)
table(credit$default)
set.seed(12345)
credit_rand <- credit[order(runif(1000)),]
summary(credit_rand$default)
credit_train <- credit_rand[1:900,]
credit_test <- credit_rand[901:1000,]
prop.table(table(credit_train$default))
prop.table(table(credit_test$default))
library(C50)
credit_model <- C5.0(credit_train[-17], credit_train$default)
summary(credit_model)
credit_pred <- predict(credit_model, credit_test)
# install.packages("gmodels")
library(gmodels)
CrossTable(credit_test$default, credit_pred, 	prop.chisq = FALSE, prop.c = FALSE, prop.r = FALSE, 	dnn = c("actual default", "predict default"))


credit_boost10 <- C5.0(credit_train[-17], credit_train$default, trials=10)
summary(credit_boost10)
credit_boost_pred <- predict(credit_boost10, credit_test)
CrossTable(credit_test$default, credit_boost_pred, prop.chisq = FALSE, prop.c = FALSE, prop.r = FALSE, dnn = c("actual default", "predict default"))
str(credit_train$default)
error_cost <- matrix(c(0,1,8,0), nrow=2)
credit_cost <- C5.0(credit_train[-17], credit_train$default, costs = error_cost)
credit_cost_pred <- predict(credit_cost, credit_test)
CrossTable(credit_test$default, credit_cost_pred,  prop.chisq = FALSE, prop.c = FALSE, prop.r = FALSE, 	dnn = c("actual default", "predict default"))

