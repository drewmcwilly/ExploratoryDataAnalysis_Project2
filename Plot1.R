#download zip folde, Unzip files and read into data frame  
    Zfile<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
    download.file(Zfile,destfile="exdata-data-NEI_data.zip")
    unzip("exdata-data-NEI_data.zip")
    Em_dat <- readRDS("summarySCC_PM25.rds")
    Code_dat <- readRDS("Source_Classification_Code.rds")
    
#calculate total emissions levels    
    Sum_emit<-with(Em_dat,tapply(Emissions, year, sum))
# prepare plot to print ot png file.
#plot with be a bar plot with a trend line
    png("plot1.png", width = 800, height = 800)
    barplot(Sum_emit/1000, col=c("purple","green", "blue", "red"), main="Total Pm2.5 Emissions by year", xlab="Year", ylab="Emisions Levels (in 1000s)")
    lines(Sum_emit/1000, col="black",type="b", lwd=4, pch=20)
    dev.off()