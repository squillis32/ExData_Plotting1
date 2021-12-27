#Exploratory_Data_Analysis
#Jake J. Willis
#12/21/2021


###########################Course Project 1###############################################################
#Set working directory to location you desire to downlooad the data.
#setwd("~/Coursera/Getting_and_Cleaning_Data/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset")
setwd("~/Military/COURSERA")

# Clear the Global Environment.
rm(list = ls())


# Install necessary libraries.
library(dplyr)          # A set of functions designed to enable dataframe manipulation in a intuitive, user-friendly way.
library(lubridate)      # Provides tools that make it easier to parse and manipulate dates.
library(hms)

# Create value for the location of the data.
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

# Download the compressed file and unzip it.
download.file(url, "exdata_data_household_power_consumption.zip")
unzip("exdata_data_household_power_consumption.zip")

# Create a data frame with the household power consumption for the dates of 2007-02-01 and 2007-02-02.
household_power_consumption_data <- read.table(file = "household_power_consumption.txt", sep = ";", header = TRUE) %>%
  filter(Date == "1/2/2007" | Date == "2/2/2007")

# Convert the class of the variables from factor to date, time or numeric.
household_power_consumption_data$Date <- as.Date(levels(household_power_consumption_data$Date)[household_power_consumption_data$Date], format = "%d/%m/%Y")
household_power_consumption_data$Time2 <- as_hms(strptime(levels(household_power_consumption_data$Time)[household_power_consumption_data$Time], format = "%H:%M:%S"))
household_power_consumption_data$Time <- strptime(levels(household_power_consumption_data$Time)[household_power_consumption_data$Time], format = "%H:%M:%S")
household_power_consumption_data$Global_active_power <- as.numeric(levels(household_power_consumption_data$Global_active_power)[household_power_consumption_data$Global_active_power])
household_power_consumption_data$Time3 <- as.POSIXct(paste(household_power_consumption_data$Date,household_power_consumption_data$Time2), format = "%Y-%m-%d %H:%M:%S")
household_power_consumption_data$Global_reactive_power <- as.numeric(levels(household_power_consumption_data$Global_reactive_power)[household_power_consumption_data$Global_reactive_power])
household_power_consumption_data$Voltage <- as.numeric(levels(household_power_consumption_data$Voltage)[household_power_consumption_data$Voltage])
household_power_consumption_data$Sub_metering_1 <- as.numeric(levels(household_power_consumption_data$Sub_metering_1)[household_power_consumption_data$Sub_metering_1])
household_power_consumption_data$Sub_metering_2 <- as.numeric(levels(household_power_consumption_data$Sub_metering_2)[household_power_consumption_data$Sub_metering_2])

# construct and save a plot of the day against the Energy sub metering by each sub metering.
png(filename = "plot3.png", width = 480, height = 480, units = "px")
plot(x = household_power_consumption_data$Time3, y = household_power_consumption_data$Sub_metering_1, type = "S", xlab = "", ylab = "Energy sub metering", col = "black", ylim = c(0, 40))
lines(x = household_power_consumption_data$Time3, y = household_power_consumption_data$Sub_metering_2, type = "S", col = "red")
lines(x = household_power_consumption_data$Time3, y = household_power_consumption_data$Sub_metering_3, type = "S", col = "blue")

# Add a legend to the plot for each Sub Metering.
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty = c(1,1,1))
dev.off()


