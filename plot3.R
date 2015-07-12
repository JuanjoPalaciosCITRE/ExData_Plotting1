library(plyr)
library(lubridate)

# Load input file from unzipped file in local directory
# (need to setwd() to the directory where file was unzipped)

indata<-read.table("household_power_consumption.txt", sep = ";", header = TRUE)

# As Date and Time are factors, converting both to Dates with lubridate functions
indata$Fdate<-dmy_hms(paste(as.character(indata$Date), as.character(indata$Time)))


# Select the data within the date period
begin<-ymd_hms("2007-02-01 00:00:00")
End<-ymd_hms("2007-02-02 23:59:59")
period<-interval(begin, End)

selected<-indata$Fdate %within% period
graphData<-indata[selected,]

# Convert graph variables to numeric from factor format
graphData$Sub_metering_1<-as.numeric(as.character(graphData$Sub_metering_1))
graphData$Sub_metering_2<-as.numeric(as.character(graphData$Sub_metering_2))
graphData$Sub_metering_3<-as.numeric(as.character(graphData$Sub_metering_3))

# Plot Graphic 3 (Energy Sub Metering) on PNG file
png(file="plot3.png", width = 480, height = 480, units = "px")
with(graphData, plot(Fdate, Sub_metering_1, type = "n", xlab = "", ylab = "Energy sub metering"))
with(graphData, lines(Fdate, Sub_metering_1))
with(graphData, lines(Fdate, Sub_metering_2, col = "red"))
with(graphData, lines(Fdate, Sub_metering_3, col = "blue"))
legend("topright", pch = "---", col = c(1, 2, 4), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()