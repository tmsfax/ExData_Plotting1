# Read the data from the file.
readData = function() {

    setwd("~/Documents")

    # skip, nrows, and columnNames were determined with this code:
    # data = read.table("household_power_consumption.txt", sep = ";", na.strings = "?", header = TRUE, colClasses = "character")
    # desiredDataIndices = seq_along(data$Date)[data$Date == "1/2/2007" | data$Date == "2/2/2007"]
    # skip = min(desiredDataIndices)
    # nrows = max(desiredDataIndices) - skip + 1
    # columnNames = names(data)

    skip = 66637
    nrows = 2880
    columnNames = c(
        "Date",
        "Time",
        "Global_active_power",
        "Global_reactive_power",
        "Voltage",
        "Global_intensity",
        "Sub_metering_1",
        "Sub_metering_2",
        "Sub_metering_3")

    data = read.table(
        "household_power_consumption.txt",
        sep = ";",
        na.strings = "?",
        skip = skip,
        nrows = nrows,
        col.names = columnNames)
    data = transform(data, datetime = strptime(paste(data$Date, data$Time), "%d/%m/%Y %T"))
    data
}

# Read the data from the file.
data = readData()

# Plot a x-y line drawing on a PNG device.
png("plot4.png")
par(mfcol = c(2, 2))

colors = c("black", "red", "blue")
columns = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")

# Plot an x-y line drawing.
plot(
    data$datetime,
    data$Global_active_power,
    type = "l",
    xlab = "",
    ylab = "Global Active Power")

plot(
    data$datetime,
    data$Sub_metering_1,
    type = "n",
    xlab = "",
    ylab = "Energy sub metering")

lines(
    x = data$datetime,
    data$Sub_metering_1,
    col = colors[1])
lines(
    data$datetime,
    data$Sub_metering_2,
    col = colors[2])
lines(
    data$datetime,
    data$Sub_metering_3,
    col = colors[3])

legend(
    "topright",
    columns,
    col = colors,
    lty = "solid",
    bty = "n")

with(
    data,
    plot(
        datetime,
        Voltage,
        type = "l"))

with(
    data,
    plot(
        datetime,
        Global_reactive_power,
        type = "l"))

dev.off()
