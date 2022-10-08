### libraries
library(dplyr)
library(ggplot2)

### Directory
# setwd("C:/Users/SW283QC/OneDrive - EY/Docs/Course Manuals/R_programming/exploratory_analysis/course project 2/ExploratoryAnalysis_CP2")

### READ inputs
pm25_summary <- readRDS("../exdata_data_NEI_data/summarySCC_PM25.rds")
src_class_code <- readRDS("../exdata_data_NEI_data/Source_Classification_Code.rds")

### TASK: Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?

### get source codes for coal combustion
# the aim is to get sources that has combustion and coal in the same value of EI.SEctor
coal_data <- src_class_code %>% filter(grepl("comb.*coal", EI.Sector, ignore.case = TRUE)) %>% inner_join(pm25_summary)

### input data for plot # calculating total emissions
plot_data <- coal_data %>% group_by(year) %>% summarise(Total_Emission=sum(Emissions))
plot_data$year <- factor(plot_data$year, levels = sort(unique(plot_data$year)))

### Plot
ggplot(data = plot_data, aes(x=year, y=Total_Emission)) + geom_point(shape=8) + geom_line(group=1) + theme_bw() + xlab("Year") + ylab("Total Emission") + ggtitle("Total emission from coal combustion related sources")
ggsave(filename = "plot4.png", width = 6, height = 4.5, units = "in")
