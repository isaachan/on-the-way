import matplotlib
import matplotlib.pyplot as plt
from pylab import *
from numpy import *

movies = [[3,   104, 'love'],   \
          [2,   100, 'love'],   \
          [1,   81,  'love'],   \
          [101, 10,  'action'], \
          [99,  5,   'action'], \
          [98,  2,   'action']]

dataset = []
sizes   = []
colors  = []

for movie in movies:
    dataset.append(movie[0:-1])
    type = movie[-1:][0]
    sizes.append(60 if (type == 'love') else 120)
    colors.append('red' if (type == 'love') else 'blue')
 
dataset = array(dataset)

fig = plt.figure()
ax = fig.add_subplot(111)
ax.scatter(dataset[:,0], dataset[:,1], array(sizes), array(colors))

plt.savefig("images/movie-scatter.png")
