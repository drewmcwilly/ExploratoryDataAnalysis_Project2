library(ggplot2)
library(plyr)
#download zip folde, Unzip files and read into data frame  
    Zfile<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
    download.file(Zfile,destfile="exdata-data-NEI_data.zip")
    unzip("exdata-data-NEI_data.zip")
    Em_dat <- readRDS("summarySCC_PM25.rds")
    Code_dat <- readRDS("Source_Classification_Code.rds")

#find Vehicle records in Code_dat
    Veh_text<-grep("Vehicle",Code_dat$SCC.Level.Two)
    F_Codes<-Code_dat[c(Veh_text),]
#subset Emissions data on coal combustion codes
    BA_LA_DF<-subset(Em_dat,  SCC %in% F_Codes$SCC & fips=="24510" |fips=="06037" )
    BA_LA_DF$city<- ifelse(BA_LA_DF$fips=="24510","Baltimore City", "Los Angeles")
#calculate total emissions levels    
    Sum_emit<-ddply(BA_LA_DF,.(city, year),summarize, Emissions=sum(Emissions))  
# prepare plot to print ot png file.
#plot with be a bar plot with a trend line
    png("plot6.png", width = 800, height = 800)
    g<-ggplot(Sum_emit, aes(year,Emissions))
    p<-g+geom_bar(stat="identity")+facet_grid(city~.,scales="free")+geom_smooth(method="lm")+scale_x_continuous(breaks=c(1999,2002,2005,2008))+labs(title="Motor Vehicle Emissions Levels for Baltimore City and Los Angeles County")
    print(p)
    dev.off()