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
    BVeh_emit_DF<-subset(Em_dat, fips=="24510" & SCC %in% F_Codes$SCC)

#calculate total emissions levels    
    Sum_emit<-ddply(BVeh_emit_DF,.(year),summarize, Emissions=sum(Emissions))  
# prepare plot to print ot png file.
#plot with be a bar plot with a trend line
    png("plot5.png", width = 800, height = 800)
    g<-ggplot(Sum_emit, aes(year,Emissions))
    p<-g + geom_line(aes(color=year))+labs(title="Baltimore City Motor Vehicle Emissions Levels (1999-2008)")+labs(x="Year")+
        scale_colour_continuous(guide = FALSE)
    print(p)
    dev.off()