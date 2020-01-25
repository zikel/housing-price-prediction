# first set working directory, then read in the data
dtrain <- read.csv("house_train.csv")
dtest <- read.csv("house_test.csv")


# load user-defined LinearModel function, use UW_ID 20654321 as an example
source("20530029.R")
# call the function
res <- LinearModel(dtrain, dtest)

# you can save the result for submission to Kaggle
write.csv(res, file="solution_sample_100.csv", row.names=FALSE)

# The grading team will compare the result to the solution to compute RMLSE
# for example, assume sol is the data.frame containing the true price in the same order as in res
# sqrt(mean((log(res$PRICE)-log(sol$PRICE))^2))
