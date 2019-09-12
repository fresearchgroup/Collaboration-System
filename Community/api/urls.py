from django.conf.urls import url
from .views import CommunityListsApi, CommunityArticlesApi, CommunityMediaApi, CreateCommunityResource, CommunityJoinAPI, CommunityUnJoinAPI, CommunityAPI

urlpatterns = [
	url(r'^(?P<pk>\d*)/join/', CommunityJoinAPI.as_view(), name='community-join-api'),
	url(r'^(?P<pk>\d*)/unjoin/', CommunityUnJoinAPI.as_view(), name='community-unjoin-api'),
	url(r'^(?P<type>[\w\-]+)/$', CommunityListsApi.as_view(), name='community-list-api'),
    url(r'^(?P<pk>\d*)/articles/$', CommunityArticlesApi.as_view(), name='community-articles-api'),
	url(r'^(?P<pk>\d*)/media/(?P<type>[\w\-]+)/$', CommunityMediaApi.as_view(), name='community-media-api'),
	url(r'^(?P<pk>\d*)/create/(?P<resource_type>[\w\-]+)/$', CreateCommunityResource.as_view(), name='community-resource-create'),
	url(r'^info/(?P<pk>\d*)/$', CommunityAPI.as_view(), name='community-get-api'),
	]
