from django.contrib import admin
from .models import ResourceScore, CommunityReputaion, FlagReason
# Register your models here.

admin.site.register(ResourceScore)
admin.site.register(CommunityReputaion)
admin.site.register(FlagReason)