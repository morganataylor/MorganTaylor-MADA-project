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
library(radsafer) #to create theoretical half-life decay values for each isotope
library(data.table) #to find minimums and maximums by group

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
#Calculate Expected Decay
######################################
#first create separate df for each isotope from mydata
#iodine 131
i131 <- dplyr::filter(mydata_long, Radioisotope == "Iodine131")

#caesium 134
cs134 <- dplyr::filter(mydata_long, Radioisotope == "Caesium134")

#caesium 137
cs137 <- dplyr::filter(mydata_long, Radioisotope == "Caesium137")

#use the radsafer package
#calculate the correct activity-dependent value based on radioactive decay
#units: percent of dose on days elapsed since meltdown
#iodine 131
mydata$I131.Decay <- radsafer::dk_correct(RN_select = "I-131", 
                                   time_unit = "days", 
                                   time_lapse = mydata$Day,
                                   A1 = 1,
                                   num = TRUE)

#caesium 134
mydata$Cs134.Decay <- radsafer::dk_correct(RN_select = "Cs-134", 
                                          time_unit = "days", 
                                          time_lapse = mydata$Day,
                                          A1 = 1,
                                          num = TRUE)

#caesium 137
mydata$Cs137.Decay <- radsafer::dk_correct(RN_select = "Cs-137", 
                                           time_unit = "days", 
                                           time_lapse = mydata$Day,
                                           A1 = 1,
                                           num = TRUE)

#find first day of sampling by each location
DT <- data.table(mydata)
firstday <- DT[, .SD[which.min(Day)], by = Sample.Location]
data.frame(firstday)
print(firstday$Sample.Location, firstday$Day)

#Plot function on graph
#x = days
#y = concentration