# Have total emissions from PM2.5 decreased in the United States from 1999 to 
# 2008? Using the base plotting system, make a plot showing the total PM2.5 
# emission from all sources for each of the years 1999, 2002, 2005, and 2008.

library(dplyr)

NEI <- readRDS("data/summarySCC_PM25.rds")
SCC <- readRDS("data/Source_Classification_Code.rds")

# new data frame of means per year
# due to the data frame being too large to plot without summarization
NEI_summary <- NEI %>% group_by(year, Pollutant) %>%
  summarise(mean.emmisions = mean(Emissions, na.rm = TRUE),
            sd.emmision = sd(Emissions, na.rm = TRUE))

png("plot1.png")
barplot(NEI_summary$mean.emmisions ~ NEI_summary$year,
        ylim = c(0, 8),
        ylab = "Mean PM2.5 emitted (tons)",
        xlab = "Year",
        main = "Total PM2.5 Emission: All Sources")
dev.off()

# Total emissions have decreased over time from 1999 to 2008