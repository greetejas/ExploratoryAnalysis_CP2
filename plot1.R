### Directory
# setwd("C:/Users/SW283QC/OneDrive - EY/Docs/Course Manuals/R_programming/exploratory_analysis/course project 2/ExploratoryAnalysis_CP2")

### READ inputs
pm25_summary <- readRDS("../exdata_data_NEI_data/summarySCC_PM25.rds")
src_class_code <- readRDS("../exdata_data_NEI_data/Source_Classification_Code.rds")

### TASK: 
# Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
# Using the base plotting system, make a plot showing the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.

### libraries
library(dplyr)

### input data for plot
plot_data <- pm25_summary %>% group_by(year) %>% summarise(Total_Emission=sum(Emissions))

png(file="plot1.png")
plot(x=plot_data$year, y=plot_data$Total_Emission, type = "b", xlab = "Year", ylab = "Total Emission", main = "Total emission across the time points", pch=8, xaxt="n")
axis(1, at=plot_data$year, labels=plot_data$year)
dev.off()