from django.shortcuts import redirect, render
from .models import Media
from workflow.models import States
from Community.models import CommunityMedia, CommunityMembership, Community
from workflow.views import canEditResourceCommunity
from django.core.paginator import Paginator, EmptyPage, PageNotAnInteger

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
		if cmedia.media.state == States.objects.get(name='draft') and cmedia.media.created_by != request.user:
			return redirect('home')
		canEdit = ""
		if CommunityMembership.objects.filter(user=request.user.id, community=cmedia.community).exists():
			membership = CommunityMembership.objects.get(user=request.user.id, community=cmedia.community)
			canEdit = canEditResourceCommunity(cmedia.media.state.name, membership.role.name, cmedia.media, request)
	except CommunityImages.DoesNotExist:
		raise Http404
	return render(request, 'view_media.html', {'cmedia':cmedia, 'canEdit':canEdit})