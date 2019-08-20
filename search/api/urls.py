from django.conf.urls import url
from .views import SearchCommunityAPI, SearchArticleAPI

urlpatterns = [
	url(r'^community/(?P<query>[\w\ -]+)/', SearchCommunityAPI.as_view(), name='community-search-api'),
	url(r'^article/(?P<query>[\w\ -]+)/', SearchArticleAPI.as_view(), name='article-search-api'),
	]