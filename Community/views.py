from django.shortcuts import render, redirect

# Create your views here.
from django.http import Http404, HttpResponse, JsonResponse
from .models import Community, CommunityMembership, CommunityArticles, RequestCommunityCreation, RequestCommunityCreationAssignee, RequestCommunityCreationDetails, CommunityCourses, CommunityMedia
from rest_framework import viewsets
# from .models import CommunityGroups
from UserRolesPermission.views import user_dashboard
from django.contrib.auth.models import Group as Roles
from rolepermissions.roles import assign_role
from UserRolesPermission.roles import CommunityAdmin
from django.contrib.auth.models import User
from workflow.models import States
from django.db.models import Q
from django.core.paginator import Paginator, EmptyPage, PageNotAnInteger
from Course.views import course_view, create_course
from notifications.signals import notify
from actstream import action
from actstream.models import Action
from actstream.models import target_stream
from django.contrib.contenttypes.models import ContentType
from feeds.views import update_role_feed,remove_or_add_user_feed
from notification.views import notify_subscribe_unsubscribe, notify_update_role, notify_remove_or_add_user
from django.conf import settings
from ast import literal_eval
import json
import datetime
import requests
from etherpad.views import create_community_ether, create_article_ether_community, create_session_community
from django.views.generic import CreateView, UpdateView
from .forms import CommunityCreateForm, RequestCommunityCreateForm, CommunityUpdateForm, SubCommunityCreateForm
from django.contrib import messages
from django.db import connection
from django.urls import reverse
from Categories.models import Category
from PIL import Image
from django.views.generic import TemplateView
from django.views.generic.detail import DetailView
from django.http import JsonResponse
from haystack.generic_views import FacetedSearchView as BaseFacetedSearchView
from haystack.query import SearchQuerySet
from .forms import FacetedProductSearchForm
from UserRolesPermission.models import ProfileImage
from django.db.models import Count
from django.db.models import F
from BasicArticle.models import Articles
from Media.models import Media
from django.contrib.auth.models import User

def display_communities(request):
	if request.method == 'POST':
		if 'sortby' in request.POST:
			sortby = request.POST['sortby']
			if sortby == 'a_to_z':
				communities=Community.objects.filter(parent=None).order_by('name')
			if sortby == 'z_to_a':
				communities=Community.objects.filter(parent=None).order_by('-name')
			if sortby == 'oldest':
				communities=Community.objects.filter(parent=None).order_by('created_at')
			if sortby == 'latest':
				communities=Community.objects.filter(parent=None).order_by('-created_at')
		elif 'category' in request.POST:
			category = request.POST['category']
			category = Category.objects.get(pk=category)
			communities=Community.objects.filter(category=category)
	else:
		communities=Community.objects.filter(parent=None).order_by('name')
	return render(request, 'communities.html',{'communities':communities})

def community_view(request, pk):
	try:
		message = 0
		community = Community.objects.get(pk=pk)
		uid = request.user.id
		membership = CommunityMembership.objects.get(user =uid, community = community.pk)
		role = Roles.objects.get(name='community_admin')
		if membership.role == role:
			count = CommunityMembership.objects.filter(community=community,role=role).count()
			if count < 2:
				message = 1
	except CommunityMembership.DoesNotExist:
		membership = 'FALSE'
	subscribers = CommunityMembership.objects.filter(community = pk).count()
	pubarticles = CommunityArticles.objects.raw('select ba.id, ba.body, ba.title, workflow_states.name as state from  workflow_states, BasicArticle_articles as ba , Community_communityarticles as ca  where ba.state_id=workflow_states.id and  ca.article_id =ba.id and ca.community_id=%s and ba.state_id in (select id from workflow_states as w where w.name = "publish");', [community.pk])
	pubarticlescount = len(list(pubarticles))

	top_contributors = CommunityArticles.objects.values('user__username').annotate(num=Count('user__username')).filter(community=community).order_by('-num')[:8]
	for top in top_contributors:
		username = top['user__username']
		try:
			user_profile = ProfileImage.objects.get(user__username=username)
			top['photo'] = user_profile.photo
		except ProfileImage.DoesNotExist:
			top['photo'] = ''

	communitymem=CommunityMembership.objects.filter(community = pk).order_by('?')[:10]
	for comm in communitymem:
		try:
			user_profile = ProfileImage.objects.get(user=comm.user)
			comm.photo = user_profile.photo
		except ProfileImage.DoesNotExist:
			user_profile = "No Image available"
	children = community.get_children().order_by('-contribution_status')
	childrencount = children.count()
	return render(request, 'communityview.html', {'community': community, 'membership':membership, 'subscribers':subscribers, 'top_contributors':top_contributors, 'pubarticlescount':pubarticlescount, 'message':message, 'pubarticles':pubarticles, 'communitymem':communitymem, 'children':children, 'childrencount':childrencount})

