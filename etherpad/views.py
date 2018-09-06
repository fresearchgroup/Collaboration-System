from django.shortcuts import render
from py_etherpad import EtherpadLiteClient
from django.conf import settings
from .models import EtherCommunity, EtherGroup, EtherArticle, EtherUser

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
