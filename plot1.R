## Read in data
setwd("/home/user/Documents/coursera/exploratory\ analysis/assignments/ExData_Assignment2")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

emission_totals <- data.frame(year=as.integer(), total_emissions=as.numeric())

for (year in unique(NEI$year)) {
  total <- with(subset(NEI, year=year), sum(Emissions))
  emission_totals[nrow(emission_totals)+1] <- t(c(year, total))
}