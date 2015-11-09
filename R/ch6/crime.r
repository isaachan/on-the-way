crime <- read.csv("http://datasets.flowingdata.com/crimeRatesByState2005.csv", sep=",", header=TRUE)

plot(crime$murder, crime$burglary)

crime2 <- crime[crime$state != "District of Columbia",]
crime2 <- crime2[crime2$state != "United States",]

plot(crime2$murder, crime2$burglary)

plot(crime2$murder, crime2$burglary, xlim=c(0, 10), ylim=c(0, 1200))

scatter.smooth(crime2$murder, crime2$burglary, xlim=c(0, 10), ylim=c(0, 1200))

plot(crime2[,2:9])

pairs(crime2[,2:9], panel=panel.smooth)


