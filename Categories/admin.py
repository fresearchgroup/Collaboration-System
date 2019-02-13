from django.contrib import admin
from .models import Category
from mptt.admin import DraggableMPTTAdmin

# Register your models here.
admin.site.register(
    Category,
    DraggableMPTTAdmin,
    list_display=(
        'tree_actions',
        'indented_title',
        # ...more fields if you feel like it...
    ),
    list_display_links=(
        'indented_title',
    ),)