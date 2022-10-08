### libraries
library(dplyr)

### Directory
# setwd("C:/Users/SW283QC/OneDrive - EY/Docs/Course Manuals/R_programming/exploratory_analysis/course project 2/ExploratoryAnalysis_CP2")

### READ inputs
pm25_summary <- readRDS("../exdata_data_NEI_data/summarySCC_PM25.rds")
src_class_code <- readRDS("../exdata_data_NEI_data/Source_Classification_Code.rds")

### TASK: 
# Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008? 
# Use the base plotting system to make a plot answering this question.

# subset data for Baltimore city, Maryland based on fips=24510
pm25_bmc <- pm25_summary %>% filter(fips == "24510")

### input data for plot
plot_data <- pm25_maryland %>% group_by(year) %>% summarise(Total_Emission=sum(Emissions))

png(file="plot2.png")
plot(x=plot_data$year, y=plot_data$Total_Emission, type = "b", xlab = "Year", ylab = "Total Emission", main = "Total emission across the time points", sub = "Baltimore City, Maryland", pch=8, xaxt="n")
axis(1, at=plot_data$year, labels=plot_data$year)
dev.off()