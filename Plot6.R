{if (!file.exists("data")){
        dir.create("data")}
}

dataset_url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download(dataset_url, dest = "data.zip", mode = "wb")
unzip("data.zip", exdir = "C:/Users/Vicky/Desktop/data/data")


{setwd("C:/Users/Vicky/Desktop/data/data")}

los <- subset(NEI, fips == "06037")

# subsetting SCC with vehicle values
vehicleMatches  <- grepl("vehicle", SCC$SCC.Level.Two, ignore.case=TRUE)
subsetSCC <- SCC[vehicleMatches, ]

# merging dataframes, adding city variable
dataBalt <- merge(balt, subsetSCC, by="SCC")
dataBalt$city <- "Baltimore City"
dataLos <- merge(los, subsetSCC, by="SCC")
dataLos$city <- "Los Angeles County"
data <- rbind(dataBalt, dataLos)

# summing emission data per year per type
data <- aggregate(Emissions ~ year + city, data, sum)

# plotting
png("Plot6.png")
g <- ggplot(data, aes(year, Emissions, color = city))
g + geom_line() +
        xlab("Year") +
        ylab(expression("Total PM"[2.5]*" Emissions")) +
        ggtitle("Total Emissions from motor sources in Baltimore and Los Angeles")
print(g)
dev.off()