from django.db import models

# Create your models here.

class Task(models.Model):
    name = models.CharField(max_length=100)
    tfile = models.FileField(upload_to='task/')
    status = models.BooleanField(default=False)
    