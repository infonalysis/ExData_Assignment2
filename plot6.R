## Load libraries
require("ggplot2")

## Read in data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Pre-process data
vehicle <- SCC[grepl("Highway Veh|Off-highway Gasoline|Off-highway Diesel", SCC$Short.Name, perl=TRUE),]  ## find SCCs about motor vehicles

vehicle_emissions <- NEI[NEI$SCC %in% vehicle$SCC & NEI$fips %in% c("24510", "06037"),]  ## subset emissions info to motor vehicles

## Calculate annual totals
emission_totals <- data.frame(year=as.character(), city=as.character(), total=as.integer(), stringsAsFactors=FALSE)

for (ayear in unique(vehicle_emissions$year)) {  ## for each year
	for (acity in as.character(unique(vehicle_emissions$fips))) {  ## and for each city
  total <- sum(with(vehicle_emissions, subset(Emissions, fips==acity & year==ayear)))  ## calculate total vehicle emissions for baltimore city and LA 
  emission_totals <- rbind(emission_totals, data.frame(year=as.character(ayear), city=as.character(acity), total=as.integer(total), stringsAsFactors=FALSE))  ## write to results data frame
	}
}


##  draw graph and save to png
png(file="plot6.png", width=504, height=504, bg="white")  ## engage png device

mf_labeller <- function(var, value){
    value <- as.character(value)
    if (var=="city") { 
        value[value=="24510"] <- "Baltimore City"
        value[value=="06037"]   <- "LA County"
    }
    return(value)
}

graph1 <- ggplot(emission_totals, aes(year, total)) + facet_grid(. ~ city, labeller=mf_labeller) + geom_bar(stat="identity", aes(fill=factor(year))) + xlab("Year") + ylab("PM 2.5 Emissions (tons)") + ggtitle("Comparison of Total PM 2.5 Emissions\nin Baltimore City, MD and Los Angeles County, CA")

print(graph1)

dev.off()  # ... and close device



