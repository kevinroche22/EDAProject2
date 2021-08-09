## Load Packages
library(tidyverse)
library(ggplot2)

## Load Data
NEI <- readRDS("exdata_data_NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("exdata_data_NEI_data/Source_Classification_Code.rds")

##########################################################################
# Of the four types of sources indicated by the type variable, which of  #
# these four sources have seen decreases in emissions from 1999–2008 for #
# Baltimore City? Which have seen increases in emissions from 1999–2008? #
# Use the ggplot2 plotting system to make a plot answer this question.   #
##########################################################################

## Save as png
#png("plot3.png", width = 460, height = 480)

totalEmissionsBaltimore <- NEI %>%
        filter(fips == "24510") %>% # filter on baltimore's fips code
        group_by(year, type) %>% # group by year AND type
        summarise(Emissions = sum(Emissions)) # sum of annual emissions by year and type

totalEmissionsBaltimore %>% ggplot(aes(x = factor(year), y = Emissions, fill = type)) +
        geom_bar(stat = "identity") + 
        facet_wrap(. ~ type, scales = "free_y") + 
        geom_smooth(method = "lm", aes(group = type), se = FALSE, col = "black") +
        theme_bw() +
        xlab("Year") + 
        ylab("Annual Emissions") +
        ggtitle(expression('PM'[2.5]*' Emissions in Baltimore by Type'))

#dev.off()

##########
# Answer #
##########

# Non-road, nonpoint and on-road types have seen decreases in emissions in 
# Baltimore from 1999-2008, while point type has seen increases in emissions.


