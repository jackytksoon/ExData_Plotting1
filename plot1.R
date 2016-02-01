##load the library
library(lubridate)

##read the data
hhpower <- read.table("./exdata-data-household_power_consumption/household_power_consumption.txt",
                      sep = ";", header = TRUE, colClasses = "character")

##change the data format and filter the date that is need
hhpower$Date <- as.Date(hhpower$Date,"%d/%m/%Y")
dateneed <- c("1/2/2007","2/2/2007")
dateneed <- as.Date(dateneed,"%d/%m/%Y")
hhpower <- subset(hhpower,hhpower$Date %in% dateneed)

##Change the variable to numberic
hhpower$Global_active_power <- as.numeric(hhpower$Global_active_power)

##save the graph as a png file
png(filename = "plot1.png",width = 480, height = 480)
hist(hhpower$Global_active_power, main="Global Active Power",
     col = "red",xlab = "Global Active Power (kilowatts)")
dev.off()
