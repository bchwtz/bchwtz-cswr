# Working with Australian tourism data: Filter tourism data, plot the
# corresponding time series and get summarized values.

# The purpose is to filter the Australian tourism data or a similar one by its
# variables state, region and optionally by purpose in order to get some 
# summarized values and to plot the corresponding time series.

# Author: Hannah Behrens
# Date: May 2, 2022
# Version Changelog: 
#   v0.1 - Initial Release
#   v0.2 - ...

################################################################################
## PART I: Load Libraries and external Dependencies
################################################################################

# Loading installed packages ------------

library(ggplot2)
library(readxl)
library(dplyr)

# Read in data ------------

gwd <- getwd()
setwd("aus_tourism") # data set and functions are saved in folder "aus_tourism"
tourism <- read_excel("tourism.xlsx") # downloaded file 
# (https://bit.ly/fpptourism or http://robjhyndman.com/data/tourism.xlsx)
# original tourism data published by Tourism Research Division 
# (Tourism Research Australia) of the Australian Trade and Investment Commission
# of the Australian Government](https://www.tra.gov.au/data-and-research)

# Loading own functions ------------
source("selectedData.R")
source("plotTs.R")
source("summarizeRegion.R")


################################################################################
## PART II: Define Constants
################################################################################

state <- "South Australia" # define the state of interest

region <- "Adelaide" # define the region of interest

# purpose <- "Holiday"

dataset <- tourism # the data set of interest

################################################################################
## PART III: Problem Solving
################################################################################

sel_Data <- selectedData(dataset = dataset, state = state, region = region)

plot1 <- plotTs(filtered_data = sel_Data)

sR <- summarizeRegion(dataset = dataset, state = state)


################################################################################
## PART IV: Output Results
################################################################################

# Save filtered data set(s) and plot(s) ----------

write.table(sel_Data, file = "Filtered_Aus_tourism_data.csv", sep = ",")

png("Tourism_data_South_Aus_Adelaide.png") # additionally, save the plot
plot1
dev.off()