def community_subscribe(request):
	cid = request.POST['cid']
	if request.user.is_authenticated:
		if request.method == 'POST':
			community=Community.objects.get(pk=cid)
			role = Roles.objects.get(name='author')
			user = request.user

			if CommunityMembership.objects.filter(user=user, community=community).exists():
				return redirect('community_view',pk=cid)
			notify_subscribe_unsubscribe(request.user,community, 'subscribe')
			obj = CommunityMembership.objects.create(user=user, community=community, role=role)
			return redirect('community_view',pk=cid)
		return render(request, 'communityview.html')
	else:
		return redirect('/login/?next=/community-view/%d' % int(cid) )



def community_unsubscribe(request):
	if request.user.is_authenticated:
		if request.method == 'POST':
			cid = request.POST['cid']
			community=Community.objects.get(pk=cid)
			user = request.user
			if CommunityMembership.objects.filter(user=user, community=community).exists():
				remove_or_add_user_feed(user,community,'left')
				notify_remove_or_add_user(user, user, community, 'left')
				obj = CommunityMembership.objects.filter(user=user, community=community).delete()
				#notify_subscribe_unsubscribe(request.user, community, 'unsubscribe')
			return redirect('community_view',pk=cid)
		return render(request, 'communityview.html')
	else:
		return redirect('login')

class RequestCommunityCreationView(CreateView):
	form_class = RequestCommunityCreateForm
	model = RequestCommunityCreationDetails
	template_name = 'request_community_creation.html'
	success_url = 'request_community_creation'

	def get_form_kwargs(self):
		kwargs = super(RequestCommunityCreationView, self).get_form_kwargs()
		kwargs['cid'] = self.request.GET.get('cid')
		return kwargs

	def get(self, request, *args, **kwargs):
		if request.user.is_authenticated:
			self.object = None
			return super(RequestCommunityCreationView, self).get(request, *args, **kwargs)
		return redirect('login')

	def form_valid(self, form):
		"""
		If the form is valid, save the associated model.
		"""
		self.object = form.save(commit=False)
		self.object.actionby = self.request.user

		cid = form.cleaned_data.get('parent')
		parent = Community.objects.get(name=cid)

		rcommunity = RequestCommunityCreation.objects.create(
			requestedon = datetime.datetime.now(),
			requestedby = self.request.user,
			email = self.request.user.email,
			parent = parent
		)
		self.object.requestcommunity = rcommunity
		self.object.save()

		curators = User.objects.filter(groups__name='curator').exclude(username='admin').order_by('pk')
		curatorCount = curators.count()
		requestCount = RequestCommunityCreation.objects.all().count()
		curatorNo = requestCount % curatorCount
		assignedto = curators[curatorNo]

		RequestCommunityCreationAssignee.objects.create(
			requestcommunity = rcommunity,
			assignedto = assignedto,
			assignedon = datetime.datetime.now()
		)
		messages.success(self.request, 'Request for creation of place of worship successfully submited.')
		return super(RequestCommunityCreationView, self).form_valid(form)

	def get_success_url(self):
		"""
		Returns the supplied URL.
		"""
		if self.success_url:
			return reverse(self.success_url)
		else:
			try:
				url = self.object.get_absolute_url()
			except AttributeError:
				raise ImproperlyConfigured(
				"No URL to redirect to.  Either provide a url or define"
				" a get_absolute_url method on the Model.")
		return url

