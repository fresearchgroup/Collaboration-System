from django.conf.urls import url
from .views import CourseRUDApiView, CourseCreateApiView, TopicsLinksApiView, TopicArticleApiView, LinksDetailsApiView, TopicsApiView

urlpatterns = [
	url(r'^create$', CourseCreateApiView.as_view(), name='cousre-create-api'),
    url(r'^(?P<pk>\d*)/$', CourseRUDApiView.as_view(), name='cousre-rud-api'),
    url(r'^topics/links/(?P<pk>\d*)/$', TopicsLinksApiView.as_view(), name='topics-links-api'),
	url(r'^topics/articles/(?P<pk>\d*)/$', TopicArticleApiView.as_view(), name='topics-article-api'),
	url(r'^topics/link/(?P<pk>\d*)/$', LinksDetailsApiView.as_view(), name='topics-link-api'),
	url(r'^topics/(?P<pk>\d*)/$', TopicsApiView.as_view(), name='course-topics-api'),
	]
