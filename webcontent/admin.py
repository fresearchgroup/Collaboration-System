from django.contrib import admin
from .models import Feedback, Faq
from django.db.models import Manager
# Register your models here.

admin.site.register(Feedback)
admin.site.register(Faq)
