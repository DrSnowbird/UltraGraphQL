import requests
import json

url = "http://0.0.0.0:8092/graphql"

payload="{\"query\":\"{\\n    ex_Person {\\n        _id\\n        ex_name\\n        ex_age\\n        ex_relatedWith{\\n            _id\\n            ex_name\\n        }\\n    }\\n}\",\"variables\":{}}"
headers = {
  'Accept': 'application/json',
  'Content-Type': 'application/json'
}

response = requests.request("POST", url, headers=headers, data=payload)

print(response.text)

