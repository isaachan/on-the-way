import matplotlib
import matplotlib.pyplot as plt
from pylab import *
from numpy import *

movies = [[3,   104, 'love'],   \
          [2,   100, 'love'],   \
          [1,   81,  'love'],   \
          [101, 10,  'action'], \
          [99,  5,   'action'], \
          [98,  2,   'action'], \
          [18,  90,  '??']]

typeColorMap = { 'love'  : 'red',
                 'action': 'blue',
                 '??'    : 'gray'}

dataset = []
sizes   = []
colors  = []

fig = plt.figure()
ax = fig.add_subplot(111)

for movie in movies:
    dataset.append(movie[0:-1])
    type = movie[-1:][0]
    sizes.append(120 if (type == '??') else 60)
    colors.append(typeColorMap[type])
    ax.annotate(movie[2], (movie[0]+2, movie[1]-1))
    
dataset = array(dataset)
ax.scatter(dataset[:,0], dataset[:,1], array(sizes), array(colors))

if len(sys.argv) == 2 and sys.argv[1] == '-save':
    plt.savefig("images/movie-scatter.png")
else:
    plt.show()
