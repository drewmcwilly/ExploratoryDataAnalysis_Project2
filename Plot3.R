library(ggplot2)
library(plyr)
#download zip folde, Unzip files and read into data frame  
    Zfile<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
    download.file(Zfile,destfile="exdata-data-NEI_data.zip")
    unzip("exdata-data-NEI_data.zip")
    Em_dat <- readRDS("summarySCC_PM25.rds")
    Code_dat <- readRDS("Source_Classification_Code.rds")
#subset data frame for only Baltimore City   
    Balt_dat<-subset(Em_dat, fips== "24510")
#split the data out by type and year   
    Bsplit<-ddply(Balt_dat,.(year,type),summarize, Emissions=sum(Emissions))
    
#build plot with ggplot2
    png("plot3.png", width = 800, height = 800)
    g<-ggplot(Bsplit, aes(year,Emissions))
    p<-g + geom_line(aes(color=type))+facet_grid(.~type)+labs(title="Baltimore City PM25 Emissions levels")+labs(x="Year")+scale_x_continuous(breaks=c(2000,2004,2008))+ scale_colour_discrete(name = "Source")
    print(p)
    dev.off()