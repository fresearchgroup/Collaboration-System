from django.shortcuts import render, redirect
from .forms import NewArticleForm
from django.http import Http404, HttpResponse
from .models import Articles, ArticleViewLogs
from django.views.generic.edit import UpdateView
from reversion_compare.views import HistoryCompareDetailView
from Community.models import CommunityArticles, CommunityMembership, CommunityGroups
from Group.models import GroupArticles, GroupMembership
from django.contrib.auth.models import Group as Roles
from workflow.models import States, Transitions
from django.shortcuts import render,get_object_or_404,redirect
from django.core.paginator import Paginator, EmptyPage, PageNotAnInteger
from search.views import IndexDocuments
from UserRolesPermission.models import favourite
from BasicArticle.views import display_articles,create_article,view_article,edit_article,delete_article,article_watch,SimpleModelHistoryCompareView
from .models import Voting,Law
from django.http import JsonResponse
from django.views.generic import View
from reputation.views import CommunityReputation

def updown(request):
	#art=get_object_or_404(Voting, pk=a_id)

	if request.method == 'GET':
		return HttpResponse("Noob")
	else:
		if request.user.is_authenticated:
			thread_id = int(request.POST.get('id'))
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
			voting = Voting.objects.get(article_id=thread_id,user_id=request.user.id)
			law = Law.objects.get(article_id=thread_id)
			upflag = voting.upflag
			downflag = voting.downflag

			if (vote_action == 'vote'):
				if (vote_type == 'up'):
					if (upflag == False) and (downflag == False):
						voting.upflag=True
						law.upvote += 1
						law.save()
						voting.save()
						CommunityReputation(request,thread_id,1)
					elif (downflag == True):
						voting.upflag=True
						voting.downflag =False
						law.upvote +=1
						law.downvote -=1
						law.save()
						voting.save()
						CommunityReputation(request,thread_id,2)
				elif (vote_type == 'down'):
					if (upflag == False) and (downflag == False):
						voting.downflag=True
						law.downvote += 1
						law.save()
						voting.save()
						CommunityReputation(request,thread_id,3)
					elif (upflag == True):
						voting.downflag=True
						voting.upflag =False
						law.upvote -=1
						law.downvote +=1
						law.save()
						voting.save()
						CommunityReputation(request,thread_id,4)
			elif (vote_action == 'recall-vote'):
				if (upflag == True) and (vote_type == 'up'):
					voting.upflag=False
					law.upvote-=1
					law.save()
					voting.save()
					CommunityReputation(request,thread_id,5)
				elif (downflag == True) and (vote_type == 'down'):
					voting.downflag=False
					law.downvote-=1
					law.save()
					voting.save()
					CommunityReputation(request,thread_id,6)
		else:
			return redirect('login')
	try:
		article = CommunityArticles.objects.get(article=thread_id)
		law = Law.objects.get(article_id=thread_id)
		voting = Voting.objects.get(article_id=thread_id,user_id=request.user.id)
		if article.article.state == States.objects.get(name='draft') and article.article.created_by != request.user:
			return redirect('home')
		count = article_watch(request, article.article)
	except CommunityArticles.DoesNotExist:
		try:
			article = GroupArticles.objects.get(article=thread_id)
			if article.article.state == States.objects.get(name='draft') and article.article.created_by != request.user:
				return redirect('home')
			count = article_watch(request, article.article)
		except GroupArticles.DoesNotExist:
			raise Http404
	is_fav =''
	if request.user.is_authenticated:
		is_fav = favourite.objects.filter(user = request.user, resource = thread_id, category= 'article').exists()
	return redirect('article_view', pk=thread_id)
