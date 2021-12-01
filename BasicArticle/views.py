from django.shortcuts import render, redirect
from .forms import NewArticleForm, ArticleUpdateForm, ArticleCreateForm, MergedArticleUpdateForm
from django.http import Http404, HttpResponse, JsonResponse
from .models import ArticleStates, Articles, ArticleViewLogs
from django.views.generic import CreateView, UpdateView
from reversion_compare.views import HistoryCompareDetailView
from Community.models import CommunityArticles, CommunityMembership, CommunityGroups, Community, MergedArticles, MergedArticleStates
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
from workflow.views import canEditResourceCommunity, canEditResource
from django.urls import reverse
from etherpad.views import create_article_ether_community
from webcontent.views import sendEmail_contributor_contribution_submitted, sendEmail_curator_contribution_submitted

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
	articlelist = CommunityArticles.objects.filter(article__state__final=True)
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
		resource_ids = favourite.objects.values_list('resource').filter(user=request.user,category='article')
		fav_articles = Articles.objects.filter(pk__in=resource_ids)
	return render(request, 'articles.html',{'articles':articles, 'favs':fav_articles})

def view_article(request, pk):
	"""
	A function to view an article. The function will check if the article belongs to group or
	community before displaying it. It displays whether the article belongs
	to group or community
	"""
	try:
		article = CommunityArticles.objects.get(article=pk)
		statehistory = ArticleStates.objects.filter(article=article.article).order_by('-changedon')
		curator = CommunityMembership.objects.filter(community=article.community.parent).order_by('-assignedon')[:1]
		state = get_state_article(article.article)
		# if article.article.state == States.objects.get(name='draft') and article.article.created_by != request.user:
		u = User.objects.get(username=request.user)
		if article.article.created_by != request.user and not (u.groups.filter(name='curator').exists()) and not (u.groups.filter(name='icpapprover').exists()):
			return redirect('home')
		count = article_watch(request, article.article)
	except CommunityArticles.DoesNotExist:
		raise Http404
	is_fav =''
	if request.user.is_authenticated:
		is_fav = favourite.objects.filter(user = request.user, resource = pk, category= 'article').exists()
	if MergedArticles.objects.filter(community=article.community.parent).exists():
		merged = True
	else:
		merged = False
	
	return render(request, 'view_article.html', {'article': article, 'state': state, 'statehistory':statehistory, 'count':count, 'is_fav':is_fav, 'curator':curator[0].user, 'merged':merged})

def reports_article(request, pk):
	try:
		article = CommunityArticles.objects.get(article=pk)
		if article.article.state == States.objects.get(name='draft') and article.article.created_by != request.user:
			return redirect('home')
	except CommunityArticles.DoesNotExist:
		raise Http404
	return render(request, 'reports_article.html', {'article': article})

class ArticleCreateView(CreateView):
	form_class = ArticleCreateForm
	model = Articles
	template_name = 'create_article.html'
	context_object_name = 'article'
	success_url = 'article_view'

	def get_context_data(self, **kwargs):
		# Call the base implementation first to get a context
		context = super().get_context_data(**kwargs)
		context['community'] = Community.objects.get(pk=self.kwargs['pk'])
		return context

	def get(self, request, *args, **kwargs):
		if request.user.is_authenticated:
			if Community.objects.filter(pk=self.kwargs['pk']).exists():
				# if self.is_communitymember(request, Community.objects.get(pk=self.kwargs['pk'])):
				# 	self.object = None
				# 	return super(ArticleCreateView, self).get(request, *args, **kwargs)
				# messages.success(self.request, 'Please join this community to create article.')
				# return redirect('community_view', self.kwargs['pk'])

				self.object = None
				return super(ArticleCreateView, self).get(request, *args, **kwargs)
			return redirect('home')
		return redirect('login')

	def form_valid(self, form):
		self.object = form.save(commit=False)
		self.object.created_by = self.request.user
		state = States.objects.get(initial=True)
		self.object.state = state
		self.object.save()
		form.save_m2m()
		community = Community.objects.get(pk=self.kwargs['pk'])
		CommunityArticles.objects.create(article=self.object, user = self.request.user , community =community )
		comments = self.request.POST['comments']
		ArticleStates.objects.create(
			article = self.object,
			state = state,
			changedby = self.request.user,
			changedon = datetime.datetime.now(),
			body = self.object.body,
			comments = comments
		)
		if settings.REALTIME_EDITOR:
			try:
				create_article_ether_community(community.pk, self.object)
			except Exception as e:
				messages.success(self.request, 'Reatime services are down.')
			return redirect('article_edit', self.object.pk)
		return super(ArticleCreateView, self).form_valid(form)

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

	def is_communitymember(self, request, community):
		return CommunityMembership.objects.filter(user =request.user, community = community).exists()


