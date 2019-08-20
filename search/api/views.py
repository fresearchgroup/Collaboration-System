from rest_framework import generics
from .serializers import SearchCommunitySerializer
from Community.models import Community

class SearchCommunityAPI(generics.ListAPIView):
	serializer_class = SearchCommunitySerializer

	def get_queryset(self):
		return Community.objects.filter(name__contains=self.kwargs['query'])