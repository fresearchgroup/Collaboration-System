from Community.models import Community, CommunityArticles, CommunityMedia, CommunityMembership
from .serializers import CommunitySerializer, CommunityArticlesSerializer, CommunityMediaSerializer, CommunityMembershipSerializer
from rest_framework import generics
from BasicArticle.serializers import ArticleSerializer
from BasicArticle.models import Articles
from Media.api.serializers import MediaCreateSerializer
from Media.models import Media
from rest_framework.permissions import IsAuthenticated
from .permissions import IsCommunityMember, IfNotCommunityMember, CanUnjoinCommunity
from rest_framework.response import Response
from rest_framework import status
from django.contrib.auth.models import Group as Roles

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

	
class CommunityJoinAPI(generics.CreateAPIView):
	permission_classes = (IsAuthenticated, IfNotCommunityMember)
	serializer_class = CommunityMembershipSerializer

	def create(self, request, *args, **kwargs):
		role = Roles.objects.get(name='author')
		community = Community.objects.get(pk=self.kwargs['pk'])
		membership=CommunityMembership.objects.create(user=request.user, community=community, role=role)
		serializer =self.serializer_class(membership)
		return Response(serializer.data, status=status.HTTP_201_CREATED)

class CommunityUnJoinAPI(generics.DestroyAPIView):
	permission_classes = (IsAuthenticated, IsCommunityMember, CanUnjoinCommunity)
	serializer_class = CommunityMembershipSerializer

	def destroy(self, request, *args, **kwargs):
		community = Community.objects.get(pk=self.kwargs['pk'])
		CommunityMembership.objects.get(user=request.user, community=community).delete()
		return Response(status=status.HTTP_204_NO_CONTENT)