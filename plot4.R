# Verify that file doesn't exists

if(!file.exists("exdata_data_household_power_consumption.zip")){
  
  #Downloading the .zip containing the dataset
  
  file_url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(file_url, "exdata_data_household_power_consumption.zip", method = "curl")
  
  # Unzipping the file
  
  unzip("exdata_data_household_power_consumption.zip")
  date_downloaded <- date()
}

#Importing data 
powc_data <- read.table("household_power_consumption.txt", sep = ";", header = TRUE, na.strings = "?")

#Before working, format Dates
powc_data$Date <- as.Date(powc_data$Date, "%d/%m/%Y")

#Filtering data and removing missing values
powc_data <- subset(powc_data,Date >= as.Date("2007-2-01") & Date <= as.Date("2007-2-02"))
powc_data <- na.omit(powc_data)

#Plotting
dateTime <- as.POSIXct(paste(powc_data$Date,powc_data$Time),tz = "UTC")

par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(powc_data, {
  plot(Global_active_power~dateTime, type="l", 
       ylab="Global Active Power (kilowatts)", xlab="")
  plot(Voltage~dateTime, type="l", 
       ylab="Voltage (volt)", xlab="")
  plot(Sub_metering_1~dateTime, type="l", 
       ylab="Global Active Power (kilowatts)", xlab="")
  lines(Sub_metering_2~dateTime,col='Red')
  lines(Sub_metering_3~dateTime,col='Blue')
  legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
         legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(Global_reactive_power~dateTime, type="l", 
       ylab="Global Rective Power (kilowatts)",xlab="")
})

# Saving to file
dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()
