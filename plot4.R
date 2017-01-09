
plot4 <- function(){
 
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
	leglabels<-c("Sub_metering_1","Sub_metering_2","Sub_metering_3")
	png(file="plot4.png",width=480,height=480)					##sets file name
	par(bg="gray",mfrow=c(2,2))								##add gray to background and creates 2x2 matrix for plots
	
	##plot1
	with(data,plot(date_time,Global_active_power,type="l",xlab="",		
		ylab="Global Active Power"))
	
	##plot2
	with(data,plot(date_time,Voltage,type="l",xlab="datetime",		
		ylab="Global Active Power"))
	
	##plot3
	with(data,plot(date_time,Sub_metering_1,type="l",xlab="",
		ylab="Energy sub metering"))
	with(data,lines(date_time,Sub_metering_2,col="red"))
	with(data,lines(date_time,Sub_metering_3,col="blue"))
	legend("topright",bty="n",leglabels,lty=rep(1,3),col=c("black","red","blue"))
	
	##plot4
	with(data,plot(date_time,Global_reactive_power,type="l",xlab="datetime"))

	dev.off()
}