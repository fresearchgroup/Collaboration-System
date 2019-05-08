from django.db import models
from mptt.models import MPTTModel, TreeForeignKey
import os, uuid
# Create your models here.
def get_file_path(instance, filename):
    ext = filename.split('.')[-1]
    filename = "%s.%s" % (uuid.uuid4(), ext)
    return os.path.join('category', filename)
    
class Category(MPTTModel):

        name = models.CharField(max_length=100)
        image = models.ImageField(null=True, upload_to=get_file_path)
        created_at = models.DateTimeField(null=True, auto_now_add=True)
        parent = TreeForeignKey('self', null=True, blank=True, related_name='children', db_index=True)

        def __str__(self):
            return self.name