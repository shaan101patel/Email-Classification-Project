---
  title: "MIST 7770 Final Project 'Spambase'"
author: "Group 3: Ryan Cullen, Judd Douglas, Matthew Karnatz, Collin Ladina, Shaan Patel"
date: "`r Sys.Date()`"
output:
  html_document: default
---
  
  ```{r setup, include=FALSE}
library(readxl) # reading the data in Excel file
library(writexl) # writes the manipulated data to a new Excel file in my data directory
library(psych) # descriptive statistics
library(caret) # k-fold cross-validation or cv for short
library(tidyverse) # %>% (pipes) and data structure called tibble
```

# Read data as tibble (tidyverse data structure that is similar to dataframes)
```{r read and split data}
data <- read_excel("data/SpamBase data.xlsx") %>% as_tibble()
```

# Descriptive statistics for X's (independent features) with describe method from psych package
These descriptive statistics are before handling any outliers and/or missing valeus in the data
```{r descriptive statistics}
descriptive_statistics <- describe(data,fast = T)
descriptive_statistics %>%
  select(-c(vars,n,skew,kurtosis,se)) %>% 
  slice(1:nrow(descriptive_statistics)-1) # does not include is_spam (binary values 0 or 1)
```

# Descriptive Statistics for Most Important Inputs
A feature being considered the most important in this context means the feature was included in the final/best Big ML model.
```{r most important descriptive statistics}
most_important <- data %>%
  select(c('word_freq_all', 'word_freq_our', 'word_freq_will', 'word_freq_free', 'word_freq_you', 'word_freq_your', 'word_freq_re', 'char_freq_(', 'char_freq_!', 'char_freq_$', 'capital_run_length_average', 'capital_run_length_longest', 'capital_run_length_total'))

describe(most_important,fast = T) %>%
  select(-c(vars,n,skew,kurtosis,se)) %>% 
  slice(1:nrow(descriptive_statistics)-1) # does not include is_spam (binary values 0 or 1)
```

Descriptive statistics from describe method in psych package will not be helpful for the is_spam because is_spam is binary. Therefore, we created a relative frequency table below to serve as the descriptive statistic for is_spam.

# Relative Frequency Table of Spam
```{r relative frequency table}
table(data$is_spam)/length(data$is_spam)
```

# Missing Values
```{r missing values}
missing_values <- is.na(data) %>% sum()
```
There are `r missing_values` missing values. We will now check for outliers below.

# Handling Outliers (any outliers for a feature become the median of said feature)
```{r handling outliers}
columns_with_outliers <- c()
clean_data <- data[,1:ncol(data)-1] # we are just checking X's for outliers, not checking y plus our y (is_spam) is categorical and binary (0 or 1), so no need to check for outliers in y

for (col_name in colnames(clean_data)) {
  column <- clean_data[[col_name]]
  
  if (is.numeric(column)) { # they should all be numeric, but safe to check
    q1 <- quantile(column,0.25) # could use na.rm = T, but there are no missing values
    column_median <- median(column) # could use na.rm = T, but there are no missing values
    q3 <- quantile(column,0.75) # could use na.rm = T, but there are no missing values
    iqr <- q3 - q1
    lower_bound <- q1 - (1.5 * iqr)
    upper_bound <- q3 + (1.5 * iqr)
    
    clean_data[[col_name]] <- ifelse( (column < lower_bound | column > upper_bound), column_median, column) # this will replace any outlier in column with the median of said column
    
    outlier_indices <- which(column < lower_bound | column > upper_bound)
    if (length(outlier_indices) > 0) {
      columns_with_outliers <- c(columns_with_outliers, col_name)
    }
    
  }
  paste(col_name,"is not numeric, so function was not applied to said column") %>% return()
}
```

There are `r ncol(data)-1` X's that are numeric columns needing to be checked for outliers, and `r length(columns_with_outliers)` columns had outliers.

# Writing new Excel file with cleaned data (input to BigML models)
```{r new Excel file}
clean_data <- clean_data %>%
  mutate(is_spam = data$is_spam)
# dim(clean_data) # it has 4601 (rows), 58 (columns) just like the original data
write_xlsx(clean_data, "data/Cleaned SpamBase Data.xlsx")
```

The dimensions for the clean data (now in a new Excel file) and the original data are the same. The original data has `r nrow(data)` rows and `r ncol(data)` columns; similarly, the clean data has `r nrow(clean_data)` rows and `r ncol(clean_data)` columns.