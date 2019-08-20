from rest_framework import generics
from .serializers import SearchCommunitySerializer, SearchArticleSerializer, SearchMediaSerializer
from Community.models import Community
from BasicArticle.models import Articles
from Media.models import Media

class SearchCommunityAPI(generics.ListAPIView):
	serializer_class = SearchCommunitySerializer

	def get_queryset(self):
		return Community.objects.filter(name__icontains=self.kwargs['query'])


class SearchArticleAPI(generics.ListAPIView):
	serializer_class = SearchArticleSerializer

	def get_queryset(self):
		return Articles.objects.filter(title__icontains=self.kwargs['query'], state__name='publish')

class SearchMediaAPI(generics.ListAPIView):
	serializer_class = SearchMediaSerializer

	def get_queryset(self):
		return Media.objects.filter(title__icontains=self.kwargs['query'], state__name='publish')