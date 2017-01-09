
plot1 <- function(){
 
## Read file, Gets working directory, sets clases, and just reads data for dates (1/2/2007 & 2/2/2007)
	directory<-getwd()
	file<-paste0(directory,"/household_power_consumption.txt")
	class<-c("character","character",rep("numeric",7))
	names<-names(read.table(file,header=TRUE,sep=";",nrow=1))  							##reads column names from txt file
	data<-read.table(file, header=TRUE, sep=";",colClasses=class,col.names= ,skip=66636,nrow=2880)	##reads select data into data table
	names(data)<- names													##renames columns

## Cleans Data - reformats Date and Time
	data<-transform(data,date_time=paste0(Date,"-",Time))				##Adds a column that combines the date and time
	data$date_time <- strptime(data$date_time,"%d/%m/%Y-%H:%M:%S")		##reformats the date_time column		
	data$Date<-as.Date(data$Date,"%d/%m/%Y")						##reformats the date column

## Generate Charts
	png(file="plot1.png")									## sets file name
	par(bg="gray")										##formats chart
	hist(data$Global_active_power,xlab="Global Active Power (kilowatts)", ylab= "Frequency",main="Global Active Power", col="red")
	dev.off()
}