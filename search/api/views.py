from rest_framework import generics
from .serializers import SearchCommunitySerializer, SearchArticleSerializer, SearchMediaSerializer
from Community.models import Community
from BasicArticle.models import Articles
from Media.models import Media
from django.conf import settings
from elasticsearch import Elasticsearch
from elasticsearch_dsl import Search
from elasticsearch_dsl.query import MultiMatch

class SearchCommunityAPI(generics.ListAPIView):
	serializer_class = SearchCommunitySerializer

	def get_queryset(self):
		query =self.request.query_params.get('query', None)
		if query:
			if settings.ELASTICSEARCH_RUNNING:
				client = Elasticsearch()
				s = Search(index='community').using(client).query(MultiMatch(query=query, fields=['name', 'desc']))
				response = s.execute()
				community_ids=[i.community_id for i in response]
				return Community.objects.filter(pk__in=community_ids)
			else:
				return Community.objects.filter(name__icontains=query)
		return Community.objects.none()


class SearchArticleAPI(generics.ListAPIView):
	serializer_class = SearchArticleSerializer

	def get_queryset(self):
		query =self.request.query_params.get('query', None)
		if query:
			if settings.ELASTICSEARCH_RUNNING:
				client = Elasticsearch()
				s = Search(index='article').using(client).query(MultiMatch(query=query, fields=['title', 'body']))
				response = s.execute()
				articles_ids = [i.article_id for i in response]
				return Articles.objects.filter(pk__in=articles_ids)
			else:
				return Articles.objects.filter(title__icontains=query, state__name='publish')
		return Articles.objects.none()

class SearchMediaAPI(generics.ListAPIView):
	serializer_class = SearchMediaSerializer

	def get_queryset(self):
		query =self.request.query_params.get('query', None)
		if query:
			if settings.ELASTICSEARCH_RUNNING:
				client = Elasticsearch()
				s = Search(index='media').using(client).query(MultiMatch(query=query, fields=['title', 'mediatype']))
				response = s.execute()
				media_ids = [i.media_id for i in response]
				return Media.objects.filter(pk__in=media_ids)
			else:
				return Media.objects.filter(title__icontains=query, state__name='publish')
		return Media.objects.none()