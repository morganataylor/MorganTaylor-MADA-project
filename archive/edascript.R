######################################
#Exploratory Data Analysis Script
######################################

#this script loads the processed data and conducts the exploratory data analysis
#and saves the results to the results folder

######################################
#Libraries and Options
######################################

#load needed packages
library(here) #for data loading/saving
library(summarytools) #for overall df summary
library(ggplot2) #for plotting
library(table1) #to create summary tables for summary statistics
library(broom) #for cleaning up output from lm()

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
# Outcome Variable Exploration
######################################
#start by examining each of the radioisotopes
#units of each are Bq/m^3

#using the wide format df (most complete df)

#Iodine 131
#start with base summary statistics
summary(mydata$Iodine131)

#create a density plot
ggplot2::ggplot(data = mydata, aes(x = Iodine131)) +
  geom_density()
#this is expected as increased rates will be less frequent
#more likely to be in USSR than in EU countries

#create a box plot
ggplot2::ggplot(data = mydata, aes(y = Iodine131)) +
  geom_boxplot()
#also to be expected for same descriptions as listed above
#clearly does not follow a normal distribution

#Caesium 134
#start with base summary statistics
summary(mydata$Caesium134)
#more NA values
#makes sense given Caesium 134 is less likely than I-131 to have extended fallout

#create a density plot
ggplot2::ggplot(data = mydata, aes(x = Caesium134)) +
  geom_density()
#this is expected as increased rates will be less frequent
#more likely to be in USSR than in EU countries

#create a box plot
ggplot2::ggplot(data = mydata, aes(y = Caesium134)) +
  geom_boxplot()
#also to be expected for same descriptions as listed above
#clearly does not follow a normal distribution

#Caesium 137
#start with base summary statistics
summary(mydata$Caesium137)
#more NA values
#makes sense given Caesium 137 is the least likely to have extended fallout

#create a density plot
ggplot2::ggplot(data = mydata, aes(x = Caesium137)) +
  geom_density()
#this is expected as increased rates will be less frequent
#more likely to be in USSR than in EU countries

#create a box plot
ggplot2::ggplot(data = mydata, aes(y = Caesium137)) +
  geom_boxplot()
#also to be expected for same descriptions as listed above
#clearly does not follow a normal distribution

#summary statistics table for radioisotopes
#first define labels
table1::label(mydata$Iodine131) <- "Iodine 131 (Bq/m^3)"
table1::label(mydata$Caesium134) <- "Caesium 134 (Bq/m^3)"
table1::label(mydata$Caesium137) <- "Caesium 137 (Bq/m^3)"

#now combine into table
isotope_table <- table1::table1(~ Iodine131 + Caesium134 + Caesium137, 
                                data = mydata)
isotope_table

#save summary statistics table  
#may or may not work, but including it just in case
#otherwise can code it into the manuscript rmd directly
isotopes_file = here("results", "isotopetable.rds")
saveRDS(isotope_table, file = isotopes_file)

######################################
# Elapsed Time Variable Exploration
######################################
#the "predictors" in this analysis aren't quite the same as traditional models
#half-life decay depends on: radionuclide of interest and elapsed time
#distance from chernobyl and country also relevant and interesting

#using long format df here to be able to account for radionuclides as group

#start with elapsed time
#start with base summary statistics
summary(mydata_long$Day)
#100 value is curious
#but have no way of knowing if accurate or record error

#create a density plot
ggplot2::ggplot(data = mydata_long, aes(x = Day)) +
  geom_density()
#heavy left skew (aka not normally distributed)

#create a box plot
ggplot2::ggplot(data = mydata_long, aes(y = Day)) +
  geom_boxplot()
#record at 100 days is a clear outlier
#may warrant removal later, but for now leave as half-life decay isn't affected

