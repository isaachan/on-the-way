posts <- read.csv("http://datasets.flowingdata.com/post-data.txt", sep=",", header=TRUE)

#install.packages("portfolio")
library(portfolio)

map.market(id=posts$id, area=posts$views, group=posts$category, color=posts$comments, main="FlowingData Map")
