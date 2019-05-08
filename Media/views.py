from django.shortcuts import redirect, render
from .models import Media
from workflow.models import States
from Community.models import CommunityMedia, CommunityMembership, Community
from workflow.views import canEditResourceCommunity, getStatesCommunity
from django.core.paginator import Paginator, EmptyPage, PageNotAnInteger
from metadata.models import Metadata
import requests
from django.urls import reverse
from django.contrib import messages
from django.views.generic import CreateView, UpdateView
from workflow.models import States
from .forms import *

class MediaCreateView(CreateView):
	form_class = MediaCreateForm
	model = Media
	template_name = 'create_update_media.html'
	context_object_name = 'media'
	success_url = 'media_view'

	def get_initial(self):
		"""
		Returns the initial data to use for forms on this view.
		"""
		initial= self.initial.copy()
		initial.update({'mediatype': self.kwargs['mediatype'] })
		return initial

	def get_context_data(self, **kwargs):
		# Call the base implementation first to get a context
		context = super().get_context_data(**kwargs)
		context['community'] = Community.objects.get(pk=self.kwargs['pk'])
		return context

	def get(self, request, *args, **kwargs):
		if request.user.is_authenticated:
			if self.kwargs['mediatype'] in dict(self.model.media_types):
				if Community.objects.filter(pk=self.kwargs['pk']).exists():
					if self.is_communitymember(request, Community.objects.get(pk=self.kwargs['pk'])):
						self.object = None
						return super(MediaCreateView, self).get(request, *args, **kwargs)
					messages.success(self.request, 'Please join this community to create content')
					return redirect('community_view', self.kwargs['pk'])
				return redirect('home')
			messages.warning(self.request, 'Media type not available')
			return redirect('community_view', self.kwargs['pk']) 
		return redirect('login')

	def form_valid(self, form):
		self.object = form.save(commit=False)
		self.object.mediatype = self.kwargs['mediatype']
		self.object.created_by = self.request.user
		self.object.state = States.objects.get(initial=True)
		self.object.save()
        
		community = Community.objects.get(pk=self.kwargs['pk'])
		CommunityMedia.objects.create(media=self.object, user=self.request.user, community=community)

		return super(MediaCreateView, self).form_valid(form)

	def get_form_kwargs(self):
		kwargs = super(MediaCreateView, self).get_form_kwargs()
		kwargs.update({'mediatype': self.kwargs['mediatype']})
		return kwargs

	def get_success_url(self):
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
		return CommunityMembership.objects.filter(user=request.user, community=community).exists()

def media_view(request, pk):
	try:
		gcmedia = CommunityMedia.objects.get(media=pk)
	except CommunityMedia.DoesNotExist:
		return redirect('home')
	if gcmedia.media.state == States.objects.get(name='draft') and gcmedia.media.created_by != request.user:
		return redirect('home')
	# canEdit = ""
	# if CommunityMembership.objects.filter(user=request.user.id, community=cmedia.community).exists():
	# 	membership = CommunityMembership.objects.get(user=request.user.id, community=cmedia.community)
	# 	canEdit = canEditResourceCommunity(cmedia.media.state.name, membership.role.name, cmedia.media, request)

	return render(request, 'view_media.html', {'gcmedia':gcmedia})

class MediaUpdateView(UpdateView):
	form_class = MediaUpdateForm
	model = Media
	template_name = 'create_update_media.html'
	pk_url_kwarg = 'pk'
	context_object_name = 'media'
	success_url = 'media_view'

	def get(self, request, *args, **kwargs):
		if request.user.is_authenticated:
			self.object = self.get_object()
			if self.object.state.initial and self.object.created_by != request.user:
				return redirect('home')
			if self.object.state.final:
				messages.warning(request, 'Published content are not editable.')
				return redirect('media_view',pk=self.object.pk)
			community = self.get_community()
			if self.is_communitymember(request, community):
				role = self.get_communityrole(request, community)
				if canEditResourceCommunity(self.object.state.name, role.name, self.object, request):
					response=super(MediaUpdateView, self).get(request, *args, **kwargs)
					return response
				return redirect('media_view',pk=self.object.pk)
			return redirect('community_view',pk=community.pk)
		return redirect('login')

	def get_context_data(self, **kwargs):
		# Call the base implementation first to get a context
		context = super().get_context_data(**kwargs)
		community = self.get_community()
		if self.is_communitymember(self.request, community):
			context['role'] = self.get_communityrole(self.request, community)
		return context

	def get_form_kwargs(self):
		kwargs = super(MediaUpdateView, self).get_form_kwargs()
		kwargs.update({'role': self.get_communityrole(self.request, self.get_community())})
		kwargs.update({'mediatype': self.object.mediatype})
		return kwargs

	def form_valid(self, form):
		"""
		If the form is valid, save the associated model.
		"""
		self.object = form.save(commit=False)
		self.object.save()
		return super(MediaUpdateView, self).form_valid(form)

	def is_communitymember(self, request, community):
		return CommunityMembership.objects.filter(user=request.user, community=community).exists()

	def get_community(self):
		media= CommunityMedia.objects.get(media=self.object)
		return media.community

	def get_communityrole(self, request, community):
		community = CommunityMembership.objects.get(user=request.user, community=community)
		return community.role

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

def media_reports(request, pk):
	if request.user.is_authenticated:
		try:
			gcmedia = CommunityMedia.objects.get(media=pk)
		except CommunityMedia.DoesNotExist:
			return redirect('home')
		return render(request, 'reports_media.html', {'gcmedia':gcmedia })
	
	return redirect('login')

def get_belongsto(pk, uid):
	community = CommunityMedia.objects.get(media=pk)
	commgrp = Community.objects.get(pk=community.community.id)
	membership = CommunityMembership.objects.get(user=uid, community=commgrp.id)
	return commgrp, membership

def display_published_media(request, mediatype):
	try: 
		cmedialist = CommunityMedia.objects.filter(media__state__name='publish', media__mediatype=mediatype)

		medialist = list(cmedialist)
		
		page = request.GET.get('page', 1)
		paginator = Paginator(list(medialist), 5)
		try:
			mediaPublished = paginator.page(page)
		except PageNotAnInteger:
			mediaPublished = paginator.page(1)
		except EmptyPage:
			mediaPublished = paginator.page(paginator.num_pages)

		if mediatype == 'Image':
			return render(request, 'images_published.html',{'mediaPublished':mediaPublished})
		elif mediatype == 'Audio':
			return render(request, 'audio_published.html',{'mediaPublished':mediaPublished})
		else:
			return render(request, 'video_published.html',{'mediaPublished':mediaPublished})
	except CommunityMedia.DoesNotExist:
		errormessage = 'No published media in community'
