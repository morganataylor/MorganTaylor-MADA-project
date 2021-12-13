# Introduction

This repository contains my cumulative course project in Dr. Andreas Handel's [Modern Applied Data Analysis](https://andreashandel.github.io/MADAcourse/) course at the University of Georgia in Fall 2021. The project was designed to include all the different components of a data analysis covered in the course:

* Finding a good data/question pair
* Getting the data
* Cleaning the data
* Exploring the data
* Processing the data
* Analyzing the data
* Reporting/communicating your findings
* Doing everything reproducibly


# Project History: A Saga
I initially planned to use random forests and artificial neural networks to predict burn patient survival in the United States for this project, an analysis I will eventually complete for my dissertation. However, I was unable to access the data in a reasonable timeframe, so I then turned to examining the radioactivity in European countries after the Chernobyl nuclear meltdown. Then, an external model upon which the analysis relied went offline, and the dataset was not large enough to create a summary dataset to avoid time-series analysis. These were not time lost, as they were valuble lessons in data analysis.


# Project Topic

This brings us to the actual project contained within this repository: identifying the parameters that significantly predict funding requested from FEMA by states as well as funding actually obligated from FEMA to states after a federal government disaster declaration in the United States in the years 2012 - 2021.


# Requirements for Reproduction

This analysis requires R, Rmarkdown (and variants, e.g. bookdown), Github and a reference manager that can handle bibtex (e.g. Zotero). It also requires a word processor to be installed (e.g. MS Word or [LibreOffice](https://www.libreoffice.org/)). It is beneficial (but not technically required) to have a spreadsheet processor installed (e.g. MS Excel or [LibreOffice](https://www.libreoffice.org/)) to read the data dictionaries.


# Repository Structure

* All data are in the subfolders inside the `data` folder.
* All code is in the subfolders inside the `code` folder.
* All results (figures, tables, computed values) are in `results` folder.
* All products (manuscripts, supplement, etc.) are in `products` subfolders.
* All old files are in the `archive` folder.
* See the various `readme.md` files in those folders for some more information.


# Project Content 

* The original data are located in the `raw_data` folder. 
* The `processing_code` folder contains the markdowns required for processing the data, which are then saved in the `processed_data` folder.
* The `analysis_code` folder contains the markdowns that address the research questions for this study. They produce figures and numeric outputs, all which are saved in the `results` folder.
* The `products` folder contains the `bibtex` and CSL style file for references, which are used by the manuscript.
* The `products/manuscript` folder contains the report written in Rmarkdown (bookdown, to be precise).
* The `products/supplement` folder contains the supplemental material for the manuscript.
* The `archive` folder contains remnants of previous iterations of the project. This is mostly for myself for future data analysis projects, in the event I ever come back to the original topics.


# Data Sources

* [Disaster Declarations Summaries:](https://www.fema.gov/openfema-data-page/disaster-declarations-summaries-v2)
* [Mission Assignments:](https://www.fema.gov/openfema-data-page/mission-assignments-v1)
* [Population:](https://www.ers.usda.gov/data-products/county-level-data-sets/download-data/)
* [Coordinates:](https://developers.google.com/public-data/docs/canonical/states_csv)

# A Few Notes
As the project has developed, I have a few thoughts I want to explain:

* the doParallels package throws MANY errors, but if you re-run the code a second time, it always goes away
* the manuscript is written for an emergency management journal -- therefore:
  * some statisical concepts are likely over-explained (e.g. RMSE)
  * I chose to exclude the MVR in the manuscript, as I thought it would be too confusing to non-biostiatisticans
