from django.shortcuts import render
from py_etherpad import EtherpadLiteClient
from django.conf import settings
from .models import EtherCommunity, EtherGroup

def create_community_ether(community):
    epclient = EtherpadLiteClient(settings.APIKEY, settings.APIURL)
    result =  epclient.createGroupIfNotExistsFor(community.id)
    EtherCommunity.objects.create(community=community, community_ether_id=result['groupID'])
    return


def create_group_ether(community_id, group):
    epclient = EtherpadLiteClient(settings.APIKEY, settings.APIURL)
    group_id = str(community_id) + str(group)
    result =  epclient.createGroupIfNotExistsFor(group_id)
    EtherGroup.objects.create(group=group, group_ether_id=result['groupID'])
    return