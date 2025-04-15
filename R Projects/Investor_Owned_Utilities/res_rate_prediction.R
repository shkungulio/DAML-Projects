# Load libraries
library(tidyverse)
library(caret)
library(randomForest)
library(rpart)
library(xgboost)
library(e1071)
library(nnet)

# Load data
utility_20 <- read.csv("data/iou_zipcodes_2020.csv")
utility_20$year <- "2020"

utility_21 <- read.csv("data/iou_zipcodes_2021.csv")
utility_21$year <- "2021"

utility_22 <- read.csv("data/iou_zipcodes_2022.csv")
utility_22$year <- "2022"

utility_23 <- read.csv("data/iou_zipcodes_2023.csv")
utility_23$year <- "2023"

# Combine the individual files into one
data <- rbind(utility_20, utility_21, utility_22, utility_23)

# Drop rows with NA or 0 in res_rate
data_clean <- data %>%
  filter(res_rate > 0) %>%
  drop_na()

# Encode categorical variables
data_clean <- data_clean %>%
  mutate(across(c(utility_name, state, service_type, ownership, year), as.factor))

# Split data into features and target
X <- data_clean %>% select(-res_rate)
y <- data_clean$res_rate

# One-hot encoding for categorical variables
# Remove factors with only one level
X <- X %>% select(where(~ nlevels(as.factor(.)) > 1))

# Then do one-hot encoding
X_encoded <- model.matrix(~ . -1, data = X) %>% as.data.frame()

# Combine features and target for modeling
full_data <- cbind(X_encoded, res_rate = y)

# Train-test split
set.seed(123)
train_index <- createDataPartition(full_data$res_rate, p = 0.8, list = FALSE)
train_data <- full_data[train_index, ]
test_data <- full_data[-train_index, ]

# Helper function to evaluate model
evaluate_model <- function(pred, actual) {
  RMSE <- sqrt(mean((pred - actual)^2))
  R2 <- 1 - sum((pred - actual)^2) / sum((actual - mean(actual))^2)
  return(list(RMSE = RMSE, R2 = R2))
}

## LINEAR REGRESSION
lm_model <- lm(res_rate ~ ., data = train_data)
lm_pred <- predict(lm_model, test_data)
evaluate_model(lm_pred, test_data$res_rate)


## DECISION TREE
tree_model <- rpart(res_rate ~ ., data = train_data)
tree_pred <- predict(tree_model, test_data)
evaluate_model(tree_pred, test_data$res_rate)


## RANDOM FOREST
#rf_model <- randomForest(res_rate ~ ., data = train_data, ntree = 100)
#rf_pred <- predict(rf_model, test_data)
#evaluate_model(rf_pred, test_data$res_rate)


## XGBOOST
# XGBoost needs matrices
dtrain <- xgb.DMatrix(data = as.matrix(train_data[, -ncol(train_data)]), label = train_data$res_rate)
dtest <- xgb.DMatrix(data = as.matrix(test_data[, -ncol(test_data)]), label = test_data$res_rate)

xgb_model <- xgboost(data = dtrain, nrounds = 100, objective = "reg:squarederror", verbose = 0)
xgb_pred <- predict(xgb_model, dtest)
evaluate_model(xgb_pred, test_data$res_rate)


## SVM
svm_model <- svm(res_rate ~ ., data = train_data)
svm_pred <- predict(svm_model, test_data)
evaluate_model(svm_pred, test_data$res_rate)


## NEURAL NETWORKS
nn_model <- nnet(res_rate ~ ., data = train_data, size = 5, linout = TRUE, trace = FALSE)
nn_pred <- predict(nn_model, test_data, type = "raw")
evaluate_model(nn_pred, test_data$res_rate)


## COMPARE MODEL PERFORMANCE
results <- tibble(
  Model = c("Linear Regression", "Decision Tree", "Random Forest", 
            "XGBoost", "Support Vector Machine", "Neural Network"),
  RMSE = c(
    evaluate_model(lm_pred, test_data$res_rate)$RMSE,
    evaluate_model(tree_pred, test_data$res_rate)$RMSE,
    evaluate_model(rf_pred, test_data$res_rate)$RMSE,
    evaluate_model(xgb_pred, test_data$res_rate)$RMSE,
    evaluate_model(svm_pred, test_data$res_rate)$RMSE,
    evaluate_model(nn_pred, test_data$res_rate)$RMSE
  ),
  R2 = c(
    evaluate_model(lm_pred, test_data$res_rate)$R2,
    evaluate_model(tree_pred, test_data$res_rate)$R2,
    evaluate_model(rf_pred, test_data$res_rate)$R2,
    evaluate_model(xgb_pred, test_data$res_rate)$R2,
    evaluate_model(svm_pred, test_data$res_rate)$R2,
    evaluate_model(nn_pred, test_data$res_rate)$R2
  )
)

print(results)
