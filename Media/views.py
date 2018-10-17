from django.shortcuts import redirect, render
from .models import Media
from workflow.models import States
from Community.models import CommunityMedia, CommunityMembership, Community
from workflow.views import canEditResourceCommunity, getStatesCommunity
from django.core.paginator import Paginator, EmptyPage, PageNotAnInteger
from metadata.models import MediaMetadata, Metadata

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
		cmedia = CommunityMedia.objects.get(media=pk)
		mediametadata = MediaMetadata.objects.get(media=pk)
		if cmedia.media.state == States.objects.get(name='draft') and cmedia.media.created_by != request.user:
			return redirect('home')
		canEdit = ""
		if CommunityMembership.objects.filter(user=request.user.id, community=cmedia.community).exists():
			membership = CommunityMembership.objects.get(user=request.user.id, community=cmedia.community)
			canEdit = canEditResourceCommunity(cmedia.media.state.name, membership.role.name, cmedia.media, request)
	except CommunityMedia.DoesNotExist:
		raise Http404
	return render(request, 'view_media.html', {'cmedia':cmedia, 'canEdit':canEdit, 'mediametadata':mediametadata})

def media_edit(request,pk):
	if request.user.is_authenticated:
		media = Media.objects.get(pk=pk)
		mediametadata = MediaMetadata.objects.get(media=media)
		metadata = Metadata.objects.get(pk=mediametadata.metadata.pk)
		if media.state == States.objects.get(name='draft') and media.created_by != request.user:
			return redirect('home')
		community = CommunityMedia.objects.get(media=pk)
		uid = request.user.id
		membership = None
		comm = Community.objects.get(pk=community.community.id)
		errormessage = ''
		try:
			membership = CommunityMembership.objects.get(user=uid, community=comm.id)
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
						errormessage = 'media not uploaded'
					media.save()
					metadata.save()
					return redirect('media_view',pk=pk)
				else:
					states = getStatesCommunity(media.state.name)
					message = canEditResourceCommunity(media.state.name, membership.role.name, media, request)
					if message != 'True':
						return render(request, 'error.html', {'message':message, 'url':'media_view', 'argument':pk})
					return render(request, 'edit_media.html', {'media':media, 'membership':membership, 'community':community, 'comm':comm, 'mediametadata':mediametadata, 'states':states})
			else:
				return redirect('media_view',pk=pk)
		except CommunityMembership.DoesNotExist:
			return redirect('login')
	else:
		return redirect('login')


def display_published_media(request, mediatype):
	try: 
		medialist = CommunityMedia.objects.filter(media__state__name='publish', media__mediatype=mediatype)
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
