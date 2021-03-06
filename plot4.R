library(lubridate)
library(dplyr)

setwd("~/Coursera/04 Exploratory Data Analysis/Week 1/Course Project 1")

# Download the data from the source and unzip the file
fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileURL, destfile = "Dataset.zip")
dateDownloaded <- date()
unzip("Dataset.zip")

# Read the data and subset by date and variable
type_data <- c(rep("character", 9))
data <- read.table("household_power_consumption.txt", header = TRUE, sep = ";",
                   colClasses = type_data)
data$Date <- dmy_hms(paste(data$Date, data$Time))
data <- data %>%
        select(-Time, -Global_intensity) %>%
        filter(Date >= ymd("2007-02-01")) %>%
        filter(Date < ymd("2007-02-03"))

# Plot the 4 graphs directly into the file "plot4.png"
Sys.setlocale("LC_TIME", "English")
png(filename =  "plot4.png", width = 480, height = 480, bg="transparent")
par(mfrow = c(2, 2))

with (data, {
        plot(Date, as.numeric(Global_active_power), type = "l",
        xlab = "", ylab = "Global Active Power")
        
        plot(Date, Voltage, type = "l", xlab = "datetime")
        
        plot(data$Date, as.numeric(data$Sub_metering_1), type = "l",
             xlab = "", ylab = "Energy sub metering")
        points(data$Date, as.numeric(data$Sub_metering_2), type = "l", col = "red")
        points(data$Date, as.numeric(data$Sub_metering_3), type = "l", col = "blue")
        legend("topright", col = c("black", "blue", "red"), lty=c(1,1,1), box.col = "transparent",
               legend = c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"))
        
        plot(Date, Global_reactive_power, type = "l", xlab = "datetime")
        })

dev.off()