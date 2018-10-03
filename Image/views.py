from django.shortcuts import redirect, render
from .models import Images
from workflow.models import States
from Community.models import CommunityImages, CommunityMembership, Community
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
 
def image_edit(request,pk):
	if request.user.is_authenticated:
		image = Images.objects.get(pk=pk)
		if image.state == States.objects.get(name='draft') and image.created_by != request.user:
			return redirect('home')
		community = CommunityImages.objects.get(image=pk)
		uid = request.user.id
		membership = None
		comm = Community.objects.get(pk=community.community.id)
		errormessage = ''
		try:
			membership = CommunityMembership.objects.get(user=uid, community=comm.id)
			if membership:
				if request.method == 'POST':
					title = request.POST['name']
					getstate = request.POST['change_image_state']
					state = States.objects.get(name=getstate)
					image.title = title
					image.state = state
					try:
						image_image = request.FILES['image_image']
						image.image = image_image
					except:
						errormessage = 'image not uploaded'
					image.save()
					return redirect('image_view',pk=pk)
				else:
					message = canEditResourceCommunity(image.state.name, membership.role.name, image, request)
					if message != 'True':
						return render(request, 'error.html', {'message':message, 'url':'image_view', 'argument':pk})
					return render(request, 'edit_image.html', {'image':image, 'membership':membership, 'community':community, 'comm':comm})
			else:
				return redirect('image_view',pk=pk)
		except CommunityMembership.DoesNotExist:
			return redirect('login')
	else:
		return redirect('login')

