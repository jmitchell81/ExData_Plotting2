# Compare emissions from motor vehicle sources in Baltimore City with emissions
# from motor vehicle sources in Los Angeles County, California (fips == "06037").
# Which city has seen greater changes over time in motor vehicle emissions?

library(ggplot2)
library(dplyr)

NEI <- readRDS("data/summarySCC_PM25.rds")
SCC <- readRDS("data/Source_Classification_Code.rds")

# retrieve classification codes for vehicle emission sources
SCC_vehicle <- SCC[grepl("*vehicle*", SCC$SCC.Level.Two, ignore.case = TRUE),]

# Subsetting NEI data frame to only the Baltimore city data
baltimore <- NEI[NEI$fips == "24510",]

# Subsetting NEI data frame to only the LA County data
la_county <- NEI[NEI$fips == "06037",]

# Filter pollution data to vehicle sources only
baltimore_vehicle <- baltimore[baltimore$SCC %in% SCC_vehicle$SCC,]

la_vehicle <- la_county[la_county$SCC %in% SCC_vehicle$SCC,]

balt_vehicle_summary <- baltimore_vehicle %>% group_by(year) %>%
  summarise(mean.emissions = mean(Emissions, na.rm = TRUE),
            sd.emission = sd(Emissions, na.rm = TRUE))
balt_vehicle_summary$county <- "Baltimore City"

la_vehicle_summary <- la_vehicle %>% group_by(year) %>%
  summarise(mean.emissions = mean(Emissions, na.rm = TRUE),
            sd.emission = sd(Emissions, na.rm = TRUE))
la_vehicle_summary$county <- "Los Angeles County"

vehicle_summary <- rbind(balt_vehicle_summary, la_vehicle_summary)

ggplot(vehicle_summary, aes(x = year, y = mean.emissions, col = county)) +
  geom_point() +
  geom_line() +
  ylim(c(0, max(vehicle_summary$mean.emissions))) +
  ggtitle("PM2.5 Vehicle Emissions") +
  ylab("Mean PM2.5 emitted (tons)") +
  xlab("Year")
ggsave("plot6.png")

# Vehicle emissions have been decreasing in Baltimore City from 1999 to 2008 while
# LA county has consistently had higher vehicle emissions than Baltimore City,
# with emissions decreasing between 1999 and 2002 and rising from 2002 to 2008.