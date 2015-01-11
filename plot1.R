plot1 <- function() {
  ##Column header of source data
  colNames = c("Date", "Time", "GlobalActivePower", "GlobalReactivePower", "Voltage", "GlobalIntensity", "SubMetering1", "SubMetering2", "SubMetering3")
  ##Setting colClasses
  colClasses = c("character", "character", rep("numeric",7) )
  ##Read source file data into R
  data <- read.table("household_power_consumption.txt", header=TRUE, col.names=colNames, colClasses=colClasses, na.strings="?", sep=";")
  ##Subsetting data of 1st and 2nd Feb 2007
  data <- subset(data, grepl("^[12]/2/2007", data$Date))
  within(data, DateTime <- strptime(paste(Date, Time, sep="-"), format="%d/%m/%Y-%H:%M:%S", tz = ""))
  data
  ##Plotting bars
  png(filename="plot1.png", width=480, height=480, units="px")
  hist(data$GlobalActivePower, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)")
  dev.off()
}
