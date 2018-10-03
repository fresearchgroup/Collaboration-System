from django.shortcuts import redirect, render
from .models import Images
from workflow.models import States
from Community.models import CommunityImages, CommunityMembership, Community
from workflow.views import canEditResourceCommunity
from django.core.paginator import Paginator, EmptyPage, PageNotAnInteger

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
			images = Images.objects.create(
				title = title,
				image = image,
				created_by = request.user,
				state = state
				)
			return images
	else:
		return redirect('login')

def image_view(request, pk):
	try:
		image = CommunityImages.objects.get(image_resource=pk)
		if image.image_resource.state == States.objects.get(name='draft') and image.image_resource.created_by != request.user:
			return redirect('home')
		canEdit = ""
		if CommunityMembership.objects.filter(user=request.user.id, community=image.community).exists():
			membership = CommunityMembership.objects.get(user=request.user.id, community=image.community)
			canEdit = canEditResourceCommunity(image.image_resource.state.name, membership.role.name, image.image_resource, request)
	except CommunityImages.DoesNotExist:
		raise Http404
	return render(request, 'view_image.html', {'image':image, 'canEdit':canEdit})
 
def image_edit(request,pk):
	if request.user.is_authenticated:
		image = Images.objects.get(pk=pk)
		if image.state == States.objects.get(name='draft') and image.created_by != request.user:
			return redirect('home')
		community = CommunityImages.objects.get(image_resource=pk)
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

def display_published_images(request):
	imagelist = CommunityImages.objects.filter(image_resource__state__name='publish')
	page = request.GET.get('page', 1)
	paginator = Paginator(list(imagelist), 5)
	try:
		imagesPublished = paginator.page(page)
	except PageNotAnInteger:
		imagesPublished = paginator.page(1)
	except EmptyPage:
		imagesPublished = paginator.page(paginator.num_pages)
	return render(request, 'images_published.html',{'imagesPublished':imagesPublished})
