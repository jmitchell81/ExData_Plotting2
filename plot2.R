# Have total emissions from PM2.5 decreased in the Baltimore City, Maryland 
# (fips == "24510") from 1999 to 2008? 
# Use the base plotting system to make a plot answering this question.

library(dplyr)

NEI <- readRDS("data/summarySCC_PM25.rds")
SCC <- readRDS("data/Source_Classification_Code.rds")

# Subsetting NEI data frame to only the Baltimore city data

baltimore <- NEI[NEI$fips == "24510",]

baltimore_summary <- baltimore %>% group_by(year, Pollutant) %>%
  summarise(mean.emmisions = mean(Emissions, na.rm = TRUE),
            sd.emmision = sd(Emissions, na.rm = TRUE))

png("plot2.png")
barplot(baltimore_summary$mean.emmisions ~ baltimore_summary$year,
        ylim = c(0, 12),
        ylab = "Mean PM2.5 emitted (tons)",
        xlab = "Year",
        main = "Total PM2.5 Emission: Baltimore")
dev.off()

# PM2.5 emissions have decreased over time in Baltimore City