def update_community_requests(request):
	pk = request.POST['pk']
	rcommunity=RequestCommunityCreation.objects.get(pk=pk)
	user = request.user
	name = request.POST['name']
	desc = request.POST['description']
	area = request.POST['area']
	city = request.POST['city']
	state = request.POST['state']
	pincode = request.POST['pincode']
	reason = request.POST['reason']

	RequestCommunityCreationDetails.objects.create(
		requestcommunity = rcommunity,
		name = name,
		desc = desc,
		area = area,
		city = city,
		state = state,
		pincode = pincode,
		status = 'Requested',
		actionby = user,
		reason = reason,
		actionon = datetime.datetime.now()
	)
	return redirect('user_dashboard')

def handle_community_creation_requests(request):

	u = User.objects.get(username=request.user)
	if u.groups.filter(name='curator').exists():
		# if request.user.is_superuser:
		if request.method == 'POST':
			pk = request.POST['pk']
			rcommunity=RequestCommunityCreation.objects.get(pk=pk)
			user = request.user
			community_parent = request.POST['community_parent']
			parent = Community.objects.get(pk=community_parent)
			status = request.POST['status']

			if status=='accept':
				name = request.POST['name']
				desc = request.POST['description']
				area = request.POST['area']
				city = request.POST['city']
				state = request.POST['state']
				pincode = request.POST['pincode']
				communitycreation = Community.objects.create(
					name = name,
					desc = desc,
					area = area,
					city = city,
					state = state,
					pincode = pincode,
					created_by = user,
					parent = parent,
					contributed_by = rcommunity.requestedby
				)

				RequestCommunityCreationDetails.objects.create(
					requestcommunity = rcommunity,
					name = communitycreation.name,
					desc = communitycreation.desc,
					area = communitycreation.area,
					city = communitycreation.city,
					state = communitycreation.state,
					pincode = communitycreation.pincode,
					status = 'accepted',
					actionby = user,
					actionon = datetime.datetime.now()
				)
				Community.objects.create(name='Introduction', created_by = user, parent = communitycreation)
				Community.objects.create(name='Architecture', created_by = user, parent = communitycreation)
				Community.objects.create(name='Rituals', created_by = user, parent = communitycreation)
				Community.objects.create(name='Ceremonies', created_by = user, parent = communitycreation)
				Community.objects.create(name='Tales', created_by = user, parent = communitycreation)
				Community.objects.create(name='More Information', created_by = user, parent = communitycreation)
				
				communityadmin = Roles.objects.get(name='community_admin')
				CommunityMembership.objects.create(
					user = user,
					community = communitycreation,
					role = communityadmin
				)
				remove_or_add_user_feed(rcommunity.requestedby,communitycreation,'community_created')
		
			if status=='modify' or status=='rejected':
				reason = request.POST['reason']
				rcom = RequestCommunityCreationDetails.objects.filter(requestcommunity__id=pk).order_by('-actionon')[:1]
				RequestCommunityCreationDetails.objects.create(
					requestcommunity = rcommunity,
					name = rcom[0].name,
					desc = rcom[0].desc,
					area = rcom[0].area,
					city = rcom[0].city,
					state = rcom[0].state,
					pincode = rcom[0].pincode,
					status = status,
					reason = reason,
					actionby = user,
					actionon = datetime.datetime.now()
				)

		rids = RequestCommunityCreation.objects.all().values_list('pk', flat=True)
		requestcommunitycreation = []
		for i in rids:
			rcom = RequestCommunityCreationDetails.objects.filter(requestcommunity__id=i).order_by('-actionon')[:1]
			assignees = RequestCommunityCreationAssignee.objects.filter(requestcommunity__id=i).order_by('-assignedon')[:1]
			for r in rcom:
				r.assignedto = assignees[0].assignedto
				r.assignedon = assignees[0].assignedon
				requestcommunitycreation.append(r)
			for r in requestcommunitycreation:
				print(r.name)
				print(r.assignedto)
		return render(request, 'community_creation_requests.html',{'requestcommunitycreation':requestcommunitycreation})
	else:
		return redirect('login')

