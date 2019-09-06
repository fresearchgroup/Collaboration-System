# encoding: utf-8
from __future__ import absolute_import, division, print_function, unicode_literals
from django.urls import reverse
from django.conf import settings
from django.core.paginator import InvalidPage, Paginator
from django.http import Http404, HttpResponse, HttpRequest
from django.shortcuts import render
from django.views.generic import TemplateView
from elasticsearch import Elasticsearch
from elasticsearch_dsl import Search
from elasticsearch_dsl.query import MultiMatch
from Community.models import Community
from BasicArticle.models import Articles
from Media.models import Media

class FacetedSearchView(TemplateView):
	template_name='search.html'

	def get_context_data(self, **kwargs):
		query = self.request.GET.get('query', None)
		if query:
			if settings.ELASTICSEARCH_RUNNING:
				client = Elasticsearch()
				s = Search().using(client).query(MultiMatch(query=query, fields=['name', 'desc', 'title', 'desc']))
				response = s.execute()
				resource = {'communities':[], 'articles': [], 'medias':[]}
				for i in response:
					if hasattr(i, 'community_id'):
						resource['communities'].append(i.community_id)
					elif hasattr(i, 'article_id'):
						resource['articles'].append(i.article_id)
					elif hasattr(i, 'media_id'):
						resource['medias'].append(i.media_id)
				if 'communities' not in kwargs:
					kwargs['communities'] = Community.objects.filter(id__in=resource['communities'])
				if 'articles' not in kwargs:
					kwargs['articles'] = Articles.objects.filter(id__in=resource['articles'])
				if 'medias' not in kwargs:
					kwargs['medias'] = Media.objects.filter(id__in=resource['medias'])
				return kwargs
			else:
				if 'communities' not in kwargs:
					kwargs['communities'] = Community.objects.filter(name__icontains=query)
				if 'articles' not in kwargs:
					kwargs['articles'] = Articles.objects.filter(title__icontains=query, state__name='publish')
				if 'medias' not in kwargs:
					kwargs['medias'] = Media.objects.filter(title__icontains=query, state__name='publish')
				return kwargs
		return kwargs