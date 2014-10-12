#datasource location
fileurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
filename <- "./exdata-data-household_power_consumption.zip"

#conditionally download the file
if (!file.exists(filename)) {
    download.file(fileurl, destfile=filename)
    unzip(filename, exdir=".")
}

#conditionally load the dataset
if (!exists("hpc_data")) {
    hpc_data <- read.table("./household_power_consumption.txt", header=TRUE, sep=";", 
                           quote="\"", na.strings="?")
}
hpc_data$Date<-as.Date(hpc_data$Date, format="%d/%m/%Y")

#trim by date.  Keep only 2007-02-01 and 2007-02-02.
hpc_trim <- subset(hpc_data, Date=="2007-02-01" | Date=="2007-02-02")

#combine date and time into a single timestamp
hpc_trim$DateTime <- paste(hpc_trim$Date, hpc_trim$Time)
hpc_trim$DateTime <- strptime(hpc_trim$DateTime, "%Y-%m-%d %H:%M:%S")

#convert to numeric
hpc_trim$Global_active_power <- as.numeric(as.character(hpc_trim$Global_active_power))

#generate the plot
png(file = "plot3.png", bg = "white")
plot(hpc_trim$DateTime, as.numeric(as.character(hpc_trim$Sub_metering_1)), 
     type="l", xlab="", ylab="Energy sub metering")

lines(hpc_trim$DateTime, as.numeric(as.character(hpc_trim$Sub_metering_2)), 
     type="l", col="red")
lines(hpc_trim$DateTime, as.numeric(as.character(hpc_trim$Sub_metering_3)), 
     type="l", col="blue")
legend("topright", lty=1, col=c("black", "red", "blue"), 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()