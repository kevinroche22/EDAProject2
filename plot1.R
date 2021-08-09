## Load Data
NEI <- readRDS("exdata_data_NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("exdata_data_NEI_data/Source_Classification_Code.rds")

################################################################################
# Q: Have total emissions from PM2.5 decreased in the United States from 1999  #
# to 2008? Using the base plotting system, make a plot showing the total PM2.5 #
# emission from all sources for each of the years 1999, 2002, 2005, and 2008.  #
################################################################################

## Save as png
# png("plot1.png", width = 460, height = 480)

totalEmissions <- aggregate(Emissions ~ year, NEI, sum) # aggregate emissions by year
colours <- c("red", "yellow", "blue", "green") # set colours for barplot
with(totalEmissions, 
     barplot(height=Emissions/1000, names.arg = year, col = colours, 
             xlab = "Year", ylab = "Annual Emissions",
             main = expression('PM'[2.5]*' Emissions in the US from 1999 to 2008')))

# dev.off()

##########
# Answer #
##########

# We see that total emissions in the US have 
# indeed decreased from 1999 to 2008.


