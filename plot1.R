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

#Creating histogram

hist(powc_data$Global_active_power, main="Global Active Power", xlab = "Global Active Power (kilowatts)", col="red")

# Save file and close device
dev.copy(png,"plot1.png", width=480, height=480)
dev.off()