#examine in relation to each isotope
day_iso_all <- ggplot2::ggplot(data = mydata_long %>%
                                        dplyr::arrange(desc(Radioisotope)),
                                      aes(x = Day, y = Concentration, color = Radioisotope, group = Sample.Location)) +
                        geom_point(alpha = 0.8) +
                        labs(  x = "Days since Release", y = "Concentration (Bq/m^3)",
                              title ="Radioisotope Concentration by Day",
                              subtitle = "in European countries in the aftermath of Chernobyl")
day_iso_all

#save figure
allday_iso_file = here("results","radioisotopesdays_all.png")
ggsave(filename = allday_iso_file, plot = day_iso_all) 

#crop plot to not include 100 day observation
day_iso_50 <- ggplot2::ggplot(data = mydata_long %>%
                                        dplyr::arrange(desc(Radioisotope)), 
                                      aes(x = Day, y = Concentration, color = Radioisotope, group = Sample.Location)) +
                        geom_point(alpha = 0.8) + 
                        xlim(0,50) +
                        labs( x = "Days since Release", y = "Concentration (Bq/m^3)",
                              title ="Radioisotope Concentration by Day",
                              subtitle = "in European countries the first 50 days after Chernobyl")
day_iso_50

#save figure
day50_iso_file = here("results","radioisotopesdays_50.png")
ggsave(filename = day50_iso_file, plot = day_iso_50)

######################################
# Country Variable Exploration
######################################
#look at radioisotope concentration by country name
#still using long format of data

#start with base summary of country name variable
# this can be done with the summary tools package function "freq" and options to hide NAs (removed during processing)
country_name_tab <- summarytools::freq(mydata_long$Country.Name, report.nas = FALSE)
country_name_tab

#save table
country_tab_file = here("results", "country_name_table.rds")
saveRDS(country_name_tab, file = country_tab_file)

# create a box plot with concentration
# include a jitter function to have a better idea of number of measurements and distribution
country_jitter <- ggplot2::ggplot(data = mydata_long, aes(x = Country.Name, 
                                                          y = Concentration, 
                                                          fill = Radioisotope)) +
                                  geom_boxplot() + 
                                  labs(  x = "Country Name", y = "Concentration (Bq/m^3)",
                                         title ="Radioisotope Concentration by Country")
country_jitter

#save figure
#but also saved manually with 1492 x 540 pixel dimensions
country_jitter_file = here("results","countryjitter.png")
ggsave(filename = country_jitter_file, plot = country_jitter) 

#create table where countries are rows and columns are each radioisotope
#simply tells us volume of samples per radioisotope for each country
#first define labels
table1::label(mydata_long$Radioisotope) <- "Radioisotope (Bq/m^3)"
table1::label(mydata_long$Country.Name) <- "Country"

#now combine into table
country_iso_table <- table1::table1(~ Country.Name | Radioisotope, 
                                    data = mydata_long)
country_iso_table

#save summary statistics table  
#may or may not work, but including it just in case
#otherwise can code it into the manuscript rmd directly
country_isotopes_file = here("results", "countryisotopetable.rds")
saveRDS(country_iso_table, file = country_isotopes_file)

######################################
# Distance Variable Exploration
######################################
#look at radioisotope concentration by distance from chernobyl

#start with base summary statistics
summary(mydata_long$Distance)
#units are km

#create a density plot
ggplot2::ggplot(data = mydata_long, aes(x = Distance)) +
  geom_density()
#not normally distributed but not really important as these are locations

#create a box plot
ggplot2::ggplot(data = mydata_long, aes(y = Distance)) +
  geom_boxplot()
#not really worried about outliers at this point as this is distance

#examine in relation to each isotope
dist_iso_all <- ggplot2::ggplot(data = mydata_long %>%
                                         dplyr::arrange(desc(Radioisotope)),
                                       aes(x = Distance, y = Concentration, color = Radioisotope)) +
                                  geom_point(alpha = 0.8) +
                                  labs(  x = "Distance from Chernobyl (km)", y = "Concentration (Bq/m^3)",
                                         title ="Radioisotope Concentration by Distance from Chernobyl")
