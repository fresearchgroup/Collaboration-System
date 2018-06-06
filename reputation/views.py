from django.shortcuts import render
from .models import SystemRep,CommunityRep
from Community.models import CommunityArticles,CommunityGroups
from Group.models import GroupArticles
from BasicArticle.models import Articles


# Create your views here.

def CommunityReputation(request,a_id,type):
	commart = CommunityArticles.objects.filter(article_id=a_id).exists()
	art = Articles.objects.get(pk = a_id)
	author = art.created_by
	if(commart == False):
		grpart = GroupArticles.objects.get(article_id=a_id)
		grp = grpart.group
		community = CommunityGroups.objects.get(group_id=grp.id)
	else:
		commart = CommunityArticles.objects.get(article_id=a_id)
		community = commart.community

	commrep = CommunityRep.objects.get(community_id=community.id, user_id=author.id)
	sysrep = SystemRep.objects.get(user_id=author.id)
	if(type==1):
		commrep.rep+=1
		sysrep.sysrep+=1
	elif(type==3):
		commrep.rep-=1
		sysrep.sysrep-=1
	elif(type==2):
		commrep.rep+=2
		sysrep.sysrep+=2
	elif(type==4):
		commrep.rep-=2
		sysrep.sysrep-=2
	elif(type==5):
		commrep.rep-=1
		sysrep.sysrep-=1
	else:
		commrep.rep+=1
		sysrep.sysrep+=1
	commrep.save()
	sysrep.save()

