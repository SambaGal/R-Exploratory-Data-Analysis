#import packages
library(dplyr)
#read data
NEI <- readRDS('summarySCC_PM25.rds')
SCC <- readRDS('Source_Classification_Code.rds')
#get Baltimore data
baltimore <-  filter(NEI, fips=='24510')

#find motor vehicle sources
motor_vehicle <- grep('Vehicles', SCC$EI.Sector, ignore.case=TRUE)
motor_vehicle_df <- SCC[motor_vehicle,]
sources <- motor_vehicle_df$SCC

#subset NEI/baltimore to motor vehicle sources only
nei_motor_vehicle <- subset(baltimore, SCC %in% sources)

#get emissions total by year
by_year <- nei_motor_vehicle %>% group_by(year) %>% summarise(Emissions=sum(Emissions))

#plot the data
barplot(by_year$Emissions, names.arg = by_year$year, main=" Total PM 2.5 Emission from Motor Vehicle Sources in Baltimore", 
        ylab='PM 2.5 in tons')

dev.copy(png, file = "Plot5.png")
dev.off()