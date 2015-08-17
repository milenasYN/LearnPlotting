library(Hmisc)
library(dplyr)#Required for some of the steps below
library(ggplot2)#Required for some of the steps below
library(tidyr)#Required for some of the steps below
library(lubridate)#Required for some of the steps below

#To load really large files, see ff package:  http://www.r-bloggers.com/opening-large-csv-files-in-r/
#Can also try:   file <- read.csv(file.choose())

if (!file.exists("./data/workingData.csv")) {
     download.file("https://d396qusza40orc.cloudfront.net/repdata%2Fdata%2FStormData.csv.bz2",
                   destfile="./data/rawData.csv.bz2")
     file = bzfile('./data/rawData.csv.bz2')
     rawData <- read.csv(file)
     #Let's preserve the raw data and creat a working copy of the dataset
     workingData <- rawData %>% select(BGN_DATE, EVTYPE, FATALITIES, INJURIES,PROPDMG,PROPDMGEXP, CROPDMG, CROPDMGEXP)
     #Let's save a copy of the working data
     write.csv(workingData, "./data/workingData.csv")
}
#If the workingData.csv exists, let's open it for analysis:
#By default, strings in the data are converted to factors. If you load the data below with read.csv,
#then all the text columns will be treated as factors, even though it might make more sense to treat
#some of them as strings. To do this, use stringsAsFactors=FALSE:
#Another alternative is to load them as factors and convert some columns to characters:
#
# data <- read.csv("datafile.csv")
#
# data$First <- as.character(data$First)
# data$Last  <- as.character(data$Last)
#
# # Another method: convert columns named "First" and "Last"
# stringcols <- c("First","Last")
# data[stringcols] <- lapply(data[stringcols], as.character)
#
# Great reference:  http://www.cookbook-r.com/Data_input_and_output/Loading_data_from_a_file - (I own the book!)

workingData <- read.csv("./data/workingData.csv", na.strings=c('?', "", "-"), stringsAsFactors = FALSE)
