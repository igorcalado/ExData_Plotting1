# Getting data set
if (!any(grepl("household_power_consumption.txt", list.files()))){
  powerdata.zip <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(url = powerdata.zip, destfile = "power consumption data.zip")
  power.file <- unzip("power consumption data.zip")
} else {
  power.file <- "./household_power_consumption.txt" 
}

# Subsetting and reading data set
if (!any(grepl("pdates", ls()))) {
  pdates <- read.csv(file=power.file, sep = ";", header = TRUE, colClasses = c("character", rep("NULL", 8)))
}
narrow <- vector(mode="numeric", length = 2)
narrow[1] <- match("1/2/2007", pdates$Date)
narrow[2] <- match("3/2/2007", pdates$Date) - 1
if (!any(grepl("power.data", ls()))) {
  power.data <- read.table(file=power.file, header=TRUE, sep=";", na.strings="?", colClasses= c(rep("character", 2), rep("numeric", 7)))[c(narrow[1]:narrow[2]),]
}

# Creating the settings for the plots
png(filename = "plot4.png", bg="white", width = 480, height = 480)
par(mfrow=c(2,2))

# Creating plots:
date.time <- paste(power.data$Date, power.data$Time)
date.time <- strptime(date.time, "%d/%m/%Y %H:%M:%S")

## First plot
plot(y=power.data$Global_active_power, x=date.time, type = "l", ylab = "Global Active Power (killowatts)", xlab="")

## Second plot
plot(y=power.data$Voltage, x= date.time, xlab="datetime", ylab="Voltage", type="l")

## Third plot
plot(date.time, power.data$Sub_metering_1, type = "l", ylab="Energy sub metering", xlab="")
lines(date.time, power.data$Sub_metering_2, col="red")
lines(date.time, power.data$Sub_metering_3, col="blue")
legend("topright", col=c("black","red","blue"), legend=c(names(power.data[,7:9])), lty = 1)

## Fourth plot
plot(y=power.data$Global_reactive_power, x= date.time, xlab="datetime", ylab="Global_reactive_power", type="l")

## Closing file
dev.off()