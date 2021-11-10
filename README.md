# Overview

This is Morgan Taylor's MADA project repository. This study examines radiation fallout samples collected across Europe in the aftermath of the Chernobyl nuclear reactor meltdown in 1986.

# Pre-requisites

This is a data analysis project using R, Rmarkdown (and variants, e.g. bookdown), Github and a reference manager that can handle bibtex. It also requires a word processor to be installed (e.g. MS Word or [LibreOffice](https://www.libreoffice.org/)).

# Structure

* All data are in the subfolders inside the `data` folder.
* All code is in the `code` folder or subfolders.
* All results (figures, tables, computed values) are in `results` folder or subfolders.
* All products (manuscripts, supplement, presentation slides, web apps, etc.) are in `products` subfolders.
* All old files are in the `archive` folder.
* See the various `readme.md` files in those folders for some more information.

# Content 

* The original data are located in the `raw_data` folder. 
* The `processing_code` folder contains a single R script which loads the raw data, cleans and wrangles it, and saves the results in the `processed_data` folder.
* The `analysis_code` folder contains R scripts that address each of the research questions for this study. They produce figures and numeric outputs, all which are saved in the `results` folder.
* The `products` folder contains an example `bibtex` and CSL style file for references. Those files are used by the example manuscript, poster and slides.
* The  `manuscript` folder contains the working draft for the report written in Rmarkdown (bookdown, to be precise). 


