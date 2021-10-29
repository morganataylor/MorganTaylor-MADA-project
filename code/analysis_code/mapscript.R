######################################
#Map Creation Script
######################################

#this script loads the processed data and creates a map of sample locations
#as well as radioisotope concentrations

######################################
#Libraries and Options
######################################

#load needed packages
library(here) #for data loading/saving
library(summarytools) #for overall df summary
library(ggplot2) #for plotting
library(table1) #to create summary tables for summary statistics
library(mapproj) #to create map
library(grid) #to create map
library(rworldmap) #to create world map

library(ggmap)
library(ggthemes)

#global environment options
# formatting for script to avoid scientific notation output
options(scipen=999)

# globally set theme for ggplots
ggplot2::theme_set(theme_classic())

#path to data
#note the use of the here() package and not absolute paths
data_location <- here::here("data","processed_data","processeddata.rds")
data_location2 <- here::here("data", "processed_data", "processeddatalong.rds")

#load data
mydata <- readRDS(data_location)
mydata_long <- readRDS(data_location2)

######################################
#Data Overview
######################################

# summarize data to see list of variables and types
summarytools::dfSummary(mydata)

summarytools::dfSummary(mydata_long)

######################################
#Create European Map
######################################
#get world map
worldmap <- getMap()

#subset to the Eurasia continent
country <- worldmap[which(worldmap$continent == "Eurasia"), ]

#extract longitude and latitude border coordinates
coordinates <- base::lapply(country, function(i){
                    df <- data.frame(worldmap@polygons[[i]]@Polygons[[1]]@coords)
                    df$region = as.character(worldmap$NAME[i])
                    colnames(df) <- list("long", "lat", "region")
                    return(df)
})
#stuck on error: no method for coercing this S4 class to a vector