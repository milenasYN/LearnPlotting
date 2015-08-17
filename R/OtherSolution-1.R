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

##############MY CHANGES################################WORKING
totalsPlotNEW <- totalsPlot1
totalsPlotNEW$INJURIES <- cut2(totalsPlotNEW$INJURIES, g = 4)

ggplot(totalsPlotNEW, aes(x = reorder(EVTYPE, -FATALITIES), y = FATALITIES, fill = INJURIES)) +
     geom_bar(stat = "identity") + scale_fill_brewer(palette = 1) + guides(fill = guide_legend(reverse = T)) +
     theme(axis.text.x = element_text(angle = 90, hjust = 1)) + xlab(NULL) +
     ggtitle(paste("Top 20 most harmful weather events in the United States")) + labs(colour = "red")

##############MY CHANGES################################
##############MORE CHANGES#############################
totalsPlotNEWGather <- totalsPlot1

totalsPlotNEWGather <- totalsPlotNEWGather[order(-totalsPlotNEWGather$totalDeathInjury)[1:10],]

totalsPlotNEWGather <- totalsPlotNEWGather %>%
     gather(PhysicalHarm, Injuries, FATALITIES:INJURIES)

ggplot(totalsPlotNEWGather, aes(x=EVTYPE, y=Injuries, fill=PhysicalHarm, order=desc(PhysicalHarm))) + ###Working
     geom_bar(stat="identity") +
     theme(axis.text.x = element_text(angle = 60, hjust = 1))
     #guides(fill=guide_legend(reverse=TRUE))

ggplot(totalsPlotNEWGather, aes(x=reorder(EVTYPE, -totalDeathInjury), y=Injuries, fill=PhysicalHarm, order=desc(PhysicalHarm))) + #works
     geom_bar(stat="identity") +
     theme(axis.text.x = element_text(angle = 60, hjust = 1)) +
     #geom_text(aes(label=totalDeathInjury)) +
     ggtitle(paste("Most Harmful Weather Events ")) +
     xlab("Weather Event") + ylab("Total Deaths and Injuries") +
     theme(legend.position=c(.9,.9)) +
     scale_fill_brewer(palette = 13)

##############MORE CHANGES#############################
decode.units <- function(d) {
     switch(d, H = 100, K = 1000, M = 1e+06, B = 1e+09, `0` = 1, `1` = 10, `2` = 100, `3` = 1000, `4` = 10000,  `5` = 1e+05, `6` = 1e+06, `7` = 1e+07, `8` = 1e+08, `9` = 1e+09, 0)
}


#Next, we calculate the total economic damage.
storm_subs$DAMAGE <- storm_subs$PROPDMG * sapply(storm_subs$PROPDMGEXP, decode.units) + storm_subs$CROPDMG * sapply(storm_subs$CROPDMGEXP, decode.units)

damage <- aggregate(DAMAGE ~ EVTYPE, storm_subs, sum, na.rm = T)

damage.top <- damage[order(-damage$DAMAGE)[1:20], ]

ggplot(damage.top, aes(x = reorder(EVTYPE, -DAMAGE), y = DAMAGE)) + geom_bar(stat = "identity", fill = "grey") + theme(axis.text.x = element_text(angle = 90, hjust = 1)) + xlab(NULL) + ylab("Damage in $") + ggtitle(paste("Top 20 events which have the greatest economic consequences in the United States"))

