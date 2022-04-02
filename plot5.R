# How have emissions from motor vehicle sources changed from 1999–2008 
# in Baltimore City?

library(ggplot2)
library(dplyr)

NEI <- readRDS("data/summarySCC_PM25.rds")
SCC <- readRDS("data/Source_Classification_Code.rds")

# retrieve classification codes for vehicle emission sources
SCC_vehicle <- SCC[grepl("*vehicle*", SCC$SCC.Level.Two, ignore.case = TRUE),]

# Subsetting NEI data frame to only the Baltimore city data
baltimore <- NEI[NEI$fips == "24510",]

# Filter pollution data to vehicle sources only
baltimore_vehicle <- baltimore[baltimore$SCC %in% SCC_vehicle$SCC,]

balt_vehicle_summary <- baltimore_vehicle %>% group_by(year) %>%
  summarise(mean.emissions = mean(Emissions, na.rm = TRUE),
            sd.emission = sd(Emissions, na.rm = TRUE))

ggplot(balt_vehicle_summary, aes(x = year, y = mean.emissions)) +
  geom_point() +
  geom_line() +
  ylim(c(0, max(balt_vehicle_summary$mean.emissions))) +
  ggtitle("PM2.5 Vehicle Emissions: Baltimore City") +
  ylab("Mean PM2.5 emitted (tons)") +
  xlab("Year")
ggsave("plot5.png")

# Motor vehicle emissions in Baltimore City have decreased from 1999 to 2008
# with the most substantial decrease occurung between 1999 and 2002.
