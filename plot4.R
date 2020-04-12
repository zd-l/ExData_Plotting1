filename <- "Dataset.zip"

if (!file.exists(filename)){
        fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
        download.file(fileURL, filename, method="curl")
}  

if (!file.exists("household_power_consumption.txt")) { 
        unzip(filename) 
}

library(dplyr)

Alldata <- read.table("household_power_consumption.txt", sep = ";", header = TRUE, na.strings = "?",
                      colClasses = c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'))

Alldata$Date <- as.Date(Alldata$Date, "%d/%m/%Y")

Febdata <- filter(Alldata, Date >= as.Date("2007-02-01") & Date <= as.Date("2007-02-02"))

Completefebdaata <- Febdata[complete.cases(Febdata),]

Completefebdaata$DateTime<- strptime(paste(Completefebdaata$Date, Completefebdaata$Time), format = "%Y-%m-%d %H:%M:%S")

par(mfrow = c(2,2), mar = c(4,4,2,2))
plot(Completefebdaata$DateTime,
     Completefebdaata$Global_active_power, 
     type="l",
     ylab="Global Active Power (kilowatts)",
     xlab="")
plot(Completefebdaata$DateTime,
     Completefebdaata$Voltage, 
     type="l",
     ylab="Voltage",
     xlab="datetime")
plot(Completefebdaata$DateTime, Completefebdaata$Sub_metering_1, type="l", 
     ylab="Global Active Power (kilowatts)",xlab="")
lines(Completefebdaata$DateTime, Completefebdaata$Sub_metering_2, col = "red")
lines(Completefebdaata$DateTime, Completefebdaata$Sub_metering_3, col = "blue")
legend("topright", col=c("black", "red", "blue"), lwd=c(1,1,1), 
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       cex = 0.5)
plot(Completefebdaata$DateTime,
     Completefebdaata$Global_reactive_power, 
     type="l",
     ylab="Global_reactive_power",
     xlab="datetime")
dev.copy(png, file = "plot4.png", width=480, height=480)
dev.off()

