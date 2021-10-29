This folder stores all of the scripts that process and analyze the data.

# Processing

The `processing_code` folder contains one script: `processingscript.R` which does the following:
* loads the raw data
* cleans the labels and formatting of the data
* conducts some feature engineering to create distance from Chernobyl and country name
* addresses missing data
* converts the data from wide format into long format for the radioisotopes measured
* creates a subset of the unique sampling locations

# Analysis

The `analysis_code` folder contains three scripts:

## Exploratory data analysis: `edascript.R`
This script conducts an  exploratory data analysis of the procesed data and saves the outputs in the `results` folder. In particular, it examines
* primary outcome(s) of interest: radisotope concentration (I-131, Cs-134, Cs-137)
* primary predictor of interest: days since Chernobyl meltdown
* other relevant variables including country, distance from Chernobyl in km, and sampling location

## Half-life decomposition analysis: `halflifescript.R`
This script utilizes the `radsafer` package to calculate the predicted half-life decomposition for each radioisotope in question. 

As of 10/29/2021, the next step in the analysis is to examine the predicted concentrations in relation to the measured concentrations.

## Mapping analysis: `mapscript.R`
This script plots the sample locations on a map in relation to the Chernobyl plant. 

As of 10/29/2021: Pending approval from Google API, this script will also plot the concentrations of the radioisotopes in a gradient fashion on a Google Maps underlay.