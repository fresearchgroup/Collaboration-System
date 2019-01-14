from django.shortcuts import render, redirect
from .forms import NewArticleForm, ArticleUpdateForm
from django.http import Http404, HttpResponse, JsonResponse
from .models import Articles, ArticleViewLogs
from django.views.generic.edit import UpdateView
from reversion_compare.views import HistoryCompareDetailView
from Community.models import CommunityArticles, CommunityMembership, CommunityGroups
from Group.models import GroupArticles, GroupMembership
from django.contrib.auth.models import Group as Roles
from workflow.models import States, Transitions
from django.core.paginator import Paginator, EmptyPage, PageNotAnInteger
from UserRolesPermission.models import favourite
import datetime
from notifications.signals import notify
from django.contrib.auth.models import User
from actstream import action
from actstream.models import Action
from actstream.models import target_stream
from django.contrib.contenttypes.models import ContentType 
from feeds.views import create_resource_feed
from notification.views import notify_update_article_state, notify_edit_article
from py_etherpad import EtherpadLiteClient
from django.conf import settings
from Recommendation_API.views import get_Recommendations
import json
from Reputation.models import ArticleScoreLog
import requests
from etherpad.views import getHTML, getText, deletePad, create_session_community, create_session_group, get_pad_id, get_pad_usercount
from django.contrib import messages
from workflow.views import canEditResourceCommunity
from django.urls import reverse

def article_autosave(request,pk):
	if request.user.is_authenticated:
		if request.method == 'POST':
			article = Articles.objects.get(pk=pk)
			article.body = getHTML(article)
			data={
				'success': "Done",
				'html' : article.body
			}
			article.save()
			return JsonResponse(data)
	
	else:
		return redirect('login')

# +++++++++++++++++++++++++++++++++++++++++++

def article_text(request,pk):
	if request.user.is_authenticated:
		if request.method == 'GET':
			article = Articles.objects.get(pk=pk)
			body = getText(article)
			data={
				'body' : body,
				'success': "Done"
			}
			# article.save()
			return JsonResponse(data)
	
	else:
		return redirect('login')
# +++++++++++++++++++++++++++++++++++++++++++

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
	fav_articles = ''
	if request.user.is_authenticated:
		fav_articles = favourite.objects.raw('select  ba.id as id , title from BasicArticle_articles as ba ,UserRolesPermission_favourite as uf where ba.id=resource and user_id =%s;', [request.user.id])
	return render(request, 'articles.html',{'articles':articles, 'favs':fav_articles})

def create_article(request):
	"""
	create a new article. This function will be called for creating an
	article in community or group.
	"""
	if request.user.is_authenticated:
		if request.method == 'POST':
			state = States.objects.get(name='draft')
			title = request.POST['title']
			body  = ""
			try:
				image = request.FILES['article_image']
			except:
				image = None
			article = Articles.objects.create(
				title = title,
				body  = body,
				image = image,
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
		raise Http404
	is_fav =''
	if request.user.is_authenticated:
		is_fav = favourite.objects.filter(user = request.user, resource = pk, category= 'article').exists()
	
	return render(request, 'view_article.html', {'article': article, 'count':count, 'is_fav':is_fav})

def reports_article(request, pk):
	try:
		article = CommunityArticles.objects.get(article=pk)
		if article.article.state == States.objects.get(name='draft') and article.article.created_by != request.user:
			return redirect('home')
	except CommunityArticles.DoesNotExist:
		raise Http404
	return render(request, 'reports_article.html', {'article': article})

class ArticleEditView(UpdateView):
	form_class = ArticleUpdateForm
	model = Articles
	template_name = 'edit_article.html'
	pk_url_kwarg = 'pk'
	context_object_name = 'article'
	success_url = 'article_view'

	def get(self, request, *args, **kwargs):
		self.object = self.get_object()
		if self.object.state.initial and self.object.created_by != request.user:
			return redirect('home')
		if self.object.state.final:
			messages.warning(request, 'Published content are are not editable.')
			return redirect('article_view',pk=self.object.pk)
		community = self.get_community()
		if self.is_communitymember(request, community):
			role = self.get_communityrole(request, community)
			if canEditResourceCommunity(self.object.state.name, role.name, self.object, request):
				response=super(ArticleEditView, self).get(request, *args, **kwargs)
				sessionid = create_session_community(request, community.id)
				response.set_cookie('sessionID', sessionid)
				return response
			return redirect('article_view',pk=self.object.pk)
		return redirect('commnity_view',pk=community.pk)

	def get_context_data(self, **kwargs):
		# Call the base implementation first to get a context
		context = super().get_context_data(**kwargs)
		community = self.get_community()
		if self.is_communitymember(self.request, community):
			context['role'] = self.get_communityrole(self.request, community)
			context['url'] = settings.SERVERURL
			context['padid'] = get_pad_id(self.object.pk)
		return context

	def form_valid(self, form):
		"""
		If the form is valid, save the associated model.
		"""
		self.object = form.save(commit=False)
		if get_pad_usercount(self.object.pk) <= 1:
			self.object.body = getHTML(self.object)
			self.object.save()
			if self.is_visible():
				self.process_visible()
			if self.is_publishable():
				self.process_publishable()
			if self.object.state.final:
				self.process_final()
			return super(ArticleEditView, self).form_valid(form)
		messages.success(request, 'The article state cannot be change at this moment because currently there are more than one user editing this article. You can save your changes.')
		return super(ArticleEditView, self).form_invalid(form)

	def is_communitymember(self, request, community):
		return CommunityMembership.objects.filter(user =request.user, community = community).exists()

	def get_community(self):
		article= CommunityArticles.objects.get(article=self.object)
		return article.community

	def get_communityrole(self, request, community):
		community = CommunityMembership.objects.get(user =request.user, community = community)
		return community.role

	def is_visible(self):
		if self.object.state == States.objects.get(name='visible'):
			return True
		return False

	def is_publishable(self):
		if self.object.state == States.objects.get(name='publishable'):
			return True
		return False

	def process_final(self):
		self.object.published_on = datetime.datetime.now()
		self.object.published_by=self.request.user
		self.object.save()
		create_resource_feed(self.object,'article_published',self.object.created_by)
		notify_update_article_state(self.request.user, self.object,'published')
		return

	def process_visible(self):
		return

	def process_publishable(self):
		notify_update_article_state(self.request.user,self.object,'publishable')
		create_resource_feed(self.object,"article_no_edit",self.request.user)
		return

	def get_success_url(self):
		"""
		Returns the supplied URL.
		"""
		if self.success_url:
			return reverse(self.success_url,kwargs={'pk': self.object.pk})
		else:
			try:
				url = self.object.get_absolute_url()
			except AttributeError:
				raise ImproperlyConfigured(
				"No URL to redirect to.  Either provide a url or define"
				" a get_absolute_url method on the Model.")
		return url

	
def delete_article(request, pk):
	"""
	a function to delete an article.
	The business logic is not yet implemented for deleting an article.
	It just displays a message

	"""
	if request.user.is_authenticated:
		article = Articles.objects.get(pk=pk)
		if article.state != States.objects.get(name='publish'):
			if request.method=='POST':
				status = request.POST['status']
				if status == '0':
					return redirect('article_view',pk=pk)
				elif status == '1':
					deletePad(article)
					article.delete()
					return redirect('display_articles')
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
				return render(request, 'delete_article.html', {'article': article,'membership':membership})
		else:
			return redirect('article_view',pk=pk)
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
