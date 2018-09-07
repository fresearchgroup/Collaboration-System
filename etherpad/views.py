from django.shortcuts import render
from py_etherpad import EtherpadLiteClient
from django.conf import settings
from .models import EtherCommunity, EtherGroup, EtherArticle, EtherUser
from time import time

def create_community_ether(community):
    epclient = EtherpadLiteClient(settings.APIKEY, settings.APIURL)
    result =  epclient.createGroupIfNotExistsFor(community.id)
    EtherCommunity.objects.create(community=community, community_ether_id=result['groupID'])
    return


def create_group_ether(group):
    epclient = EtherpadLiteClient(settings.APIKEY, settings.APIURL)
    group_id = 'group' + str(group.id)
    result =  epclient.createGroupIfNotExistsFor(group_id)
    EtherGroup.objects.create(group=group, group_ether_id=result['groupID'])
    return

def create_article_ether_community(community_id, article):
    epclient = EtherpadLiteClient(settings.APIKEY, settings.APIURL)
    community = EtherCommunity.objects.get(community=community_id)
    result =  epclient.createGroupPad(community.community_ether_id, article.id)
    EtherArticle.objects.create(article=article, article_ether_id=result['padID'])
    return
    
def create_article_ether_group(group_id, article):
    epclient = EtherpadLiteClient(settings.APIKEY, settings.APIURL)
    group = EtherGroup.objects.get(group=group_id)
    result =  epclient.createGroupPad(group.group_ether_id, article.id)
    EtherArticle.objects.create(article=article, article_ether_id=result['padID'])
    return

def create_ether_user(user):
    epclient = EtherpadLiteClient(settings.APIKEY, settings.APIURL)
    result =  epclient.createAuthorIfNotExistsFor(user.id, user.username)
    EtherUser.objects.create(user=user, user_ether_id= result['authorID'])
    return



#session creation

def create_session_community(request, community_id):
    epclient = EtherpadLiteClient(settings.APIKEY, settings.APIURL)
    ether_com = EtherCommunity.objects.get(community=community_id)
    ether_com = str(ether_com.community_ether_id)
    ether_user = EtherUser.objects.get(user=request.user)
    ether_user = str(ether_user.user_ether_id)
    validUntil = int(time())+28800
    result = epclient.createSession(ether_com, ether_user, validUntil)
    return result['sessionID']


#pad operations


def getHTML(article):
	epclient = EtherpadLiteClient(settings.APIKEY, settings.APIURL)
	result =  epclient.getHtml(article.id)
	return result['html']

# +++++++++++++++++++++++++++++++++++++++++++


def getText(article):
	epclient = EtherpadLiteClient(settings.APIKEY, settings.APIURL)
	result =  epclient.getText(article.id)
	return result['text']

# +++++++++++++++++++++++++++++++++++++++++++

def deletePad(article):
	epclient = EtherpadLiteClient(settings.APIKEY, settings.APIURL)
	epclient.deletePad(article.id)