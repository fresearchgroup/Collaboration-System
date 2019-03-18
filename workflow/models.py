from django.db import models
from django.contrib.auth.models import Group as Roles
# Create your models here.


class States(models.Model):
	name = models.CharField(null=True,max_length=100)
	desc = models.TextField(null=True)
	initial = models.BooleanField(default=False)
	final = models.BooleanField(default=False)

	def __str__(self):
		return self.name


class Transitions(models.Model):
	name = models.CharField(null=True, max_length=100)
	community = models.ForeignKey('Community.Community', null=True, related_name='community')
	role = models.ForeignKey(Roles, null=True, related_name='role')
	from_state = models.ForeignKey(States, null=True,related_name='fromtransitions')
	to_state = models.ForeignKey(States, null=True,related_name='totransitions')

	def __str__(self):
		return self.name
