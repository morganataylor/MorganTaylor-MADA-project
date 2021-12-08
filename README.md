# Overview

This is the repository for my course project in Dr. Andreas Handel's [Modern Applied Data Analysis course](https://andreashandel.github.io/MADAcourse/) in Fall 2021.


# History of The Project: A Saga
I initially planned to use random forests and artificial neural networks to predict burn patient survival in the United States for this project. However, I was unable to access the data in a reasonable timeframe, so I then turned to examining the radioactivity in European countries after the Chernobyl nuclear meltdown. Then, an external model upon which the analysis relied went offline with no notice, and the dataset was not large enough to create a summary dataset to avoid time-series analysis. Yay research!

This brings us to the actual project contained within this repository: predicting requested or obligated FEMA funding after a federal government disaster declaration in the United States.


# Pre-requisites

This is a data analysis project using R, Rmarkdown (and variants, e.g. bookdown), Github and a reference manager that can handle bibtex. It also requires a word processor to be installed (e.g. MS Word or [LibreOffice](https://www.libreoffice.org/)).


# Structure

* All data are in the subfolders inside the `data` folder.
* All code is in the `code` folder or subfolders.
* All results (figures, tables, computed values) are in `results` folder or subfolders.
* All products (manuscripts, supplement, etc.) are in `products` subfolders.
* All old files are in the `archive` folder.
* See the various `readme.md` files in those folders for some more information.


# Content 

* The original data are located in the `raw_data` folder. 
* The `processing_code` folder contains the markdowns required for processing the data, which are then saved in the `processed_data` folder.
* The `analysis_code` folder contains the markdowns that address the research questions for this study. They produce figures and numeric outputs, all which are saved in the `results` folder.
* The `products` folder contains the `bibtex` and CSL style file for references. Those files are used by the manuscript.
* The `products/manuscript` folder contains the report written in Rmarkdown (bookdown, to be precise).
* The `products/supplement` folder contains the supplemental material for the manuscript.
* The `archive` folder contains remnants of previous iterations of the project. This is mostly for myself for future data analysis projects, in the event I ever come back to the original topics.


# Data Sources

* [Disaster Declarations Summaries:](https://www.fema.gov/openfema-data-page/disaster-declarations-summaries-v2)
* [Mission Assignments:](https://www.fema.gov/openfema-data-page/mission-assignments-v1)
* [Population:](https://www.ers.usda.gov/data-products/county-level-data-sets/download-data/)

