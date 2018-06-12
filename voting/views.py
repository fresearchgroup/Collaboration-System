from BasicArticle.models import Articles
from django.http import Http404, HttpResponse
from Community.models import CommunityArticles, CommunityMembership, CommunityGroups
from Group.models import GroupArticles, GroupMembership
from django.contrib.auth.models import Group as Roles
from django.shortcuts import render,get_object_or_404,redirect
from BasicArticle.views import display_articles,create_article,view_article,edit_article,delete_article,article_watch,SimpleModelHistoryCompareView
from .models import Voting,Law
from reputation.views import CommunityReputation

def updown(request):
	#art=get_object_or_404(Voting, pk=a_id)

	if request.method == 'GET':
		return redirect('home')
	else:
		if request.user.is_authenticated:
			a_id = int(request.POST.get('id'))
			article = Articles.objects.get(id=a_id)
			if(request.user != article.created_by):
				type1 = request.POST.get('type')
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
				voting = Voting.objects.get(article_id=a_id,user_id=request.user.id)
				law = Law.objects.get(article_id=a_id)
				upflag = voting.upflag
				downflag = voting.downflag
				if (vote_action == 'vote'):
					if (vote_type == 'up'):
						if (upflag is False) and (downflag is False):
							voting.upflag=True
							law.upvote += 1
							law.save()
							voting.save()
							CommunityReputation(a_id,1)
						elif (downflag is True):
							voting.upflag=True
							voting.downflag =False
							law.upvote +=1
							law.downvote -=1
							law.save()
							voting.save()
							CommunityReputation(a_id,2)
					elif (vote_type == 'down'):
						if (upflag is False) and (downflag is False):
							voting.downflag=True
							law.downvote += 1
							law.save()
							voting.save()
							CommunityReputation(a_id,3)
						elif (upflag is True):
							voting.downflag=True
							voting.upflag =False
							law.upvote -=1
							law.downvote +=1
							law.save()
							voting.save()
							CommunityReputation(a_id,4)
				elif (vote_action == 'recall-vote'):
					if (upflag is True) and (vote_type == 'up'):
						voting.upflag=False
						law.upvote-=1
						law.save()
						voting.save()
						CommunityReputation(a_id,5)
					elif (downflag is True) and (vote_type == 'down'):
						voting.downflag=False
						law.downvote-=1
						law.save()
						voting.save()
						CommunityReputation(a_id,6)
			else:
				return render(request,'cantvote.html')
		else:
			return redirect('login')
	
	return redirect('article_view',a_id)
	# try:
	# 	article = CommunityArticles.objects.get(article=thread_id)
	# 	law = Law.objects.get(article_id=thread_id)
	# 	voting = Voting.objects.get(article_id=thread_id,user_id=request.user.id)
	# 	if article.article.state == States.objects.get(name='draft') and article.article.created_by != request.user:
	# 		return redirect('home')
	# 	count = article_watch(request, article.article)
	# except CommunityArticles.DoesNotExist:
	# 	try:
	# 		article = GroupArticles.objects.get(article=thread_id)
	# 		if article.article.state == States.objects.get(name='draft') and article.article.created_by != request.user:
	# 			return redirect('home')
	# 		count = article_watch(request, article.article)
	# 	except GroupArticles.DoesNotExist:
	# 		raise Http404
	# is_fav =''
	# if request.user.is_authenticated:
	# 	is_fav = favourite.objects.filter(user = request.user, resource = thread_id, category= 'article').exists()
	# return redirect('article_view', pk=thread_id)
