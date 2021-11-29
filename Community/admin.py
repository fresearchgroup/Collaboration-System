from django.contrib import admin
from .models import Community, CommunityMembership, CommunityArticles, CommunityGroups, Locations, RequestCommunityCreationAssignee, RequestCommunityCreation, RequestCommunityCreationDetails, CommunityCourses, CommunityMedia, MergedArticles
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

class CommunityMembershipAdmin(admin.ModelAdmin):
    list_display = ['pk', 'user', 'community', 'role', 'assignedon', ]
admin.site.register(CommunityMembership, CommunityMembershipAdmin)


admin.site.register( CommunityGroups)
# admin.site.register( RequestCommunityCreation)
# admin.site.register( RequestCommunityCreationDetails)

class RequestCommunityCreationAdmin(admin.ModelAdmin):
    list_display = ['pk', 'requestedby', 'requestedon', 'email', 'parent', ]
admin.site.register(RequestCommunityCreation, RequestCommunityCreationAdmin)

class RequestCommunityCreationDetailsAdmin(admin.ModelAdmin):
    list_display = ['pk', 'requestcommunity_id', 'requestcommunity_parent', 
                    'name','desc', 'area', 'city', 'state', 
                    'pincode', 'actionby', 'actionon', 'status', 'reason', ]

    def requestcommunity_parent(self, instance):
        return instance.requestcommunity.parent                    
admin.site.register(RequestCommunityCreationDetails, RequestCommunityCreationDetailsAdmin)

class RequestCommunityCreationAssigneeAdmin(admin.ModelAdmin):
    list_display = ['pk', 'requestcommunity_id', 'assignedto', 'assignedon', ]
admin.site.register(RequestCommunityCreationAssignee, RequestCommunityCreationAssigneeAdmin)

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

class MergedArticlesAdmin(admin.ModelAdmin):
    list_display = ['pk', 'community', 'state', 'changedby', 'changedon', 'originalarticles', ]
admin.site.register(MergedArticles, MergedArticlesAdmin)

class LocationsAdmin(admin.ModelAdmin):
    list_display = ['pk', 'state', 'district', 'city', 'pincode', ]
    list_filter = ['state']
    search_fields = ['pincode','city','district']
admin.site.register(Locations, LocationsAdmin)