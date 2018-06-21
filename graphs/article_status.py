#! /usr/bin/env python3
from BasicArticle.models import Articles
from Community.models import CommunityArticles, Community
import requests 
import json
from itertools import groupby

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

def find_articles(user):
	user_articles = Articles.objects.all().filter(created_by = user)
	article_list  = []
	for obj in user_articles:
		article_list.append(int(obj.id))
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
	top_view = sorted(viewcount, key=lambda l:l[0], reverse= True)
	if(len(top_view)>5):
		top_view = top_view[:5]
		print('greater',len(top_view))
	return top_view

def get_ip(data):
	data = list(data)
	ip = []
	for i in range(0,len(data)):
		ip.append(data[i]['session-id'])
	return ip

def published_articles(user):
	user_articles = Articles.objects.all().filter(created_by = user)
	for obj in user_articles:
		print(str(obj.id))


def community_articles(community_id):
	articles = CommunityArticles.objects.all().filter(community_id = community_id)
	article_list = []
	for item in articles:
		article_list.append(item.id)
	return article_list

def topfive(article_list):
	views = []
	for item in article_list:
		article = Articles.objects.get(pk = item)
		view = article.views
		views.append([view,item])
	top_view = sorted(views, key=lambda l:l[0], reverse = True)
	if(len(top_view)>5):
		top_view = top_view[:5]
		print('greater',len(top_view))
	return top_view