plot4 <- function() {
  colNames = c("Date", "Time", "GlobalActivePower", "GlobalReactivePower", "Voltage", "GlobalIntensity", "SubMetering1", "SubMetering2", "SubMetering3")
  colClasses = c("character", "character", rep("numeric",7) )
  data <- read.table("household_power_consumption.txt", header=TRUE, col.names=colNames, colClasses=colClasses, na.strings="?", sep=";")
  data <- subset(data, grepl("^[12]/2/2007", data$Date))
  within(data, DateTime <- strptime(paste(Date, Time, sep="-"), format="%d/%m/%Y-%H:%M:%S", tz = ""))
  data
  Sys.setlocale("LC_TIME", "English")
  data$DateTime <- strptime(paste(as.character(as.Date(data$Date, "%d/%m/%Y")), data$Time), "%Y-%m-%d %H:%M:%S")
  png(filename="plot4.png", width=480, height=480, units="px")
  par(mfcol=c(2,2))
  with(data, plot(DateTime, GlobalActivePower, main = "", ylab = "Global Active Power (kilowatts)", type = "l", xlab = ""))
  with(data, plot(DateTime, SubMetering1, main = "", ylab = "Energy sub metering", type = "l", xlab = ""))
  with(data, lines(DateTime, SubMetering2, col = "red"))
  with(data, lines(DateTime, SubMetering3, col = "blue"))
  legend("topright", c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'), col = c('black','red','blue'), lwd = 1)
  with(data, plot(DateTime, Voltage, main = "", ylab = "Voltage", type = "l", xlab = "datetime"))
  with(data, plot(DateTime, GlobalReactivePower, main = "", ylab = "Global_reactive_power", type = "l", xlab = "datetime"))
  
  dev.off()
}