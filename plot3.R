# Of the four types of sources indicated by the type (point, nonpoint, onroad,
# nonroad) variable, which of these four sources have seen decreases in 
# emissions from 1999–2008 for Baltimore City? Which have seen increases in 
# emissions from 1999–2008? Use the ggplot2 plotting system to make a plot 
# answer this question.

library(ggplot2)
library(dplyr)

NEI <- readRDS("data/summarySCC_PM25.rds")
SCC <- readRDS("data/Source_Classification_Code.rds")

# Subsetting NEI data frame to only the Baltimore city data

baltimore <- NEI[NEI$fips == "24510",]

baltimore_summary <- baltimore %>% group_by(year, type) %>%
  summarise(mean.emissions = mean(Emissions, na.rm = TRUE),
            sd.emission = sd(Emissions, na.rm = TRUE))

ggplot(baltimore_summary, aes(x = year, y = mean.emissions, col = type)) +
  geom_point() +
  geom_line() +
  ylim(c(0, max(baltimore_summary$mean.emissions))) +
  ggtitle("PM2.5 Emission Types: Baltimore") +
  ylab("Mean PM2.5 emitted (tons)") +
  xlab("Year")
ggsave("plot3.png")

# All have had overall decreases in the period of 1999 to 2008, but Point emissions
# had shown a mean increase between 2002 and 2005