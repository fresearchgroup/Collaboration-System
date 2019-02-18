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
    return result['padID']
    
def create_article_ether_group(group_id, article):
    epclient = EtherpadLiteClient(settings.APIKEY, settings.APIURL)
    group = EtherGroup.objects.get(group=group_id)
    result =  epclient.createGroupPad(group.group_ether_id, article.id)
    EtherArticle.objects.create(article=article, article_ether_id=result['padID'])
    return result['padID']

def create_ether_user(user):
    epclient = EtherpadLiteClient(settings.APIKEY, settings.APIURL)
    result = epclient.createAuthorIfNotExistsFor(user.id, user.username)
    user = EtherUser.objects.create(user=user, user_ether_id= result['authorID'])
    return user



#session creation community

def create_session_community(request, community_id):
    epclient = EtherpadLiteClient(settings.APIKEY, settings.APIURL)
    ether_com = EtherCommunity.objects.get(community=community_id)
    ether_com = str(ether_com.community_ether_id)
    try:
        ether_user = EtherUser.objects.get(user=request.user)
    except Exception as e:
        ether_user = create_ether_user(request.user)
    ether_user = str(ether_user.user_ether_id)
    validUntil = int(time())+28800
    result = epclient.createSession(ether_com, ether_user, validUntil)
    return result['sessionID']


#pad operations


def getHTML(article):
    epclient = EtherpadLiteClient(settings.APIKEY, settings.APIURL)
    article = EtherArticle.objects.get(article=article)
    result =  epclient.getHtml(article.article_ether_id)
    return result['html']

# +++++++++++++++++++++++++++++++++++++++++++


def getText(article):
    epclient = EtherpadLiteClient(settings.APIKEY, settings.APIURL)
    article = EtherArticle.objects.get(article=article)
    result =  epclient.getText(article.article_ether_id)
    return result['text']

# +++++++++++++++++++++++++++++++++++++++++++

def deletePad(article):
    epclient = EtherpadLiteClient(settings.APIKEY, settings.APIURL)
    article = EtherArticle.objects.get(article=article)
    epclient.deletePad(article.article_ether_id)



#create session group

def create_session_group(request, group_id):
    epclient = EtherpadLiteClient(settings.APIKEY, settings.APIURL)
    ether_group = EtherGroup.objects.get(group=group_id)
    ether_group = str(ether_group.group_ether_id)
    ether_user = EtherUser.objects.get(user=request.user)
    ether_user = str(ether_user.user_ether_id)
    validUntil = int(time())+28800
    result = epclient.createSession(ether_group, ether_user, validUntil)
    return result['sessionID']


def get_pad_id(article_id):
    article = EtherArticle.objects.get(article=article_id)
    return article.article_ether_id


def get_pad_usercount(article_id):
    epclient = EtherpadLiteClient(settings.APIKEY, settings.APIURL)
    padid = get_pad_id(article_id)
    count = epclient.padUsersCount(padid)
    return count['padUsersCount']

def get_read_only_padid(article_id):
    epclient = EtherpadLiteClient(settings.APIKEY, settings.APIURL)
    padid = get_pad_id(article_id)
    readonlyid = epclient.getReadOnlyID(padid)
    return readonlyid['readOnlyID']

