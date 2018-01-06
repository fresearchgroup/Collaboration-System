from django.shortcuts import render, redirect
from .forms import NewArticleForm
from django.http import Http404, HttpResponse
from .models import Articles
from django.views.generic.edit import UpdateView
from reversion_compare.views import HistoryCompareDetailView
from Community.models import CommunityArticles, CommunityMembership, CommunityGroups
from Group.models import GroupArticles, GroupMembership
from django.contrib.auth.models import Group as Roles

def display_articles(request):
	"""
	display list of articles in  article list page. 
	"""
	articles=Articles.objects.all()
	return render(request, 'articles.html',{'articles':articles})

def create_article(request):
	"""
	create a new article. This function will be called for creating an
	article in community or group.
	"""
	if request.user.is_authenticated:
		if request.method == 'POST':
			form = NewArticleForm(request.POST)
			if form.is_valid():
				article = Articles.objects.create(
					title = form.cleaned_data.get('title'),
					body  = form.cleaned_data.get('body').replace("\<script ","").replace("&lt;script ","")
					)
				return article
	else:
		return redirect('login')

def view_article(request, pk):
	"""
	A function to view an article. The function will check if the article belongs to group or
	community before displaying it. It displays whether the article belongs
	to group or community
	"""
	try:
		article = CommunityArticles.objects.get(article=pk)
	except CommunityArticles.DoesNotExist:
		try:
			article = GroupArticles.objects.get(article=pk)
		except GroupArticles.DoesNotExist:
			raise Http404
	return render(request, 'view_article.html', {'article': article})


def edit_article(request, pk):
	"""
	A function to edit an article. The function check whether the method is post,
	if not it will check if the article belong to group or community and
	whether the user is a member of that group or cummunity. If the user is not a member,
	he will not be allowed to edit this article. If the user is a member of the group and not the community
	than he will not be allowed to edit this article
	"""
	if request.user.is_authenticated:
		if request.method == 'POST':
			form = NewArticleForm(request.POST)
			if form.is_valid():
				article = Articles.objects.get(pk=pk)
				article.title = form.cleaned_data.get('title')
				article.body = form.cleaned_data.get('body')
				article.save(update_fields=["title","body"])
				return redirect('article_view',pk=article.pk)
		else:
			message=""
			try:
				article = CommunityArticles.objects.get(article=pk)
				try:
					membership = CommunityMembership.objects.get(user =request.user.id, community = article.community.pk)
				except CommunityMembership.DoesNotExist:
					membership = 'FALSE'
			except CommunityArticles.DoesNotExist:
				try:
					article = GroupArticles.objects.get(article=pk)
					try:
						membership =GroupMembership.objects.get(user=request.user.id, group = article.group.pk)
						try:
							communitygroup = CommunityGroups.objects.get(group=article.group.pk)
							membership = CommunityMembership.objects.get(user=request.user.id, community = communitygroup.community.pk)
						except CommunityMembership.DoesNotExist:
							membership = 'FALSE'
							message = 'You are not a member of <h3>%s</h3> community. Please subscribe to the community.'%(communitygroup.community.name)
					except GroupMembership.DoesNotExist:
						membership ='FALSE'
				except GroupArticles.DoesNotExist:
					raise Http404
			return render(request, 'edit_article.html', {'article': article,'membership':membership, 'message':message})
	else:
		return redirect('login')



def delete_article(request, pk):
	"""
	a function to delete an article.
	The business logic is not yet implemented for deleting an article.
	It just displays a message 

	"""
	if request.user.is_authenticated:
		if request.method=='POST':
			status = request.POST['status']
			if status == '0':
				return redirect('article_view',pk=pk)
			elif status == '1':
				return HttpResponse('deleted')
		else:
			message=""
			try:
				article = CommunityArticles.objects.get(article=pk)
				try:
					role = Roles.objects.get(name='community_admin')
					membership = CommunityMembership.objects.get(user =request.user.id, community = article.community.pk, role=role)
				except CommunityMembership.DoesNotExist:
					membership = 'FALSE'
			except CommunityArticles.DoesNotExist:
				try:
					article = GroupArticles.objects.get(article=pk)
					try:
						role = Roles.objects.get(name='group_admin')
						membership =GroupMembership.objects.get(user=request.user.id, group = article.group.pk, role=role)
						try:
							communitygroup = CommunityGroups.objects.get(group=article.group.pk)
							membership = CommunityMembership.objects.get(user=request.user.id, community = communitygroup.community.pk)
						except CommunityMembership.DoesNotExist:
							membership = 'FALSE'
							message = 'You are not a member of <h3>%s</h3> community. Please subscribe to the community.'%(communitygroup.community.name)
					except GroupMembership.DoesNotExist:
						membership ='FALSE'
				except GroupArticles.DoesNotExist:
					raise Http404
			return render(request, 'delete_article.html', {'article': article,'membership':membership})
	else:
		return redirect('login')



class SimpleModelHistoryCompareView(HistoryCompareDetailView):
    model = Articles
