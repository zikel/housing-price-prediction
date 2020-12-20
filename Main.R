
# load libraries
library(gdata)
library(stats)

LinearModel <- function(train_data, test_data){
  
  # read in training data
  #train_data <- read.csv("house_train.csv", header=TRUE)
  # read in testing data
  #test_data <- read.csv("house_test.csv", header=TRUE)
  
  # modify levels only appeared in testing data to one also appeared in the training data
  for (i in seq_len(nrow(test_data))) {
    if (test_data$INTWALL[i] == "Terrazo") test_data$INTWALL[i] <- "Default"
  }
  
  for (i in seq_len(nrow(test_data))) {
    if (test_data$STYLE[i] == "3.5 Story Fin") test_data$STYLE[i] <- "3 Story"
  }
  
  # extract year of sale from SALEDATE
  for (i in seq_len(nrow(train_data))) {
    train_data$SALEYEAR[i] <- as.numeric(substr(train_data$SALEDATE[i],1,4))
  }
  
  for (i in seq_len(nrow(test_data))) {
    test_data$SALEYEAR[i] <- as.numeric(substr(test_data$SALEDATE[i],1,4))
  }
  
  
  # linear model fit
  fit <- lm(I(log(PRICE)) ~ BATHRM + HF_BATHRM + ROOMS + EYB + SALEYEAR 
            + log(GBA) + GRADE + LANDAREA + ASSESSMENT_NBHD + CNDTN + FIREPLACES 
            + BATHRM:SALEYEAR + HF_BATHRM:SALEYEAR, data = train_data)
  pred <- predict(fit, newdata=test_data)
  res <- data.frame(Id=test_data$Id, PRICE=exp(pred))
  return(res)
}
