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
setwd("C:\\Users\\Diane\\Documents\\gitRepo\\ExData_Plotting1")
png(filename="plot2.png", width=480, height=480)
plot(pow$Global_active_power~pow$datetime, type="l",
     xlab="", ylab="Global Active Power (kilowatts)")
dev.off()
