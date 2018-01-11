from django.contrib import admin
from .models import Community, CommunityMembership, CommunityArticles, CommunityGroups, RequestCommunityCreation
from reversion_compare.admin import CompareVersionAdmin
from reversion_compare.mixins import CompareMixin
from django.db.models import Manager
# Register your models here.

admin.site.register(Community)
admin.site.register( CommunityMembership)
admin.site.register( CommunityGroups)
admin.site.register( RequestCommunityCreation)


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


class CommunityArticlesAdmin(CompareVersionAdmin):
    pass


admin.site.register(CommunityArticles, CommunityArticlesAdmin)
