birth <- read.csv("http://datasets.flowingdata.com/birth-rate.csv")
stem(birth$X2008)

hist(birth$X2008, breaks=20)

