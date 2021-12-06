from django.contrib import admin
from .models import Feedback, Faq, FaqCategory
from django.db.models import Manager
# Register your models here.

admin.site.register(Faq)
admin.site.register(FaqCategory)

class FeedbackAdmin(admin.ModelAdmin):
    list_display = ['pk', 'community', 'title', 'body', 'user', 'provided_at', ]
    list_filter = ['community']
    search_fields = ['community']
admin.site.register(Feedback, FeedbackAdmin)