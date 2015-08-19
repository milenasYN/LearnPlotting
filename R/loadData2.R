#Load dplyr
library(dplyr)#Required for some of the steps below

if (!file.exists("./data/activity.zip")) {
     download.file("http://d396qusza40orc.cloudfront.net/repdata%2Fdata%2Factivity.zip", destfile="./data/activity.zip")
     unzip("./data/activity.zip")
}
activity<- read.table(unzip("./data/activity.zip"), header=TRUE, sep=",", na.strings="NA")
glimpse(activity)
activity$date<-as.Date(activity$date, "%Y-%m-%d")
glimpse(activity)

# convert to local data frame. Printing only shows 10 rows and as many columns as can fit on your screen
#activity <- tbl_df(activity) #Not currently used in the Rmd

activityDateStep <- activity %>% group_by(date) %>% summarize(total=sum(steps, na.rm=TRUE))
#identical(activityDateStep, activityDateStep)#TRUE
