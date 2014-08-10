# Plot 3 is a line plot Global_active_power split by sub metering against date and time. 

# Loading a subset to establish the column classes, which we can use when loading the full data file to load it faster.

initial <- read.table("household_power_consumption.txt",header=TRUE,sep=";",na.strings = "?", nrows = 10) 
Classes <- sapply(initial, class)
tabAll <- read.table("household_power_consumption.txt",header=TRUE,sep=";",na.strings = "?", nrows=2075259, colClasses = Classes) 

#Specifying nrows because we've been told how much data there is; see http://www.biostat.jhsph.edu/~rpeng/docs/R-large-tables.html

# You may find it useful to convert the Date and Time variables to Date/Time classes in R using the strptime() and as.Date() functions.
tabAll$Date <- as.Date(tabAll$Date, "%d/%m/%Y")

# "We will only be using data from the dates 2007-02-01 and 2007-02-02. One alternative is to read the data from just those dates rather than reading in the entire dataset and subsetting to those dates." I'm sure there is a way to do this with readLines(), but I can't figure it out. 
tabSub <- tabAll[tabAll$Date=="2007-02-01"|tabAll$Date=="2007-02-02",]

# We need time as well for this one.
DateTime <- paste(tabSub$Date, tabSub$Time)
tabSub$DateTime <- as.POSIXct(DateTime)


png("plot3.png", width=480, height=480)
with(tabSub, {
        plot(Sub_metering_1~DateTime, type="l",
             ylab="Global Active Power (kilowatts)", xlab="")
        lines(Sub_metering_2~DateTime,col='Red')
        lines(Sub_metering_3~DateTime,col='Blue')
})
legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()
