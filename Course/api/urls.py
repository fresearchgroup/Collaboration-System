from django.conf.urls import url
from .views import CourseApiView

urlpatterns = [
    url(r'^(?P<pk>\d*)/$', CourseApiView.as_view(), name='cousre-api'),
    ]