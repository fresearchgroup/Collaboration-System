from django.contrib.sitemaps import Sitemap
from .models import Community
 
 
class CommunitySitemap(Sitemap):    
    changefreq = "monthly"
    priority = 0.9
 
    def items(self):
        return Community.objects.all()
 
    def lastmod(self, obj):
        return obj.created_at