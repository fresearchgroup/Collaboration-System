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
from django.core.paginator import Paginator, EmptyPage, PageNotAnInteger

def display_articles(request):
	"""
	display list of articles in  article list page.
	"""
	articlelist=Articles.objects.raw('select o.id,title,username,views,o.created_at,g.name GNAME,c.name CNAME from (select id,title,username,views,created_at,GID,CID COMMID from ( select ba.id,ba.title , username,views,created_at ,(select group_id from Group_grouparticles where article_id=ba.id) GID , (select community_id from Community_communityarticles where article_id=ba.id) CID from (select * from BasicArticle_articles  where id in (select article_id from Group_grouparticles) or id in (select article_id from Community_communityarticles)) ba join auth_user au on ba.created_by_id=au.id join workflow_states ws on ws.id=ba.state_id where ws.name="publish") t ) o  left join Community_community c on c.id=COMMID left join Group_group g on g.id=GID order by views desc;')
	page = request.GET.get('page', 1)
	paginator = Paginator(list(articlelist), 5)
	try:
		articles = paginator.page(page)
	except PageNotAnInteger:
		articles = paginator.page(1)
	except EmptyPage:
		articles = paginator.page(paginator.num_pages)
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
				state = States.objects.get(name='draft')
				article = Articles.objects.create(
					title = form.cleaned_data.get('title'),
					body  = form.cleaned_data.get('body').replace("\<script ","").replace("&lt;script ",""),
					image = request.FILES['article_image'],
					created_by = request.user,
					state = state
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
		if article.article.state == States.objects.get(name='draft') and article.article.created_by != request.user:
			return redirect('home')
		count = article_watch(request, article.article)
	except CommunityArticles.DoesNotExist:
		try:
			article = GroupArticles.objects.get(article=pk)
			if article.article.state == States.objects.get(name='draft') and article.article.created_by != request.user:
				return redirect('home')
			count = article_watch(request, article.article)
		except GroupArticles.DoesNotExist:
			raise Http404
	return render(request, 'view_article.html', {'article': article, 'count':count})


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
			if request.POST['state'] == 'save':
				if form.is_valid():
					article = Articles.objects.get(pk=pk)
					article.title = form.cleaned_data.get('title')
					article.body = form.cleaned_data.get('body')
					try:
						article.image = request.FILES['article_image']
						article.save(update_fields=["title","body","image"])
					except:
						article.save(update_fields=["title","body"])
					return redirect('article_view',pk=article.pk)
			else:
				article = Articles.objects.get(pk=pk)
				title = request.POST['title']
				body = request.POST['body']
				to_state = request.POST['state']
				current_state = request.POST['current']
				try:
					current_state = States.objects.get(name=current_state)
					to_state = States.objects.get(name=to_state)
					if current_state.name == 'draft' and to_state.name == 'visible' and 'belongs_to' in request.POST:
						article.state = to_state
					elif current_state.name == 'visible' and to_state.name == 'publish' and 'belongs_to' in request.POST:
						article.state = to_state
					elif 'private' in request.POST:
						to_state = States.objects.get(name='private')
						article.state = to_state
					else:
						transitions = Transitions.objects.get(from_state=current_state, to_state=to_state)
						article.state = to_state
					article.title = title
					article.body = body
					try:
						article.image = request.FILES['article_image']
						article.save(update_fields=["title","body", "image", "state"])
					except:
						article.save(update_fields=["title","body", "state"])
				except Transitions.DoesNotExist:
					message = "transition doesn' exist"
				except States.DoesNotExist:
					message = "state doesn' exist"
				return redirect('article_view',pk=pk)
		else:
			message=""
			transition =""
			cmember = ""
			gmember = ""
			private = ""
			try:
				article = CommunityArticles.objects.get(article=pk)
				if article.article.state == States.objects.get(name='draft') and article.article.created_by != request.user:
					return redirect('home')
				if article.article.state == States.objects.get(name='publish'):
					return redirect('article_view',pk=pk)
				belongs_to = 'community'
				try:
					cmember = CommunityMembership.objects.get(user =request.user.id, community = article.community.pk)
					try:
						transition = Transitions.objects.get(from_state=article.article.state)
						state1 = States.objects.get(name='draft')
						state2 = States.objects.get(name='private')
						if transition.from_state == state1 and transition.to_state ==state2:
							transition.to_state = States.objects.get(name='visible')
					except Transitions.DoesNotExist:
						message = "transition doesn't exist"
					except States.DoesNotExist:
						message = "state does n't exist"
				except CommunityMembership.DoesNotExist:
					cmember = 'FALSE'
			except CommunityArticles.DoesNotExist:
				try:
					article = GroupArticles.objects.get(article=pk)
					if article.article.state == States.objects.get(name='publish'):
						return redirect('article_view',pk=pk)
					if article.article.state == States.objects.get(name='draft') and article.article.created_by != request.user:
						return redirect('home')
					belongs_to = 'group'
					private =''
					try:
						communitygroup = CommunityGroups.objects.get(group=article.group.pk)
						cmember = CommunityMembership.objects.get(user=request.user.id, community = communitygroup.community.pk)
						try:
							gmember =GroupMembership.objects.get(user=request.user.id, group = article.group.pk)
						except GroupMembership.DoesNotExist:
							gmember = 'FALSE'
						try:
							transition = Transitions.objects.get(from_state=article.article.state)
							state1 = States.objects.get(name='visible')
							state2 = States.objects.get(name='publishable')
							if transition.from_state == state1 and transition.to_state ==state2:
								transition.to_state = States.objects.get(name='publish')
								private = States.objects.get(name='private')
						except Transitions.DoesNotExist:
							message = "transition doesn't exist"
					except CommunityMembership.DoesNotExist:
						message = 'You are not a member of <h3>%s</h3> community. Please subscribe to the community.'%(communitygroup.community.name)
				except GroupArticles.DoesNotExist:
					raise Http404
			return render(request, 'edit_article.html', {'article': article, 'cmember':cmember,'gmember':gmember,'message':message, 'belongs_to':belongs_to,'transition': transition, 'private':private,})
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


def article_watch(request, article):
    if not ArticleViewLogs.objects.filter(article=article,session=request.session.session_key):
    	view = ArticleViewLogs(
    		article=article,ip=request.META['REMOTE_ADDR'],
    		session=request.session.session_key
    		)
    	view.save()
    	article = Articles.objects.get(pk=article.pk)
    	article.views += 1
    	article.save()

    return article.views

class SimpleModelHistoryCompareView(HistoryCompareDetailView):
    model = Articles
