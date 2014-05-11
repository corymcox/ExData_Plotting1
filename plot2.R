################################################################################
# Data Set:      Individual household electric power consumption
#
#                UC Irvine Machine Learning Repository
#                University of California, Irvine
#
#                https://archive.ics.uci.edu/ml/datasets/Individual+household+electric+power+consumption
#
################################################################################
#
# Script:        plot2.R
# Date:          Sun May 1 2014
# Purpose:       This script is intended to create a plot of Global Active 
#                Power in kilowatts against time. The source data files can be 
#                found at:
#
#                https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
#
#                Sourcing this script will:
#                 * load the data;
#                 * convert data to proper data types;
#                 * plot a line graph;
#                 * appropriately labels and annotate the plot;
#                 * and save the plot as plot2.png at 480x480 pixels.
#
# Prerequisites: Data archive must be unzipped to the current working directory.
#
# Outputs:       plot2.png
#
#
################################################################################

#-------------------------------------------------------------------------------
# STEP 1: Load and prepare the data
#-------------------------------------------------------------------------------
data <- read.table("household_power_consumption.txt", header=TRUE,sep=";",na.strings="?")
data$Time <- as.POSIXct(strptime(paste(data[,1],data[,2],sep=" "),"%d/%m/%Y %H:%M:%S"))
data$Date <- as.Date(strptime(data[,1],"%d/%m/%Y"))

# Obtain the subset for the 2 days in question and remove the full-set from 
# memory
subsetData <- data[data$Date==as.Date("2007-02-01")|data$Date==as.Date("2007-02-02"),]
remove(data)

#-------------------------------------------------------------------------------
# STEP 2: Create plot and format appropriately to the png device
#-------------------------------------------------------------------------------
png(filename = "plot2.png", width = 480, height = 480)

plot(subsetData$Time,subsetData$Global_active_power, main="",type="l",
     ylab="Global Active Power (kilowatts)",
     xlab="")

dev.off()
