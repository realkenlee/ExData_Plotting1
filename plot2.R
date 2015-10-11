# This is an assignment for Coursera Exploratory Data Analysis
# Course Project #2
# Plot2

library(data.table)
library(dplyr)

destFileName <- "powerConsumption.zip"
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
if(!file.exists(destFileName)) {
        download.file(fileUrl, destfile = destFileName, method = "curl")
}

#see file content of zip
filelist = unzip(destFileName, list=TRUE)
data <- read.table(unz(destFileName, filelist[1,1]), header = TRUE, sep = ';', na.strings = "?")

# only retain Feb 1, 2007 and Feb 2, 2007
DT <- as.data.table(data)
DT <- filter(DT, Date == "1/2/2007" | Date ==  "2/2/2007")
# create datetime column as POSIXct
x <-paste(DT$Date, DT$Time)
DT$datetime <- as.POSIXct(strptime(x, "%d/%m/%Y %H:%M:%S"))

#plot 2
png(file="plot2.png",width=480,height=480)
with(DT, plot(datetime, Global_active_power, type = "l", ylab = "Global Active Power (kilowatts)", xlab = ""))
dev.off()
