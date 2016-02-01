##load the library the is needed
library(lubridate)

##pull the data from the file
hhpower <- read.table("./exdata-data-household_power_consumption/household_power_consumption.txt",
                      sep = ";", header = TRUE, colClasses = "character")

##Change the Column Date to date format and subset the data that is in use
hhpower$Date <- as.Date(hhpower$Date,"%d/%m/%Y")
dateneed <- c("1/2/2007","2/2/2007")
dateneed <- as.Date(dateneed,"%d/%m/%Y")
hhpower <- subset(hhpower,hhpower$Date %in% dateneed)

##Create a new column by combining the date and time, also changing the format
datetime <- paste(hhpower$Date, hhpower$Time)
datetime <- as.POSIXct(datetime,format="%Y-%m-%d %H:%M:%S")
newhhpower <- cbind(datetime,hhpower)

##Save the plot in a png file
png(filename = "plot4.png",width = 480, height = 480)
par(mfrow = c(2,2))

##first graph
with(newhhpower,plot(datetime,Global_active_power,type = "l",
                     ylab = "Global Active Power", xlab = ""))

##second graph
with(newhhpower,plot(datetime,Voltage,type = "l",
                     ylab = "Voltage", xlab = "datetime"))

##third graph
with(newhhpower,plot(datetime,Sub_metering_1,type = "l",
                     ylab="Energy sub metering",xlab=""))
with(newhhpower,points(datetime,Sub_metering_2,type = "l",col = "red"))
with(newhhpower,points(datetime,Sub_metering_3,type = "l",col = "blue"))

legend("topright",lty=c(1,1),col=c("black","red","blue"),bty="n",
       legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

##fourth graph
with(newhhpower,plot(datetime,Global_reactive_power,type = "l",
                     xlab = "datetime"))
dev.off()
