from django.conf.urls import url
from .views import FetchCommunityReputation, ArticlePublishScore, ReputationStats, ReputationStatsDetails, FlagReasons, ResourceReports

urlpatterns = [

    url(r'^get_reputation/(?P<pk>\d+)/$', FetchCommunityReputation.as_view(), name='get_reputation'),
    url(r'^article_publish_score/$', ArticlePublishScore, name='article_publish_score'),
    url(r'^reputation_stats/$', ReputationStats.as_view()),
    url(r'^reputation_stats/(?P<pk>[0-9]+)/$', ReputationStatsDetails.as_view()),
    url(r'^flag_reasons/$', FlagReasons.as_view()),
    url(r'^resource_reports/$', ResourceReports.as_view())
]