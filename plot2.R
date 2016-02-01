##load the library the is needed
library(lubridate)

##pull the data fro mthe file
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
png(filename = "plot2.png",width = 480, height = 480)
plot(newhhpower$datetime,newhhpower$Global_active_power,type = "l",
     ylab = "Global Active Power (kilowatts)",xlab = "")
dev.off()
