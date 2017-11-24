from django.contrib import admin
from .models import Community, CommunityMembership, CommunityArticles, CommunityGroups
# Register your models here.

admin.site.register(Community)
admin.site.register( CommunityMembership)
admin.site.register( CommunityArticles)
admin.site.register( CommunityGroups)