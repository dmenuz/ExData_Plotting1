############################################################################
#Step 1: Download data, unzipe, and create list of all files in zipped file
#Steps that do not need to be repeated more than once are commented out
setwd("C:\\Users\\Diane\\Desktop\\workingDirectory")
file="https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
destfile="dat.zip"
download.file(file, destfile)
zipList=unzip(destfile, list=TRUE)
unzip(destfile)

############################################################################
#Step 2: Load data, subset, and convert dates and times
power=read.table("household_power_consumption.txt", header=TRUE, sep=";")
power2=power[power$Date %in% c("1/2/2007", "2/2/2007"),]
write.table(power2, "power.txt",sep=",")
pow=read.table("power.txt", sep=",",header=TRUE)
pow$datetime=as.POSIXct(paste(pow$Date, pow$Time), format="%d/%m/%Y %H:%M:%S")

############################################################################
#Step 3: Produce plot
png(filename="plot4.png", width=480, height=480)
par(mfrow=c(2,2), mar=c(5.1,4.1, 1.1, 2.1))
plot(pow$Global_active_power~pow$datetime, type="l",
     xlab="", ylab="Global Active Power")
plot(pow$Voltage~pow$datetime, type="l",
     xlab="datetime", ylab="Voltage")
plot(pow$Sub_metering_1~pow$datetime, type="l",
     xlab="", ylab="Energy sub metering")
lines(pow$datetime, pow$Sub_metering_2, col="red")
lines(pow$datetime, pow$Sub_metering_3, col="blue")
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"),
       lty=1, col=c("black", "red", "blue"), bty="n")
plot(pow$Global_reactive_power~pow$datetime, type="l",
     xlab="datetime", ylab="Global_reactive_power")
dev.off()
