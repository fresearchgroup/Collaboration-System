from django.shortcuts import redirect, render
from .models import Media
from workflow.models import States
from Community.models import CommunityMedia, CommunityMembership, Community
from workflow.views import canEditResourceCommunity, getStatesCommunity
from django.core.paginator import Paginator, EmptyPage, PageNotAnInteger
from metadata.models import MediaMetadata, Metadata
import requests

def create_media(request):
	if request.user.is_authenticated:
		if request.method == 'POST':
			state = States.objects.get(name='draft')
			title = request.POST['title']
			mediatype = request.POST['mediatype']
			mediafile = request.FILES['mediafile']
			media_resource = Media.objects.create(
				title = title,
				mediatype = mediatype,
				mediafile = mediafile,
				created_by = request.user,
				state = state
				)
			return media_resource
	else:
		return redirect('login')

def media_view(request, pk):
	try:
		gcmedia = CommunityMedia.objects.get(media=pk)
		mediametadata = MediaMetadata.objects.get(media=pk)
	except CommunityMedia.DoesNotExist:
		return redirect('home')
	if gcmedia.media.state == States.objects.get(name='draft') and gcmedia.media.created_by != request.user:
		return redirect('home')
	# canEdit = ""
	# if CommunityMembership.objects.filter(user=request.user.id, community=cmedia.community).exists():
	# 	membership = CommunityMembership.objects.get(user=request.user.id, community=cmedia.community)
	# 	canEdit = canEditResourceCommunity(cmedia.media.state.name, membership.role.name, cmedia.media, request)

	return render(request, 'view_media.html', {'gcmedia':gcmedia, 'mediametadata':mediametadata})

def media_edit(request,pk):
	if request.user.is_authenticated:
		try:
			media = Media.objects.get(pk=pk)
		except Media.DoesNotExist:
			return redirect('home')			
		mediametadata = MediaMetadata.objects.get(media=media)
		metadata = Metadata.objects.get(pk=mediametadata.metadata.pk)
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
				try:
					mediafile = request.FILES['mediafile']
					media.mediafile = mediafile
				except:
					message = 'media not uploaded'
				media.save()
				metadata.save()
				return redirect('media_view',pk=pk)
			else:
				states = getStatesCommunity(media.state.name, membership.role.name)
				if canEditResourceCommunity(media.state.name, membership.role.name, media, request):
					return render(request, 'edit_media.html', {'media':media, 'membership':membership, 'commgrp':commgrp, 'mediametadata':mediametadata, 'states':states})
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
