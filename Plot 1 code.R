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

# Creating plot 1: 'Global Active Power' histogram
png(filename = "plot1.png", bg="white", width = 480, height = 480)
hist(power.data$Global_active_power, col="red", main="Global Active Power", xlab = "Global Active Power (killowatts)")
dev.off()