def manage_community(request,pk):
	if request.user.is_authenticated:
		community = Community.objects.get(pk=pk)
		uid = request.user.id
		errormessage = ''
		membership = None
		try:
			membership = CommunityMembership.objects.get(user =uid, community = community.pk)
			if membership.role.name == 'community_admin':
				count = CommunityMembership.objects.filter(community = community.pk, role=membership.role).count()
				members = CommunityMembership.objects.filter(community = community.pk)
				if request.method == 'POST':
					try:
						username = request.POST['username']
						rolename = request.POST['role']
						user = User.objects.get(username = username)
						role = Roles.objects.get(name=rolename)
						status = request.POST['status']

						if status == 'add':
							try:
								is_member = CommunityMembership.objects.get(user =user, community = community.pk)
							except CommunityMembership.DoesNotExist:
								obj = CommunityMembership.objects.create(user=user, community=community, role=role)
								notify_remove_or_add_user(request.user, user, community, 'added')
								if rolename=='publisher' or rolename=='community_admin':
									remove_or_add_user_feed(user,community,'added')

							else:
								errormessage = 'user exists in community'
						if status == 'update':
							if count > 1 or count == 1 and username != request.user.username:
								try:
									update_role_feed(user,community,rolename)
									notify_update_role(request.user, user,community,rolename)
									is_member = CommunityMembership.objects.get(user =user, community = community.pk)
									is_member.role = role
									is_member.save()


								except CommunityMembership.DoesNotExist:
									errormessage = 'no such user in the community'
							else:
								errormessage = 'cannot update this user'
						if status == 'remove':
							if count > 1 or count == 1 and username != request.user.username:
								try:
									remove_or_add_user_feed(user,community,'removed')
									notify_remove_or_add_user(request.user, user,community,'removed')
									obj = CommunityMembership.objects.filter(user=user, community=community).delete()



								except CommunityMembership.DoesNotExist:
									errormessage = 'no such user in the community'
							else:
								errormessage = 'cannot remove this user'
						return render(request, 'managecommunity.html', {'community': community, 'members':members,'membership':membership, 'errormessage':errormessage})
	#					return redirect('manage_community',pk=pk)
					except User.DoesNotExist:
						errormessage = "no such user in the system"

				return render(request, 'managecommunity.html', {'community': community, 'members':members,'membership':membership, 'errormessage':errormessage})
			else:
				return redirect('community_view',pk=pk)
		except CommunityMembership.DoesNotExist:
			return redirect('community_view',pk=pk)
	else:
		return redirect('login')

class UpdateCommunityView(UpdateView):
	form_class = CommunityUpdateForm
	model = Community
	template_name = 'updatecommunityinfo.html'
	#community_admin = Roles.objects.get(name='community_admin')
	success_url = 'community_view'
	pk_url_kwarg = 'pk'
	context_object_name = 'community'

	def get(self, request, *args, **kwargs):
		if request.user.is_authenticated:
			self.object = self.get_object()
			membership = self.get_membership()
			if membership and membership.role == Roles.objects.get(name='community_admin'):
				return super(UpdateCommunityView, self).get(request, *args, **kwargs)
			return redirect(self.success_url, self.object.pk)
		return redirect('home')

	def get_context_data(self, **kwargs):
		# Call the base implementation first to get a context
		context = super().get_context_data(**kwargs)
		if self.request.user.is_authenticated:
			context['membership'] = self.get_membership()
		return context

	def get_membership(self):
		if CommunityMembership.objects.filter(user =self.request.user, community = self.object).exists():
			return CommunityMembership.objects.get(user =self.request.user, community = self.object)
		return False

	def form_valid(self, form):
		"""
		If the form is valid, save the associated model.
		"""
		self.object = form.save(commit=False)
		self.object.image_thumbnail = form.cleaned_data.get('image')
		self.object.save()
		
		if form.cleaned_data.get('x'):
			x = form.cleaned_data.get('x')
			y = form.cleaned_data.get('y')
			w = form.cleaned_data.get('width')
			h = form.cleaned_data.get('height')
			image = Image.open(self.object.image_thumbnail)
			cropped_image = image.crop((x, y, w+x, h+y))
			resized_image = cropped_image.resize((200, 200), Image.ANTIALIAS)
			resized_image.save(self.object.image_thumbnail.path)

		return super(UpdateCommunityView, self).form_valid(form)

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