class ArticleEditView(UpdateView):
	form_class = ArticleUpdateForm
	model = Articles
	template_name = 'edit_article.html'
	pk_url_kwarg = 'pk'
	context_object_name = 'article'
	success_url = 'article_view'

	def get_form_kwargs(self):
		"""
		Returns the keyword arguments for instantiating the form.
		"""
		kwargs = super(ArticleEditView, self).get_form_kwargs()
		# kwargs.update({'role': self.get_communityrole(self.request, self.get_community())})
		return kwargs

	def get(self, request, *args, **kwargs):
		if request.user.is_authenticated:
			self.object = self.get_object()
			# if self.object.state.initial and self.object.created_by != request.user:
			u = User.objects.get(username=request.user)
			if self.object.created_by != request.user and not (u.groups.filter(name='curator').exists()):				
				return redirect('home')
			# if self.object.state.final:
			# 	messages.warning(request, 'Published content are not editable.')
			# 	return redirect('article_view',pk=self.object.pk)
			community = self.get_community()

			# if self.is_communitymember(request, community):
			# 	role = self.get_communityrole(request, community)
			# 	if canEditResourceCommunity(self.object.state.name, role.name, self.object, request):
			# 		response=super(ArticleEditView, self).get(request, *args, **kwargs)
			# 		if settings.REALTIME_EDITOR:
			# 			sessionid = create_session_community(request, community.id)
			# 			response.set_cookie('sessionID', sessionid)
			# 		return response
			# 	return redirect('article_view',pk=self.object.pk)
			# return redirect('commnity_view',pk=community.pk)
			state = get_state_article(self.object)
			if canEditResource(state.name, self.object, request):
				response=super(ArticleEditView, self).get(request, *args, **kwargs)
				if settings.REALTIME_EDITOR:
					sessionid = create_session_community(request, community.id)
					response.set_cookie('sessionID', sessionid)
				return response
			return redirect('article_view',pk=self.object.pk)
		return redirect('login')

	def get_context_data(self, **kwargs):
		# Call the base implementation first to get a context
		context = super().get_context_data(**kwargs)
		community = self.get_community()
		# if self.is_communitymember(self.request, community):
		# 	context['role'] = self.get_communityrole(self.request, community)
		# 	context['community'] = community
		# 	if settings.REALTIME_EDITOR:
		# 		context['url'] = settings.ETHERPAD_URL
		# 		context['padid'] = get_pad_id(self.object.pk)
		# return context
		context['community'] = community
		if settings.REALTIME_EDITOR:
			context['url'] = settings.ETHERPAD_URL
			context['padid'] = get_pad_id(self.object.pk)
		return context

	def form_valid(self, form):
		"""
		If the form is valid, save the associated model.
		"""
		self.object = form.save(commit=False)
		if settings.REALTIME_EDITOR:
			if get_pad_usercount(self.object.pk) <= 1 or self.object.state == self.model.objects.get(pk=self.object.pk).state:
				self.object.body = getHTML(self.object)
			else:
				messages.warning(self.request, 'The article state cannot be change at this moment because currently there are more than one user editing this article. You can save your changes in present state.')
				return super(ArticleEditView, self).form_invalid(form)
		self.object.save()
		form.save_m2m()
		state = get_state_article(self.object)
		comments = self.request.POST['comments']
		ArticleStates.objects.create(
			article = self.object,
			state = state,
			changedby = self.request.user,
			changedon = datetime.datetime.now(),
			body = self.object.body,
			comments = comments
		)
		# if self.is_visible():
		# 	self.process_visible()
		# if self.is_publishable():
		# 	self.process_publishable()
		# if self.object.state.final:
		# 	self.process_final()
		return super(ArticleEditView, self).form_valid(form)

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
		create_resource_feed(self.object,'article_edit',self.request.user)
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


