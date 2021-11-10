from django.contrib import admin
from .models import Community, CommunityMembership, CommunityArticles, CommunityGroups, RequestCommunityCreation, RequestCommunityCreationDetails, CommunityCourses, CommunityMedia
from reversion_compare.admin import CompareVersionAdmin
from reversion_compare.mixins import CompareMixin
from django.db.models import Manager
from mptt.admin import DraggableMPTTAdmin
# Register your models here.

admin.site.register(
    Community,
    DraggableMPTTAdmin,
    list_display=(
        'tree_actions',
        'indented_title',
        # ...more fields if you feel like it...
    ),
    list_display_links=(
        'indented_title',
    ),)

admin.site.register( CommunityMembership)
admin.site.register( CommunityGroups)
# admin.site.register( RequestCommunityCreation)
# admin.site.register( RequestCommunityCreationDetails)

class RequestCommunityCreationAdmin(admin.ModelAdmin):
    list_display = ['pk', 'requestedby', 'email', 'parent', ]
admin.site.register(RequestCommunityCreation, RequestCommunityCreationAdmin)

class RequestCommunityCreationDetailsAdmin(admin.ModelAdmin):
    list_display = ['pk', 'requestcommunity_id', 'requestcommunity_parent', 
                    'name','desc', 'area', 'city', 'state', 
                    'pincode', 'actionby', 'actionon', 'status', 'reason', ]

    def requestcommunity_parent(self, instance):
        return instance.requestcommunity.parent                    
admin.site.register(RequestCommunityCreationDetails, RequestCommunityCreationDetailsAdmin)

admin.site.register(CommunityCourses)
admin.site.register(CommunityMedia)

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
