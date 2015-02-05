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

#plot4
par (mfrow=c(2,2), mar = c(4,4,1,1), oma = c(0,0,2,0))
with(dataTwoDays, {
  plot(dataTwoDays$Global_active_power ~ dataTwoDays$DTmerge, type = "l", ylab = "Global Active Power", xlab = "")
  plot(dataTwoDays$Voltage ~ dataTwoDays$DTmerge, type = "l", ylab = "Voltage", , xlab = "datetime")
  with(dataTwoDays, {
    plot(Sub_metering_1 ~ DTmerge, type = "l", ylab = "Energy Sub metering", xlab = "")
    lines(Sub_metering_2 ~ DTmerge, col = 'Red')
    lines(Sub_metering_3 ~ DTmerge, col = 'Blue')
  })
  legend("topright", col = c("black", "red", "blue"), lty = 1, lwd = 2,  cex = 0.7, legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(dataTwoDays$Global_reactive_power ~ dataTwoDays$DTmerge, type = "l", ylab = "Global_Reactive_Power", , xlab = "datetime")
})

dev.copy(png,"plot4.png", height=480, width=480)
dev.off()