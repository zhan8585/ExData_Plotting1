library(dplyr)
library(lubridate)
library(tidyr)

hpc = read.table("household_power_consumption.txt", header = T, sep = ";")
hpcf = filter(hpc, Date == "1/2/2007" | Date == "2/2/2007")
hpcf = hpcf %>% unite("time", Date:Time, sep = " ")
hpcf = hpcf %>% mutate(time = dmy_hms(time))
hpcf = mutate(hpcf, Global_active_power = as.numeric(levels(hpcf$Global_active_power)[hpcf$Global_active_power]))

png(filename = "plot2.png", width=480, height=480)
plot(hpcf$time, hpcf$Global_active_power, pch = "", type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")
dev.off()