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
		print('greater, Number of results shown: ',len(top_view))
	return top_view

def get_article_name(article_list):
	article_list=list(article_list)
	article_name = []
	for article in article_list:
		obj_article = Articles.objects.get(pk = article)
		article_name.append(obj_article.title)
	return article_name
