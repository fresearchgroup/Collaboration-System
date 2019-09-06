from django.shortcuts import render, redirect
from .models import Metadata, Schema
from django.views.generic import CreateView, UpdateView
from Community.models import CommunityMembership, Community, CommunityMedia, CommunityArticles
from Media.models import Media
from django.urls import reverse
from django.contrib import messages
from workflow.views import canEditResourceCommunity
from .forms import *
from django.core.exceptions import ObjectDoesNotExist
from BasicArticle.models import Articles

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
	resource_types = ('community', 'article', 'media')

	def get_context_data(self, **kwargs):
		# Call the base implementation first to get a context
		context = super().get_context_data(**kwargs)
		resource_dict = get_resource(str(self.kwargs['resource_type']), int(self.kwargs['resource_id']))
		context['resource'] = resource_dict['resource']
		return context

	def get(self, request, *args, **kwargs):
			if request.user.is_authenticated:
				resource_dict = get_resource(str(self.kwargs['resource_type']), int(self.kwargs['resource_id']))
				resource = resource_dict['resource']
				resource_of = resource_dict['resource_of']
				if resource:
					membership, role, can_create = get_communitymemebership_and_role(request, resource, resource_of)
					if membership and can_create:
						self.object = None
						return super(MetadataCreateView, self).get(request, *args, **kwargs)
					return redirect(self.get_success_url())
				return redirect('home')
			return redirect('login')
					

	def form_valid(self, form):
		self.object = form.save(commit=False)
		attars = dict()
		for key in Schema:
			attars[key] = form.cleaned_data.get(key)
		self.object.attrs=attars
		self.object.save()
		resource = get_resource(str(self.kwargs['resource_type']), int(self.kwargs['resource_id']))
		resource['resource'].metadata = self.object
		resource['resource'].save()
		return super(MetadataCreateView, self).form_valid(form)

	def get_success_url(self):
		if self.kwargs['resource_type'] == 'community':
			return reverse('community_view',kwargs={'pk': self.kwargs['resource_id']})
		elif self.kwargs['resource_type'] == 'article':
			return reverse('article_view',kwargs={'pk': self.kwargs['resource_id']})
		elif self.kwargs['resource_type'] == 'media':
			return reverse('media_view',kwargs={'pk': self.kwargs['resource_id']})
		return None

	def is_communitymember(self, request, community):
		return CommunityMembership.objects.filter(user=request.user, community=community).exists()

class MetadataUpdateView(UpdateView):
	form_class = MetadataUpdateForm
	model = Metadata
	template_name = 'create_update_metadata.html'
	pk_url_kwarg = 'metadata_id'
	context_object_name = 'metadata'

	def get(self, request, *args, **kwargs):
		if request.user.is_authenticated:
			resource_dict = get_resource(str(self.kwargs['resource_type']), int(self.kwargs['resource_id']))
			resource = resource_dict['resource']
			resource_of = resource_dict['resource_of']
			if resource:
				membership, role, can_edit = get_communitymemebership_and_role(request, resource, resource_of)
				if membership and can_edit:
					self.object = resource.metadata
					return super(MetadataUpdateView, self).get(request, *args, **kwargs)
				return redirect(self.get_success_url())
			return redirect('home')
		return redirect('login')


	def get_context_data(self, **kwargs):
		# Call the base implementation first to get a context
		context = super().get_context_data(**kwargs)
		resource_dict = get_resource(str(self.kwargs['resource_type']), int(self.kwargs['resource_id']))
		context['resource'] = resource_dict['resource']
		return context

	def form_valid(self, form):
		self.object = form.save(commit=False)
		attars = dict()
		for key in Schema:
			attars[key] = form.cleaned_data.get(key)
		self.object.attrs=attars
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
		if self.kwargs['resource_type'] == 'community':
			return reverse('community_view',kwargs={'pk': self.kwargs['resource_id']})
		elif self.kwargs['resource_type'] == 'article':
			return reverse('article_view',kwargs={'pk': self.kwargs['resource_id']})
		elif self.kwargs['resource_type'] == 'media':
			return reverse('media_view',kwargs={'pk': self.kwargs['resource_id']})
		return None





def get_media(pk):
	return Media.objects.get(pk=pk)

def get_community(pk):
	return Community.objects.get(pk=pk)

def get_communityrole(request, community):
	community = CommunityMembership.objects.get(user=request.user, community=community)
	return community.role

def get_resource(type, id):
	try:
		if type == 'community':
			return {'resource':Community.objects.get(pk=id), 'resource_of':None}
		elif type == 'article':
			artcile = Articles.objects.get(pk=id)
			belongsto = CommuniyArticles.objects.get(article=artcile)
			return {'resource': artcile, 'resource_of':belongsto.community}
		elif type == 'media':
			media = Media.objects.get(pk=id)
			belongsto = CommunityMedia.objects.get(media=media)
			return {'resource': media, 'resource_of':belongsto.community}
		else:
			return None
	except ObjectDoesNotExist:
		return None

def is_communitymember(request, community):
		return CommunityMembership.objects.filter(user=request.user, community=community).exists()

def get_communitymemebership_and_role(request, resource, resource_of):
	role = None
	can_edit = False
	if isinstance(resource, Community):
		membership = is_communitymember(request, resource)
		if membership:
			role = get_communityrole(request, resource)
			if role.name == 'community_admin':
				can_edit = True
	else:
		membership = is_communitymember(request, resource_of)
		if membership:
			role = get_communityrole(request, resource_of)
			can_edit=canEditResourceCommunity(resource.state.name, role.name, resource, request)

	return membership, role, can_edit