class CreateCommunityView(CreateView):
	form_class = CommunityCreateForm
	model = Community
	template_name = 'create_community.html'
	#community_admin = Roles.objects.get(name='community_admin')
	success_url = 'community_view'

	def get(self, request, *args, **kwargs):
		if request.user.is_superuser:
			self.object = None
			return super(CreateCommunityView, self).get(request, *args, **kwargs)
		return redirect('home')

	def form_valid(self, form):
		"""
		If the form is valid, save the associated model.
		"""
		self.object = form.save(commit=False)
		self.object.image_thumbnail = form.cleaned_data.get('image')

		# forum_link, fid = self.create_forum(self.object.name, self.object.desc)
		# if forum_link is not False:
		# 	self.object.forum_link = forum_link
		# 	self.object.forum = fid
		# else:
		# 	messages.warning(self.request, 'Cannot Create Forum for this community. Please check if default forum is created.')
		# 	return super(CreateCommunityView, self).form_invalid(form)
		self.object.save()

		if self.object.image_thumbnail:
			x = form.cleaned_data.get('x')
			y = form.cleaned_data.get('y')
			w = form.cleaned_data.get('width')
			h = form.cleaned_data.get('height')
			image = Image.open(self.object.image_thumbnail)
			cropped_image = image.crop((x, y, w+x, h+y))
			resized_image = cropped_image.resize((200, 200), Image.ANTIALIAS)
			resized_image.save(self.object.image_thumbnail.path)

		CommunityMembership.objects.create(
			user = self.object.created_by,
			community = self.object,
			role = Roles.objects.get(name='community_admin')
			)

		#create the ether id for community
		try:
			create_community_ether(self.object)
		except Exception as e:
			messages.warning(self.request, 'Cannot create ether id for this Community. Please check whether Etherpad service is running.')

		#create the ether id for community
		try:
			create_wiki_for_community(self.object)
		except Exception as e:
			messages.warning(self.request, 'Cannot create wiki for this Community. Please check default wiki is created.')

		return super(CreateCommunityView, self).form_valid(form)

	def create_forum(self, name, desc):
		# Create Forum for this community
		try:
			cursor = connection.cursor()
			cursor.execute(''' select tree_id from forum_forum order by tree_id DESC limit 1''')
			try:
				tree_id = cursor.fetchone()[0] + 1
			except:
				tree_id = 0
			slug = "-".join(name.lower().split())
			#return HttpResponse(str(tree_id))
			insert_stmt = (
				  "INSERT INTO forum_forum (created,updated,name,slug,description,link_redirects,type,link_redirects_count,display_sub_forum_list,lft,rght,tree_id,level,direct_posts_count,direct_topics_count) "
				  "VALUES (NOW(), NOW(), %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)"
				)
			data = (name, slug, desc, 0,0,0,1,1,2,tree_id,0,0,0)
			cursor.execute(insert_stmt, data)
			cursor.execute(''' select id from forum_forum order by id desc limit 1''')
			fid = str(cursor.fetchone()[0])
			forum_link = slug + '-' + fid
			return forum_link, fid
		except:
			return False, False

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

