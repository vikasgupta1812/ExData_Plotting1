#Download the file
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

if (!file.exists("Dataset.zip")) {
  download.file(fileUrl, destfile = "Dataset.zip", method = "wget")
}


#Unzip the file.
if (!file.exists("household_power_consumption.txt")) {
  unzip("Dataset.zip", overwrite = TRUE)
}

#Load data from file
#df  <-  read.table('household_power_consumption.txt',header=T,sep=";",na.strings="?",nrows=10)
df  <-  read.table('household_power_consumption.txt',header=T,sep=";",na.strings="?")

#Convert date  to date classes using as.Date() function
df$Date  <- as.Date(df$Date,"%d/%m/%Y")

#dates for which the data is needed  2007-02-01 and 2007-02-02
dates  <- c("2007-02-01","2007-02-02")
dates  <- as.Date(dates)

#Take Subset of the dataset for specified dates
df1  <- subset(df,Date %in% dates)
#rm(df)

#Add the datetime column using Date & Time Columnns
#Code adaptes fom [StackOverflow Post](http://stackoverflow.com/a/5251189/2356016)

df1 <- within(df1, Datetime <- strptime(paste(as.character(df1$Date), df1$Time), format="%Y-%m-%d %H:%M:%S"))


#Plot the Graphs 
#========================================================
#Plot1: Histogram distribution of Global Active Power
png(filename = "plot1.png",width = 480, height = 480, units = "px")
par(mfrow=c(1,1))
hist(df1[,3],col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)", ylim = range(0,1200))
#dev.copy(png, filename = "plot1.png",width = 480, height = 480, units = "px")
dev.off()
