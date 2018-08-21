from django.db import models
from Community.models import Community
from django.contrib.auth.models import User


class CommunityReputaion(models.Model): 
	community = models.ForeignKey(Community ,on_delete = models.CASCADE)
	user = models.ForeignKey(User , on_delete = models.CASCADE)
	score = models.IntegerField()