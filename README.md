# Email Classification

## Contributers:
- Collin Ladina
- Judd Douglas
- Matthew Karnatz
- Ryan Cullen
- Shaan Patel

## Project Overview:
tasked with building a predictive model to classify emails as spam or non-spam using the **Spambase** dataset from the University of California Irvine (UCI) Machine Learning Repository.

The objective is to conduct an exploratory analysis, create visualizations, and select the most suitable machine learning model for the classification task. By the end of the project, we aim to provide actionable insights and recommend a model that accurately classifies spam emails.

## Dataset:
- **Name**: Spambase Dataset
- **Source**: [UCI ML Repository](https://archive.ics.uci.edu/dataset/94/spambase)
- **Size**: 4,601 emails
- **Variables**: 58 variables including word frequencies, character frequencies, and length-based metrics.
- **Target Variable**: `is_spam` (1: Spam, 0: Non-Spam)

### Data Description:
The Spambase dataset contains 57 features describing different aspects of email content, such as the frequency of specific words or characters (e.g., "make", "address", "!", etc.), and the percentage of capital letters. The binary target variable `is_spam` indicates whether an email is spam or not.

## Feedback & Revision:
Following feedback from our professor, Dr. Rios, on 10/19/2024, we have incorporated the following improvements:
1. **Relative Frequency**: We added analyses for the relative frequency of categorical variables.
2. **Handling Missing Data**: Explored alternatives to excluding missing values and performed a detailed analysis of the missing values in our dataset.
3. **Descriptive Visualizations**: Created visualizations to explore relationships between features and the target variable.

## Model Selection:
For this stage, we focused on selecting the appropriate model for our final analysis. After exploratory data analysis (EDA) and considering the features of the dataset, we have shortlisted models like Logistic Regression, Decision Trees, and Random Forests.

## Instructions:
The final model, along with supporting visualizations and analysis, will be presented as part of the final project submission.

## How to Use This Repository:
1. **Data Import**: The Spambase dataset can be accessed via UCI ML Repository and is pre-processed in our code.
2. **Analysis**: Our notebook includes code for exploratory data analysis, descriptive visualizations, and model selection.
3. **Execution**: Clone the repository and run the Jupyter notebooks to view the analysis.

## Future Work:
- **Model Training & Evaluation**: After the exploratory analysis, we will train the selected model and evaluate its performance on the classification task.
- **Model Optimization**: Fine-tune hyperparameters and regularize the model to improve its performance and generalizability.
