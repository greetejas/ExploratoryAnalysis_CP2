### libraries
library(dplyr)
library(ggplot2)

### Directory
# setwd("C:/Users/SW283QC/OneDrive - EY/Docs/Course Manuals/R_programming/exploratory_analysis/course project 2/ExploratoryAnalysis_CP2")

### READ inputs
pm25_summary <- readRDS("../exdata_data_NEI_data/summarySCC_PM25.rds")
src_class_code <- readRDS("../exdata_data_NEI_data/Source_Classification_Code.rds")

### TASK: 
# Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles County, California (fips == "06037"). 
# Which city has seen greater changes over time in motor vehicle emissions?

### get source codes for motor vehicles and relevant emissions from  Baltimore city, Maryland and LA,California
# extract all the rows with mobile vehicles in EI Sector
vehicle_data <- src_class_code %>% filter(grepl("mobile.*vehicle", EI.Sector, ignore.case = TRUE)) %>% inner_join(pm25_summary) %>% filter(fips == "24510" | fips == "06037")

### input data for plot # calculating total emissions

plot_data <- vehicle_data %>% group_by(year, fips) %>% summarise(Total_Emission=sum(Emissions))
plot_data$year <- factor(plot_data$year, levels = sort(unique(plot_data$year)))

plot_data$Place <- ifelse(plot_data$fips=="24510", "Baltimore City", "Los Angeles")

### Plot
ggplot(data = plot_data, aes(x=year, y=Total_Emission, col=Place, group=Place)) + geom_point(shape=8) + geom_line() + theme_bw() + xlab("Year") + ylab("Total Emission") + ggtitle("Total emission from Motor Vehicle sources", subtitle = "Baltimore City, Maryland vs. Los Angeles, California")
ggsave(filename = "plot6.png", width = 6, height = 4.5, units = "in")
