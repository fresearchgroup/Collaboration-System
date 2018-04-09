from django.conf.urls import url
from .views import CourseRUDApiView, CourseCreateApiView

urlpatterns = [
	url(r'^$', CourseCreateApiView.as_view(), name='cousre-create-api'),
    url(r'^(?P<pk>\d*)/$', CourseRUDApiView.as_view(), name='cousre-rud-api'),
    ]