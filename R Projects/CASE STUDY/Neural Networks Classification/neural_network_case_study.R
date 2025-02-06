setwd("C:/Users/shkungulio/OneDrive/Documentos/DATA 620 - Data Mining/case-studies/Neural Networks Classification")

#==============================================================================#
# BUSINESS UNDERSTANDING
#==============================================================================#
# Problem Statement:
# In this case study we aim to predict if a stock will pay a dividend

#


#==============================================================================#
# DATA UNDERSTANDING
#==============================================================================#
# Review the Dataset:
#

# Data Dictionary:



#==============================================================================#
# DATA PREPARATION
#==============================================================================#
# Load the Dataset:
dividend.df <- read.csv("dividend_info.csv")

# Check the dimensions of the dataset.
dim(dividend.df)

# Show the first six rows to check the data
head(dividend.df)

# Display all data in a new tab
View(dividend.df)

# Determine the type (class) of each variable in R
# Print the list of the variables
variable_names <- names(dividend.df)

# Use sapply to get the class of each variable
variable_classes <- sapply(dividend.df, class)

# Combine variable names and classes into the data frame
result_df <- data.frame(Variable = variable_names, Class = variable_classes)

# Print the result
print(result_df)

# Determine the type (class) of each variable in R using the str() function
str(dividend.df)

# Determine the summary statistics for each column
summary(dividend.df)

#==============================================================================#
# MODELING
#==============================================================================#



#==============================================================================#
# EVALUATION
#==============================================================================#

