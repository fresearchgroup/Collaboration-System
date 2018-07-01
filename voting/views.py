from BasicArticle.models import Articles
from django.http import Http404, HttpResponse
from Community.models import CommunityArticles, CommunityMembership, CommunityGroups, Community
from Group.models import GroupArticles, GroupMembership
from django.contrib.auth.models import Group as Roles
from django.shortcuts import render,get_object_or_404,redirect
from BasicArticle.views import display_articles,create_article,view_article,edit_article,delete_article,article_watch,SimpleModelHistoryCompareView
from .models import VotingFlag,ArticleVotes,ArticleReport
from reputation.views import CommunityReputation,rolechange,check_article, get_reputation_values
from reputation.models import CommunityRep,SystemRep,ReputationDashboard
from django.views.decorators.csrf import csrf_exempt
from django.contrib.auth.models import User

#This function helps the user in upvoting or downvoting any article
#GET and POST will be used as a method of differentiation.
def updown(request):

	if request.method == 'GET':
		return redirect('home')
	else:
		if request.user.is_authenticated: #(checking user authentication)
			#a_id is the article id
			a_id = int(request.POST.get('id'))
			article = Articles.objects.get(id=a_id)
			if(request.user != article.created_by): # identifying whether the voted person is same as the author
				type1 = request.POST.get('type') # here we identify the type of vote done (upvote or downvote or recall of vote)
				if(type1 == 'upvote'):
					vote_type = "up"
					vote_action = "vote"
				elif(type1 == 'downvote'):
					vote_type = "down"
					vote_action = "vote"
				elif(type1 == 'uprecall'):
					vote_type = "up"
					vote_action = "recall-vote"
				else:
					vote_type = "down"
					vote_action = "recall-vote"
					#Basically we can have 4 types of cases where a user wants to upvote or downvote or user wants to take back(recall)the upvote or downvote button that he clicked
				create_voting_flag(a_id,request.user)
				voting = VotingFlag.objects.get(article_id=a_id,user_id=request.user.id)	
				article_votes = ArticleVotes.objects.get(article_id=a_id)
				upflag = voting.upflag
				downflag = voting.downflag
				if (vote_action == 'vote'): #Based on the type of vote we change the vote count as well as the author reputation
					if (vote_type == 'up'):
						vote_up(a_id,upflag,downflag,voting,article_votes)
					elif (vote_type == 'down'):
						vote_down(a_id,upflag,downflag,voting,article_votes)
				elif (vote_action == 'recall-vote'): # Recall of vote
					recall_vote(a_id,upflag,downflag,voting,article_votes,vote_type)
		else:
			return redirect('login') # anonymous user
		return redirect('article_view',a_id) #once updated redirect back to the article
	
#The user clicks the report flag for the first time.
@csrf_exempt
def report(request):
	if request.method == 'POST':
		username = request.POST.get('username')
		reason = request.POST.get('reason')
		if(reason == 'Others'):
			reason = request.POST.get('reasontext')
		user= User.objects.get(username=username)
		resource_id = request.POST.get('rid')
		status = request.POST.get('status')
		create_voting_flag(resource_id,user)
		community = check_article(resource_id)
		if status == 'add':
			add_report(user,resource_id,community,reason)
			return redirect('article_view',resource_id)	
		if status == 'remove':
			remove_report(user,resource_id,community,reason)
			return redirect('article_view',resource_id)

#The community-admin approves or rejects the reported article
def article_report(request,pk):
	community = Community.objects.get(pk=pk)
	if request.method == 'POST':
		pk1 = int(request.POST.get('pk1'))
		article_reported = ArticleReport.objects.get(pk=pk1)
		status = request.POST.get('status')
		defaultval = get_reputation_values()
		article = article_reported.article
		article_vote = ArticleVotes.objects.get(article=article)
		publisher = article_vote.published_by
		if(status == 'approve'):
			approve_report(pk,article,publisher,community,defaultval)
		else:
			reject_report(article,defaultval)

		voteflags = VotingFlag.objects.filter(article=article,reportflag=True)
		for voteflag in voteflags:
			voteflag.reportflag = False
			voteflag.report_reason = ''
			voteflag.save()
		articlevotes = ArticleVotes.objects.get(article=article_reported.article)
		articlevotes.report = 0
		articlevotes.save()
		ArticleReport.objects.filter(pk=pk1).delete()
	articles_reported = ArticleReport.objects.filter(community=community)
	membership = CommunityMembership.objects.get(user=request.user,community=community)
	return render(request, 'article_report.html' , {'articles_reported':articles_reported,'community':community,'membership':membership})

