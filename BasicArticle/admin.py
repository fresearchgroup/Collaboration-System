from django.contrib import admin
from .models import ArticleStates, Articles, ArticleViewLogs
# Register your models here.
from reversion_compare.admin import CompareVersionAdmin
from reversion_compare.mixins import CompareMixin
from django.db.models import Manager


_old_compare = CompareMixin.compare


def compare(self, obj, version1, version2):
    def replace_taggit_field(version_ins):
        for fieldname in version_ins.field_dict:
            if isinstance(version_ins.field_dict[fieldname], Manager):
                version_ins.field_dict[fieldname] = []
    replace_taggit_field(version1)
    replace_taggit_field(version2)
    return _old_compare(self, obj, version1, version2)


CompareMixin.compare = compare



class VersionedArticleAdmin(CompareVersionAdmin):
    pass


admin.site.register(Articles, VersionedArticleAdmin)

class ArticleStatesAdmin(admin.ModelAdmin):
    list_display = ['pk', 'article_id', 'state_name', 'changedby', 'changedon', ]

    def state_name(self, instance):
        return instance.state.name 

admin.site.register(ArticleStates, ArticleStatesAdmin)

admin.site.register(ArticleViewLogs, VersionedArticleAdmin)