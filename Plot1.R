#import packages
library(dplyr)
#read data
NEI <- readRDS('summarySCC_PM25.rds')
#SCC <- readRDS('Source_Classification_Code.rds')
#get emissions total by year
by_year <- NEI %>% group_by(year) %>% summarise(Emissions=sum(Emissions))

#create barplot
barplot(by_year$Emissions, names.arg = by_year$year, main=" Total PM 2.5 Emission", 
        ylab='PM 2.5 in tons')

dev.copy(png, file = "Plot1.png")
dev.off()
  