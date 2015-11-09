hotdog_places <- read.csv("http://datasets.flowingdata.com/hot-dog-places.csv", sep=",", header=TRUE)
names(hotdog_places) <- 2000:2010
hotdog_matrix <- as.matrix(hotdog_places)
barplot(hotdog_matrix,
        border=NA,
	space=0.25,
	ylim=c(0, 200),
	xlab="Year",
	ylab="Hot dogs and buns (HDBs) eaten",
	main="Hot Dog Eating Contest Result, 2000-2010")