class CreateSubCommunityView(CreateView):
	form_class = SubCommunityCreateForm
	model = Community
	template_name = 'create_community.html'
	success_url = 'community_view'

	def get_initial(self):
		"""
		Returns the initial data to use for forms on this view.
		"""
		initial= self.initial.copy()
		initial.update({'parent': self.model.objects.get(pk=self.kwargs['pk']) })
		return initial

	def get(self, request, *args, **kwargs):
		if request.user.is_authenticated:
			if self.is_member_of_parent():
				self.object = None
				return super(CreateSubCommunityView, self).get(request, *args, **kwargs)
			messages.warning(self.request, 'You are not a member of this community.')
			return redirect(self.success_url, self.kwargs['pk'])
		return redirect('home')

	def is_member_of_parent(self):
		community = self.model.objects.get(pk=self.kwargs['pk'])
		return CommunityMembership.objects.filter(community=community, user=self.request.user).exists()

	def form_valid(self, form):
		"""
		If the form is valid, save the associated model.
		"""
		self.object = form.save(commit=False)
		self.object.created_by = self.request.user
		self.object.image_thumbnail = form.cleaned_data.get('image')
		self.object.save()

		if self.object.image_thumbnail:
			x = form.cleaned_data.get('x')
			y = form.cleaned_data.get('y')
			w = form.cleaned_data.get('width')
			h = form.cleaned_data.get('height')
			image = Image.open(self.object.image_thumbnail)
			cropped_image = image.crop((x, y, w+x, h+y))
			resized_image = cropped_image.resize((200, 200), Image.ANTIALIAS)
			resized_image.save(self.object.image_thumbnail.path)

		CommunityMembership.objects.create(
			user = self.object.created_by,
			community = self.object,
			role = Roles.objects.get(name='community_admin')
			)

		try:
			create_community_ether(self.object)
		except Exception as e:
			messages.warning(self.request, 'Cannot create ether id for this Community. Please check whether Etherpad service is running.')

		return super(CreateSubCommunityView, self).form_valid(form)

	def get_form_kwargs(self):
		"""
		Returns the keyword arguments for instantiating the form.
		"""
		kwargs = super(CreateSubCommunityView, self).get_form_kwargs()
		kwargs.update({'community': self.model.objects.get(pk=self.kwargs['pk'])})
		return kwargs

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


def community_content(request, pk):
	commarticles = ''
	try:
		community = Community.objects.get(pk=pk)
		uid = request.user.id
		membership = CommunityMembership.objects.get(user=uid, community=community.pk)
		if membership:

			carticles = CommunityArticles.objects.filter(community=community, article__state__initial=False, article__state__final=False).annotate(title=F('article__title'),state=F('article__state__name'),created_at=F('article__created_at'),body=F('article__body'),image=F('article__image'),views=F('article__views'),username=F('article__created_by__username'))
			for art in carticles:
				art.type = 'article'

			ccourse = CommunityCourses.objects.filter(community=community, course__state__initial=False, course__state__final=False).annotate(title=F('course__title'),state=F('course__state__name'),created_at=F('course__created_at'),body=F('course__body'),image=F('course__image'),username=F('course__created_by__username'))
			for course in ccourse:
				course.type = 'course'

			cmedia = CommunityMedia.objects.filter(community=community, media__state__initial=False, media__state__final=False).annotate(title=F('media__title'),state=F('media__state__name'),created_at=F('media__created_at'),mediatype=F('media__mediatype'),image=F('media__mediafile'),username=F('media__created_by__username'))
			for media in cmedia:
				media.type = 'media'

			ch5p = []
			print('new test')
			try:
				response = requests.get(settings.H5P_ROOT + 'h5p/h5papi/?format=json')
				json_data = json.loads(response.text)
				print(json_data)

				for obj in json_data:
					if obj['community_id'] == community.pk:
						obj['type'] = 'h5p'
						ch5p.append(obj)
			except Exception as e:
				print(e)
				print("H5P server down...Sorry!! We will be back soon")
			lstfinal = list(carticles) +  list(cmedia) + list(ccourse) + list(ch5p)

			page = request.GET.get('page', 1)
			paginator = Paginator(list(lstfinal), 5)
			try:
				commarticles = paginator.page(page)
			except PageNotAnInteger:
				commarticles = paginator.page(1)
			except EmptyPage:
				commarticles = paginator.page(paginator.num_pages)

	except CommunityMembership.DoesNotExist:
		return redirect('community_view', community.pk)
	return render(request, 'communitycontent.html', {'community': community, 'membership':membership, 'commarticles':commarticles})


def h5p_view(request, pk):
	try:
		requests.get(settings.H5P_ROOT + 'h5p/h5papi/?format=json')
		return redirect( settings.H5P_ROOT + "h5p/content/?contentId=%s" % pk)
	except ConnectionError:
		return render(request, 'h5pserverdown', {})

