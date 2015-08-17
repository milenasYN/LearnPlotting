#totalsPlot1 <- totalsPlot1 %>% select(EVTYPE,FATALITIES, INJURIES, totalDeathInjury)
totalsPlot1 <- totals[order(-totals$totalDeathInjury)[1:10],]

ggplot(totalsPlot1, aes(x = reorder(EVTYPE, -totalDeathInjury), y = totalDeathInjury)) +
     geom_bar(stat = "identity", fill = "lightblue") +
     theme(axis.text.x = element_text(angle = 60, hjust = 1)) +
     xlab(NULL) + ylab("Damage in Death and Injury") +
     ggtitle(paste("Death and Injury: Weather Events"))


totalsPlot2 <- totals[order(-totals$totalDollarLost)[1:10], ]

ggplot(totalsPlot2, aes(x = reorder(EVTYPE, -totalDollarLost), y = totalDollarLost/1000000000)) +
     geom_bar(stat = "identity", fill = "lightblue") +
     theme(axis.text.x = element_text(angle = 60, hjust = 1)) +
     xlab(NULL) + ylab("Damage in $ - Billions") +
     ggtitle(paste("Largest Economic Losses: Weather"))
