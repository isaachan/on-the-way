import requests
from requests.auth import HTTPBasicAuth
import json, os


#jira_url = 'https://jira.nioint.com'
#issue_key = 'PROJECT-123'
#username = 'your-email@example.com'
#api_token = 'your-api-token'


jira_url = os.getenv('JIRA_URL')
issue_key = os.getenv('ISSUE_KEY')
username = os.getenv('JIRA_USERNAME')
api_token = os.getenv('JIRA_API_TOKEN')

url = f'{jira_url}/rest/api/2/issue/{issue_key}'

# 发送请求
response = requests.get(url, auth=HTTPBasicAuth(username, api_token))

# 检查请求是否成功
if response.status_code == 200:
    issue_data = response.json()
    print(json.dumps(issue_data, indent=4))
else:
    print(f'Failed to fetch issue: {response.status_code}')
    print(response.text)
