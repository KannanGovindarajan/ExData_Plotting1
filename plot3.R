
constructplot3 <- function() {
        
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
        png("plot3.png", 480, 480)
        
        ## Draw plot to device
        x <- c(filteredData$DateTime,filteredData$DateTime
               ,filteredData$DateTime)
        y <- c(filteredData$Sub_metering_1,filteredData$Sub_metering_2
               ,filteredData$Sub_metering_3)
        
        ## draw blank plot
        plot(x, y, type = "n",xlab = "", ylab = "Energy sub metering",  lwd = 1)
        
        ## add points to same plot
        points(filteredData$DateTime, filteredData$Sub_metering_1, type = "l"
               , col = "black")
        
        
        points(filteredData$DateTime, filteredData$Sub_metering_2, type = "l"
                     , col = "red")
        
        points(filteredData$DateTime, filteredData$Sub_metering_3, type = "l"
                     , col = "blue")
        
        ## add legends
        legend("topright", lty = 1, col = c("black", "red", "blue"), lwd = 1
               ,legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
        
        ## Remove unused objects
        rm(filteredData)
        
        ## Close device
        dev.off()
}