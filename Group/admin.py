from django.contrib import admin
from .models import Group, GroupArticles, GroupMembership
from reversion_compare.admin import CompareVersionAdmin
# Register your models here.


admin.site.register(Group)
admin.site.register(GroupMembership)

class GroupArticlesAdmin(CompareVersionAdmin):
    pass


admin.site.register(GroupArticles, GroupArticlesAdmin)
