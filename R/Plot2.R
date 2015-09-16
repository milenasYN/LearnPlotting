
library(ggplot2)
library(lattice)

qplot(activityDateStep$total, geom="histogram") #qplot is supposed to make the same graph as ggplot(), but with a simpler syntax.
#While ggplot() allows for maximum features and flexibility, qplot() is a simpler but less customizable wrapper around ggplot.
#Note in practice, ggplot() is used more often.
#See http://www.r-bloggers.com/how-to-make-a-histogram-with-ggplot2/
#
ggplot(activityDateStep, aes(x=total)) + geom_histogram()
#specify a binwidth of 1 so that each column represents one discrete value of the data.  Since we have a lot of data, larger values work better
ggplot(activityDateStep, aes(x=total)) + geom_histogram(binwidth = 30)
ggplot(activityDateStep, aes(x=total)) + geom_histogram(binwidth = 1000)
ggplot(activityDateStep, aes(x=total)) + geom_histogram(binwidth = 2500)

ggplot(activityDateStep, aes(x=total)) +
     geom_histogram(binwidth = 1000, col="red", fill="green", alpha=.2)

ggplot(activityDateStep, aes(x=total)) +
     geom_histogram(binwidth = 2500, aes(fill = ..count..))

ggplot(activityDateStep, aes(x=total)) +
     geom_histogram(binwidth = 2500, aes(fill = ..count..)) +
     scale_fill_gradient("Count", low = "green", high = "red") +
     coord_flip()

######################Density Plot#
ggplot(activityDateStep, aes(x=total)) + geom_density()
#The code below retrieves the position of the average steps for the interval in the second argument that is equal to
#the interval in the dataset activityNEW$interval.This position number is then used to subset the 2nd argument to get
#the average step value and put that in the newcolumn called average in the dataset actvityNEW
activityNEW$average <- activityIntervalStepAve$average[activityIntervalStepAve$interval %in% activityNEW$interval]
##########################################################


##############################Facetted - Lattice Like Plots#################################
#Great reference of Lattice vs ggplot2:
#https://learnr.wordpress.com/2009/06/28/ggplot2-version-of-figures-in-lattice-multivariate-data-visualization-with-r-part-1/
activityNEW <- activity #Make copy of the data
#Goup data by interval and then find the interval mean
activityIntervalStepAve <- activityNEW %>% group_by(interval) %>% summarize(average=mean(steps, na.rm=TRUE))
#The code below retrieves the position of the average steps for the interval in the second argument that is equal to
#the interval in the dataset activityNEW$interval.This position number is then used to subset the 2nd argument to get
#the average step value and put that in the newcolumn called average in the dataset actvityNEW
activityNEW$average <- activityIntervalStepAve$average[activityIntervalStepAve$interval %in% activityNEW$interval]
#Where NA exists in the steps column, replace with the interval average
#Info on using replace with NA values found here:  http://rprogramming.net/recode-data-in-r/
activityNEW <- activityNEW %>% mutate(steps=ifelse(is.na(activityNEW$steps),activityNEW$average, activityNEW$steps))
# Calculate the weekdays
dayType <- weekdays(activityNEW$date)
# Assign the weekdays and the weekends to the data set
dayType <- ifelse(test = dayType %in% c("Saturday", "Sunday"), yes="weekend", "weekday")
activityNEW$dayType <- as.factor(dayType)

lattice1 <- xyplot(interval ~ steps | dayType, data = activityNEW) #Working
print(lattice1)


ggplot1 <- ggplot(activityNEW, aes(x=steps, y=interval)) + #Not working
     geom_point() +
     facet_wrap(dayType, ncol=1)
print(ggplot1)

##############################

################ORIGINAL DATA#########################################
hist(activityDateStep$total, main="Frequency of the Number of Steps Taken Daily", xlab="Steps", breaks=15)
abline(v=mean(activityDateStep$total), lty=4, col="red")
text(9500, 14, "Mean",col="red", pos=2)
text(9500,13,format(mean(activityDateStep$total), digits=1),col="red", pos=2)
abline(v=median(activityDateStep$total), lty=2, col="blue")
text(10100, 14, "Median",col="blue", pos=4)
text(10100, 13, median(activityDateStep$total),col="blue", pos=4)

aveSteps <- activity %>% group_by(interval) %>% summarize(steps=mean(steps, na.rm=TRUE))

plot(aveSteps, type="l", main="Time Series: Average Number of Steps", xlab="5-Minute Interval",
     ylab="Ave steps taken")
maxInterval<-aveSteps[which.max(aveSteps$steps),1]
abline(v=maxInterval, lty=2, col="blue")
text(maxInterval, 180, "Interval - Max Steps",col="blue", pos=4)
text(maxInterval, 170, maxInterval, col="blue", pos=4)

maxSteps <- filter(aveSteps, interval==maxInterval$interval)

sumNA <- sum(is.na(activity$steps))

activityNEW <- activity #Make copy of the data
#Goup data by interval and then find the interval mean
activityIntervalStepAve <- activityNEW %>% group_by(interval) %>% summarize(average=mean(steps, na.rm=TRUE))
activityIntervalStepAve %>% sample_n(5) #Take a look at 5 random records
#The code below retrieves the position of the average steps for the interval in the second argument that is equal to
#the interval in the dataset activityNEW$interval.This position number is then used to subset the 2nd argument to get
#the average step value and put that in the newcolumn called average in the dataset actvityNEW
activityNEW$average <- activityIntervalStepAve$average[activityIntervalStepAve$interval %in% activityNEW$interval]

activityNEW %>% sample_n(5)
#Where NA exists in the steps column, replace with the interval average
#Info on using replace with NA values found here:  http://rprogramming.net/recode-data-in-r/
activityNEW <- activityNEW %>% mutate(steps=ifelse(is.na(activityNEW$steps),activityNEW$average, activityNEW$steps))
activityNEW %>% sample_n(5)

activityDateStep2 <- activityNEW %>% group_by(date) %>% summarize(total=sum(steps, na.rm=TRUE))

#Write the new histogram
hist(activityDateStep2$total, main="Frequency of the Number of Steps Taken Daily", xlab="Steps", breaks=15)
abline(v=mean(activityDateStep2$total), lty=4, col="red")
text(9500, 14, "Mean",col="red", pos=2)
text(9500,13,format(mean(activityDateStep2$total), digits=1),col="red", pos=2)
abline(v=median(activityDateStep2$total), lty=2, col="blue")
text(10100, 14, "Median",col="blue", pos=4)
text(10100, 13, format(median(activityDateStep2$total), digits=1),col="blue", pos=4)

###Original lattice like plot comparison#########################
# Calculate the weekdays
dayType <- weekdays(activityNEW$date)
# Assign the weekdays and the weekends to the data set
dayType <- ifelse(test = dayType %in% c("Saturday", "Sunday"), yes="weekend", "weekday")
activityNEW$dayType <- as.factor(dayType)

aveStepsInt <- activityNEW %>% group_by(interval) %>% summarize(steps=mean(steps, na.rm=TRUE))

par(mfrow = c(2, 1))
for (type in c("weekend", "weekday")) {
     steps.type <- aggregate(steps ~ interval, data = activityNEW, subset = activityNEW$dayType ==
                                  type, FUN = mean)
     plot(steps.type, type = "l", main = type)
}
