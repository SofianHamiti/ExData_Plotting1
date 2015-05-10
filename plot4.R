## read the .txt file located in the working directory
filename <- "household_power_consumption.txt"
data <- read.table(filename, header = TRUE, 
                   sep = ";", 
                   colClasses = c("character", "character", rep("numeric",7)), 
                   na="?")

## subset data from the dates 2007-02-01 and 2007-02-02.
subset <- data$Date == "1/2/2007" | data$Date == "2/2/2007"
data <- data[subset, ]

## putting Date and Time together in one variable, 
## format them with strptime() and remove the original variables from the dataframe. 
x <- paste(data$Date, data$Time)
data$DateTime <- strptime(x, "%d/%m/%Y %H:%M:%S")
data <- subset( data, select = -c(Date, Time ) )

## Construct the plots and save them to plot4.png file
png(filename = "plot4.png", 
    width = 480, height = 480,
    units = "px")
par(mfrow = c(2, 2))
        ## Top-left plot
        plot(data$DateTime, data$Global_active_power, 
             type = "l",
             xlab = "", ylab = "Global Active Power")
        ## Top-right plot
        plot(data$DateTime, data$Voltage,
             type = "l",
             xlab = "datetime", ylab = "Voltage")
        ## Bottom-left plot
        plot(data$DateTime, data$Sub_metering_1, 
             type = "l",
             col = "black",
             xlab = "", ylab = "Energy sub metering")
        lines(data$DateTime, data$Sub_metering_2, col = "red")
        lines(data$DateTime, data$Sub_metering_3, col = "blue")

        ## Bottom-right plot
        plot(data$DateTime, data$Global_reactive_power, 
             type = "l",
             col = "black",
             xlab = "datetime", ylab = colnames(data)[4])
dev.off()