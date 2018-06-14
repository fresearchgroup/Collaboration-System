from BasicArticle.models import Articles
from django.http import Http404, HttpResponse
from Community.models import CommunityArticles, CommunityMembership, CommunityGroups
from Group.models import GroupArticles, GroupMembership
from django.contrib.auth.models import Group as Roles
from django.shortcuts import render,get_object_or_404,redirect
from BasicArticle.views import display_articles,create_article,view_article,edit_article,delete_article,article_watch,SimpleModelHistoryCompareView
from .models import VotingFlag,ArticleVotes
from reputation.views import CommunityReputation

def updown(request):
	#This function is called whenever a user upvotes or downvotes

	if request.method == 'GET':
		return redirect('home')
	else:#POST method 
		if request.user.is_authenticated: #checking user authentication
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
				voting = VotingFlag.objects.get(article_id=a_id,user_id=request.user.id)
				article_votes = ArticleVotes.objects.get(article_id=a_id)
				upflag = voting.upflag
				downflag = voting.downflag
				if (vote_action == 'vote'): #Based on the type of vote we change the vote count as well as the author reputation( here it is voting)
					if (vote_type == 'up'):
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
					elif (vote_type == 'down'):
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
				elif (vote_action == 'recall-vote'): # Recall of vote
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
			else:
				return render(request,'cantvote.html') # Author can't vote his own article
		else:
			return redirect('login') # anonymous user
		return redirect('article_view',a_id) # once updated redirect back to the article
	