def community_course_create(request):
	if request.user.is_authenticated:
		if request.method == 'POST':
			status = request.POST['status']
			cid = request.POST['cid']
			community = Community.objects.get(pk=cid)
			if status=='1':
				course = create_course(request)
				obj = CommunityCourses.objects.create(course=course, user=request.user, community=community)
				return redirect('course_view', course.pk)
			else:
				return render(request, 'new_course.html', {'community':community, 'status':1})
		else:
			return redirect('home')
	else:
		return redirect('login')



def feed_content(request, pk):
	communityfeed = ''
	try:
		community = Community.objects.get(pk=pk)
		uid = request.user.id
		membership = CommunityMembership.objects.get(user=uid, community=community.pk)
		if membership:
			feeds = community.target_actions.all()
			page = request.GET.get('page', 1)
			paginator = Paginator(feeds, 10)
			try:
				communityfeed = paginator.page(page)
			except PageNotAnInteger:
				communityfeed = paginator.page(1)
			except EmptyPage:
				communityfeed = paginator.page(paginator.num_pages)

	except CommunityMembership.DoesNotExist:
		return redirect('community_view', community.pk)

	return render(request, 'communityfeed.html', {'community': community, 'membership':membership, 'feeds':communityfeed})

def community_h5p_create(request):
	if request.user.is_authenticated:
		if request.method == 'POST':
			cid = request.POST['cid']
			request.session['cid'] = cid
			request.session['gid'] = 0
			try:
				requests.get(settings.H5P_ROOT + 'h5p/h5papi/?format=json')
				return redirect(settings.H5P_ROOT + 'h5p/create/')
			except Exception as e:
				print(e)
				return render(request, 'h5pserverdown.html', {})
		return redirect('home')
	return redirect('login')

def create_wiki_for_community(community):

	cursor = connection.cursor()
	wiki_slug = str(community.name) + str(community.pk)
	#Create wiki for this community
	cursor.execute('''SET FOREIGN_KEY_CHECKS=0''')
	insert_stmt_urlpath = (
			"INSERT INTO wiki_urlpath (id, slug, lft, rght, tree_id, level, article_id, parent_id, site_id)"
			"VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s)"
		)

	cursor.execute(''' select rght from wiki_urlpath order by rght DESC limit 1''')
	url_rght = cursor.fetchone()[0]

	cursor.execute(''' select id from wiki_urlpath order by id DESC limit 1''')
	urlpath_id = cursor.fetchone()[0] + 1

	cursor.execute(''' select id from wiki_article order by id DESC limit 1''')
	new_id = cursor.fetchone()[0] + 1

	data_urlpath = (urlpath_id, wiki_slug , url_rght, url_rght + 1, 1, 1, new_id, 1, 1)

	cursor.execute('''update wiki_urlpath set rght = rght + 2 where slug IS NULL''')

	cursor.execute(insert_stmt_urlpath, data_urlpath)

	cursor.execute(''' select id from wiki_articlerevision order by id DESC limit 1''')
	cur_rev_id =  cursor.fetchone()[0] + 1

	insert_stmt_article = (
					"INSERT INTO wiki_article (id, created, modified, group_read, group_write, other_read, other_write,current_revision_id, group_id, owner_id)"
					"VALUES (%s, NOW(), NOW(), %s, %s, %s, %s, %s, %s, %s)"
				)

	data_article = (new_id, 1, 1, 1, 1, cur_rev_id, 1,2)
	cursor.execute(insert_stmt_article, data_article)

	cursor.execute(''' select content_type_id from wiki_articleforobject order by content_type_id DESC limit 1''')
	con_type_id = cursor.fetchone()[0]

	cursor.execute(''' select id from wiki_articleforobject order by id DESC limit 1''')
	forobject_id = cursor.fetchone()[0] + 1

	insert_stmt_articleforobject = (
					"INSERT INTO wiki_articleforobject (id, object_id, is_mptt, article_id, content_type_id)"
					"VALUES (%s, %s, %s, %s, %s)"
				)

	data_articleforobject = (forobject_id, new_id, 1, new_id, con_type_id)

	cursor.execute(insert_stmt_articleforobject, data_articleforobject)

	cursor.execute(''' select id from wiki_articlerevision order by id DESC limit 1''')
	articlerev_id = cursor.fetchone()[0] + 1

	insert_stmt_wikiarticlerevision = (
					"INSERT INTO wiki_articlerevision (id, revision_number, user_message, automatic_log, ip_address, modified, created, deleted, locked, content, title, article_id, user_id)"
					"VALUES (%s, %s, %s, %s, %s, NOW(), NOW(), %s, %s, %s, %s, %s, %s)"
				)

	data_wikiarticlerevision = (articlerev_id ,1, "Write your summary here.", "", "", 0, 0, "Write your content here", str(community.name) , new_id, 2)


	cursor.execute(insert_stmt_wikiarticlerevision, data_wikiarticlerevision)


	cursor.execute('''SET FOREIGN_KEY_CHECKS=1''')

