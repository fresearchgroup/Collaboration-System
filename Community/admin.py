from django.contrib import admin
from .models import Community, CommunityMembership
# Register your models here.

admin.site.register(Community)
admin.site.register( CommunityMembership)