#Utility function
def create_voting_flag(a_id,user):
	if not VotingFlag.objects.filter(article_id=a_id,user_id=user.id).exists():
		voting = VotingFlag()
		voting.article_id = a_id
		voting.user = user
		voting.upflag = False
		voting.downflag = False
		voting.reportflag = False
		voting.save()	

#The user needs to mention the reason as to why the article has been reported.
def report_reasons(request,a_id):
	votingflags = VotingFlag.objects.filter(article_id=a_id,reportflag=True)
	return render(request,'report_reasons.html',{'votingflags':votingflags})


#The user upvotes an article
def vote_up(a_id,upflag,downflag,voting,article_votes):
	if (upflag is False) and (downflag is False):
		voting.upflag=True
		article_votes.upvote += 1
		article_votes.save()
		voting.save()
		CommunityReputation(a_id,1)
	elif (downflag is True):
		voting.upflag=True
		voting.downflag =False
		article_votes.upvote +=1
		article_votes.downvote -=1
		article_votes.save()
		voting.save()
		CommunityReputation(a_id,2)

#The user downvotes an article
def vote_down(a_id,upflag,downflag,voting,article_votes):
	if (upflag is False) and (downflag is False):
		voting.downflag=True
		article_votes.downvote += 1
		article_votes.save()
		voting.save()
		CommunityReputation(a_id,3)
	elif (upflag is True):
		voting.downflag=True
		voting.upflag =False
		article_votes.upvote -=1
		article_votes.downvote +=1
		article_votes.save()
		voting.save()
		CommunityReputation(a_id,4)

#The user takes backs the upvote or downvote for the particular article.
def recall_vote(a_id,upflag,downflag,voting,article_votes,vote_type):
	if (upflag is True) and (vote_type == 'up'):
		voting.upflag=False
		article_votes.upvote-=1
		article_votes.save()
		voting.save()
		CommunityReputation(a_id,5)
	elif (downflag is True) and (vote_type == 'down'):
		voting.downflag=False
		article_votes.downvote-=1
		article_votes.save()
		voting.save()
		CommunityReputation(a_id,6)

#The reporting of the article by every user is handled which helps in increasing the count of flag.
def add_report(user,resource_id,community,reason):
	voteflag = VotingFlag.objects.get(user=user,article_id= resource_id)
	voteflag.reportflag = True
	voteflag.report_reason = reason
	voteflag.save()
	article_votes = ArticleVotes.objects.get(article_id = resource_id)
	article_votes.report +=1
	article_votes.save()
	defaultval = get_reputation_values()
	if(article_votes.report >= defaultval.threshold_report):
		article = Articles.objects.get(pk=resource_id)					
		if not ArticleReport.objects.filter(article = article).exists():
			ArticleReport.objects.create(community=community,article = article,no_of_report = article_votes.report)
		else:
			ArticleReport.objects.filter(community=community,article = article).update(no_of_report = article_votes.report)


#If the user wants to take back the flag that he reported
def remove_report(user,resource_id,community,reason):
	voteflag = VotingFlag.objects.get(user=user,article_id= resource_id)
	voteflag.reportflag = False
	voteflag.report_reason = reason
	voteflag.save()
	article_votes = ArticleVotes.objects.get(article_id = resource_id)
	article_votes.report -=1
	article_votes.save()
	defaultval = get_reputation_values()
	if(article_votes.report < defaultval.threshold_report):
		article = Articles.objects.get(pk=resource_id)
		if ArticleReport.objects.filter(article = article).exists():
			ArticleReport.objects.filter(article = article).delete()
	else:
		article = Articles.objects.get(pk=resource_id)
		ArticleReport.objects.filter(community=community,article=article).update(no_of_report = article_votes.report)


#Whenever the reported article gets an approval and distribution of points is followed.
def approve_report(pk,article,publisher,community,defaultval):
	commrep = CommunityRep.objects.get(user=article.created_by,community_id=pk) #reducing author reputation
	commrep.rep -= defaultval.author_report
	sysrep = SystemRep.objects.get(user=article.created_by)
	sysrep.sysrep -= defaultval.author_report
	commrep.save()
	sysrep.save()
	rolechange(commrep,article.created_by,community)
	commrep = CommunityRep.objects.get(user=publisher,community_id=pk)
	commrep.rep -= defaultval.publisher_report
	sysrep = SystemRep.objects.get(user=publisher)
	sysrep.sysrep -= defaultval.publisher_report
	commrep.save()
	sysrep.save()
	rolechange(commrep,publisher,community)

#Whenever the reported article gets a rejection
def reject_report(article,defaultval):
	users_rejected = VotingFlag.objects.filter(article=article,reportflag=True)
	for user_rejected in users_rejected:
		sysrep = SystemRep.objects.get(user=user_rejected.user)
		sysrep.sysrep -= defaultval.article_report_rejected
		sysrep.save()
