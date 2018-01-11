from django.contrib import admin
from .models import Articles, ArticleViewLogs
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
admin.site.register(ArticleViewLogs, VersionedArticleAdmin)