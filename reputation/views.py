from django.shortcuts import render,redirect
from .models import SystemRep,CommunityRep,DefaultValues
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
	defaultval = DefaultValues.objects.get(pk=1)
	up=defaultval.upvote
	down=defaultval.downvote
	if(type==1):
		commrep.rep+=up
		sysrep.sysrep+=up
	elif(type==3):
		commrep.rep-=down
		sysrep.sysrep-=down
	elif(type==2):
		commrep.rep+=down+up
		sysrep.sysrep+=down+up
	elif(type==4):
		commrep.rep=commrep.rep-down-up
		sysrep.sysrep=sysrep.sysrep-down-up
	elif(type==5):
		commrep.rep-=up
		sysrep.sysrep-=up
	else:
		commrep.rep+=down
		sysrep.sysrep+=down
	commrep.save()
	sysrep.save()


def defaultval(request):
	if request.method == 'POST':
		upvote = int(request.POST.get('upvote'))
		downvote = int(request.POST.get('downvote'))
		published_author = int(request.POST.get('published_author'))
		published_publisher = int(request.POST.get('published_publisher'))
		comment_flag = int(request.POST.get('comment_flag'))
		reply = int(request.POST.get('reply'))
		crep_for_art = int(request.POST.get('crep_for_art'))
		srep_for_art = int(request.POST.get('srep_for_art'))
		srep_for_comm = int(request.POST.get('srep_for_comm'))
		srep_for_comm_creation = int(request.POST.get('srep_for_comm_creation'))
		defaultval = DefaultValues.objects.get(pk=1)
		defaultval.upvote = upvote
		defaultval.downvote = downvote
		defaultval.published_author = published_author
		defaultval.published_publisher = published_publisher
		defaultval.comment_flag = defaultval.comment_flag
		defaultval.reply =reply
		defaultval.crep_for_art = crep_for_art
		defaultval.srep_for_art = srep_for_art
		defaultval.srep_for_comm = srep_for_comm
		defaultval.srep_for_comm_creation = srep_for_comm_creation
		defaultval.save()
		return redirect('home')
	else:
		if request.user.is_superuser:
			defaultval = DefaultValues.objects.get(pk=1)
			return render(request,'defaultval.html',{'defaultval':defaultval})
		else:
			return redirect('home')