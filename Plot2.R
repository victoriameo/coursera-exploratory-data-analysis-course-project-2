{if (!file.exists("data")){
        dir.create("data")}
}

dataset_url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download(dataset_url, dest = "data.zip", mode = "wb")
unzip("data.zip", exdir = "C:/Users/Vicky/Desktop/data/data")


{setwd("C:/Users/Vicky/Desktop/data/data")}

# reading and subsetting data
balt <- subset(NEI, fips == "24510")

# summing emissions per year
totalEmissions <- tapply(balt$Emissions, balt$year, sum)

# plotting
png('plot2.png')
barplot(totalEmissions, xlab = "Year", ylab = "Total Emission (ton)", 
        main = "Total Emission per year in Baltimore")
dev.off()

