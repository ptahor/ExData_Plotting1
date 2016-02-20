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

# Plot the time series
Sys.setlocale("LC_TIME", "English")
par(bg="transparent")
with(data, plot(Date, as.numeric(Global_active_power), type = "l",
                xlab = "",
                ylab = "Global Active Power (kilowatts)"))

# Save the file plot2.png
dev.copy(png, width=480, height=480, file = "plot2.png")
dev.off()