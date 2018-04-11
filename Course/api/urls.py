from django.conf.urls import url
from .views import CourseRUDApiView, CourseCreateApiView, TopicsLinksApiView

urlpatterns = [
	url(r'^create$', CourseCreateApiView.as_view(), name='cousre-create-api'),
    url(r'^(?P<pk>\d*)/$', CourseRUDApiView.as_view(), name='cousre-rud-api'),
    url(r'^topics/links/(?P<pk>\d*)/$', TopicsLinksApiView.as_view(), name='topics-links-api'),
    ]