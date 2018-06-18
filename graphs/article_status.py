#! /usr/bin/env python3
from BasicArticle.models import Articles
import requests 
import json
from itertools import groupby

def get_articlelist(data):
	data = list(data)
	create_list = []
	for i in range(0,len(data)):
		if (data[i]['referer'] == "http://localhost:8000/community-article-create/"):
			create_list.append(int(data[i]['event']['article-id']))
			print("\n\n\n\n\n\n",int(data[i]['event']['article-id']),"\n\n\n\n\n\n\n\n")
	return create_list

def extract_state(article_list):
	article_list=list(article_list)
	article_state = []
	for i in range (0, len(article_list)):
		articles = Articles.objects.get(pk=int(article_list[i]))
		article_state.append(str(articles.state))
		print(article_state[i])
	return article_state

def freq_state(article_state):
	article_state=list(article_state)
	frequency = [len(list(group)) for key,group in groupby(article_state)]
	return frequency

def find_articles(user_id):
	url_api = 'http://localhost:8000/logapi/user/'+str(user_id)+'/event/article/view'
	result = requests.get(url_api)
	json_result = result.json()
	data = json_result["result"]
	##print("\n\n\n\n\n\n",len(data),"\n\n\n\n\n\n")
	article_list = get_articlelist(data)
	return article_list

def findstates(article_list):
	article_list=list(article_list)
	article_state = extract_state(article_list)
	article_state.sort()
	return article_state

def plot_data(article_state):
	state_frequency = freq_state(article_state)
	return state_frequency	

def labels(article_state):
	states = list(set(article_state))
	states.sort()
	return states

def top_articles(create_list):
	create_list=list(create_list)
	res = []
	viewcount = [] 
	for i in range (0,len(create_list)):
		url_api = 'http://localhost:8000/logapi/event/article/view/'+str(create_list[i])+'/'
		data = requests.get(url_api)
		data_json = data.json()
		res.append(list(data_json["result"]))
		ip = get_ip(res[i])
		viewcount.append([len(list(set(ip))),create_list[i]])
	top_view = sorted(viewcount, key=lambda l:l[1])
	if(len(top_view)>5):
		top_view = top_view[:5]
	return viewcount

def get_ip(data):
	data = list(data)
	ip = []
	for i in range(0,len(data)):
		ip.append(data[i]['session-id'])
	return ip

def published_articles(user):
	published = Articles.objects.all().filter(created_by = user)
	print(str(published))
