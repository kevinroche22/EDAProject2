## Load Packages
library(tidyverse)

## Load Data
NEI <- readRDS("exdata_data_NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("exdata_data_NEI_data/Source_Classification_Code.rds")

################################################################
# Have total emissions from PM2.5 decreased in the             #
# Baltimore City, Maryland from 1999 to 2008? Use the          #
# base plotting system to make a plot answering this question. #
################################################################

## Save as png
#png("plot2.png", width = 460, height = 480)

totalEmissionsBaltimore <- NEI %>%
        filter(fips == "24510") %>% # filter on baltimore's fips code
        group_by(year) %>%
        summarise(Emissions = sum(Emissions)) # sum of annual emissions
colours <- c("red", "yellow", "blue", "green") # set colours for barplot
with(totalEmissionsBaltimore,
     barplot(height=Emissions/1000, names.arg = year, col = colours, 
             xlab = "Year", ylab = "Annual Emissions",
             main = expression('PM'[2.5]*' Emissions in Baltimore from 1999 to 2008'))
)
#dev.off()

##########
# Answer #
##########

# We see that annual emissions in Baltimore have 
# indeed decreased from 1999 to 2008.


