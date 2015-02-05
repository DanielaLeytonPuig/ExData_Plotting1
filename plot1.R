unzip("exdata-data-household_power_consumption.zip")

## Reading DataSet
dataProject1 <- read.table("household_power_consumption.txt", header = T, sep = ';',na.strings = "?", stringsAsFactors = F)
## Convert Date
dataProject1$Date <- as.Date(dataProject1$Date, format = "%d/%m/%Y")

## Subsetting for the 2 days
dataTwoDays <- subset(dataProject1, subset = (Date >= "2007-02-01" & Date <= "2007-02-02"))
rm(dataProject1)

## Convert Time
dataTwoDays$Time<-format(dataTwoDays$Time, format="%H:%M:%S")

## Converting dates
DTmerge <- paste(dataTwoDays$Date, dataTwoDays$Time)
dataTwoDays$DTmerge <- as.POSIXct(DTmerge)

#plot1
hist(dataTwoDays$Global_active_power,col="RED", main="Global Active Power", xlab="Global Active Power (kilowatts)", ylim=c(0,1200) )
dev.copy(png,"plot1.png", height=480, width=480)
dev.off()