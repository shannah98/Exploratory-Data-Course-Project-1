library(dplyr)

filename <- "ECP_Consumption.zip"

# Checking if archieve already exists.
if (!file.exists(filename)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(fileURL, filename, method="curl")
}  

# Checking if folder exists
if (!file.exists("ECP_Consumption")) { 
  unzip(filename) 
}

dataset<- read.csv("household_power_consumption.txt", header = T, sep = ';', na.strings = "?",
                   nrows = 2075259, check.names = F, stringsAsFactors = F, comment.char="", quote='\"')
d1<- subset(dataset, Date %in% c("1/2/2007", "2/2/2007"))
dataset$Date <- as.Date(dataset$Date, format="%d/%m/%Y")
hist(d1$Global_active_power, xlab = "Global Active Power (Kilowatts)", ylab = "Frequency", main = "Global Active Power",
     col = 'red')
png("plot1.png", width=480, height=480)
dev.off()