def community_media_create(request):
	if request.user.is_authenticated:
		if request.method == 'POST':
			status = request.POST['status']
			cid = request.POST['cid']
			community = Community.objects.get(pk=cid)
			if status=='1':
				media = create_media(request)
				metadata = create_metadata(request)
				CommunityMedia.objects.create(media=media, user=request.user, community=community)
				MediaMetadata.objects.create(media=media, metadata=metadata)
				return redirect('media_view', media.pk)
			else:
				return render(request, 'new_media.html', {'community':community, 'status':1})
		else:
			return redirect('home')
	else:
		return redirect('login')


class FacetedSearchView(BaseFacetedSearchView, TemplateView):

    form_class = FacetedProductSearchForm
    facet_fields = ['created_at', 'views']
    template_name = 'search_result.html'
    #paginate_by = 3
    # context_object_name = 'object_list'


    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        print("context..................")
        print(context)
        print("self.request.GET >>>>>>>>>>>>>>>>>>>>> ", self.request.GET)
        
        try:
        	if 'community' in self.request.GET:
		        context['community'] = self.request.GET['community']
        	if 'article' in self.request.GET:
	            context['article'] = self.request.GET['article']
        	if 'image' in self.request.GET:
	        	context['image'] = self.request.GET['image']
        	if 'audio' in self.request.GET:
		        context['audio'] = self.request.GET['audio']
        	if 'video' in self.request.GET:
		        context['video'] = self.request.GET['video']
        	if 'query' in self.request.GET:
		        context['query'] = self.request.GET['query']
        except:
            pass
        
        # new_created_at = []
        # for d in context['facets']['fields']['created_at']:
        # 	date_value = datetime.datetime.fromtimestamp(int(str(d[0]))/1000)
        # 	temp_tuple = (date_value, d[1])
        # 	new_created_at.append(temp_tuple)
        # context['facets']['fields']['created_at'] = new_created_at

        object_list = context['object_list']
        return context

def curate_content(request):
	u = User.objects.get(username=request.user)
	if u.groups.filter(name='curator').exists():
		if request.method == 'POST':
			pk = request.POST['pk']
			conttype = request.POST['type']
			status = request.POST['status']
			if status == 'accept':
				state = States.objects.get(name='accepted')
			if status == 'reject':
				state = States.objects.get(name='rejected')
			if conttype == 'Article':
				article = Articles.objects.get(pk=pk)
				article.state = state
				article.save()
			if conttype == 'Media':
				media = Media.objects.get(pk=pk)
				media.state = state
				media.save()

		commarticles = CommunityArticles.objects.filter( Q(article__state__name='submitted') | Q(article__state__name='accepted') | Q(article__state__name='rejected'))
		commmedia = CommunityMedia.objects.filter( Q(media__state__name='submitted') | Q(media__state__name='accepted') | Q(media__state__name='rejected'))
		for cart in commarticles:
			cart.type = 'Article'
		for cmedia in commmedia:
			cmedia.type = 'Media'
		lstContent = list(commarticles) + list(commmedia)
		return render(request, 'curate_content.html',{'lstContent':lstContent})
	return redirect('login')
