from django.contrib.sitemaps.views import sitemap
from .sitemaps import CommunitySitemap
from django.conf.urls import url

sitemaps = {
    'community': CommunitySitemap
}

urlpatterns = [
    url(r'^sitemap\.xml/$', sitemap, {'sitemaps' : sitemaps } , name='sitemap'),
]
