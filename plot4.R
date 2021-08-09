## Load Packages
library(tidyverse)
library(ggplot2)

## Load Data
NEI <- readRDS("exdata_data_NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("exdata_data_NEI_data/Source_Classification_Code.rds")

##########################################################
# Across the United States, how have emissions from coal #
# combustion-related sources changed from 1999–2008?     #
##########################################################

## Save as png
#png("plot4.png", width = 460, height = 480)

coalSCC <- SCC[grep("(?i)coal", SCC$EI.Sector), "SCC"] # case insensitive will match coal, Coal, COAL, etc.
coalNEI <- NEI %>% 
        filter(SCC %in% coalSCC)
totalEmissionsCoal <- coalNEI %>% 
        group_by(year) %>% 
        summarise(Emissions = sum(Emissions))

totalEmissionsCoal %>% ggplot(aes(x = factor(year), y = round(Emissions/1000, 2), fill = factor(year), label = round(Emissions/1000, 2))) +
        geom_bar(stat = "identity") + 
        theme_bw() +
        xlab("Year") + 
        ylab("Annual Emissions in Kilotons") +
        geom_label(aes(fill = factor(year)), colour = "white", fontface = "bold", show.legend = FALSE) +
        ggtitle(expression('PM'[2.5]*' Emissions from Coal 1999 - 2008')) +
        guides(fill=guide_legend(title='Year'))

#dev.off()

##########
# Answer #
##########

# Emissions from coal were relatively constant from 1999-2005, but dropped
# drastically between 2005 and 2008.


