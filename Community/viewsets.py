from .models import Community
from .serializers import CommunitySerializer
from rest_framework import viewsets

# Create your views here.

class CommunityViewSet(viewsets.ModelViewSet):
	queryset = Community.objects.all().order_by('name')
	serializer_class = CommunitySerializer
