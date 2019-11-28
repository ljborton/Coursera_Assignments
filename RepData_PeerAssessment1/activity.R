unzip("activity.zip")
activity<-read.csv("activity.csv")

library(plyr)

activityw <- activity[complete.cases(activity),]
totaldsteps<-ddply(activityw,.(date),summarize,sumsteps=sum(steps))
hist(totaldsteps$sumsteps,xlab="Total Number of Steps Taken Each Day",
     main="Histogram of Total Numberof Steps Taken Each Day")
summarytotal<-summary(totaldsteps$sumsteps)
summarytotal<-as.vector(summarytotal)

mean<-summarytotal[4]
median<-summarytotal[3]

print(mean)
print(median)

##
activityw$interval<-as.factor(activityw$interval)
meanisteps<-ddply(activityw,.(interval),summarize,avgsteps=mean(steps))     

plot(meanisteps$interval,meanisteps$avgsteps,xlab="Interval", 
     ylab="Average Number of Steps Taken, Averaged Across All Days")
points(meanisteps$interval,meanisteps$avgsteps,type="l")

tryt<-max(meanisteps$avgsteps)
maxint<-meanisteps[meanisteps$avgsteps==max(meanisteps$avgsteps),]

maxint$interval<-as.character(maxint$interval)
maxint$interval<-as.numeric(maxint$interval)
maxintint<-maxint[1,1]
print(maxintint)

###
x<-sum(is.na(activity$date))
print(x)
        
activity$steps <- with(activity, ave(steps, interval,
        FUN = function(x) replace(x, is.na(x), mean(x, na.rm = TRUE))))


totdsteps<-ddply(activity,.(date),summarize,sumsteps=sum(steps))

hist(totdsteps$sumsteps,xlab="Total Number of Steps Taken Each Day",
     main="Histogram of Total Numberof Steps Taken Each Day")

summarytotal<-summary(totdsteps$sumsteps)
summarytotal<-as.vector(summarytotal)

mean<-summarytotal[4]
median<-summarytotal[3]

print(mean)
print(median)

####

activity$date<-as.Date(activity$date)

wk<-ddply(activity, .(date), transform, wkdy=weekdays(date))
wkend<-ddply(wk, .(wkdy), transform, dow=ifelse(wkdy=="Saturday"|
                        wkdy=="Sunday", "weekend", "weekday"))

wkend$interval<-as.factor(wkend$interval)
meanwksteps<-ddply(wkend,.(interval,dow),summarize,avgsteps=mean(steps))



meanwksteps$interval<-as.character(meanwksteps$interval)
meanwksteps$interval<-as.numeric(meanwksteps$interval)

g<-ggplot(meanwksteps,aes(interval,avgsteps))
g+facet_grid(dow~.)+geom_line()


