# Code Folder Overview

This folder stores all of the scripts that process and analyze the data. There are two sub-folders: `processing_code` and `analysis_code`, the contents of each are described below.


# Processing

The `processing_code` folder contains five markdowns that should be run in the following order:

### 1. Populations: `processing-populations.Rmd`
This markdown loads the raw population data and does the following:

* Raw data summarization and overview
* Removal of irrelevant variables
* Feature engineering to determine number of counties per state
* Saving the processed dataset as an .rds

### 2. Mission Assignments: `processing-missions.Rmd`
This markdown loads the raw mission assignments data and does the following:

* Raw data summarization and overview
* Removal of irrelevant variables
* Summarization of mission costs for each state and disaster declaration
* Feature engineering to create cost share proportions and number of government agencies involved in the response
* Cleaning the state variable names to match the other data sources
* Saving the processed dataset as an .rds

### 3. Disaster Declarations: `processing-declarations.Rmd`
This markdown loads the raw declaration data and does the following:

* Raw data summarization and overview
* Removal of irrelevant variables
* Feature engineering to create duration of incident and response as well as month and year of event
* Summarization of key variables for each disaster declaration and state
* Saving the processed dataset as an .rds

### 4. Combine: `processing-combine.Rmd`
This markdown loads the previously processed data and combines them into one dataframe.

### 5. Further Processing: `processing-ML.Rmd`
This markdown loads the singular dataframe and does the following additional cleaning/processing steps:

* Adding coordinates and FEMA Region for each state and territory
* Subsetting the outcome
* Cleaning variables (e.g. "other" categorization and ordinal transformation of incident month)
* Labeling variables

It creates the following dataframes used for analysis:

* `analysisdata.rds` : used for exploratory data analysis
* `analysisdata-RA.rds`: used for modeling request amount as the outcome
* `analysisdata-OA.rds`: used for modeling obligated amount as the outcome


# Analysis

The `analysis_code` folder contains six markdowns that should be run in the following order:

### 1. Exploratory Data Analysis: `analysis-eda.Rmd`
This markdown loads the processed data and does the following for each variable:

1. Produce and print some numerical output (e.g. table, summary statistics)
2. Create a histogram or density plot (continuous variables only)
3. Scatterplot, boxplot, or other similar plots against the main outcome of interest
4. Any other exploration steps that may be useful.

### 2. Linear Models: `analysis-lienramodels.Rmd`
This analysis examines the predictors of allocation of FEMA funds during disaster declarations. The following definitions exist for the analysis:

* The two outcomes of interest are Requested Amount (`ReqAmt`) and Obligated Amount (`OblAmt`).
* The primary predictor of interest is Incident Duration (`IncidentDuration`)
* Whichever outcome is not currently fitted to the model will *not* be considered a predictor of interest

For each outcome of interest, the following steps will be completed:

1. Fit a simple linear regression with the primary predictor of interest
2. Fit a multivariable linear regression
3. Comparison of the two models

### 3. Machine Learning for Requested Funds: `analysis-ML-RA.Rmd`
This script uses requested FEMA funds as the outcome of interest and fits the following models to the analysis data:

* Null
* Decision Tree
* Random Forest
* Bagged Tree

It compares the  models, and then finally fits the ???best??? model to the test data.

### 4. Machine Learning for Obligated Funds: `analysis-ML-OA.Rmd`
This script uses obligated FEMA funds as the outcome of interest and fits the following models to the analysis data:

* Null
* Decision Tree
* Random Forest
* Bagged Tree

It compares the  models, and then finally fits the ???best??? model to the test data.

### 5&6. Outlier Analysis: `...-outlier.Rmd`
These scripts repeat the previously described machine learning analyses, but it removes the $4B outlier that corresponds to the 2017 Hurricane Maria in Puerto Rico. This disaster was more than \$2B than the next largest allocation of FEMA funds and has been repeatedly identified as extenuating circumstances.
