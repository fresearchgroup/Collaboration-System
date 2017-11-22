from django.shortcuts import render, redirect
from BasicArticle.views import create_article, view_article
# Create your views here.
from django.shortcuts import render
from .models import Community, CommunityMembership, CommunityArticles
from rest_framework import viewsets


# Create your views here.


def display_communities(request):
	communities=Community.objects.all()
	return render(request, 'communities.html',{'communities':communities})

def community_view(request, pk):
	try:
		community = Community.objects.get(pk=pk)
		uid = request.user.id
		membership = CommunityMembership.objects.get(user =uid, community = community.pk)
	except CommunityMembership.DoesNotExist:
		membership = 'FALSE'
	return render(request, 'communityview.html', {'community': community, 'membership':membership})

def community_subscribe(request):
	if request.user.is_authenticated:
		if request.method == 'POST':
			cid = request.POST['cid']
			community=Community.objects.get(pk=cid)
			user = request.user
			obj = CommunityMembership.objects.create(user=user, community=community)
			return redirect('community_view',pk=cid)
		return render(request, 'communityview.html')
	else:
		return redirect('login')

def community_unsubscribe(request):
	if request.method == 'POST':
		cid = request.POST['cid']
		community=Community.objects.get(pk=cid)
		user = request.user
		obj = CommunityMembership.objects.filter(user=user, community=community).delete()
		return redirect('community_view',pk=cid)
	return render(request, 'communityview.html')


def community_article(request, pk):
	if request.user.is_authenticated:
		if request.method == 'POST':
			article = create_article(request)
			community = Community.objects.get(pk=pk)
			obj = CommunityArticles.objects.create(article=article, user = request.user , community =community )
			return redirect('article_view', article.pk)
		else:
			return render(request, 'new_article.html', {'pk':pk})
	else:
		return redirect('login')


