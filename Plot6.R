#import packages
library(dplyr)
library(ggplot2)
#read data
NEI <- readRDS('summarySCC_PM25.rds')
SCC <- readRDS('Source_Classification_Code.rds')
#get Baltimore data
baltimore <-  filter(NEI, fips=='24510')
los_angeles <- filter(NEI, fips=="06037")

balt_la <- filter(NEI, fips=='24510' | fips=='06037')

#find motor vehicle sources
motor_vehicle <- grep('Vehicles', SCC$EI.Sector, ignore.case=TRUE)
motor_vehicle_df <- SCC[motor_vehicle,]
sources <- motor_vehicle_df$SCC

#subset NEI/baltimore-LA to motor vehicle sources only
nei_motor_vehicle <- subset(balt_la, SCC %in% sources)


by_year_loc <- nei_motor_vehicle %>% group_by(year, fips) %>% summarise(Emissions=sum(Emissions))

#plot data
g <- ggplot(by_year_loc, aes(x=factor(year),y=Emissions, fill=fips)) +
  geom_bar(stat='identity', position='dodge') + xlab('Year')+
  ylab('PM 2.5 Emissions in tons') + ggtitle('Total PM 2.5 Emissions from Motor Vehicles Baltimore and Los Angeles')+
  scale_fill_discrete(name="Location", labels=c("Los Angeles", 'Baltimore'))
print(g)

dev.copy(png, file = "Plot6.png")
dev.off()