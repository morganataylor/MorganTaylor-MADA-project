######################################
#Processing Script
######################################

#this script loads the raw data, processes and cleans it 
#and saves it as Rds file in the processed_data folder

######################################
#Libraries and Options
######################################

#load needed packages
library(here) #to set paths
library(tidyverse) #for data processing
library(geosphere) #for distance calculations

##Import data
#define path to data
data_location <- here::here("data","raw_data","Chernobyl_ Chemical_Radiation.csv")

#load data
rawdata <- utils::read.csv(data_location)

######################################
#Cleaning and Feature Engineering
######################################

#overview
utils::str(rawdata)

#rename variable columns
processeddata <- rawdata
colnames(processeddata) <- c("Country-Abbrev", "Country-Code", "Sample.Location", "Longitude", "Latitude", "Date", "Iodine131", "Caesium134", "Caesium137")

#spell out country names in new variable
processeddata$Country.Name <- dplyr::recode(processeddata$`Country-Abbrev`,
                                              AU = "Austria",
                                              BE = "Belgium",
                                              CH = "Switzerland",
                                              CZ = "Czechoslovakia",
                                              DE = "Germany",
                                              ES = "Spain", 
                                              F = "France",
                                              FI = "Finland",
                                              GR = "Greece",
                                              HU = "Hungary",
                                              IR = "Ireland",
                                              IT = "Italy",
                                              NL = "Netherlands",
                                              NO = "Norway",
                                              SE = "Sweden",
                                              UK = "United Kingdom")

#convert radioisotope variables to numeric variables
processeddata$Caesium134 <- as.numeric(processeddata$Caesium134)
processeddata$Caesium137 <- as.numeric(processeddata$Caesium137)
processeddata$Iodine131 <- as.numeric(processeddata$Iodine131)
#NAs introduced by coercion expected due to missing observations

#convert Date column to date class
processeddata$Date <- as.Date(processeddata$Date, '%y/%m/%d')


#first create variable for chernobyl event date
#Chernobyl occurred on Saturday 26 April 1986
chernobyl <- "04/26/1986"
processeddata$incidentdate <- as.Date(chernobyl,"%m/%d/%Y")

#create new variable for days since event
for (i in seq(nrow(processeddata))) {
  processeddata$Day[i] <- difftime(processeddata$Date[i], processeddata$incidentdate[i], units = "days")
}

#first create variables for Chernobyl longitude and latitude
chernobyllat <- 51.387
chernobyllong <- 30.093

#create new variable to calculate distance between chernobyl and sample location
#use distGeo and default WGS84 ellipsoid
#divide by 10^3 to convert from m to km
for (i in seq(nrow(processeddata))) {
  processeddata$Distance[i] <- (geosphere::distGeo(c(chernobyllong, chernobyllat),
                                              c(processeddata$Longitude[i], processeddata$Latitude[i]))/(10^3))
}

#clean up df by getting rid of variables no longer needed
#drop the following: country abbreviation, country code, sample date, incident date
processeddata <- processeddata[,-c(1, 2, 6, 11)]

#rearrange column order
processeddata <- processeddata[, c(1, 7, 2, 3, 9, 8, 4, 5, 6)]

#summary of cleaned data
summary(processeddata)
#based on this data structure, we don't know if NAs are reasonable (due to fallout)

#omit na's if no concentration recorder for any of the radioisotopes
processeddata_filtered <- processeddata %>%
                              dplyr::filter(!if_all(c(Iodine131, Caesium134, Caesium137), is.na))
#only removes 20 observations so definitely within reason

#location to save long format
save_data_location <- here::here("data","processed_data","processeddata.rds")

#save sample locations data
saveRDS(processeddata_filtered, file = save_data_location)

######################################
# Conversion to Long Format
######################################
#convert to long format
processeddata_long <- processeddata_filtered %>%
  tidyr::gather("Radioisotope",
                "Concentration",
                7:9)

#filter NAs here too
#have to be careful about the interpretation when using two different datasets
processeddata_long_filtered <- processeddata_long %>%
                                  dplyr::filter(!is.na(Concentration))
(6093-5316)/6093
#less than 15% of long dataset so within reason to filter

#location to save long format
long_data_location <- here::here("data","processed_data","processeddatalong.rds")

#save sample locations data
saveRDS(processeddata_long_filtered, file = long_data_location)

######################################
# Sample Locations Subset
######################################
#create a df for sample locations
#include: sample location name, country, latitude, longitude, distance
sample_locations <- processeddata_filtered %>% dplyr::distinct(Sample.Location,
                                                                Country.Name,
                                                                Longitude,
                                                                Latitude,
                                                                Distance)

#location to save sample locations file
sample_data_location <- here::here("data","processed_data","samplelocations.rds")

#save sample locations data
saveRDS(sample_locations, file = sample_data_location)

