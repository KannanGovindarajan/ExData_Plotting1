
constructplot1 <- function() {
        
        ## Read data
        file <- "household_power_consumption.txt"
        data <- read.table(file, header = TRUE, sep = ";", quote="\"", dec = ","
                           , fill = TRUE, comment.char = ""
                           , stringsAsFactors = FALSE)
        
        data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
        
        ## Filter data by specific dates
        filteredData <- data[data$Date == "2007-02-01"  
                             | data$Date == "2007-02-02", ]
        
        ## Remove unused objects
        rm(data)
        
        ## Apply data conversions
        filteredData$Global_active_power <- as.numeric(filteredData$Global_active_power)
        
        ## Construct device
        png("plot1.png", 480, 480)
        
        ## Draw Histogram to device
        hist(filteredData$Global_active_power
             , col = "red"
             , main = "Global Active Power"
             , xlab = "Global Active Power (kilowatts)"
        )
        
        ## Remove unused objects
        rm(filteredData)
        
        ## Close device
        dev.off()
}