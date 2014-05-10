setwd("C:\\Users\\masahiro\\Videos\\Lecture\\2014 Data Science 4 Exploratory Data Analysis\\Assessment1\\exdata-data-household_power_consumption")

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
png("plot1.png" , width = 480, height = 480)

hist(dt$Global_active_power
     ,main="Global Active Power",xlab="Global Active Power (kilowatts)"
      ,col="red")

dev.off()
