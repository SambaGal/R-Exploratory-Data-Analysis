#import packages
library(dplyr)
library(ggplot2)
#read data
NEI <- readRDS('summarySCC_PM25.rds')
SCC <- readRDS('Source_Classification_Code.rds')

#find coal sources
coal <-  grep('coal', SCC$EI.Sector, ignore.case=TRUE)
coal_df <- SCC[coal,]
sources <- coal_df$SCC
#subset nei to coal related sources only
nei_coal <- subset(NEI, SCC %in% sources)

#get emissions total by year
by_year <- nei_coal %>% group_by(year) %>% summarise(Emissions=sum(Emissions))

#plot the data
barplot(by_year$Emissions, names.arg = by_year$year, main=" Total PM 2.5 Emission from Coal Combustion Sources", 
        ylab='PM 2.5 in tons')

dev.copy(png, file = "Plot4.png")
dev.off()