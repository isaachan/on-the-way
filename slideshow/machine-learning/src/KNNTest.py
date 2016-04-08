import unittest
from KNN import *

class KNNTest(unittest.TestCase):

    dataset = array([[3, 104], [2, 100], [1, 81], [101, 10], [99, 5], [98, 2]])
    labels = ['love', 'love', 'love', 'action', 'action', 'action']
        
    def test_knn_classify0_1(self):
        result = classify0([18, 90], KNNTest.dataset, KNNTest.labels, 3)
        self.assertEqual('love', result)

    def test_knn_classify0_2(self):
        result = classify0([90, 10], KNNTest.dataset, KNNTest.labels, 3)
        self.assertEqual('action', result)

    def test_norm_1(self):
        result = autonorm(array( \
                       [[0,  700,  0.2], \
                        [10, 200,  0.9], \
                        [5,  400,  0.3], \
                        [7,  1000, 0.1]]))
        self.assertEqual(0, result[0][0])
        self.assertEqual(1, result[1][0])
