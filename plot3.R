# Read the file
theFile <- "./household_power_consumption.txt"
dat <- read.table(theFile, header = TRUE, sep = ";",
                  stringsAsFactors = FALSE, dec = ".")

# Convert data and time variables
dat$Date <- as.Date(dat$Date, "%d/%m/%Y")
datetime <- paste(as.Date(dat$Date), dat$Time)
dat$datetime <- as.POSIXct(datetime)

# Subset 2007-02-01 and 2007-02-02 from the data set
library("data.table")
newDat <- subset(dat, Date == "2007-02-01" | Date == "2007-02-02")

# Converting from char to num variables
newDat$Global_active_power <- as.numeric(newDat$Global_active_power)
newDat$Global_reactive_power <- as.numeric(newDat$Global_reactive_power)
newDat$Voltage <- as.numeric(newDat$Voltage)
newDat$Global_intensity <- as.numeric(newDat$Global_intensity)
newDat$Sub_metering_1 <- as.numeric(newDat$Sub_metering_1)
newDat$Sub_metering_2 <- as.numeric(newDat$Sub_metering_2)

# Constructing plot3 -> XYplot + legend // Sub_meterings against Date
plot(1, type = "n", xlab = "", ylab = "")
plot(x = newDat$datetime, y = newDat$Sub_metering_1, type = "l",
     xlab = "",
     ylab = "Energy Submetering")
lines(x = newDat$datetime, y = newDat$Sub_metering_2, type = "l", col = "red")
lines(x = newDat$datetime, y = newDat$Sub_metering_3, type = "l", col = "blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty = 1, lwd = 2.5, col = c("black", "red", "blue"))
dev.copy(png, file = "plot3.png", width = 480, height = 480)
dev.off()