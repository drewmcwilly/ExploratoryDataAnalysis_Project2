#download zip folde, Unzip files and read into data frame  
    Zfile<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
    download.file(Zfile,destfile="exdata-data-NEI_data.zip")
    unzip("exdata-data-NEI_data.zip")
    Em_dat <- readRDS("summarySCC_PM25.rds")
    Code_dat <- readRDS("Source_Classification_Code.rds")

#find coal and combustion records in Code_dat
    comb_text<-grep("Comb",Code_dat$SCC.Level.One)
    coal_text<-grep("Coal",Code_dat$SCC.Level.Three)
    int_Text<-intersect(comb_text,coal_text)
    F_Codes<-Code_dat[c(int_Text),]
#subset Emissions data on coal combustion codes
    Coal_emit_DF<-subset(Em_dat, SCC %in% F_Codes$SCC)
    
#calculate total emissions levels    
    Sum_emit<-with(Coal_emit_DF,tapply(Emissions, year, sum))    
# prepare plot to print ot png file.
#plot with be a bar plot with a trend line
    png("plot4.png", width = 800, height = 800)
    barplot(Sum_emit/1000, col=c("purple","green", "blue", "red"), main="Coal Combustion Emissions by year", xlab="Year", ylab="Emisions Levels (in 1000s)")
    lines(Sum_emit/1000, col="black",type="b", lwd=4, pch=20)
    dev.off()