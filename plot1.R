library(dplyr)

# check if directory exists and create if not true
if(!file.exists("graphdir")) {
  dir.create("graphdir")
  
  # Download the file to the created directory, record download date/time
  fileUrl = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(fileUrl, "graphdir/powerdata.zip", method = "curl")
  dateDownloaded<-date()
  
  #unzip file into directory
  setwd("graphdir")
  unzip("powerdata.zip")
}

# load the power consumption data into memory in a data frame named "indata"
# leave the date/time columns as characters in the load and change the "?"
# characters indicating missing data to NAs
indata<-read.csv("household_power_consumption.txt", header = TRUE, na.strings = "?", sep = ";", stringsAsFactors = FALSE)

# As date columns have been loaded as character variables, I need to transform the data
# and produce a date/time column to select the wanted dates
# First I produce a vector with POSIXlt variables
graphDates<-as.POSIXct(paste(indata$Date, indata$Time), format = "%d/%m/%Y %H:%M:%S")

# I bind the new column and subset the data frame to obtain the table I need
# Then subset the table removing unwanted columns (character Date and Time)
# I remove the unwanted objects so I do not collapse memory
graphData<-cbind(graphDates, indata)
graphData<-subset(graphData, select = -c(Date, Time))
rm(indata, graphDates)
# Select the records with the correct dates to compute
beginDate<-as.POSIXct("2007-02-01")
endDate<-as.POSIXct("2007-02-02")
graphData<-subset(graphData, graphDates >= beginDate & graphDates <= endDates )
# Remove NAs
sindatos<-is.na(graphData$Global_active_power)
grafico1<-graphData$Global_active_power[!sindatos]

# Plot graph
hist(grafico1, col = "red", xlab = "Global Active Power(kilowatts)", main = "Global Active Power")




