## Load libraries
library("ggplot2")

## Read in data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Calculate annual totals
emission_totals <- data.frame(year=as.character(), type=as.character(), total=as.integer(), stringsAsFactors=FALSE)

for (ayear in unique(NEI$year)) {  ## for each year
	for (atype in as.character(unique(NEI$type))) {  ## and for each type
  		total <- round(sum(with(NEI, subset(Emissions, fips=="24510" & year==ayear & type==atype))))   ## calculate total emissions for baltimore city
  		emission_totals <- rbind(emission_totals, data.frame(year=as.character(ayear), type=as.character(atype), total=as.integer(total), stringsAsFactors=FALSE))  ## write to results data frame
	}
}

##  draw graph and save to png
png(file="plot3.png", width=504, height=504, bg="white")  ## engage png device

qplot(year, total, data=emission_totals, facets=. ~ type)

## barplot(emission_totals$total_emissions, names.arg=emission_totals$year, xlab="Year", ylab="PM 2.5 Emissions (tons)", main="Total PM 2.5 Emissions in Baltimore City, MD")  ## barplot
dev.off()  # ... and close device
