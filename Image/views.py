from django.shortcuts import redirect, render
from .models import Images
from workflow.models import States
from Community.models import CommunityImages, CommunityMembership
from workflow.views import canEditResourceCommunity

def create_image(request):
	"""
	create a new image. This function will be called for creating an
	image in community or group.
	"""
	if request.user.is_authenticated:
		if request.method == 'POST':
			state = States.objects.get(name='draft')
			title = request.POST['title']
			image = request.FILES['image']
			article = Images.objects.create(
				title = title,
				image = image,
				created_by = request.user,
				state = state
				)
			return article
	else:
		return redirect('login')

def image_view(request, pk):
	try:
		image = CommunityImages.objects.get(image=pk)
		if image.image.state == States.objects.get(name='draft') and image.image.created_by != request.user:
			return redirect('home')
		canEdit = ""
		if CommunityMembership.objects.filter(user=request.user.id, community=image.community).exists():
			membership = CommunityMembership.objects.get(user=request.user.id, community=image.community)
			canEdit = canEditResourceCommunity(image.image.state.name, membership.role.name, image.image, request)
	except CommunityImages.DoesNotExist:
		raise Http404
	return render(request, 'view_image.html', {'image':image, 'canEdit':canEdit})
 