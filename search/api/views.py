from rest_framework import generics
from .serializers import SearchCommunitySerializer, SearchArticleSerializer, SearchMediaSerializer
from Community.models import Community
from BasicArticle.models import Articles
from Media.models import Media

class SearchCommunityAPI(generics.ListAPIView):
	serializer_class = SearchCommunitySerializer

	def get_queryset(self):
		query =self.request.query_params.get('query', None)
		if query:
			return Community.objects.filter(name__icontains=query)
		return Community.objects.none()


class SearchArticleAPI(generics.ListAPIView):
	serializer_class = SearchArticleSerializer

	def get_queryset(self):
		query =self.request.query_params.get('query', None)
		if query:
			return Articles.objects.filter(title__icontains=query, state__name='publish')
		return Articles.objects.none()

class SearchMediaAPI(generics.ListAPIView):
	serializer_class = SearchMediaSerializer

	def get_queryset(self):
		query =self.request.query_params.get('query', None)
		if query:
			return Media.objects.filter(title__icontains=query, state__name='publish')
		return Media.objects.none()