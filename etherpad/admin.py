from django.contrib import admin
from .models import EtherUser, EtherCommunity, EtherGroup, EtherArticle
# Register your models here.

admin.site.register(EtherUser)
admin.site.register(EtherCommunity)
admin.site.register(EtherGroup)
admin.site.register(EtherArticle)