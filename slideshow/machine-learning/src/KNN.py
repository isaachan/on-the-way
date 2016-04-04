from numpy import *
import operator

def classify0(inX, dataSet, labels, k):
    datasetSize = dataSet.shape[0]
    distances = ((tile(inX, (datasetSize, 1)) - dataSet) ** 2).sum(axis=1)
    distances = distances ** 0.5
    sortedDistanceIndies = distances.argsort()
    
    classCount = {}
    for i in range(k):
        voteLabel = labels[sortedDistanceIndies[i]]
        classCount[voteLabel] = classCount.get(voteLabel, 0) + 1

    sortedClassCount = sorted(classCount.iteritems(), operator.itemgetter(1), reverse=True)
    return sortedClassCount[0][0]

