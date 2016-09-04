## Attaching packages
library(dplyr)
library(lubridate)

## Reading Data
hdata <- read.table("household_power_consumption.txt",sep = ";", header = T, colClasses = "character")

## Creating new variable
hdata <- hdata %>% mutate(datetime = str_c(Date,Time, sep = " "))

## Converting to appropriate types
hdata$datetime <- dmy_hms(hdata$datetime)
hdata$Date <- dmy(hdata$Date)
hdata$Global_active_power <- as.numeric(hdata$Global_active_power)
hdata$Global_reactive_power <- as.numeric(hdata$Global_reactive_power)
hdata$Voltage <- as.numeric(hdata$Voltage)
hdata$Global_intensity <- as.numeric(hdata$Global_intensity)
hdata$Sub_metering_1 <- as.numeric(hdata$Sub_metering_1)
hdata$Sub_metering_2 <- as.numeric(hdata$Sub_metering_2)
hdata$Sub_metering_3 <- as.numeric(hdata$Sub_metering_3)

## Filtering dates
hhdata <- hdata %>% filter(Date >= ymd(20070201) & Date <= ymd(20070202))

## Plot 4
par(mfrow = c(2, 2)) 

plot(hhdata$datetime, hhdata$Global_Active_Power, type="l", xlab="", ylab="Global Active Power", cex=0.2)

plot(hhdata$datetime, hhdata$Voltage, type="l", xlab="datetime", ylab="Voltage")

plot(hhdata$datetime, hhdata$Sub_Metering_1, type="l", ylab="Energy Submetering", xlab="")
lines(hhdata$datetime, hhdata$Sub_Metering_2, type="l", col="red")
lines(hhdata$datetime, hhdata$Sub_Metering_3, type="l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=, lwd=2.5, col=c("black", "red", "blue"), bty="o")

plot(hhdata$datetime, hhdata$Global_Reactive_Power, type="l", xlab="datetime", ylab="Global_reactive_power")

## Saving to file
dev.copy(png, file="plot1.png", height=480, width=480)
dev.off()