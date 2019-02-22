from django.shortcuts import render, redirect
from .models import Metadata
from django.views.generic import CreateView, UpdateView
from Community.models import CommunityMembership, Community, CommunityMedia
from Media.models import Media
from django.urls import reverse
from django.contrib import messages
from workflow.views import canEditResourceCommunity
from .forms import *

# Create your views here.
def create_metadata(request):
	if request.user.is_authenticated:
		if request.method == 'POST':
			description = request.POST['description']
			metadata = Metadata.objects.create(
				description = description,
				)
			return metadata
	else:
		return redirect('login')

class MetadataCreateView(CreateView):
	form_class = MetadataForm
	model = Metadata
	template_name = 'create_update_metadata.html'
	context_object_name = 'media'
	success_url = 'media_view'

	def get_initial(self):
		"""
		Returns the initial data to use for forms on this view.
		"""
		initial= self.initial.copy()
		return initial

	def get_context_data(self, **kwargs):
		# Call the base implementation first to get a context
		context = super().get_context_data(**kwargs)
		context['community'] = Community.objects.get(pk=self.kwargs['cpk'])
		context['media'] = Media.objects.get(pk=self.kwargs['mdpk'])
		return context

	def get(self, request, *args, **kwargs):
		if request.user.is_authenticated:
			cpk = self.kwargs['cpk']
			mdpk = self.kwargs['mdpk']
			if Community.objects.filter(pk=cpk).exists():
				community = get_community(cpk)
				if self.is_communitymember(request, community):
					if Media.objects.filter(pk=mdpk).exists():
						media = get_media(mdpk)
						role = get_communityrole(request, community)
						if canEditResourceCommunity(media.state.name, role.name, media, request):
							self.object = None
							return super(MetadataCreateView, self).get(request, *args, **kwargs)
						return redirect('media_view', mdpk)
					messages.warning(self.request, 'No such media')
				return redirect('media_view', mdpk)
				messages.warning(self.request, 'Please join this community to create metadata')
				return redirect('community_view', cpk)
			return redirect('home')
		return redirect('login')

	def form_valid(self, form):
		self.object = form.save(commit=False)
		self.object.save()
		redirect_url = super(MetadataCreateView, self).form_valid(form)
		
		media = Media.objects.get(pk=self.kwargs['mdpk'])
		media.metadata = self.object
		media.save()
		return redirect_url

	def get_success_url(self):
		if self.success_url:
			mdpk = self.kwargs['mdpk']
			return reverse(self.success_url,kwargs={'pk': mdpk})
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

class MetadataUpdateView(UpdateView):
	form_class = MetadataForm
	model = Metadata
	template_name = 'create_update_metadata.html'
	pk_url_kwarg = 'pk'
	context_object_name = 'metadata'
	success_url = 'media_view'

	def get(self, request, *args, **kwargs):
		if request.user.is_authenticated:
			self.object = self.get_object()
			media = get_media(self.kwargs['mdpk'])
			if media.state.initial and media.created_by != request.user:
				return redirect('home')
			community = self.get_community(media)
			if self.is_communitymember(request, community):
				role = self.get_communityrole(request, community)
				if canEditResourceCommunity(media.state.name, role.name, self.object, request):
					response=super(MetadataUpdateView, self).get(request, *args, **kwargs)
					return response
				return redirect('media_view',pk=media.pk)
			return redirect('community_view',pk=community.pk)
		return redirect('login')

	def get_context_data(self, **kwargs):
		# Call the base implementation first to get a context
		context = super().get_context_data(**kwargs)
		media = Media.objects.get(pk=self.kwargs['mdpk'])
		context['media'] = media
		community = self.get_community(media)
		context['community'] = community
		return context

	def form_valid(self, form):
		self.object = form.save(commit=False)
		self.object.save()
		return super(MetadataUpdateView, self).form_valid(form)

	def is_communitymember(self, request, community):
		return CommunityMembership.objects.filter(user=request.user, community=community).exists()

	def get_community(self, media):
		media = CommunityMedia.objects.get(media=media)
		return media.community

	def get_communityrole(self, request, community):
		community = CommunityMembership.objects.get(user=request.user, community=community)
		return community.role

	def get_success_url(self):
		"""
		Returns the supplied URL.
		"""
		if self.success_url:
			mdpk = self.kwargs['mdpk']
			return reverse(self.success_url,kwargs={'pk': mdpk})
		else:
			try:
				url = self.object.get_absolute_url()
			except AttributeError:
				raise ImproperlyConfigured(
				"No URL to redirect to.  Either provide a url or define"
				" a get_absolute_url method on the Model.")
		return url





def get_media(pk):
	return Media.objects.get(pk=pk)

def get_community(pk):
	return Community.objects.get(pk=pk)

def get_communityrole(request, community):
	community = CommunityMembership.objects.get(user=request.user, community=community)
	return community.role		