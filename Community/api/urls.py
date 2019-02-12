from django.conf.urls import url
from .views import CommunityListsApi, CommunityArticlesApi, CommunityMediaApi

urlpatterns = [
	url(r'^list/$', CommunityListsApi.as_view(), name='community-list-api'),
    url(r'^(?P<pk>\d*)/articles/$', CommunityArticlesApi.as_view(), name='community-articles-api'),
	url(r'^(?P<pk>\d*)/media/(?P<type>[\w\-]+)/$', CommunityMediaApi.as_view(), name='community-media-api'),
	]
