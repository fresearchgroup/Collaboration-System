from Community.models import Community, CommunityArticles, CommunityMedia
from .serializers import CommunitySerializer, CommunityArticlesSerializer, CommunityMediaSerializer
from rest_framework import generics
from BasicArticle.serializers import ArticleSerializer
from BasicArticle.models import Articles
from Media.api.serializers import MediaCreateSerializer
from Media.models import Media
from rest_framework.permissions import IsAuthenticated
from .permissions import IsCommunityMember
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


class CreateCommunityResource(generics.CreateAPIView):
	permission_classes = (IsAuthenticated, IsCommunityMember,)

	def get_serializer_class(self):
		if self.kwargs['resource_type'] == 'article':
			return ArticleSerializer
		elif self.kwargs['resource_type'] == 'media':
			return MediaCreateSerializer
		else:
			return

	def get_queryset(self):
		if self.kwargs['resource_type'] == 'article':
			return Article.objects.all()
		elif self.kwargs['resource_type'] == 'media':
			return Media.objects.all()
		else:
			return

	