crime <- read.csv("http://datasets.flowingdata.com/crimeRatesByState2005.tsv", sep="\t", header=TRUE)

radius <- sqrt(crime$population / pi)
symbols(crime$murder, crime$burglary, circles=radius)
symbols(crime$murder, crime$burglary, circles=radius, inches=0.35, fg="white", bg="red", xlab="Murder Rate", ylab="Burglary Rate")
text(crime$murder, crime$burglary, crime$state, cex=0.5)


