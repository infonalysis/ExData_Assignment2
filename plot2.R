## Read in data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Calculate annual totals
emission_totals <- data.frame(year=as.integer(), total_emissions=as.numeric())

for (ayear in unique(NEI$year)) {  ## for each year
  total <- sum(with(NEI, subset(Emissions, fips=="24510" & year==ayear)))  ## calculate total emissions for baltimore city
  emission_totals[nrow(emission_totals)+1,] <- t(c(ayear, total))  ## write to results data frame
}


##  draw graph and save to png
png(file="plot2.png", width=504, height=504, bg="white")  ## engage png device
barplot(emission_totals$total_emissions, names.arg=emission_totals$year, xlab="Year", ylab="PM 2.5 Emissions (tons)", main="Total PM 2.5 Emissions in Baltimore City, MD")  ## barplot
dev.off()  # ... and close device
