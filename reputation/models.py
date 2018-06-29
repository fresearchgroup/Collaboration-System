from django.db import models
from Community.models import Community
from django.contrib.auth.models import User

#Representing the relation between community,user and its reputation.
class CommunityRep(models.Model): #stores the user community reputation
	community = models.ForeignKey(Community ,on_delete = models.CASCADE)
	user = models.ForeignKey(User , on_delete = models.CASCADE)
	rep = models.IntegerField(default = 25)

	def __str__(self):
		return self.community.name + "-" + self.user.username

#Representing the relation between user and its system reputation.
class SystemRep(models.Model): #store the user system reputation
	user = models.OneToOneField(User,on_delete = models.CASCADE)
	sysrep = models.IntegerField(default = 25)

	def __str__(self):
		return self.user.username

#Representing the default values of Reputation.The admin can change it too.
class ReputationDashboard(models.Model): #stores all the values of the reputation model
	upvote = models.PositiveIntegerField(default=2)
	downvote = models.PositiveIntegerField(default=2)
	published_author = models.PositiveIntegerField(default=5)
	published_publisher = models.PositiveIntegerField(default=5)
	comment_flag = models.PositiveIntegerField(default=2)
	reply = models.PositiveIntegerField(default=1)
	min_crep_for_art = models.PositiveIntegerField(default=15)
	min_srep_for_comm = models.PositiveIntegerField(default=200)
	srep_for_comm_creation = models.PositiveIntegerField(default=25)
	threshold_publisher = models.PositiveIntegerField(default=2000)
	threshold_cadmin = models.PositiveIntegerField(default=3000)
	threshold_report = models.PositiveIntegerField(default = 10)
	author_report = models.PositiveIntegerField(default=5)
	publisher_report = models.PositiveIntegerField(default=10)
	article_report_rejected = models.PositiveIntegerField(default=1)

	def __str__(self):
		return "Reputation Dashboard"
