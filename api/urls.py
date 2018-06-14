from django.conf.urls import url

from . import views

urlpatterns = [
        url(r'^user/(?P<id>\d+)/$', views.get_user_id),
        url(r'^event/(?P<param1>\w+)/(?P<param2>\w+)/$', views.get_event),
      	url(r'^event/(?P<param1>\w+)/(?P<param2>\w+)/(?P<eid>\d+)/$', views.get_event_id),
        url(r'^user/(?P<id>\d+)/event/(?P<param1>\w+)/(?P<param2>\w+)/$', views.get_user_id_event),
        url(r'^user/(?P<id>\d+)/event/(?P<param1>\w+)/(?P<param2>\w+)/(?P<eid>\d+)/$',views.get_user_id_event_id),
        ]
