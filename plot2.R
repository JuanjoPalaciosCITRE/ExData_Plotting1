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

# Convert graph Data variables to numeric from factor format
graphData$Global_active_power<-as.numeric(as.character(graphData$Global_active_power))

# Plot Graphic 2 (Global Active Power - Line) on PNG file
png(file="plot2.png", width = 480, height = 480, units = "px")
with(graphData, plot(Fdate, Global_active_power, type="n", ylab = "Global active power(kilowatts)", xlab = ""))
lines(graphData$Fdate, graphData$Global_active_power)
dev.off()