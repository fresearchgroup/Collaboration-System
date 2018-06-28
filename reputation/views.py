from django.shortcuts import render,redirect
from .models import SystemRep,CommunityRep,ReputationDashboard
from Community.models import CommunityArticles,CommunityGroups, CommunityMembership,Community
from Group.models import GroupArticles
from BasicArticle.models import Articles
from django.contrib.auth.models import User
from django.contrib.auth.models import Group as Roles
from voting.models import ArticleVotes,ArticleReport,Badges


def CommunityReputation(a_id,votetype):
	# This method is called from the voting-views.py file 
	# It is used to change the reputation of the author based on the type of vote
	article = Articles.objects.get(pk = a_id)
	author = article.created_by
	community = check_article(a_id)

	#community variable stores the community
	commrep = CommunityRep.objects.get(community_id=community.id, user_id=author.id)
	sysrep = SystemRep.objects.get(user_id=author.id)
	defaultval = ReputationDashboard.objects.get(pk=1)
	up=defaultval.upvote
	down=defaultval.downvote
	# Votetype contains the type of vote made which is passed as a parameter to the function
	change_reputation(votetype,commrep,sysrep,up,down,community,author)
	
	
#The further three functions are the repercursion of changing the default values of reputation.
def author_reputation_dashboard(request):
	if request.method == 'POST':
		published_author = int(request.POST.get('published_author'))
		author_report = int(request.POST.get('author_report'))		
		defaultval = ReputationDashboard.objects.get(pk=1)
		defaultval.published_author = published_author
		defaultval.author_report = author_report
		defaultval.save()
		return redirect('home')
	else:
		if request.user.is_superuser: 
			defaultval = ReputationDashboard.objects.get(pk=1)
			return render(request,'author_reputation_dashboard.html',{'defaultval':defaultval})
		return redirect('home') #if user is not superuser redirect to home


def general_reputation_dashboard(request):
	if request.method == 'POST':
		upvote = int(request.POST.get('upvote'))
		downvote = int(request.POST.get('downvote'))		
		new_min_srep_for_comm = int(request.POST.get('min_srep_for_comm'))
		srep_for_comm_creation = int(request.POST.get('srep_for_comm_creation'))
		new_threshold_publisher = int(request.POST.get('threshold_publisher'))
		new_threshold_cadmin = int(request.POST.get('threshold_cadmin'))
		article_report_rejected = int(request.POST.get('article_report_rejected'))
		if(new_min_srep_for_comm == 0) or (new_threshold_publisher == 0) or (new_threshold_cadmin == 0): #can't make some of the values to zero
			return render(request,'cantset.html')
		defaultval = ReputationDashboard.objects.get(pk=1)
		defaultval.upvote = upvote
		defaultval.downvote = downvote
		defaultval.article_report_rejected = article_report_rejected
		old_min_srep_for_comm = defaultval.min_srep_for_comm
		#The user reputation changes as the default changes for creating the community.
		if(old_min_srep_for_comm != new_min_srep_for_comm): #checking if old is not equal to new ,if yes then change the user reputation accordingly
			change_alluser_reputation(new_min_srep_for_comm,old_min_srep_for_comm)
		defaultval.min_srep_for_comm = new_min_srep_for_comm
		defaultval.srep_for_comm_creation = srep_for_comm_creation
		old_threshold_publisher = defaultval.threshold_publisher
		#The user reputation changes as the default changes for publisher threshold.
		if(old_threshold_publisher != new_threshold_publisher): #checking if old is not equal to new ,if yes then change the user reputation accordingly
			change(new_threshold_publisher,old_threshold_publisher,'publisher')
		defaultval.threshold_publisher = new_threshold_publisher
		old_threshold_cadmin = defaultval.threshold_cadmin
		#The user reputation changes as the default changes for community-admin threshold.
		if(old_threshold_cadmin != new_threshold_cadmin): #checking if old is not equal to new ,if yes then change the user reputation accordingly
			change(new_threshold_cadmin,old_threshold_cadmin,'community_admin')
		defaultval.threshold_cadmin = new_threshold_cadmin
		defaultval.save()
		return redirect('home')
	else:
		if request.user.is_superuser: 
			defaultval = ReputationDashboard.objects.get(pk=1)
			return render(request,'general_reputation_dashboard.html',{'defaultval':defaultval})
		return redirect('home') #if user is not superuser redirect to home	


def publisher_reputation_dashboard(request):
	if request.method == 'POST':
		published_publisher = int(request.POST.get('published_publisher'))
		publisher_report = int(request.POST.get('publisher_report'))
		defaultval = ReputationDashboard.objects.get(pk=1)
		defaultval.published_publisher = published_publisher
		defaultval.publisher_report = publisher_report
		defaultval.save()
		return redirect('home')
	else:
		if request.user.is_superuser: 
			defaultval = ReputationDashboard.objects.get(pk=1)
			return render(request,'publisher_reputation_dashboard.html',{'defaultval':defaultval})
		return redirect('home') #if user is not superuser redirect to home	


def communityadmin_reputation_dashboard(request):
	if request.method == 'POST':
		new_threshold_report = int(request.POST.get('threshold_report'))
		defaultval = ReputationDashboard.objects.get(pk=1)
		if(defaultval.threshold_report < new_threshold_report):
			articles_reported = ArticleReport.objects.all()
			for article in articles_reported:
				if(article.no_of_report < new_threshold_report):
					article.delete()
		else:
			article_votes = ArticleVotes.objects.all()
			for article in article_votes:
				if(article.report >= new_threshold_report):
					article1 = article.article
					community = check_article(article1.id)
					if not ArticleReport.objects.filter(article = article1).exists():
						ArticleReport.objects.create(community=community,article = article1,no_of_report = article.report)
		defaultval.threshold_report = new_threshold_report
		defaultval.save()
		return redirect('home')
	else:
		if request.user.is_superuser: 
			defaultval = ReputationDashboard.objects.get(pk=1)
			return render(request,'communityadmin_reputation_dashboard.html',{'defaultval':defaultval})
		return redirect('home') #if user is not superuser redirect to home		


