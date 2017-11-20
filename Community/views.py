from django.shortcuts import render

# Create your views here.
from django.shortcuts import render
from .models import Community
from .serializers import CommunitySerializer
from rest_framework import viewsets

# Create your views here.


def display_communities(request):
	communities=Community.objects.all()
	return render(request, 'communities.html',{'communities':communities})

def community_view(request, pk):
    try:
        community = Community.objects.get(pk=pk)
    except Community.DoesNotExist:
        raise Http404
    return render(request, 'communityview.html', {'community': community})



class CommunityViewSet(viewsets.ModelViewSet):
	queryset = Community.objects.all().order_by('name')
	serializer_class = CommunitySerializer
