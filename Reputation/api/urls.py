from django.conf.urls import url
from .views import ReputationStats, ReputationStatsDetails, FlagReasons, ResourceReports, ReputationScore
from .views import BadgesProgress

urlpatterns = [

    url(r'^reputation_stats/$', ReputationStats.as_view()),
    url(r'^reputation_stats/(?P<pk>[0-9]+)/$', ReputationStatsDetails.as_view()),
    url(r'^flag_reasons/$', FlagReasons.as_view()),
    url(r'^resource_reports/$', ResourceReports.as_view()),
    url(r'^score/$', ReputationScore.as_view()),
    url(r'^badges/$', BadgesProgress.as_view()),
]