def submit_article(request):
	if request.method == 'POST':
		state = States.objects.get(name='submitted')
		pk = request.POST['pk']
		article = Articles.objects.get(pk=pk)
		article.state = state
		article.save()
		ArticleStates.objects.create(
			article = article,
			state = state,
			changedby = request.user,
			changedon = datetime.datetime.now(),
			body = article.body
		)

		commparentpk = request.POST['commparentpk']
		community = Community.objects.get(pk=commparentpk)
		role = Roles.objects.get(name='curator')

		if CommunityMembership.objects.filter(community=community, role=role).exists() :
			# Send email to curator
			pass
		else:
			curators = User.objects.filter(groups__name='curator').exclude(username='admin').order_by('pk')
			curatorCount = curators.count()
			level1commCount = Community.objects.filter(level=1).count()
			curatorNo = level1commCount % curatorCount
			assignedto = curators[curatorNo]
			CommunityMembership.objects.create(
				user = assignedto,
				community = community,
				role = role,
				assignedon = datetime.datetime.now()
			)

		# Send email to contributor and curator
		commarticles = article.communityarticles.all()
		section = commarticles[0].community.name
		to = []
		to.append(request.user.email)
		sendEmail_contributor_contribution_submitted(to, 'Article', section, community.name, request.META.get('HTTP_REFERER'))
		to = []
		curator = CommunityMembership.objects.filter(community=community, role=role).order_by('-assignedon')[:1]
		to.append(curator[0].user.email)
		sendEmail_curator_contribution_submitted(to, 'Article', section, community.name, request.META.get('HTTP_REFERER'))

		return redirect('article_view',pk=pk)

def get_state_article(article):
	articlestates = ArticleStates.objects.filter(article=article).order_by('-changedon')[:1]
	return articlestates[0].state

def add_content_by_curator(request):
	commpk = request.POST['pk']
	section = request.POST['section']
	body = request.POST['body']
	user = request.user
	state = States.objects.get(name='accepted')
	parent = Community.objects.get(pk=commpk)
	community = Community.objects.get(name=section, parent=parent)
	article = Articles.objects.create(
		body = body,
		state = state,
		created_at = datetime.datetime.now(),
		created_by = user
	)
	parent = Community.objects.get(pk=commpk)
	community = Community.objects.get(name=section, parent=parent)
	CommunityArticles.objects.create(
		article=article, 
		user = request.user, 
		community =community 
	)
	ArticleStates.objects.create(
		article = article,
		state = state,
		changedby = request.user,
		changedon = datetime.datetime.now(),
		body = body
	)
	return redirect('view_all_content',pk1=commpk, state='accepted')


class MergedArticleEditView(UpdateView):
	form_class = MergedArticleUpdateForm
	model = MergedArticles
	template_name = 'edit_merged_article.html'
	pk_url_kwarg = 'pk'
	context_object_name = 'article'
	success_url = 'view_merged_content'

	def get_form_kwargs(self):
		kwargs = super(MergedArticleEditView, self).get_form_kwargs()
		return kwargs

	def get(self, request, *args, **kwargs):
		if request.user.is_authenticated:
			self.object = self.get_object()
			u = User.objects.get(username=request.user)
			if not (u.groups.filter(name='curator').exists()) and not (u.groups.filter(name='icpapprover').exists()):				
				return redirect('home')
			# state = get_state_article(self.object)

			articlestates = MergedArticleStates.objects.filter(mergedarticle=self.object).order_by('-changedon')[:1]
			state = articlestates[0].state
			# response=super(MergedArticleEditView, self).get(request, *args, **kwargs)
			if canEditResource(state.name, self.object, request):
				response=super(MergedArticleEditView, self).get(request, *args, **kwargs)
				return response
			return redirect('view_merged_content',pk=self.object.community.pk)
		return redirect('login')

	def get_context_data(self, **kwargs):
		context = super().get_context_data(**kwargs)
		# community = self.get_community()
		# context['community'] = self.object.commu
		return context

	def form_valid(self, form):
		self.object = form.save(commit=False)
		self.object.save()
		form.save_m2m()
		comments = self.request.POST['comments']
		MergedArticleStates.objects.create(
			mergedarticle = self.object,
			state = self.object.state,
			changedby = self.request.user,
			changedon = datetime.datetime.now(),
			introduction = self.object.introduction,
			architecture = self.object.architecture,
			rituals = self.object.rituals,
			ceremonies = self.object.ceremonies,
			tales = self.object.tales,
			moreinfo = self.object.moreinfo,
			comments = comments
		)
		return super(MergedArticleEditView, self).form_valid(form)

	def get_success_url(self):
		"""
		Returns the supplied URL.
		"""
		if self.success_url:
			return reverse(self.success_url,kwargs={'pk': self.object.community.pk})
		else:
			try:
				url = self.object.get_absolute_url()
			except AttributeError:
				raise ImproperlyConfigured(
				"No URL to redirect to.  Either provide a url or define"
				" a get_absolute_url method on the Model.")
		return url

