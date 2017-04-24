# This assignment is plot1 for a histogram for Global Active Power.
# It uses data from the UC Irvine Machine Learning Repository,
# a popular repository for machine learning datasets. It will be using the 
# "Individual household electric power consumption Data Set" which 
# is available on the course web site:
#      Dataset: Electric power consumption [20Mb]
# Description: Measurements of electric power consumption in one household
# with a one-minute sampling rate over a period of almost 4 years. Different 
# electrical quantities and some sub-metering values are available.

# data fields on file
# Date: Date in format dd/mm/yyyy 
# Time: time in format hh:mm:ss 
# Global_active_power: household global minute-averaged active power (in kilowatt) 
# Global_reactive_power: household global minute-averaged reactive power (in kilowatt) 
# Voltage: minute-averaged voltage (in volt) 
# Global_intensity: household global minute-averaged current intensity (in ampere) 
# Sub_metering_1: energy sub-metering No. 1 (in watt-hour of active energy). 
#      It corresponds to the kitchen, containing mainly a dishwasher, an oven and 
#      a microwave (hot plates are not electric but gas powered). 
# Sub_metering_2: energy sub-metering No. 2 (in watt-hour of active energy). 
#      It corresponds to the laundry room, containing a washing-machine, 
#      a tumble-drier, a refrigerator and a light. 
# Sub_metering_3: energy sub-metering No. 3 (in watt-hour of active energy). It 
#      corresponds to an electric water-heater and an air-conditioner.

library(datasets)

infile <- "household_power_consumption.txt"  # Data file in root directory
outDataFile <- "Feb1and2.txt"  # Output file that will only hold two days of data

# Because this file will be appended to it must be deleted before evey run
if (file.exists(outDataFile)) file.remove(outDataFile)

#Read the large file in using strategy from American Community Survey Example
input <- readLines(infile, n= -1)

# Add the headers to the file
cat(input[1],file=outDataFile,sep="\n",append = TRUE)

# Select the Feb 1 and 2 data and write them out to a file
lapply(input,function(x) {
      if ((substr(x,1,8) == "1/2/2007") | (substr(x,1,8) == "2/2/2007") ) {
            cat(x,file=outDataFile,sep="\n",append = TRUE)}})

# Read the two day file that has the data needed
df_data <- read.csv(outDataFile, sep=';', colClasses = "character")

# Display the histogram
hist(as.numeric(df_data$Global_active_power),main="Global Active Power", 
     col='red', xlab = 'Global Active Power (kilowatts)', ylab='Frequency')
title(main ='Global Active Power')

# Create file copy of the output
png(file='plot1.png',width=480, height=480, bg="transparent")
# Plot the histogram
hist(as.numeric(df_data$Global_active_power),main="Global Active Power", 
     col='red', xlab = 'Global Active Power (kilowatts)', ylab='Frequency')
title(main ='Global Active Power')
par(bg="transparent")
dev.off()
