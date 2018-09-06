from django.shortcuts import render
from py_etherpad import EtherpadLiteClient
from django.conf import settings
from .models import EtherCommunity

def create_community_ether(community):
    epclient = EtherpadLiteClient(settings.APIKEY, settings.APIURL)
    result =  epclient.createGroupIfNotExistsFor(community.id)
    EtherCommunity.objects.create(community=community, community_ether_id=result['groupID'])
    return

