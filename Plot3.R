#import packages
library(dplyr)
library(ggplot2)
#read data
NEI <- readRDS('summarySCC_PM25.rds')
#get Baltimore data
baltimore <-  filter(NEI, fips=='24510')
#group by year an type
by_year_type = baltimore %>% group_by(year, type) %>% summarise(Emissions=sum(Emissions))
#set up the plot
g <- ggplot(by_year_type, aes(x=factor(year),y=Emissions, fill=type)) +
  geom_bar(stat='identity', position='dodge') + xlab('Year')+
  ylab('PM 2.5 Emissions in tons') + ggtitle('Total PM 2.5 Emissions')+
  scale_fill_discrete('Source Type')
print(g)

dev.copy(png, file = "Plot3.png")
dev.off()