dist_iso_all
#distance isn't really continuously represented in this model 

#save figure
dist_iso_file = here("results","radioisotopesdistance.png")
ggsave(filename = dist_iso_file, plot = dist_iso_all) 

#create table where countries are rows and columns are each radioisotope
#simply tells us volume of samples per radioisotope for each country
#first define labels
table1::label(mydata_long$Radioisotope) <- "Radioisotope (Bq/m^3)"
table1::label(mydata_long$Distance) <- "Distance"

#now combine into table
dist_iso_table <- table1::table1(~ Distance | Radioisotope, 
                                    data = mydata_long)
dist_iso_table

######################################
# Sample Location Variable Exploration
######################################
#days since meltdown is the primary predictor
#actual sample location is the secondary predictor
#for statistics purposes, using the name as a categorical variable
#can use lat/long for mapping in the analysis

#start with summary of sample locations
# this can be done with the summary tools package function "freq" and options to hide NAs (removed during processing)
sample_loc_tab <- summarytools::freq(mydata_long$Sample.Location, report.nas = FALSE)
sample_loc_tab

#save summary statistics table  
sample_loc_file = here("results", "samplelocationstable.rds")
saveRDS(sample_loc_tab, file = sample_loc_file)

#too many sample locations to explicitly graph
#so use a facet wrap for countries
#plot for each radioisotope
#different colors represent different sample locations
#but too many to have a legend -- legend isn't really meaningful anyways

#iodine 131
sl_i131 <- ggplot2::ggplot(data = mydata_long %>%
                                      dplyr::filter(Radioisotope == "Iodine131") %>%
                                      dplyr::arrange(Country.Name),
                            aes(x = Day, y = Concentration, color = Sample.Location)) +
                            geom_point(alpha = 0.8) +
                            labs(  x = "Days since Release", y = "Concentration (Bq/m^3)",
                                   title ="Iodine131 Concentration by Day",
                                   subtitle = "in European countries in the aftermath of Chernobyl") +
                            facet_wrap(~ Country.Name, scales = "free") +
                            theme(legend.position = "none")
sl_i131

#save figure
sl_i131_file = here("results","i131samplelocations.png")
ggsave(filename = sl_i131_file, plot = sl_i131) 

#caesium 134
sl_cs134 <- ggplot2::ggplot(data = mydata_long %>%
                             dplyr::filter(Radioisotope == "Caesium134") %>%
                             dplyr::arrange(Country.Name),
                           aes(x = Day, y = Concentration, color = Sample.Location)) +
                          geom_point(alpha = 0.8) +
                          labs(  x = "Days since Release", y = "Concentration (Bq/m^3)",
                                 title ="Caesium134 Concentration by Day",
                                 subtitle = "in European countries in the aftermath of Chernobyl") +
                          facet_wrap(~ Country.Name, scales = "free") +
                          theme(legend.position = "none")
sl_cs134

#save figure
sl_cs134_file = here("results","cs134samplelocations.png")
ggsave(filename = sl_cs134_file, plot = sl_cs134) 

#caesium 137
sl_cs137 <- ggplot2::ggplot(data = mydata_long %>%
                              dplyr::filter(Radioisotope == "Caesium137") %>%
                              dplyr::arrange(Country.Name),
                            aes(x = Day, y = Concentration, color = Sample.Location)) +
  geom_point(alpha = 0.8) +
  labs(  x = "Days since Release", y = "Concentration (Bq/m^3)",
         title ="Caesium137 Concentration by Day",
         subtitle = "in European countries in the aftermath of Chernobyl") +
  facet_wrap(~ Country.Name, scales = "free") +
  theme(legend.position = "none")
sl_cs137

#save figure
sl_cs137_file = here("results","cs137samplelocations.png")
ggsave(filename = sl_cs137_file, plot = sl_cs137) 

