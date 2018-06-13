from django.contrib import admin
from .models import SystemRep,CommunityRep,DefaultValues

admin.site.register(SystemRep)
admin.site.register(CommunityRep)
admin.site.register(DefaultValues)
