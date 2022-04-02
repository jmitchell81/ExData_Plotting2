# Across the United States, how have emissions from coal combustion-related 
# sources changed from 1999–2008?

library(ggplot2)
library(dplyr)

NEI <- readRDS("data/summarySCC_PM25.rds")
SCC <- readRDS("data/Source_Classification_Code.rds")

# retrieve classification codes for coal combustion
SCC_coal <- SCC[grepl("Coal$", SCC$EI.Sector),]

# Filter pollution data to coal sources only
NEI_coal <- NEI[NEI$SCC %in% SCC_coal$SCC,]

coal_summary <- NEI_coal %>% group_by(year) %>%
  summarise(mean.emissions = mean(Emissions, na.rm = TRUE),
            sd.emission = sd(Emissions, na.rm = TRUE))

ggplot(coal_summary, aes(x = year, y = mean.emissions)) +
  geom_point() +
  geom_line() +
  ylim(c(0, max(coal_summary$mean.emissions))) +
  ggtitle("PM2.5 Coal Emissions: All Counties") +
  ylab("Mean PM2.5 emitted (tons)") +
  xlab("Year")
ggsave("plot4.png")

# Coal emissions decreased from 1999 to 2002, but remained relatively consistent
# from 2002 to 2008.