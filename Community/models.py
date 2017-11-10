from django.db import models
from django.contrib.auth.models import User
from django.contrib.auth.models import Group as Roles

# Create your models here.
class Community(models.Model):
	name = models.CharField(max_length=100)
	desc = models.TextField()
	category = models.CharField(max_length=100)

	def __str__(self):
		return self.name
