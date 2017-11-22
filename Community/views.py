from django.shortcuts import render, redirect

# Create your views here.
from django.shortcuts import render
from .models import Community, CommunityMembership
from rest_framework import viewsets


# Create your views here.


def display_communities(request):
	communities=Community.objects.all()
	return render(request, 'communities.html',{'communities':communities})

def community_view(request, pk):
	try:
		community = Community.objects.get(pk=pk)
		uid = request.user.id
		membership = CommunityMembership.objects.get(user =uid, community = community.pk)
	except CommunityMembership.DoesNotExist:
		membership = 'FALSE'
	subscribers = CommunityMembership.objects.filter(community = pk).count()
	return render(request, 'communityview.html', {'community': community, 'membership':membership, 'subscribers':subscribers})

def community_subscribe(request):
	if request.user.is_authenticated:
		if request.method == 'POST':
			cid = request.POST['cid']
			community=Community.objects.get(pk=cid)
			user = request.user
			obj = CommunityMembership.objects.create(user=user, community=community)
			return redirect('community_view',pk=cid)
		return render(request, 'communityview.html')
	else:
		return redirect('login')

def community_unsubscribe(request):
	if request.method == 'POST':
		cid = request.POST['cid']
		community=Community.objects.get(pk=cid)
		user = request.user
		obj = CommunityMembership.objects.filter(user=user, community=community).delete()
		return redirect('community_view',pk=cid)
	return render(request, 'communityview.html')
