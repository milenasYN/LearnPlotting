
#Because weather reporting early in the dataset was sporatic, we are going to evalaute wehtehr events later than 1995
workingData$BGN_DATE <- mdy_hms(workingData$BGN_DATE)
workingData <- workingData %>% filter(year(BGN_DATE) > 2000)
# convert to local data frame. Printing only shows 10 rows and as many columns as can fit on your screen
workingData <- tbl_df(workingData)
glimpse(workingData)

#In the fields, the format of the data is not consistent.  Here are a few examples:
unique(workingData$PROPDMGEXP)
unique(workingData$CROPDMGEXP)
#This needs to be corrected.

#workingData$EVTYPE <- as.factor(workingData$EVTYPE)
workingData$PROPDMGEXP <- toupper(workingData$PROPDMGEXP)
workingData$PROPDMGEXP[workingData$PROPDMGEXP == ""] <- "0"
workingData$CROPDMGEXP <- toupper(workingData$CROPDMGEXP)
workingData$CROPDMGEXP[workingData$CROPDMGEXP == ""] <- "0"

unique(workingData$PROPDMGEXP)

#Property damage
workingData$PROPDMGEXP <- gsub('K', '1000', workingData$PROPDMGEXP)
workingData$PROPDMGEXP <- gsub('M', '1000000', workingData$PROPDMGEXP)
workingData$PROPDMGEXP <- gsub('M', '1000000000', workingData$PROPDMGEXP)
glimpse(workingData)

workingData$PROPDMGEXP <- as.numeric(workingData$PROPDMGEXP, na.rm=TRUE)
#Multiply the PROPDMG values with their respective PROPDMGEXP values
workingData$PROPDMG <- workingData$PROPDMG * workingData$PROPDMGEXP

#Crop Damage
workingData$CROPDMGEXP <- gsub('K', '1000', workingData$CROPDMGEXP)
workingData$CROPDMGEXP <- gsub('M', '1000000', workingData$CROPDMGEXP)
workingData$CROPDMGEXP <- gsub('B', '1000000000', workingData$CROPDMGEXP)
workingData$CROPDMGEXP <- as.numeric(workingData$CROPDMGEXP)

#Multiply the CPROPDMG values with their respective CPROPDMGEXP values
workingData$CROPDMG <- workingData$CROPDMG * workingData$CROPDMGEXP


totals <- workingData %>%
     group_by(EVTYPE) %>%
     summarise(FATALITIES = sum(FATALITIES), INJURIES = sum(INJURIES),PROPDMG = sum(PROPDMG, na.rm = TRUE),
               CROPDMG = sum(CROPDMG, na.rm = TRUE)) %>%
     mutate(totalDeathInjury=FATALITIES + INJURIES, totalDollarLost= PROPDMG + CROPDMG)
