import requests
import base64
import json
import os
import numpy as np
import codecs
import unittest

voiceFilePath = 'voice.wav'
fh = open(voiceFilePath, 'r')
speech = base64.b64encode(fh.read())

class AudioToTextRequest:
	def __init__(self):
		self.format = "wav"
		self.rate = 8000
		self.channel = 1
		self.cuid = "jjj_dd"
		self.token = self.get_accesstoken()
		self.speech = speech
		self.len = os.path.getsize(voiceFilePath)
		self.lan = "zh"

	def get_accesstoken(self):
		url = 'https://openapi.baidu.com/oauth/2.0/token?grant_type=client_credentials&client_id=j43LMaLBD30gQ5GTtOGjzigL&client_secret=fa8525a54a70971e06a97276cc409491'
		response = requests.get(url).text
		return json.loads(response)['access_token']
		

req = AudioToTextRequest()

data = json.dumps(req, default=lambda o: o.__dict__)

api_url = "http://vop.baidu.com/server_api"

headers = {'content-type' : 'application/json', 'content-length' : len(data), 'keep-alive' : 'false'}

re = requests.post(api_url, data=data, headers=headers).text
content = json.loads(re)

content = content['result']

f = codecs.open('report3.txt', 'w', 'utf-8')
for c in content:
    f.write(c)        
f.close()

