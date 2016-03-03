import requests
import base64
import json
import os
import numpy as np
import codecs
import unittest

class AudioToTextRequest:
	API_URL   = 'https://openapi.baidu.com/oauth/2.0/token?grant_type=client_credentials&client_id={0}&client_secret={1}'
        CLIENT_ID = 'j43LMaLBD30gQ5GTtOGjzigL'
	APP_KEY   = 'fa8525a54a70971e06a97276cc409491'
 
	def __init__(self, voiceFilePath="voice.wav", rate="8000"):
		self.format = "wav"
		self.rate = rate
		self.channel = 1
		self.cuid = "jjj_dd"
		self.token = self.get_accesstoken()
		self.speech = self.get_speech(voiceFilePath)
		self.len = os.path.getsize(voiceFilePath)
		self.lan = "zh"

	def get_speech(self, voiceFilePath):	
		fh = open(voiceFilePath, 'r')
		return base64.b64encode(fh.read())

	def get_accesstoken(self):
		response = requests.get(self.API_URL.format(self.CLIENT_ID, self.APP_KEY)).text
		return json.loads(response)['access_token']

	def get_postdata(self):
		return json.dumps(self, default=lambda o: o.__dict__)

class Voice:
	API_URL = "http://vop.baidu.com/server_api"
	
	def __init__(self, voiceFilePath):
		self.voiceFilePath = voiceFilePath

	def totext(self):
		data = AudioToTextRequest(self.voiceFilePath).get_postdata()
		headers = {'content-type' : 'application/json', 'content-length' : len(data), 'keep-alive' : 'false'}
		response = requests.post(self.API_URL, data=data, headers=headers).text
		self.content = json.loads(response)['result']
                return self

	def saveto(self, resultFilePath="speech.txt"):
		f = codecs.open(resultFilePath, 'w', 'utf-8')
		for c in self.content:
			f.write(c)        
		f.close()

Voice('voice.wav').totext().saveto('speech.txt')
