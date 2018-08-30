from django.conf.urls import url
from .views import FetchCommunityReputation

urlpatterns = [

    url(r'^get_reputation/(?P<pk>\d+)/$', FetchCommunityReputation.as_view(), name='get_reputation'),
]