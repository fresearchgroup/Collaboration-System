from django.shortcuts import render,redirect
from .models import SystemRep,CommunityRep,DefaultValues
from Community.models import CommunityArticles,CommunityGroups, CommunityMembership
from Group.models import GroupArticles
from BasicArticle.models import Articles
from django.contrib.auth.models import User
from django.contrib.auth.models import Group as Roles

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
	if(commrep.rep >= defaultval.threshold_cadmin):
		community_membership = CommunityMembership.objects.get(user_id=author.id,community_id=community.id)
		community_membership.role = Roles.objects.get(name='community_admin')
		community_membership.save()
	elif(commrep.rep >= defaultval.threshold_publisher):
		community_membership = CommunityMembership.objects.get(user_id=author.id,community_id=community.id)
		role = Roles.objects.get(name='community_admin')
		count_community_admin = CommunityMembership.objects.filter(role=role,community_id=community.id).count()
		if(count_community_admin > 1) or (community_membership.role != role):
			community_membership.role = Roles.objects.get(name='publisher')
		community_membership.save()
	else:
		community_membership = CommunityMembership.objects.get(user_id=author.id,community_id=community.id)
		community_membership.role = Roles.objects.get(name='author')
		community_membership.save()
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
		new_min_crep_for_art = int(request.POST.get('min_crep_for_art'))
		new_min_srep_for_comm = int(request.POST.get('min_srep_for_comm'))
		srep_for_comm_creation = int(request.POST.get('srep_for_comm_creation'))
		new_threshold_publisher = int(request.POST.get('threshold_publisher'))
		new_threshold_cadmin = int(request.POST.get('threshold_cadmin'))
		defaultval = DefaultValues.objects.get(pk=1)
		defaultval.upvote = upvote
		defaultval.downvote = downvote
		defaultval.published_author = published_author
		defaultval.published_publisher = published_publisher
		defaultval.comment_flag = defaultval.comment_flag
		defaultval.reply =reply
		old_min_srep_for_comm = defaultval.min_srep_for_comm
		if(old_min_srep_for_comm != new_min_srep_for_comm):
			users = User.objects.all()
			for user in users:
				sysrep = SystemRep.objects.get(user=user)
				old_sysrep = sysrep.sysrep
				new_sysrep = new_min_srep_for_comm*old_sysrep/old_min_srep_for_comm
				sysrep.sysrep = new_sysrep
				sysrep.save()
		defaultval.min_srep_for_comm = new_min_srep_for_comm
		old_min_crep_for_art = defaultval.min_crep_for_art
		if(old_min_crep_for_art != new_min_crep_for_art):
			change(request,new_min_crep_for_art,old_min_crep_for_art)
		defaultval.min_crep_for_art = new_min_crep_for_art
		defaultval.srep_for_comm_creation = srep_for_comm_creation
		old_threshold_publisher = defaultval.threshold_publisher
		if(old_threshold_publisher != new_threshold_publisher):
			change(request,new_threshold_publisher,old_threshold_publisher)
		defaultval.threshold_publisher = new_threshold_publisher
		old_threshold_cadmin = defaultval.threshold_cadmin
		if(old_threshold_cadmin != new_threshold_cadmin):
			change(request,new_threshold_cadmin,old_threshold_cadmin)
		defaultval.threshold_cadmin = new_threshold_cadmin
		defaultval.save()
		return redirect('home')
	else:
		if request.user.is_superuser:
			defaultval = DefaultValues.objects.get(pk=1)
			return render(request,'defaultval.html',{'defaultval':defaultval})
		else:
			return redirect('home')

def change(request,new,old):
	users = User.objects.all()
	for user in users:
		commreps = CommunityRep.objects.filter(user=user)
		for commrep in commreps:
			old_commrep = commrep.rep
			new_commrep = new*old_commrep/old
			commrep.rep = new_commrep
			sysrep = SystemRep.objects.get(user=user)
			if(old_commrep < new_commrep):
				change = new_commrep-old_commrep
				sysrep.sysrep +=change
			else:
				change = old_commrep-new_commrep
				sysrep.sysrep -= change
			sysrep.save()
			commrep.save()