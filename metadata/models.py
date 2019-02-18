from django.db import models
from django.conf import settings

# Create your models here.
class Metadata(models.Model):
    description = models.TextField()



