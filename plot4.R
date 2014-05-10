### Script for PLOT4

# Loading library
library(data.table)

# Loading Data as data table
time<-system.time(dt<-fread("household_power_consumption.txt",na.strings="?"))
print(time)
str(dt)

# Coverting class 
dt[[1]]<-as.POSIXct(strptime(paste(dt[[1]],dt[[2]]),"%d/%m/%Y %H:%M:%S"))
for(i in 3:9) dt[[i]]<-as.numeric(dt[[i]])

# Subsetting
dt<-dt[(dt[[1]]>=as.POSIXct("2007-2-1"))&(dt[[1]]<as.POSIXct("2007-2-3"))]

# Making histgram to a png file
png("plot4.png" , width = 480, height = 480)

par(mfrow=c(2,2))

# Top Left
plot(x=dt$Date, y=dt$Global_active_power
     ,type="l", main="",xlab="",ylab="Global Active Power (kilowatts)",xaxt="n")
axis(side=1,at=c(as.POSIXct("2007-2-1"),as.POSIXct("2007-2-2"),as.POSIXct("2007-2-3")),labels=c("Thu","Fri","Sat"))

# Top Right
plot(x=dt$Date, y=dt$Voltage
     ,type="l", main="",xlab="datetime",ylab="Voltage",xaxt="n")
axis(side=1,at=c(as.POSIXct("2007-2-1"),as.POSIXct("2007-2-2"),as.POSIXct("2007-2-3")),labels=c("Thu","Fri","Sat"))

# Bottom Left
matplot(x=dt$Date, y=cbind(dt[[7]],dt[[8]],dt[[9]])
      ,type="l", lty=1, main="",xlab="",ylab="Energy sub metering"
      ,col=c("black","red","blue"),xaxt="n")
axis(side=1,at=c(as.POSIXct("2007-2-1"),as.POSIXct("2007-2-2"),as.POSIXct("2007-2-3")),labels=c("Thu","Fri","Sat"))
legend("topright",lty=1,col=c("black","red","blue"),legend=names(dt)[7:9],bty = "n")

# Bottom Right
plot(x=dt$Date, y=dt$Global_reactive_power
     ,type="l", main="",xlab="datetime",ylab="Global_reactive_power",xaxt="n")
axis(side=1,at=c(as.POSIXct("2007-2-1"),as.POSIXct("2007-2-2"),as.POSIXct("2007-2-3")),labels=c("Thu","Fri","Sat"))

dev.off()
