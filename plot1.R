library(dplyr)
library(lubridate)

hpc = read.table("household_power_consumption.txt", header = T, sep = ";")

hpc = mutate(hpc, Date = dmy(Date))
hpcf = filter(hpc, Date == "2007-02-01" | Date == "2007-02-02")
hpcf = mutate(hpcf, Global_active_power = as.numeric(levels(hpcf$Global_active_power)[hpcf$Global_active_power]))

png(filename = "plot1.png", width=480, height=480)
hist(hpcf$Global_active_power, xlab = "Global Active Power (kilowatts)", col = "red", main = "Global Active Power")
dev.off()