# This program requires the following packages:
# reshape2
# Please install before running this program

# Download project data (zipped file) 
fileURL1<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileURL1,destfile="householdpowerconsumptionzip")
 
# Unzip project data file  
householdpower<-unzip("householdpowerconsumptionzip")

# Unzipping creates the householdpower directory in the same directory as the 
# downloaded zip file
 
# Remove downloadeded zip file for tidyness 
file.remove("householdpowerconsumptionzip")

# Read in household_power_consumption dataset and assign to "power"
# The first line has column (variable) names so the header is TRUE, the file separator is ";" 
# instead of "," so the sep = ";", and NA values are "?"
power<-read.table("household_power_consumption.txt", sep = ";", header = TRUE,
                  stringsAsFactors = FALSE, na.strings="?")

# Convert dates from "character" to "Date" using as.date
power$Date<-as.Date(power$Date, "%d/%m/%Y")

# Convert times from "character" to POSIXlt 
# strptime adds today's date as a default if no date is specified 
# Use date from Date column instead
times<-power$Time
dates<-as.character(power$Date)
datetime<-paste(dates,times)
power$Time<-strptime(datetime, format="%Y-%m-%d %H:%M:%S")

# Only dates 2007-02-01 and 2007-02-02 will be used.  Select off these dates
# into "powerfeb"
powerfeb<-subset(power, Date=="2007-02-01"|Date=="2007-02-02")

# Convert the remaining columns from character to numeric.  By using sapply(powerfeb,class),
# the columns needed to change are 3:8
powerfeb[, c(3:8)] <- sapply(powerfeb[, c(3:8)], as.numeric)

# Remove NA values (actually omits all rows with NA's). There are no NA's for the February dates
# though
powerfebcc<-na.omit(powerfeb)

# Create three plots of submetering in png file format (size: 480x480 pixels)
# First set up blank plot with type = "n", then plot each dataset
png("plot3.png",width=480,height=480)
plot(powerfebcc$Time, powerfebcc$Sub_metering_1,type="n",xlab="",ylab="Energy sub metering")
points(powerfebcc$Time, powerfebcc$Sub_metering_1,col="black", type="l")
points(powerfebcc$Time, powerfebcc$Sub_metering_2,col="red", type="l")
points(powerfebcc$Time, powerfebcc$Sub_metering_3,col="blue", type="l")
legend("topright", lty=c(1,1,1), col=c("black","red", "blue"), 
       legend = c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"))
dev.off()