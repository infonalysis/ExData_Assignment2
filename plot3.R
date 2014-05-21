## Load libraries
require("ggplot2")

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
png(file="plot3.png", width=600, height=504, bg="white")  ## engage png device

graph1 <- ggplot(emission_totals, aes(year, total)) + facet_grid(. ~ type) + geom_bar(stat="identity", aes(fill=factor(year))) + xlab("Year") + ylab("PM 2.5 Emissions (tons)") + ggtitle("Total PM 2.5 Emissions in Baltimore City, MD Divided By Type")

print(graph1)

dev.off()  ## ... and close device
