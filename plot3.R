library(dplyr)

filename <- "ECP_Consumption.zip"

# Checking if archieve already exists.
if (!file.exists(filename)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
}  

# Checking if folder exists
if (!file.exists("ECP_Consumption")) { 
  unzip(filename) 
}

dataset<- read.csv("household_power_consumption.txt", header = T, sep = ';', na.strings = "?",
                   nrows = 2075259, check.names = F, stringsAsFactors = F, comment.char="", quote='\"')
d1<- subset(dataset, Date %in% c("1/2/2007", "2/2/2007"))
d1$Date <- as.Date(d1$Date, format="%d/%m/%Y")
datetime <- paste(as.Date(d1$Date), d1$Time)
d1$Datetime <- as.POSIXct(datetime)


with(d1, {
  plot(Sub_metering_1~Datetime, type="l",
       ylab="Global Active Power (kilowatts)", xlab="")
  lines(Sub_metering_2~Datetime,col='Red')
  lines(Sub_metering_3~Datetime,col='Blue')
})
legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
## Saving to file
dev.copy(png, file="plot3.png", height=480, width=480)
dev.off()