## Load Packages
library(tidyverse)
library(ggplot2)

## Load Data
NEI <- readRDS("exdata_data_NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("exdata_data_NEI_data/Source_Classification_Code.rds")

#################################################
# How have emissions from motor vehicle sources # 
# changed from 1999–2008 in Baltimore City?     #
#################################################

## Save as png
#png("plot5.png", width = 460, height = 480)

sccMV <- SCC[grep("(?i)vehicle", SCC$EI.Sector), "SCC"] # case insensitive catches vehicle, Vehicle, VEHICLE, etc.
MVEmissions <- NEI %>% 
        filter(SCC %in% sccMV & fips == "24510") %>%
        group_by(year) %>%
        summarise(Emissions = sum(Emissions))

MVEmissions %>% ggplot(aes(x = factor(year), y = Emissions, fill = factor(year), label = round(Emissions, 2))) +
        geom_bar(stat = "identity") + 
        theme_bw() +
        xlab("Year") + 
        ylab("Annual Emissions") +
        geom_label(aes(fill = factor(year)), colour = "white", fontface = "bold", show.legend = FALSE) +
        ggtitle(expression('PM'[2.5]*' Emissions from Vehicles in Baltimore 1999 - 2008')) +
        guides(fill=guide_legend(title='Year'))

#dev.off()

##########
# Answer #
##########

# Emissions from motor vehicles in Baltimore drastically
# decreased between 1999 and 2008