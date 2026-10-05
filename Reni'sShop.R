library(tidyverse)
library(RMySQL)
con <- dbConnect(RMySQL::MySQL(),
                 dbname = "shoppingdb",
                 host = "localhost",
                 user = "root",
                 password = "Harshita@123")
df <- dbGetQuery(con, "SELECT * FROM CustomerData")
head(df)
str(df)
dfClean <- df %>%
	distinct() %>%
	drop_na()
cat("Original rows:",nrow(df),"\n")
cat("Cleaned rows:",nrow(dfClean),"\n")
dfFeatures <- dfClean %>%
	mutate(
		viewTocartRate = CartAdds /pmax(Views,1),
		targetPurchased = ifelse(Purchases> 0,1,0)
		)
model <- glm(targetPurchased ~ ProductPrice + Views + CartAdds + PreviousPurchases,
		data = dfFeatures,
		family = binomial)
print(summary(model))
getTop5Recommended <- function(targetCustomerId, data, trainedModel){
  customerData <- data %>% filter(CustomerId == targetCustomerId)
  
  if(nrow(customerData) == 0){
    cat("Ohoi there, new customer! Welcome to Reni Lab's product recommendation system! We guarantee you will like these: \n")
    
    topGlobal <- data %>%
      group_by(ProductId, ProductCategory) %>%
      summarise(score = mean(Purchases, na.rm = TRUE), .groups = 'drop') %>%
      arrange(desc(score)) %>%
      head(5)
    
    return(topGlobal)
  } else {
    customerData$predictedProbability <- predict(trainedModel, newdata = customerData, type = "response")
    
    top5Products <- customerData %>%
      arrange(desc(predictedProbability)) %>%
      head(5) %>%
      select(CustomerId, ProductId, ProductCategory, ProductPrice, predictedProbability)
    
    return(top5Products)
  }
}
