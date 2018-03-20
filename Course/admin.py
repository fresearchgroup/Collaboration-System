from django.contrib import admin
from mptt.admin import DraggableMPTTAdmin
from .models import Course, Topics, Links
# Register your models here.


admin.site.register(Course)
admin.site.register(Links)

admin.site.register(
    Topics,
    DraggableMPTTAdmin,
    list_display=(
        'tree_actions',
        'indented_title',
        # ...more fields if you feel like it...
    ),
    list_display_links=(
        'indented_title',
    ),
)
