from django.contrib import admin
from .models import Group
# Register your models here.


admin.site.register(Group)

'''class GroupArticlesAdmin(CompareVersionAdmin):
    pass


admin.site.register(GroupArticle, GroupArticlesAdmin)
'''