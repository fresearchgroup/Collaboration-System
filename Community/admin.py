from django.contrib import admin
from .models import Community, CommunityMembership, CommunityArticles, CommunityGroups
from reversion_compare.admin import CompareVersionAdmin
# Register your models here.

admin.site.register(Community)
admin.site.register( CommunityMembership)
admin.site.register( CommunityGroups)


class CommunityArticlesAdmin(CompareVersionAdmin):
    pass


admin.site.register(CommunityArticles, CommunityArticlesAdmin)
