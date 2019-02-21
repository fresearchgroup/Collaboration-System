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
from django.views.generic import CreateView
from workflow.models import States
from .forms import MediaCreateForm

class MediaCreateView(CreateView):
	form_class = MediaCreateForm
	model = Media
	template_name = 'new_media.html'
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

def media_edit(request,pk):
	if request.user.is_authenticated:
		try:
			media = Media.objects.get(pk=pk)
		except Media.DoesNotExist:
			return redirect('home')			
		metadata = Metadata.objects.get(pk=media.metadata.pk)
		if media.state == States.objects.get(name='draft') and media.created_by != request.user:
			return redirect('home')
		uid = request.user.id
		membership = None
		message = 'True'
		states = ['']
		commgrp, membership = get_belongsto(pk, request.user.id)
		if membership:
			if request.method == 'POST':
				title = request.POST['name']
				getstate = request.POST['change_media_state']
				state = States.objects.get(name=getstate)
				description = request.POST['description']
				media.title = title
				media.state = state
				metadata.description = description
				uploadOrLink = request.POST['uploadOrLink']
				if uploadOrLink == 'upload':
					try:
						mediafile = request.FILES['mediafile']
						media.mediafile = mediafile
					except:
						message = 'media not uploaded'
				if uploadOrLink == 'link':
					try:
						mediafile = request.POST['medialink']
						media.medialink = medialink
					except:
						message = 'no media link'
				media.save()
				metadata.save()
				return redirect('media_view',pk=pk)
			else:
				states = getStatesCommunity(media.state.name)
				if canEditResourceCommunity(media.state.name, membership.role.name, media, request):
					return render(request, 'edit_media.html', {'media':media, 'membership':membership, 'commgrp':commgrp, 'states':states})
				return redirect('media_view',pk=pk)
		else:
			return redirect('media_view',pk=pk)
	else:
		return redirect('login')

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
