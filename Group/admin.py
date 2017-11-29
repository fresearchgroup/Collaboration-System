from django.contrib import admin
from .models import Group, GroupArticles
from reversion_compare.admin import CompareVersionAdmin
# Register your models here.


admin.site.register(Group)

class GroupArticlesAdmin(CompareVersionAdmin):
    pass


admin.site.register(GroupArticles, GroupArticlesAdmin)
