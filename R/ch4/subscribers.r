subscribers <- read.csv("http://datasets.flowingdata.com/flowingdata_subscribers.csv", sep=",", header=TRUE)

plot(subscribers$Subscribers, type="p", ylim=c(0, 30000))

plot(subscribers$Subscribers, type="h", ylim=c(0, 30000), xlab="Day", ylab="Subscribers")
points(subscribers$Subscribers, pch=19, col="green")
