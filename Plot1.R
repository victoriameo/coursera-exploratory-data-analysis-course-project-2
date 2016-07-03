{if (!file.exists("data")){
        dir.create("data")}
}

dataset_url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download(dataset_url, dest = "data.zip", mode = "wb")
unzip("data.zip", exdir = "C:/Users/Vicky/Desktop/data/data")


{setwd("C:/Users/Vicky/Desktop/data/data")}

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

totalEmissions <- tapply(NEI$Emissions, NEI$year, sum)

png('Plot1.png')
barplot(totalEmissions, xlab = "Year", ylab = "Total Emission (ton)", 
        main = "Total Emission per year")
dev.off()


        

        