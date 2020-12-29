#import packages
library(dplyr)
#read data
NEI <- readRDS('summarySCC_PM25.rds')
#get Baltimore data
baltimore <-  filter(NEI, fips=='24510')
#get emissions total by year
by_year <- baltimore %>% group_by(year) %>% summarise(Emissions=sum(Emissions))
#create barplot
barplot(by_year$Emissions, names.arg = by_year$year, main=" Total PM 2.5 Emission Baltimore", 
        ylab='PM 2.5 in tons')

dev.copy(png, file = "Plot2.png")
dev.off()
