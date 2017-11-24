from django.db import models
from django.contrib.auth.models import User
from django.contrib.auth.models import Group as Roles

# Create your models here.

class Group(models.Model):
	name = models.CharField(max_length=100)
	desc = models.TextField()
	visibility = models.BooleanField()

	def __str__(self):
		return self.name

class GroupMembership(models.Model):
	group = models.ForeignKey(Group, related_name='groupmembership')
	user = models.ForeignKey(User, related_name='groupmembership')
	role = models.ForeignKey(Roles, null=True, related_name='groupmembership')
