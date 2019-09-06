from django.conf.urls import url
from .views import MetadataCreateView, MetadataUpdateView
urlpatterns = [
	url(r'^(?P<resource_type>[\w\-]+)/(?P<resource_id>\d*)/create$',MetadataCreateView.as_view(), name='create'),
	url(r'^(?P<resource_type>[\w\-]+)/(?P<resource_id>\d*)/update/(?P<metadata_id>\d*)$',MetadataUpdateView.as_view(), name='update'),
	]