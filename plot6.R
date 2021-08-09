## Load Packages
library(tidyverse)
library(ggplot2)

## Load Data
NEI <- readRDS("exdata_data_NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("exdata_data_NEI_data/Source_Classification_Code.rds")

#############################################################################
# Compare emissions from motor vehicle sources in Baltimore City with       #
# emissions from motor vehicle sources in Los Angeles County, California.   #
# Which city has seen greater changes over time in motor vehicle emissions? #
#############################################################################

## Save as png
#png("plot6.png", width = 460, height = 480)

fips <- data.frame(fips = c("06037", "24510"), county = c("Los Angeles", "Baltimore"))

sccMV <- SCC[grep("(?i)vehicle", SCC$EI.Sector), "SCC"] # case insensitive catches vehicle, Vehicle, VEHICLE, etc.
MVEmissions <- NEI %>%
        filter(SCC %in% sccMV & fips %in% fips) %>%
        group_by(fips, year) %>%
        summarize(Emissions = sum(Emissions))
MVEmissions <- merge(MVEmissions, fips)

MVEmissions %>% ggplot(aes(x = factor(year), y = Emissions, fill = factor(year), label = round(Emissions, 2))) +
        geom_bar(stat = "identity") + 
        facet_wrap(. ~ county) + 
        geom_smooth(method = "lm", aes(group = county), se = FALSE, col = "black") +
        theme_bw() +
        xlab("Year") + 
        ylab("Annual Emissions") +
        ggtitle(expression('PM'[2.5]*' Emissions from Vehicles in Baltimore and LA 1999 - 2008')) +
        guides(fill=guide_legend(title='Year'))

#dev.off()

##########
# Answer #
##########

# Baltimore's vehicle emissions are about 1/10 that of LA's. Baltimore's
# emissions have been declining since 1999 while LA's rose from 1999-2005
# before declining in 2008.