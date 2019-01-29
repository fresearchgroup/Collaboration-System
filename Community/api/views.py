from Community.models import Community, CommunityArticles, CommunityMedia
from .serializers import CommunitySerializer, CommunityArticlesSerializer, CommunityMediaSerializer
from rest_framework import generics

class CommunityListsApi(generics.ListAPIView):
	queryset = Community.objects.all()
	serializer_class = CommunitySerializer


class CommunityArticlesApi(generics.ListAPIView):
	serializer_class = CommunityArticlesSerializer

	def get_queryset(self):
		return CommunityArticles.objects.filter(article__state__name='publish', community = self.kwargs['pk'])

class CommunityMediaApi(generics.ListAPIView):
	serializer_class = CommunityMediaSerializer

	def get_queryset(self):
		return CommunityMedia.objects.filter(media__state__name='publish', media__mediatype=self.kwargs['type'], community = self.kwargs['pk'])