{if (!file.exists("data")){
        dir.create("data")}
}

dataset_url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download(dataset_url, dest = "data.zip", mode = "wb")
unzip("data.zip", exdir = "C:/Users/Vicky/Desktop/data/data")


{setwd("C:/Users/Vicky/Desktop/data/data")}

vehicleMatches  <- grepl("vehicle", SCC$SCC.Level.Two, ignore.case=TRUE)
subsetSCC <- SCC[vehicleMatches, ]

# merging dataframes
NEISCC <- merge(balt, subsetSCC, by="SCC")

# summing emission data per year per type
totalEmissions <- tapply(NEISCC$Emissions, NEISCC$year, sum)

# plotting
png("Plot5.png", width=840, height=480)
barplot(totalEmissions, xlab = "Year", ylab = "Total Emission (ton)", 
        main = "Total Emission from motor sources in Baltimore")
dev.off()