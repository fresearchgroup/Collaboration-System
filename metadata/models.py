from django.db import models
from django.conf import settings
from Media.models import Media

# Create your models here.
class Metadata(models.Model):
    description = models.TextField()

class MediaMetadata(models.Model):
   	metadata = models.ForeignKey(Metadata, null=True, related_name='mediametadata')
   	media = models.ForeignKey(Media, null=True, related_name='mediametadata')


