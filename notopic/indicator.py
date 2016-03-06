import threading
import time
import sys
from voice2text import Voice

class Indicator (threading.Thread):

    def __init__(self):
        super(Indicator, self).__init__()
        self.stoprequest = threading.Event()
        
    def run(self):
        while (not self.stoprequest.isSet()):
            print "."
            time.sleep(1)
    
    def stop(self):
        self.stoprequest.set()
        self.join()

print "Begin convert voice.wav into text."
indicator = Indicator()
indicator.start()

Voice(sys.argv[1]).totext().saveto(sys.argv[2])

indicator.stop()
print "Convert voice.wav to text and save into speech.txt file."
