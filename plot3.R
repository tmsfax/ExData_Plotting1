# Read the data into a data frame.
# For best speed, I'm only reading a subset of the data.
# The subset was determined with the following code:
#   d <- read.table("household_power_consumption.txt", sep = ";", na.strings = "?", header = TRUE)
#   ss <- d$Date == "1/2/2007" | d$Date == "2/2/2007"
#   ss2 <- seq_along(ss)[ss]
#   min(ss2)
#   max(ss2) - min(ss2)
columnnames <- c(
    "Date",
    "Time",
    "Global_active_power",
    "Global_reactive_power",
    "Voltage",
    "Global_intensity",
    "Sub_metering_1",
    "Sub_metering_2",
    "Sub_metering_3"
    )

d <- read.table(
    "household_power_consumption.txt",
    sep = ";",
    na.strings = "?",
    skip = 66637,
    nrows = 2880,
    col.names = columnnames
    )

# Create a new column that combines the date and time using the POSIXlt class.
d$DateTime <- strptime(paste(d$Date, d$Time, sep = " "), "%d/%m/%Y %H:%M:%S")

# Prepare the PNG device that will hold the graph.
png("plot3.png")


# Construct the desired plot.

linenames <- c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
linecolors <- c("black", "red", "blue")


plot(
    d$DateTime,
    d$Sub_metering_1,
    type = "n",
    ylab = "Energy sub metering",
    xlab = ""
    )

lines(
    d$DateTime,
    d$Sub_metering_1,
    col = "black"
)

lines(
    d$DateTime,
    d$Sub_metering_2,
    col = "red"
)

lines(
    d$DateTime,
    d$Sub_metering_3,
    col = "blue"
)

legend(
    "topright",
    legend = linenames,
    col = linecolors,
    lty = "solid"
    )

# Write the PNG to disk.
dev.off()




