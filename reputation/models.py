from django.db import models
from Community.models import Community
from django.contrib.auth.models import User
import os

class CommunityRep(models.Model):
	community = models.ForeignKey(Community ,on_delete = models.CASCADE)
	user = models.ForeignKey(User , on_delete = models.CASCADE)
	rep = models.IntegerField(default = 0)

	def __str__(self):
		return self.community.name + "-" + self.user.username

class SystemRep(models.Model):
	user = models.OneToOneField(User,on_delete = models.CASCADE)
	sysrep = models.IntegerField(default = 0)

	def __str__(self):
		return self.user.username