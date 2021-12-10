# Overview

This folder contains all of the data for this analysis (pre- and post-processing and cleaning).


# Data Sources

Three publicly available datasets are used in this analysis:

* [Disaster Declarations Summaries:](https://www.fema.gov/openfema-data-page/disaster-declarations-summaries-v2)
* [Mission Assignments:](https://www.fema.gov/openfema-data-page/mission-assignments-v1)
* [Population:](https://www.ers.usda.gov/data-products/county-level-data-sets/download-data/)
* [Coordinates:](https://developers.google.com/public-data/docs/canonical/states_csv)


# Raw Data

The `raw_data` folder contains the data listed at the above links as:

* `DisasterDeclarationsSummaries.csv`
* `MissionAssignments.csv`
* `PopulationEstimates.csv`
* `states.csv`


# Processed Data

The outputs of the markdowns in `/code/processing_code` are stored in the `processed_data` sub-folder. Processed datasets are saved as .rds to preserve all data types and classes and thus avoid having to redefine data types in subsequent markdowns.

* `processing-missions.Rmd` &#8594; `missionsprocessed.rds`
* `processing-populations.Rmd` &#8594; `popsprocessed.rds`
* `processing-declarations.Rmd` &#8594; `declarationsprocessed.rds`
* `processing-combine.Rmd` &#8594; `combinedprocessed.rds`
* `processing-ML.Rmd` &#8595;
  * `analysisdata.rds` (all data)
  * `analysisdata-RA.rds` (for requested amount outcome)
  * `analysisdata-OA.rds` (for obligated amount outcome)
  
See `/code/readme.md` as well as the source markdowns for more detail about how each processed dataset was generated.
  
  
# Data Dictionaries

A data dictionary for each raw dataset is located in the `data_dictionaries` folder.
