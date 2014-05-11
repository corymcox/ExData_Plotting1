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
# Script:        plot4.R
# Date:          Sun May 1 2014
# Purpose:       This script is intended to create 4 plots of from the dataset 
#                in a single frame. The source data files can be 
#                found at:
#
#                https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
#
#                Sourcing this script will:
#                 * load the data;
#                 * convert data to proper data types;
#                 * plot 4 plots;
#                 * appropriately labels and annotate the plot;
#                 * and save the plot as plot4.png at 480x480 pixels.
#
# Prerequisites: Data archive must be unzipped to the current working directory.
#
# Outputs:       plot4.png
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
# STEP 2: Create plots and format appropriately to the png device
#-------------------------------------------------------------------------------
png(filename = "plot4.png", width = 480, height = 480)

par(mfrow=c(2,2))

with(subsetData, {
        #Graph 1
        plot(Time,Global_active_power, main="",type="l",
             ylab="Global Active Power",
             xlab="")  
        
        #Graph 2
        plot(Time,Voltage, main="",type="l",
             ylab="Voltage",
             xlab="datetime")
        
        #Graph 3
        plot(subsetData$Time,Sub_metering_1, main="",type="l",
             ylab="Energy sub metering",
             xlab="",
             ylim=c(0,38),
             col="black")
        
        legend("topright", lty=1, bty="n", col=c("black","red","blue"), legend=colnames(subsetData[,7:9]))
        
        lines(Time,Sub_metering_2,type="l",col="red")
        lines(Time,Sub_metering_3,type="l",col="blue")
        
        #Graph 4
        plot(Time,Global_reactive_power, main="",type="l",
             ylab="Global_reactive_power",
             xlab="datetime")
        
})

dev.off()
