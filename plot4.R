## Read data
power_data <- read.table("household_power_consumption.txt", header=T, sep=";")

## Create a DateTime column and convert it to date time
power_data$DateTime <- paste(power_data$Date,power_data$Time)
power_data$DateTime <- strptime(power_data$DateTime, format="%d/%m/%Y %H:%M:%S")

## Convert Date column to date
power_data$Date <- as.Date(power_data$Date, format="%d/%m/%Y")

## Create subset with dates from 01/02/2007 - 02/02/2007
sampled_data <- with(power_data, power_data[(Date >= as.Date("01/02/2007","%d/%m/%Y") & Date <= as.Date("02/02/2007","%d/%m/%Y")), ])

## Replace the ? character in all measure fields
sampled_data$Global_active_power <- gsub('?', '', sampled_data$Global_active_power)
sampled_data$Global_reactive_power <- gsub('?', '', sampled_data$Global_reactive_power)
sampled_data$Voltage <- gsub('?', '', sampled_data$Voltage)
sampled_data$Global_intensity <- gsub('?', '', sampled_data$Global_intensity)
sampled_data$Sub_metering_1 <- gsub('?', '', sampled_data$Sub_metering_1)
sampled_data$Sub_metering_2 <- gsub('?', '', sampled_data$Sub_metering_2)

## Convert measure columns to numeric (Sub_metering_3 is already numeric)
sampled_data$Global_active_power <- as.numeric(sampled_data$Global_active_power)
sampled_data$Global_reactive_power <- as.numeric(sampled_data$Global_reactive_power)
sampled_data$Voltage  <- as.numeric( sampled_data$Voltage)
sampled_data$Global_intensity <- as.numeric( sampled_data$Global_intensity)
sampled_data$Sub_metering_1   <- as.numeric( sampled_data$Sub_metering_1 )
sampled_data$Sub_metering_2   <- as.numeric( sampled_data$Sub_metering_2)

## Create a set of four plots
par(mfrow=(c(2,2)))
## Create the first plot
plot(sampled_data$DateTime,sampled_data$Global_active_power,xlab="",ylab="Global Active Power (kilowatts)",type="l")
## Create the second plot
plot(sampled_data$DateTime,sampled_data$Voltage,ylab="Voltage",xlab="datetime",type="l")
## Create the third plot
plot(sampled_data$DateTime,sampled_data$Sub_metering_1,xlab="",ylab="Energy sub metering",type="l")
points(sampled_data$DateTime,sampled_data$Sub_metering_2, col="red", type="l")
points(sampled_data$DateTime,sampled_data$Sub_metering_3, col="blue", type="l")
## Create the fourth plot
plot(sampled_data$DateTime,sampled_data$Global_reactive_power,ylab="Global_reactive_power",xlab="datetime",type="l")

## Create the png file
dev.copy(png,file="plot4.png")
dev.off()