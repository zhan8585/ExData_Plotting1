library(dplyr)
library(lubridate)
library(tidyr)

hpc = read.table("household_power_consumption.txt", header = T, sep = ";")
hpcf = filter(hpc, Date == "1/2/2007" | Date == "2/2/2007")
hpcf = hpcf %>% unite("time", Date:Time, sep = " ")
hpcf = hpcf %>% mutate(time = dmy_hms(time))

hpcf = mutate(hpcf, Global_active_power = as.numeric(levels(hpcf$Global_active_power)[hpcf$Global_active_power]))
hpcf = mutate(hpcf, Global_reactive_power = as.numeric(levels(hpcf$Global_reactive_power)[hpcf$Global_reactive_power]))
hpcf = mutate(hpcf, Voltage = as.numeric(levels(hpcf$Voltage)[hpcf$Voltage]))
hpcf = mutate(hpcf, Sub_metering_1 = as.numeric(levels(hpcf$Sub_metering_1)[hpcf$Sub_metering_1]))
hpcf = mutate(hpcf, Sub_metering_2 = as.numeric(levels(hpcf$Sub_metering_2)[hpcf$Sub_metering_2]))

png(filename = "plot4.png", width=480, height=480)
par(mfrow = c(2, 2))

plot(hpcf$time, hpcf$Global_active_power, pch = "", type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")

plot(hpcf$time, hpcf$Voltage, pch = "", type = "l", xlab = "datetime", ylab = "Voltage")

plot(hpcf$time, hpcf$Sub_metering_1, pch = "", type = "n", xlab = "", ylab = "Energy sub metering")
lines(hpcf$time, hpcf$Sub_metering_1)
lines(hpcf$time, hpcf$Sub_metering_2, col = "red")
lines(hpcf$time, hpcf$Sub_metering_3, col = "blue")
legend("topright", lwd = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

plot(hpcf$time, hpcf$Global_reactive_power, pch = "", type = "l", xlab = "", ylab = "Global_reactive_power")

dev.off()
