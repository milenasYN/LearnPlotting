library(dplyr)
library(ggplot2)
library(Hmisc)

## Warning: package 'Hmisc' was built under R version 3.2.1

library(knitr)

#See solution here:  http://www.rpubs.com/kagklis/87570

storm <- tbl_df(read.csv("./data/rawData.csv.bz2", as.is=T))


#Select only useful for our analysis columns.
storm_subs <- subset(storm, select = c("EVTYPE", "INJURIES", "PROPDMG", "PROPDMGEXP", "CROPDMG", "CROPDMGEXP", "FATALITIES"))


#Clean data. Convert letters to capitals and change the value that indicates missing value
with(storm_subs, {
     EVTYPE <- factor(EVTYPE)
     PROPDMGEXP <- toupper(PROPDMGEXP)
     PROPDMGEXP[PROPDMGEXP == ""] <- "0"
     CROPDMGEXP <- toupper(CROPDMGEXP)
     CROPDMGEXP[CROPDMGEXP == ""] <- "0"
})

health_impact <- aggregate(cbind(FATALITIES, INJURIES) ~ EVTYPE, storm_subs, sum, na.rm= TRUE)

health_impact.top <- health_impact[order(-health_impact$FATALITIES)[1:20], ]

health_impact.top$INJURIES <- cut2(health_impact.top$INJURIES, g = 7)

ggplot(health_impact.top, aes(x = reorder(EVTYPE, -FATALITIES), y = FATALITIES, fill = INJURIES)) +
     geom_bar(stat = "identity") + scale_fill_brewer(palette = 1) + guides(fill = guide_legend(reverse = T)) +
     theme(axis.text.x = element_text(angle = 90, hjust = 1)) + xlab(NULL) +
     ggtitle(paste("Top 20 most harmful weather events in the United States")) + labs(colour = "red")

decode.units <- function(d) {
     switch(d, H = 100, K = 1000, M = 1e+06, B = 1e+09, `0` = 1, `1` = 10, `2` = 100, `3` = 1000, `4` = 10000,  `5` = 1e+05, `6` = 1e+06, `7` = 1e+07, `8` = 1e+08, `9` = 1e+09, 0)
}


#Next, we calculate the total economic damage.
storm_subs$DAMAGE <- storm_subs$PROPDMG * sapply(storm_subs$PROPDMGEXP, decode.units) + storm_subs$CROPDMG * sapply(storm_subs$CROPDMGEXP, decode.units)

damage <- aggregate(DAMAGE ~ EVTYPE, storm_subs, sum, na.rm = T)

damage.top <- damage[order(-damage$DAMAGE)[1:20], ]

ggplot(damage.top, aes(x = reorder(EVTYPE, -DAMAGE), y = DAMAGE)) + geom_bar(stat = "identity", fill = "grey") + theme(axis.text.x = element_text(angle = 90, hjust = 1)) + xlab(NULL) + ylab("Damage in $") + ggtitle(paste("Top 20 events which have the greatest economic consequences in the United States"))

