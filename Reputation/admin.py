from django.contrib import admin
from .models import ResourceScore, CommunityReputaion, FlagReason, ArticleFlagLogs, MediaFlagLogs
# Register your models here.

admin.site.register(ResourceScore)
admin.site.register(CommunityReputaion)
admin.site.register(FlagReason)
admin.site.register(ArticleFlagLogs)
admin.site.register(MediaFlagLogs)