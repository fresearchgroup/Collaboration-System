from django.contrib import admin

# Register your models here.

from .models import BrowseHistory

class BrowseHistoryAdmin(admin.ModelAdmin):
    list_display = ['pk', 'user', 'content_type', 'object_id', 'content_object', 'viewed_on', 'link', ]
    list_filter = ['content_type']
admin.site.register(BrowseHistory, BrowseHistoryAdmin)
