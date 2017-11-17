from django.db import models
from django.contrib.auth.models import User
from django.contrib.auth.models import Group as Roles
from Community.models import Community

# Create your models here.

class Group(models.Model):
	name = models.CharField(max_length=100)
	desc = models.TextField()
	created_by = models.ForeignKey(User, related_name='group')
	community = models.ForeignKey(Community,null=True,  related_name='group')
	visibility = models.BooleanField()

	def __str__(self):
		return self.name
