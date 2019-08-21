from django.db import models
from django.conf import settings
from django_mysql.models import JSONField, Model

# Create your models here.
class Metadata(Model):
    description = models.TextField()
    attrs = JSONField()



#Metadata schema
Schema = ('Contributor', 'Coverage', 'Creator', 'Date', 'Description', 'Format', 'Identifier', 'Language', 'Publisher', 'Relation', 'Rights', 'Source', 'Subject', 'Title', 'Type')