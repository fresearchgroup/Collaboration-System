from django.db import models
from Community.models import Community
from django.contrib.auth.models import User
import os

class CommunityRep(models.Model): #stores the user community reputation
	community = models.ForeignKey(Community ,on_delete = models.CASCADE)
	user = models.ForeignKey(User , on_delete = models.CASCADE)
	rep = models.IntegerField(default = 15)

	def __str__(self):
		return self.community.name + "-" + self.user.username

class SystemRep(models.Model): #store the user system reputation
	user = models.OneToOneField(User,on_delete = models.CASCADE)
	sysrep = models.IntegerField(default = 100)

	def __str__(self):
		return self.user.username

class DefaultValues(models.Model): #stores all the values of the reputation model
	upvote = models.PositiveIntegerField(default=1)
	downvote = models.PositiveIntegerField(default=1)
	published_author = models.PositiveIntegerField()
	published_publisher = models.PositiveIntegerField()
	comment_flag = models.PositiveIntegerField()
	reply = models.PositiveIntegerField()
	min_crep_for_art = models.PositiveIntegerField()
	min_srep_for_comm = models.PositiveIntegerField()
	srep_for_comm_creation = models.PositiveIntegerField()
	threshold_publisher = models.PositiveIntegerField(default=0)
	threshold_cadmin = models.PositiveIntegerField(default=0)

	def __str__(self):
		return "Default Values"
