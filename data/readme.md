This folder contains all of the data (pre- and post-processing and cleaning).

# Data Source

A publicly available dataset identifying sampling locations from across several European countries can be accessed [here](https://www.kaggle.com/brsdincer/chernobyl-chemical-radiation-csv-country-data).

There are nine variables included: country abbreviation, country numerical code, sampling location (city or state), latitude of sampling location, longitude of sampling location, date of sampling, and concentration of three radioisotopes (Iodine 131, Caesium 134, and Ceasium 137). There are 2051 observations included, but not all observations have complete data.

# Raw Data
The data listed at the above link are stored as `Chernobyl_Chemical_Radiation.csv` in the `raw_data` folder.

# Processed Data
The output of the processing script are stored in the `processed_data`. See `processingscript.R` for details.