## Read in data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Pre-process data
coal <- SCC[grepl("[Cc]oal", SCC$Short.Name, perl=TRUE) & !grepl("[Cc]oal\\sMining", SCC$Short.Name, perl=TRUE),]  ## find SCCs about coal combustion

coal_emissions <- NEI[NEI$SCC %in% coal$SCC,]  ## subset emissions info to coal combustion

## Calculate annual totals
emission_totals <- data.frame(year=as.integer(), total_emissions=as.numeric())

for (ayear in unique(coal_emissions$year)) {  ## for each year
  total <- sum(with(coal_emissions, subset(Emissions, year==ayear)))  ## calculate total emissions due to coal combuston
    emission_totals[nrow(emission_totals)+1,] <- t(c(ayear, total))  ## write to results data frame
}

##  draw graph and save to png
png(file="plot4.png", width=504, height=504, bg="white")  ## engage png device
barplot(emission_totals$total_emissions, names.arg=emission_totals$year, xlab="Year", ylab="PM 2.5 Emissions (tons)", main="Total PM 2.5 Emissions in the U.S. Due to Coal Combustion ")  ## barplot
dev.off()  # ... and close device
