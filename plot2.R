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

# Constructing plot2 -> XYplot // Global Active Power against Date
plot(x = newDat$datetime, y = newDat$Global_active_power, type = "l",
     xlab = "",
     ylab = "Global Active Power (kilowatts)")
dev.copy(png, file = "plot2.png", width = 480, height = 480)
dev.off()