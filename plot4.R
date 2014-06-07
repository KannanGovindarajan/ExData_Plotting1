
constructplot4 <- function() {
        
        ## Read data
        file <- "household_power_consumption.txt"
        data <- read.table(file, header = TRUE, sep = ";", quote="\"", dec = ","
                           , fill = TRUE, comment.char = ""
                           , stringsAsFactors = FALSE)
        
        data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
        
        ## Filter data 
        filteredData <- data[data$Date == "2007-02-01" | 
                                     data$Date == "2007-02-02", ]
        
        ## Remove unused objects
        rm(data)
        
        ## Apply data conversions
        filteredData$Global_active_power <- as.numeric(filteredData$Global_active_power)
        
        filteredData$DateTime <- as.POSIXlt(strptime(paste(filteredData$Date
                                                           ,filteredData$Time)
                                                     ,"%Y-%m-%d %H:%M:%S"))
        
        ## Construct device
        png("plot4.png", 480, 480)
        
        ## Specify number of plots (mfcol fills columns first)
        par(mfcol = c(2,2))
        
        ## Draw plot1 to device
        plot(filteredData$DateTime, filteredData$Global_active_power, type = "l"
             ,xlab = ""
             , ylab = "Global Active Power")
        
        
        ## Draw plot2 to device
        x <- c(filteredData$DateTime,filteredData$DateTime,filteredData$DateTime)
        y <- c(filteredData$Sub_metering_1,filteredData$Sub_metering_2
               ,filteredData$Sub_metering_3)
        
        ## draw blank plot
        plot(x, y, type = "n",xlab = "", ylab = "Energy sub metering",  lty = 1)
        
        ## add points to same plot
        points(filteredData$DateTime, filteredData$Sub_metering_1, type = "l"
               , col = "black")
        
        
        points(filteredData$DateTime, filteredData$Sub_metering_2, type = "l"
                , col = "red")
        
        points(filteredData$DateTime, filteredData$Sub_metering_3, type = "l"
                , col = "blue")
        
        ## add legends
        legend("topright", lty = 1, col = c("black", "red", "blue"), lwd = 1
               ,legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
               ,bty = "n")
        
        
        ## Draw plot3 to device
        plot(filteredData$DateTime, filteredData$Voltage, type = "l"
             ,xlab = "datetime", ylab = "Voltage")
        
        ## Draw plot4 to device
        plot(filteredData$DateTime, filteredData$Global_reactive_power
             , type = "l",xlab = "datetime", ylab = "Global_reactive_power")
        
        ## Remove unused objects
        rm(filteredData)
        
        ## Close device
        dev.off()
}