from django.conf.urls import url
from .views import SearchCommunityAPI

urlpatterns = [
	url(r'^community/(?P<query>[\w\ -]+)/', SearchCommunityAPI.as_view(), name='community-search-api'),
	]