def change(new,old,role1):
	#this function is called by the above function in order to change all the user values accordingly
	communities = Community.objects.all()
	role = Roles.objects.get(name=role1)
	for community in communities:
		community_memberships = CommunityMembership.objects.filter(community=community,role=role)
		for community_membership in community_memberships:
			user = community_membership.user
			commrep = CommunityRep.objects.get(community=community,user=user)
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

#This function is called if any default or any change in reputation occurs because it might change the roles of the user.
def rolechange(commrep,user,community):#once the user reputation has changed we need to compare with the threshold to become a publisher or community admin in order to change his role in that community
	defaultval=ReputationDashboard.objects.get(pk=1)
	if(commrep.rep >= defaultval.threshold_cadmin): #if user reputation is greater than community admin threshold then change his role to community admin
		community_membership = CommunityMembership.objects.get(user_id=user.id,community_id=community.id)
		community_membership.role = Roles.objects.get(name='community_admin')
		community_membership.save()
	elif(commrep.rep >= defaultval.threshold_publisher): #if user reputation is greater than publisher threshold then change his role to publisher
		community_membership = CommunityMembership.objects.get(user_id=user.id,community_id=community.id)
		role = Roles.objects.get(name='community_admin')
		count_community_admin = CommunityMembership.objects.filter(role=role,community_id=community.id).count()
		if(count_community_admin > 1) or (community_membership.role != role): #checking if there is only one community admin in the community so that, that admin is not changed to publisher when is reputation falls below the threshold of community admin
			community_membership.role = Roles.objects.get(name='publisher')
		community_membership.save()
	else: # else change his role to author
		community_membership = CommunityMembership.objects.get(user_id=user.id,community_id=community.id)
		community_membership.role = Roles.objects.get(name='author')
		community_membership.save()


#Article belonging to which community?? THis function gives you this feature.
def check_article(a_id):
	communtiy_articles = CommunityArticles.objects.filter(article_id=a_id).exists()
	if(communtiy_articles is False): #it is not a community article
		grpart = GroupArticles.objects.get(article_id=a_id)
		grp = grpart.group
		community = CommunityGroups.objects.get(group_id=grp.id)
	else: #it is a community article
		communtiy_articles = CommunityArticles.objects.get(article_id=a_id)
		community = communtiy_articles.community
	return community
	
#When the article gets published then change in respective reputation is done.
def article_published(request,pk):
	article = Articles.objects.get(pk=pk)
	author = article.created_by
	publisher = request.user
	community = check_article(pk)
	article_vote = ArticleVotes.objects.get(article=article)
	article_vote.published_by = publisher
	article_vote.save()

	change_reputation_aritcle_published(community,author,publisher)


def change_reputation(votetype,commrep,sysrep,up,down,community,author):
	if(votetype==1):
		commrep.rep+=up
		sysrep.sysrep+=up
	elif(votetype==3):
		commrep.rep-=down
		sysrep.sysrep-=down
	elif(votetype==2):
		commrep.rep+=down+up
		sysrep.sysrep+=down+up
	elif(votetype==4):
		commrep.rep=commrep.rep-down-up
		sysrep.sysrep=sysrep.sysrep-down-up
	elif(votetype==5):
		commrep.rep-=up
		sysrep.sysrep-=up
	else:
		commrep.rep+=down
		sysrep.sysrep+=down
	commrep.save()
	sysrep.save()
	rolechange(commrep,author,community)


def change_alluser_reputation(new_min_srep_for_comm,old_min_srep_for_comm):
	users = User.objects.all()
	for user in users:
		sysrep = SystemRep.objects.get(user=user)
		old_sysrep = sysrep.sysrep
		new_sysrep = new_min_srep_for_comm*old_sysrep/old_min_srep_for_comm
		sysrep.sysrep = new_sysrep
		sysrep.save()


def change_reputation_aritcle_published(community,author,publisher):
	author_crep = CommunityRep.objects.get(community_id=community.id, user_id=author.id)
	author_srep = SystemRep.objects.get(user_id=author.id)
	publisher_crep = CommunityRep.objects.get(community_id=community.id,user_id=publisher.id)
	publisher_srep = SystemRep.objects.get(user_id=publisher.id)
	defaultval = ReputationDashboard.objects.get(pk=1)
	#increasing the author and publisherc reputation has an article has been published
	author_srep.sysrep+=defaultval.published_author
	author_crep.rep+=defaultval.published_author
	publisher_crep.rep+=defaultval.published_publisher
	publisher_srep.sysrep+=defaultval.published_publisher

	author_srep.save()
	author_crep.save()
	publisher_crep.save()
	publisher_srep.save()
	rolechange(author_crep,author,community)
	rolechange(publisher_crep,publisher,community)
	change_badge_article_published(publisher,author)


def change_badge_article_published(publisher,author):
	badge_publisher = Badges.objects.get(user=publisher)
	badge_author = Badges.objects.get(user=author)
	badge_publisher.articles_published_publisher += 1
	badge_author.articles_published_author += 1
	badge_publisher.save()
	badge_author.save()