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

##plot2 
plot(sub$datetime, sub$Global_active_power, type = "l",
     ylab="Global Active Power (kilowatts)",
     xlab = "")
dev.copy(png,file="plot2.png", width=480, height=480)
dev.off()
