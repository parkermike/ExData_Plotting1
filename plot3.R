# This assignment is plot3 for a line graph3 for the 3 sub_metering.
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

# Convert the date and time and pull out submetering
x <- strptime(paste(df_data$Date,df_data$Time),"%d/%m/%Y %H:%M:%S")
y1 <- df_data$Sub_metering_1
y2 <- df_data$Sub_metering_2
y3 <- df_data$Sub_metering_3

# Create the plot of the output
png(file='plot3.png',width=480, height=480, bg="transparent")
plot(x,y1, type='l', xlab='', ylab='Energy sub metering')
lines(x,y2, col='red')
lines(x,y3, col='blue')
legend(x='topright', y=NULL, c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       col=c("black","red","blue"), lty=1, lwd = 2)
par(bg="transparent")
dev.off()

