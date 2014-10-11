#datasource location
fileurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
filename <- "./exdata-data-household_power_consumption.zip"

#conditionally download the file
if (!file.exists(filename)) {
    download.file(fileurl, destfile=filename)
    unzip(filename, exdir=".")
}

#conditionally load the training and test datasets
if (!exists("hpc_data")) {
    hpc_data <- read.table("./household_power_consumption.txt", header=TRUE, sep=";", quote="\"")
}
hpc_data$Date<-as.Date(hpc_data$Date, format="%d/%m/%Y")

#trim by date.  Keep only 2007-02-01 and 2007-02-02.
hpc_trim <- subset(hpc_data, Date=="2007-02-01" | Date=="2007-02-02")

#convert to numeric
hpc_trim$Global_active_power <- as.numeric(as.character(hpc_trim$Global_active_power))

png(file = "plot1.png", bg = "transparent")
#create histogram
hist(hpc_trim$Global_active_power, col="red", main="Global Active Power",
     xlab="Global Active Power (kilowatts)", ylab="Frequency", xlim=c(0,6), ylim = c(0, 1200))
dev.off()