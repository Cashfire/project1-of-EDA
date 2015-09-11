#setwd("~/Documents/exploratoryData")
temp<- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp, mode="wb")
data<-read.table(unzip(temp,"household_power_consumption.txt"),
                 header= T, sep=";", stringsAsFactors = F, na.strings = "?")
unlink(temp)
##get the subset of 2880 obs.
sub<-subset(data,data$Date=="1/2/2007"|data$Date=="2/2/2007") 
##change the format of date and time
dt<-paste(sub$Date,sub$Time)
dt1<-strptime(dt,format="%d/%m/%Y %H:%M:%S")
sub$datetime<-dt1

##plot4
par(mfrow=c(2,2))
plot(sub$datetime, sub$Global_active_power, type = "l",
     ylab="Global Active Power (kilowatts)",
     xlab = "")
plot(sub$datetime, sub$Voltage, type = "l",
     ylab="Voltage",xlab = "datetime")
plot(sub$datetime, sub$Sub_metering_1,type = "l",
     ylab = "Energy sub metering", xlab = "")
lines(sub$datetime, sub$Sub_metering_2, col="red")
lines(sub$datetime, sub$Sub_metering_3, col="blue")
legend("topright", lty = 1, cex = 0.25, bty = "n",
       legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       col=c("black","red","blue"))
plot(sub$datetime, sub$Global_reactive_power, type = "l",
     ylab="Global_reactive_power", xlab = "datetime")
dev.copy(png,file="plot4.png", width=480, height=480)
dev.off()
