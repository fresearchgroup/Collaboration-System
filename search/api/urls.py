from django.conf.urls import url
from .views import SearchCommunityAPI, SearchArticleAPI, SearchMediaAPI

urlpatterns = [
	url(r'^community$', SearchCommunityAPI.as_view(), name='community-search-api'),
	url(r'^article$', SearchArticleAPI.as_view(), name='article-search-api'),
	url(r'^media$', SearchMediaAPI.as_view(), name='media-search-api'),
	]