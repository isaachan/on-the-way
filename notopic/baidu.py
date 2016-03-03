import requests
import base64
import json
import os
import numpy as np
import codecs
import unittest


class AudioToTextRequest:

	def __init__(self, voiceFilePath):
		self.format = "wav"
		self.rate = 8000
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
		url = 'https://openapi.baidu.com/oauth/2.0/token?grant_type=client_credentials&client_id=j43LMaLBD30gQ5GTtOGjzigL&client_secret=fa8525a54a70971e06a97276cc409491'
		response = requests.get(url).text
		return json.loads(response)['access_token']

	def get_postdata(self):
		return json.dumps(self, default=lambda o: o.__dict__)

class Voice:
	def __init__(self, voiceFilePath):
		self.voiceFilePath = voiceFilePath

	def totext(self):
		data = AudioToTextRequest(self.voiceFilePath).get_postdata()
		api_url = "http://vop.baidu.com/server_api"
		headers = {'content-type' : 'application/json', 'content-length' : len(data), 'keep-alive' : 'false'}
		re = requests.post(api_url, data=data, headers=headers).text
		content = json.loads(re)
		self.content = content['result']

	def saveto(self, resultFilePath):
		f = codecs.open(resultFilePath, 'w', 'utf-8')
		for c in self.content:
			f.write(c)        
		f.close()

Voice('voice.wav').totext().saveto('report3.txt')
