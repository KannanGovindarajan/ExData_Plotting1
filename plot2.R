
constructplot2 <- function() {
        
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
        png("plot2.png", 480, 480)
        
        ## Draw Plot to device
        plot(filteredData$DateTime, filteredData$Global_active_power
             , type = "l"
             ,xlab = ""
             , ylab = "Global Active Power (kilowatts)")
        
        ## Remove unused objects
        rm(filteredData)
        
        ##Close device
        dev.off()
}