from django.conf.urls import url
from .views import FetchCommunityReputation, ArticlePublishScore

urlpatterns = [

    url(r'^get_reputation/(?P<pk>\d+)/$', FetchCommunityReputation.as_view(), name='get_reputation'),
    url(r'^article_publish_score/$', ArticlePublishScore, name='article_publish_score'),
]